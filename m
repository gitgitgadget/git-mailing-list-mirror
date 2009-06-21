From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH 2/2] Add support for remote.name.pushurl
Date: Sun, 21 Jun 2009 19:30:43 +0200
Message-ID: <200906211930.43809.robin.rosenberg@dewire.com>
References: <1245547316-10299-1-git-send-email-spearce@spearce.org> <1245547316-10299-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jun 21 19:31:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIQsg-00071a-Fp
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 19:31:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbZFURav convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Jun 2009 13:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959AbZFURau
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 13:30:50 -0400
Received: from mail.dewire.com ([83.140.172.130]:7681 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751808AbZFURat convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Jun 2009 13:30:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9A235147D72E;
	Sun, 21 Jun 2009 19:30:46 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mtg80oszN0aC; Sun, 21 Jun 2009 19:30:45 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 74330147D72C;
	Sun, 21 Jun 2009 19:30:45 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1245547316-10299-2-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121987>

s=F6ndag 21 juni 2009 03:21:56 skrev "Shawn O. Pearce" <spearce@spearce=
=2Eorg>:
> In C Git commit 203462347fce Michael J Gruber added support for a
> new URL key within a remote block, permitting a different URL to
> be used for push than for fetch.  In the commit message he cites
> an example where fetch runs over git://, but push uses ssh://,
> as the git:// protocol has lower connection setup overheads.
>=20
> This change complicates the Transport API as now we must know
> in advance when the Transport.open() call is made what type of
> operation the caller wants to perform, so we know which config
> key to honor when constructing the Transport objects.
>=20
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  .../src/org/spearce/jgit/pgm/Push.java             |    3 +-
>  .../org/spearce/jgit/transport/RemoteConfig.java   |   47 ++++++
>  .../src/org/spearce/jgit/transport/Transport.java  |  150 ++++++++++=
++++++++--
>  3 files changed, 190 insertions(+), 10 deletions(-)
>=20
> diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java =
b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
> index 19d31a1..9364e4a 100644
> --- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
> +++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
> @@ -102,7 +102,8 @@ protected void run() throws Exception {
>  				refSpecs.add(spec.setForceUpdate(true));
>  		}
> =20
> -		final List<Transport> transports =3D Transport.openAll(db, remote)=
;
> +		final List<Transport> transports;
> +		transports =3D Transport.openAll(db, remote, Transport.Operation.P=
USH);

Nit-pick. We usually initialize in one statement. I'll squash that for =
you.

Seems we need to consider the Eclipse UI, since that has only of only o=
ne UI. Can we hold on to
that or at least establish a related issue in the bug tracker for Egit.

-- robin
