From: Deskin Miller <deskinm@umich.edu>
Subject: Re: git-svn: ignoring a bogus svn revision ?
Date: Mon, 4 May 2009 00:28:03 -0700
Message-ID: <86d4c5e00905040028v1136e49cn5478e6a50020ab0d@mail.gmail.com>
References: <a70244740905031224j6b215bcfxfe11bf5ae84c70fd@mail.gmail.com>
Reply-To: deskinm@umich.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Noble <pixel.nobis@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 04 09:28:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0sb1-0000ZP-2g
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 09:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147AbZEDH2I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 May 2009 03:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752600AbZEDH2G
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 03:28:06 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:52326 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbZEDH2E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 May 2009 03:28:04 -0400
Received: by yx-out-2324.google.com with SMTP id 3so2136844yxj.1
        for <git@vger.kernel.org>; Mon, 04 May 2009 00:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:reply-to:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=2olFw1qsXfGcZXWVFQvJd1lAEbV1Ok6wzUoXX6s8QXI=;
        b=efZsLW2Mb/0rta6jn8F0bBprLvD9zsUZXL6MhyzNIQ7mqbWl2h07VC5NVLFtRtrYmd
         of1wPcuftk+lylQ7xyfBtP7SNBt+ze61Xpy1njfCJ51b2ePWXhdCm1j8FX0NTQ3zHYAu
         HOq3TROxS4+iVRmKIB4emtt0zYHrBGR3mvMGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:reply-to:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=bEewgXSIpKkKPy1CR6QTG6PwsZfaxBMlVcH46ClBXQ4DmKEK7VkA0gXgAuL7CJ4SvY
         8GbZnhZJnsszEPyQwlnZdjYNQGJOuuWYBYGszXnrIUVH5cHK5MIpwFyOi17LqxuqTrTk
         2a5h7hQgT+TzKAGozVoulEahEh++Cnt1wkRLE=
Received: by 10.151.134.13 with SMTP id l13mr11510713ybn.217.1241422083399; 
	Mon, 04 May 2009 00:28:03 -0700 (PDT)
In-Reply-To: <a70244740905031224j6b215bcfxfe11bf5ae84c70fd@mail.gmail.com>
X-Google-Sender-Auth: eedae97d5df404f0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118218>

On Sun, May 3, 2009 at 12:24, Nicolas Noble <pixel.nobis@gmail.com> wro=
te:
> Hello,
>
> =C2=A0I'm a frantic user of git-svn at work, as my company uses SVN a=
s a
> SCM for all of our projects. I've been very happily using git-svn ove=
r
> our repositories since quite some time, and I think I managed to
> convert a couple of colleagues by doing so.
>
> =C2=A0But now I'm facing an interesting issue. Our biggest repository=
 has
> over 102600 revisions, and initializing from scratch the git
> repository up to this revision takes approximately 2 days of computer
> work. The trouble begins with revision 102601... Up so far the
> repository was in a perfect shape, and no one did any huge mistake. O=
n
> revision 102601 however, someone branched... /. Not /trunk, but /,
> which means the whole nine yards, containing tags, branches, and
> trunk.
>
> =C2=A0So I'm stuck with this:
>
> repository-up-to-102600$ git branch -r | wc -l
> 1824
>
> =C2=A0And when I issue a git-svn fetch --no-follow-parent --revision
> 102601, git-svn starts trying to fetch all of these 1824 branches and
> tag, obviously. I had to add the --no-follow-parent otherwise git-svn
> would just go nuts. Now if it wasn't for the loosy svn server
> disconnecting me after 2 or 3 days of work trying to check out this
> branch, git-svn would probably manage to get over it. But the server
> can't keep up it seems, and I eventually get disconnected, which mean=
s
> I have to do it all over again.
>
> =C2=A0Of course, this svn commit is undeniably bogus, and no one will=
 ever
