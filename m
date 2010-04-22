From: Petr Baudis <pasky@suse.cz>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Thu, 22 Apr 2010 22:25:01 +0200
Message-ID: <20100422202501.GJ10939@machine.or.cz>
References: <201004150630.44300.chriscool@tuxfamily.org>
 <201004191243.24209.jnareb@gmail.com>
 <20100419115113.GC3563@machine.or.cz>
 <201004202014.19477.jnareb@gmail.com>
 <k2le72faaa81004211349o1628ed42s4fa0aa412006128@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, Sam Vilain <sam@vilain.net>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 22:26:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O52yA-000182-9v
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 22:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757970Ab0DVUZ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 16:25:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45257 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758364Ab0DVUZF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 16:25:05 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 4129F86208E; Thu, 22 Apr 2010 22:25:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <k2le72faaa81004211349o1628ed42s4fa0aa412006128@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145555>

  Hi!

On Thu, Apr 22, 2010 at 02:19:02AM +0530, Pavan Kumar Sunkara wrote:
> a) File Structure:
>=20
> =A0 =A0* gitweb.pl -- Main script parsing urls and calling required m=
odules
> =A0 =A0* gitweb.css -- The style for the gitweb pages.
> =A0 =A0* gitweb.js -- javascript to make gitweb more interactive
> =A0=A0 * git-logo.png
> =A0=A0 * git-favicon.png
> =A0=A0 * Makefile --=A0 Responsible for installing gitweb
> =A0 =A0* lib (dir) -- some basic files like config, view and other ac=
tions
> =A0=A0=A0=A0=A0 * config.pm
> =A0=A0=A0=A0=A0 * view.pm
> =A0=A0=A0=A0=A0 * default.pm -- this just outputs the list of all pro=
jects.
> =A0=A0=A0=A0=A0 * {actions}.pm -- One file for every action

  (I have reservations to this particular structure and naming, but I
don't think that's crucial for the proposal.)

> The current gitweb makefile makes a gitweb.cgi from the perl script
> and requires a server for it's working. I would like to continue this
> process but the change will be in the gitweb perl script. The new
> script includes config and other basic files, checks the URL, parses
> it, detects the action, uses the output and along with view.pm gives
> out a proper HTML, CSS web page.

Sounds fine in principle.

> The lib directory will also contain
> some basic modules like Gitweb::Repo, Gitweb::Commit which will make
> developing further functionalities easier.

Beware, this might be an awful can of worms. The previous gitweb SoC
project failed to get merged in part due to trying to do something like
this.

I recommend to avoid any large architectural changes and just shuffle
around all the utility routines to lib/Gitweb.pm or so.

> I will be using a static
> file to maintain the list of repositories which is obtained by
> scanning repositories.

Will this be compatible with the current project list file?

> b) Read modules of the client: (most of this need not be written, jus=
t
> need to be organised)
>=20
> =A0 1. See the status of repository [git status]
> =A0 2. Show diff of the current working file compared to HEAD [git di=
ff]
> =A0 3. List all the commits with pagination [git log]
> =A0 4. With every commit we can
> =A0 =A0 =A0 =A0 =A0* Visualise trees [git ls-tree]
> =A0 =A0 =A0 =A0 =A0* Visualise files and diffs [git show]
> =A0 =A0 =A0 =A0 =A0* Visualise annotations [git blame]
> =A0 5. List all branches including remote ones [git branch]
> =A0 6. Search commits, branches, authors etc.. [git grep]
>=20
> c) Write modules of the client:
>=20
> =A0 1. Add Existing repositories to the gitweb -- This will list the
> given repo into static list of repos.
> =A0 2. Create new/Clone repositories into a given path [git init | gi=
t
> clone] -- This will create new repo and list it
> =A0 3. Add/Remove/Move files [git add | git rm | git mv]
> =A0 4. Stage/Unstage files [git add | git reset]
> =A0 5. Add files to ignore list when u click on 'Ignore' link
> =A0 6. Discard changes to a file in working copy [git reset]
> =A0 7. Commit to the repository with a log message and an optional
> sign-off [git commit]
> =A0 8. Manage branches [git branch]
> =A0 9. A simple branch merging* [git merge]
> =A010. Creating tags [git tag]
> =A011. Implementing a simple file editor
> =A012. Checkout code to a specific commit or branch or tag [git check=
out]
> =A013. Editing config for remotes [git remote]
> =A014. Push to a remote branch [git push]
> =A015. Fetch/Pull from a remote branch [git fetch | git pull]
> =A016. Garbage collection [git gc | git count-objects | git fsck | gi=
t prune]
> =A017. Search for a part of code using pickaxe

BTW, I think you could prioritize better, e.g. (5) or (10) is rather
minor thing while (11) or (14),(15) are crucial. But this is not that
important if you are confident you will finish everything listed. ;-)

> * - Merging two branches can be quite complicated. Simple merge
> mentioned above will be just showing you that there are conflicts. Bu=
t
> you won't be having options to

BTW, I don't think it's really complicated at all in the simple conflic=
t
case - just edit the file and do git add (getting all the file-director=
y
etc. cases right might be more tedious, but less important).

> d) Usage of the client:
>=20
> This client can be used in 2 ways.
>=20
> * Install a local version using instaweb - The gitweb will be only
> accessible by you. You can browse through the git repository using
> read modules and simultaneously work on them using write modules.
> * Install on intranet - A company when installs this gitweb along wit=
h
> some other login and account managing scripts will be able to order
> their employees to login and ask them to work on the code with out th=
e
> security risk of providing ssh access to the git repository host. The
> authentication support can be implemented as an optional part of my
> proposal.
> * Install on web - Just like normal gitweb, or enable write modules t=
o
> look like gist.github.com

Note that for the latter two, operation mode without working copy is
essential; I have not seen you address it anywhere.

Good work, I like this better than the first proposal. :-)

--=20
				Petr "Pasky" Baudis
http://pasky.or.cz/ | "Ars longa, vita brevis." -- Hippocrates
