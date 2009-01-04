From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] Fixed trivial warnings. Mainly parametrized raw types, added serialVersionUID, removed unnecessery throws.
Date: Mon, 5 Jan 2009 00:04:41 +0100
Message-ID: <200901050004.41531.robin.rosenberg.lists@dewire.com>
References: <gjrcni$9q$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Vasyl' Vavrychuk" <vvavrychuk@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 05 00:06:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJc3M-0005Oj-AL
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 00:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762AbZADXEu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Jan 2009 18:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755741AbZADXEt
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 18:04:49 -0500
Received: from mail.dewire.com ([83.140.172.130]:26046 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752547AbZADXEs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jan 2009 18:04:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 893531484F5D;
	Mon,  5 Jan 2009 00:04:45 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LwMXuVhprQb1; Mon,  5 Jan 2009 00:04:44 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id B1CAA1484F53;
	Mon,  5 Jan 2009 00:04:44 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27-11-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <gjrcni$9q$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104551>


s=F6ndag 04 januari 2009 23:20:19 skrev Vasyl' Vavrychuk:
> Also fixed:
> 1. "The 'Eclipse-LazyStart' header is deprecated, use 'Bundle-Activat=
ionPolicy'" warning.
> 2. Possible NullPointerException warning.
> 3. Unnecessery function parameter warning.

Thanks for your interest in the projects. Most changes from a 30 second=
s review look reasonable.
However we don't apply changes this way. From your comments it seems we=
'd require about
five patches since the changes are of very different types.

-- robin

> diff --git a/org.spearce.egit.core.test/META-INF/MANIFEST.MF b/org.sp=
earce.egit.core.test/META-INF/MANIFEST.MF
> index ee5f277..e8bcc79 100644
> --- a/org.spearce.egit.core.test/META-INF/MANIFEST.MF
> +++ b/org.spearce.egit.core.test/META-INF/MANIFEST.MF
> @@ -11,7 +11,7 @@ Require-Bundle: org.eclipse.core.runtime,
>   org.spearce.egit.ui,
>   org.spearce.jgit,
>   org.eclipse.core.filesystem
> -Eclipse-LazyStart: true
> +Bundle-ActivationPolicy: lazy

Any pointers on this? (so I can learn)

> diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal=
/storage/GitFileHistory.java b/org.spearce.egit.core/src/org/spearce/eg=
it/core/internal/storage/GitFileHistory.java
> index c01c1c3..61c32ce 100644
> --- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/storag=
e/GitFileHistory.java
> +++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/storag=
e/GitFileHistory.java
> @@ -50,11 +50,11 @@
>  	GitFileHistory(final IResource rsrc, final int flags,
>  			final IProgressMonitor monitor) {
>  		resource =3D rsrc;
> -		walk =3D buildWalk(flags);
> +		walk =3D buildWalk(/*flags*/);
>  		revisions =3D buildRevisions(monitor, flags);
>  	}
> -	private KidWalk buildWalk(final int flags) {
> +	private KidWalk buildWalk(/*final int flags*/) {
Can't we just drop the parameter completely and wipe every trace of it?

>  		final RepositoryMapping rm =3D RepositoryMapping.getMapping(resour=
ce);
>  		if (rm =3D=3D null) {
>  			Activator.logError("Git not attached to project "
> diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/=
GitProjectData.java b/org.spearce.egit.core/src/org/spearce/egit/core/p=
roject/GitProjectData.java
> index 04130db..db5f20b 100644
> --- a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProj=
ectData.java
> +++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProj=
ectData.java
> @@ -48,9 +48,9 @@
>   * a Git repository.
>   */
>  public class GitProjectData {
> -	private static final Map projectDataCache =3D new HashMap();
> +	private static final Map<IProject, GitProjectData> projectDataCache=
 =3D new HashMap<IProject, GitProjectData>();
> =20
> -	private static final Map repositoryCache =3D new HashMap();
> +	private static final Map<File, WeakReference> repositoryCache =3D n=
ew HashMap<File, WeakReference>();
Been thinking about doing this myself but always found something more i=
nteresting to do. Good.

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/Canonical=
TreeParser.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/Canoni=
calTreeParser.java
> index dcc53cd..4700510 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreePar=
ser.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreePar=
ser.java
> @@ -175,8 +175,9 @@ public void back(int delta) {
>  			// space so this prunes our search more quickly.
>  			//
>  			ptr -=3D Constants.OBJECT_ID_LENGTH;
> -			while (raw[--ptr] !=3D ' ')
> -				/* nothing */;
> +			while (raw[--ptr] !=3D ' ') {
> +				/* nothing */
> +			}
Not sure if this buys us anything. I wouldn't react if original code wa=
s either way, but
changing it seems unnecessary.

-- robin