> be able to check it out and work on it for real. However, this doesn'=
t
> disrupt the usual course of work for other SVN users, but just
> prevents anyone from using git-svn ever again on this repository.
>
> =C2=A0I've tried to look into how to remove/amend this svn revision
> directly onto the server, but even if some documentation was telling
> me how to do so (which isn't the case), our IS crew is just too
> stubborn, and fills my requests back with "Please use a SVN client
> supported by the IS crew; you can find links on this page...". I'm
> still going to try to go through this path though, as I feel this is
> probably the right thing to do, (apart holding my boss hostage in his
> office until they finally decide to switch over to git completely, an=
d
> stop using a piece of software that allows you to push bogus commits)
>
> =C2=A0So on the other hand, I'm looking at how git-svn works, and I'm
> trying to jump around this utterly bogus svn revision. I haven't foun=
d
> any information at all about how I could skip this revision, and even
> though I'm all willing to make some tests on the git repository itsel=
f
> by tweaking it, I'd hate to leave it in a broken state that would
> explode in my hands several weeks/month later. Thus I think I'd bette=
r
> ask the authors directly, in order to know how I could achieve that i=
n
> a way that isn't too disruptive.

I should probably say now that it's a good idea to back up your git
repository, by making a plain old directory copy, before trying any of
the stuff here; especially given that you're up to 100000 revisions, I
wouldn't want you to have to wait two more days because I gave bad
advice.  Using cp is necessary to back up the metadata related to
git-svn which isn't transferred through a normal git clone.

=46ortunately there's a relatively painless way to avoid the bad svn
revision, by using the -r$m:$n flag to git svn fetch, where $m and $n
are integers.  If you do e.g.

$ git svn fetch -r1:102600
$ git svn fetch -r102602:HEAD

git-svn will happily skip over the bad revision 102601, and fetch
102602 up to the latest svn revision, creating a history with the same
tree content but skipping that commit.  From a git mindset, the
general case of this is very much like squashing several commits in to
one- the resultant tree is the same but some history has been omitted
or 'cleaned up'.  Note that HEAD on the command line here is *not* the
same as git's HEAD; it is rather an svn keyword meaning the latest
revision number.

There are potentially two complications with this approach; neither is
very serious, and the bottom line is that you might have to continue
doing a command like the above to fetch, with an explicit revision
range, instead of omitting them entirely.

The first complication is that your svn repository will most likely
revert commit 102601 by deleting the offending branch in a later
commit.  In this case, you have not one, but two bad revisions to
avoid.  Not to worry- one can simply grab the range in between the two
bad commits as illustrated above; suppose the revert happened in
commit 102644:

$ git svn fetch -r1:102600 # up to bad branch creation
$ git svn fetch -r102602:102643 # between bad create and delete
$ git svn fetch -r102645:HEAD # up to most recent

Note that the revision numbers specified with -r are inclusive on both
ends, that is, you'll get commits corresponding to both the low and
high revision number (if the commits are interesting to your view of
svn).  Additionally, you should be able to see how to generalise this
from here, for n arbitrary bad commits.

The second complication, and I only mention this because I can't test
the behaviour right now, is that even after fetching up past the bad
revision(s) to svn HEAD, you may need to continue to specify an
explicit revision range to avoid the bad commit(s).  This is because
git-svn tries to fetch from the revision of the latest commit it
obtained from svn when you don't specify an explicit revision range.
Consequently, if none of the revisions after the bad commit(s) were
interesting to you (perhaps they were on other projects in the same
svn repo, or in branches you aren't interested in), then when you go
to run git svn fetch again, your repository hasn't 'recorded' any
history which omits the bad commits, since there hasn't been anything
to fetch yet.  In this case, you need to continue to use the explicit
revision numbers, as appropriate, until you have actual commits
corresponding to later revisions than the bad ones.

Actually, it is more strict than that- to be safe, use the explicit
revision numbers until your git view of svn trunk has a commit after
the bad revision number(s).  In other words, it's not enough for some
branches to get commits which come after the bad revision; until trunk
moves forward, you should continue using the explicit revision range.
It's possible I'm mistaken on this necessity, but better safe than
sorry; if you want to experiment on your repository, feel free.

Other things to consider when doing this, perhaps more for others
reading along: I strongly discourage doing this for anything but
pathological cases like yours; that is, don't be tempted to tidy up
svn history by skipping commits, perhaps saying to yourself 'but the
trees end up the same, and those svn users probably would've squashed
these commits themselves if only they were using a DVCS'.  You will
regret it.  Doing so would be akin to cloning a public git repository,
squashing already-public commits together, and expecting others to
follow how your clone and the origin are related.  Skipping svn
revisions should rather be viewed as a nuclear option, used only when
there's really truly no other way to progress, like your case.

Let me say it again, because I've seen plenty of people on IRC who
think that git-svn is hanging, when it's not, and I don't want them to
think that the way around this supposed hang is to skip the nasty
revision: Don't do it unless you're absolutely sure you need to.

Hope that helps,

Deskin Miller
