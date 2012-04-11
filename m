From: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Wed, 11 Apr 2012 21:20:31 +0200
Message-ID: <2866164.rI5svgrW1x@flomedio>
References: <11292500.AVmZFUUvNi@flobuntu> <1421035.yALBSXSHGd@flomedio> <20120410171707.GA3869@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 21:22:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI37I-0006IY-HX
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 21:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932978Ab2DKTWB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 15:22:01 -0400
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:4353 "EHLO
	mailrelay.tugraz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760904Ab2DKTWA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2012 15:22:00 -0400
Received: from flomedio.localnet (91-115-90-225.adsl.highway.telekom.at [91.115.90.225])
	(authenticated bits=0)
	by mailrelay2.tugraz.at (8.14.4/8.14.4) with ESMTP id q3BJKW5w010640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Apr 2012 21:20:32 +0200 (CEST)
User-Agent: KMail/4.7.3 (Linux/3.0.0-17-generic; KDE/4.7.4; x86_64; ; )
In-Reply-To: <20120410171707.GA3869@burratino>
X-TUG-Backscatter-control: qyH/vN2riZ/masrHmZoJqQ
X-Spam-Scanner: SpamAssassin 3.003000 
X-Spam-Score-relay: 0.6
X-Scanned-By: MIMEDefang 2.70 on 129.27.10.19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195241>

On Tuesday 10 April 2012 12:17:07 Jonathan Nieder wrote:
> Hi,
>=20
> Florian Achleitner wrote:
> > Thanks for your inputs. I've now submitted a slightly updated versi=
on of
> > my proposal to google. Additionally it's on github [1].
> >=20
> > Summary of diffs:
> > I'll concentrate on the fetching from svn, writing a remote helper
> > without branch detection (like svn-fe) first, and then creating the
> > branch mapper.
> Thanks for the update.
>=20
> If I understand correctly, the remote helper from the first half woul=
d
> do essentially the same thing as Dmitry's remote-svn-alpha script.
> Since in shell script form it is very simple, I don't think it should
> take more than a couple of days to write such a thing in C.

If the remote-svn-alpha script is really all that needs to be done, you=
're=20
right. It just pipes through svn-fe. I thought svn-fe could only import=
 an svn=20
repo initially, and there would be some difference between importing th=
e whole=20
history and fetching new revisions later, (?).

> Via
> > Timeline
> >=20
> > GSoC timeline and summer holidays
> > Summer holidays in Austria at 9th of July. So until the mid-term
> > evaluations my git project will have co-exist with my regular
> > university work and projects. But holidays extend until the beginni=
ng
> > of October, so there=E2=80=99s some time left to catch up after the=
 official
> > end of GSoC.
>=20
> Another possibility that some people in similar situations have
> followed is to start early.  That works a little better since it mean=
s
> that by the time midterm evaluations come around we can have a
> reasonable idea of whether a change in strategy is needed for the
> project to finished on time.
>=20
> > I plan to split the project in two parts:
> >=20
> > Writing the remote helper using existing functions in vcs-svn to
> > import svn history without detecting branches, like svn-fe does.
> > Milestone: 9th of July, GSoC mid-term
> >=20
> > Writing a branch mapper for the remote helper that reads the config
> > language (SBL) and imports branches trying to deal as good as possi=
ble
> > with all the little pitfalls that will occur. Milestone: 20th of
> > August, GSoC end
>=20
> Could you flesh out this timeline more?  Ideally it would be nice to
> have a definite plan here, even to the point of listing what patches
> would need to be written, so during the summer all that would need to
> happen is to execute and deal with bugs as they come.

Listing patches and planing all details in the submitted proposal would=
=20
require me to know what I do and how I will do it all before last Frida=
y! As=20
I'm not yet an expert on this topic, I don't know how I could have know=
n all=20
details a-priori.
Of course the project's documentation will evolve outside the GSoC proj=
ect=20
proposal, which cannot be changed anymore.

