From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: git merge after git cherry-pick?
Date: Wed, 23 Jul 2008 19:56:00 +0200
Message-ID: <20080723175600.GL22606@neumann>
References: <48876709.3090504@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter Valdemar =?iso-8859-1?Q?M=F8rch_=28Lists=29?= 
	<4ux6as402@sneakemail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 19:57:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLiaF-0007ra-TF
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 19:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbYGWR4E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 13:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753083AbYGWR4D
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 13:56:03 -0400
Received: from francis.fzi.de ([141.21.7.5]:50602 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752810AbYGWR4B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 13:56:01 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 23 Jul 2008 19:55:59 +0200
Content-Disposition: inline
In-Reply-To: <48876709.3090504@sneakemail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 23 Jul 2008 17:55:59.0179 (UTC) FILETIME=[5D00B1B0:01C8ECED]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89722>

On Wed, Jul 23, 2008 at 07:14:49PM +0200, "Peter Valdemar M=F8rch (List=
s)" wrote:
> On a branch, b, made off of master, I've made the commits b1, b2, b3 =
and =20
> b4.
>
> Back on master, I need commit b1 and b3 immediately. So I:
>
> $ git checkout master
> $ git cherry-pick "b1's SHA"
> $ git cherry-pick "b3's SHA"
>
> Now, both b and master contain b1 and b3. How do I now create a log o=
f =20
> "what remains to be merged from b to master", i.e. only b2 and b4? An=
d =20
> how do I merge b2 and b4 to master, so master's log shows b1, b3, b2 =
and =20
> b4 and doesn't show b1 and b3 twice, which is what I get if I:
>
> $ git merge b
>
> after the cherry-picks above. Also I noticed, that if I merge master =
=20
> into b (to keep up-to-date with master) b1 and b3 are also mentioned=20
> twice.
You could use 'git rebase' for that.

e.g. now the history of your master and b branches look like this:

  o---X---b1'---b3'---Y   master
   \
    b1---b2---b3---b4   b

The command 'git rebase master b' will then turn this history into the
following:

  o---X---b1'---b3'---Y   master
                       \
                        b2---b4   b

After this 'git merge b' will do what you would like it to do.


Regards,
G=E1bor
