From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 01/11] Add support code to handle plugin property
	changes
Date: Thu, 5 Feb 2009 07:53:37 -0800
Message-ID: <20090205155337.GH26880@spearce.org>
References: <1233795618-20249-1-git-send-email-torarnv@gmail.com> <1233795618-20249-2-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Tor Arne =?iso-8859-1?Q?Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 16:56:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV6ZF-0001tT-J1
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 16:55:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613AbZBEPxj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2009 10:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752565AbZBEPxi
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 10:53:38 -0500
Received: from george.spearce.org ([209.20.77.23]:38270 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443AbZBEPxi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 10:53:38 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 832F738210; Thu,  5 Feb 2009 15:53:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1233795618-20249-2-git-send-email-torarnv@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108573>

Tor Arne Vestb=F8 <torarnv@gmail.com> wrote:
> diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.ja=
va b/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
> index fced643..d4a9e8e 100644
> --- a/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
> +++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
> @@ -44,9 +48,24 @@
>   * This is a plugin singleton mostly controlling logging.
>   */
>  public class Activator extends AbstractUIPlugin {
> +
> +	/**
> +	 *  The one and only instance
> +	 */
>  	private static Activator plugin;

What does this field do?  I don't see it referenced anywhere...
 =20
>  	/**
> +	 * Property listeners for plugin specific events
> +	 */
> +	private static List<IPropertyChangeListener> propertyChangeListener=
s =3D
> +		new ArrayList<IPropertyChangeListener>(5);

None of these list accesses are thread-safe.  Are we certain they
call will come from a single thread, e.g. the SWT event thread?
Or do we need to put synchronized protection in here?

--=20
Shawn.