>=20
> Given the goal described here of an import with support for
> automatically detecting branches, here are some rough steps I imagine
> would be involved:
>=20
>  . baseline: remote helper in C
>=20
>  . option to import starting with a particular numbered revision.
>    This would be good practice for seeing how options passed to
>    "git clone -c" can be read from the config file.
>=20
>  . option or URL schema to import a single project from a large
>    Subversion repository that houses several projects.  This would
>    already be useful in practice since importing the entire Apache
>    Software Foundation repository takes a while which is a waste
>    when one only wants the history of the Subversion project.
>=20
>    How should the importer handle Subversion copy commands that
>    refer to other projects in this case?
>=20
>  . automatically detecting trunk when importing a project with the
>    standard layout.  The trunk usually is not branched from elsewhere
>    so this does not require copyfrom info.  Some design questions
>    come up here: should the remote helper import the entire project
>    tree, too?  (I think "yes", since copy commands that copy from
>    other branches are very common and that would ensure the relevant
>    info is available to git.)  What should the mapping of git commit
>    names to Subversion revision numbers that is stored in notes say
>    in this case?
>=20
>  . detecting trunk and branches and exposing them as different remote
>    branches.  This is a small step that just involves understanding
>    how remote helpers expose branches.
>=20
>  . storing path properties and copyfrom information in the commits
>    produced by the vcs-svn/ library.  How should these be stored?
>    For example, there could be a parallel directory structure
>    in the tree:
>=20
> 	foo/
> 		bar.c
> 	baz/
> 		qux.c
> 	.properties/
> 		foo.properties
> 		foo/
> 			bar.c.properties
> 		baz/
> 			qux.c.properties
>=20
>    with properites for <path> stored at .properties/<path>.properties=
=2E
>    This strawman scheme doesn't work if the repository being imported
>    has any paths ending with ".properties", though.  Ideas?
>=20
>  . tracing history past branch creation events, using the now-saved
>    copyfrom information.
>=20
>  . tracing second-parent history using svn:mergeinfo properties.
>=20
> In other words, in the above list the strategy is:
>=20
>  1. First convert the remote helper to C so it doesn't have to be
>     translated again later.
>=20
>  2. Teach the remote helper to import a single project from a
>     repository that houses multiple projects (i.e., path limiting).
>=20
>  3. Teach the remote helper to split an imported project that uses
>     the standard layout into branches (an application of the code
>     from (2)).  This complicates the scheme for mapping between
>     Subversion revision numbers and git commit ids.
>=20
>  4. Teach the SVN dumpfile to fast-import stream converter not to
>     lose the information that is needed in order to get parenthood
>     information.
>=20
>  5. Use the information from step (4) to get parenthood right for a
>     project split into branches.
>=20
>  6. Getting the second parent right (i.e., merges).  I mentioned
>     this for fun but I don't expect there to be time for it.
>=20
> Does that seem right, or does it need tweaks?  How long would each
> step take?  Can the steps be subdivided into smaller steps?
>=20
> Another question is: what is the design for this?  With the existing
> remote-svn-alpha script, there are a few different components with
> well defined interfaces:
>=20
> 	commands like "git fetch"
>=20
> 	  | (1)
>=20
> 	transport-helper --- (2) --- git fast-import
>=20
> 	  | (2, 3)                        |
>=20
> 	remote-svn-alpha                  | (3)
>=20
> 	  |             ''..              |
> 	  |=20
> 	  | (2)             ''(2)..       |
> 	  |=20
> 	  |                        ''..   |
>=20
> 	svnrdump --------- (3) -------- svn-fe
>=20
>  (1) communicates using function calls and shared data
>  (2) launches
>  (3) communicates over pipe
>=20
> Once remote-svn-alpha is rewritten in C, the same structure is still
> present, though it might be less obvious because some of the (2)
> and (3) can change into (1).
>=20
> Where does the functionality you are adding fit into this picture?
> Are there any new components being added, and if so what do they take
> as input and output?

I planned to implement a remote-helper using the existing interface=20
specification to communicate over pipes with git's transport-helper.=20
Instead of invoking svn-fe as a subprocess, I want to call vcs-svn/ fun=
ctions=20
directly from the remote-helper and place new functions in this directo=
ry (?).
To communicate with svn, the remote-helper launches svnrdump as a subpr=
ocess.
Additionally the remote-helper will read a configuration file containin=
g=20
additional information about branch-mapping, this should be closely rel=
ated to=20
Andrew's SBL.

>=20
> Hope that helps,
> Jonathan
>=20
> > [1] https://github.com/flyingflo/git/wiki/

=46lorian
