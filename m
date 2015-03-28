From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: how to make "full" copy of a repo
Date: Sat, 28 Mar 2015 19:52:06 +0100
Message-ID: <5516F856.9010100@web.de>
References: <1427511397.19633.52.camel@scientia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Christoph Anton Mitterer <calestyo@scientia.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 28 19:52:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbvqC-0000Ml-Lk
	for gcvg-git-2@plane.gmane.org; Sat, 28 Mar 2015 19:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbbC1SwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2015 14:52:11 -0400
Received: from mout.web.de ([212.227.17.12]:57072 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024AbbC1SwK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2015 14:52:10 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0Lba7D-1ZLg3o14m3-00lGML; Sat, 28 Mar 2015 19:52:07
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <1427511397.19633.52.camel@scientia.net>
X-Provags-ID: V03:K0:ZphUYRD/Sa1g3HALNEasyGZHItfwTzPq8XIvwPZuz2WT70/wIFX
 pDLgWLDzXF5jtIpP0B9iWjrQJQBmtH07ECRQRRz4HOcppRoEUUnwbluSUcl3/x7r9Ipc9fV
 GWUCVq4a3o1rQFRnj7BsllOMRo2ZqYMMfNkwD0CK5R6ONsovDMmeTJsNwRMoi2JU/xD9lAT
 NLIyUu5p6W7rrF9q7UVgQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266422>

On 2015-03-28 03.56, Christoph Anton Mitterer wrote:
> Hey.
> 
> I was looking for an ideally simple way to make a "full" copy of a git
> repo. Many howtos are floating around on this on the web, with also lots
> of voodoo.
> 
> 
> First, it shouldn't be just a clone, i.o.w.
> - I want to have all refs (local/remote branches/tags) and of course all
> objects from the source repo copied as is.
> So it's local branches should become my local branches and not remote
> branches as well - and so on.
> Basically I want to be able to delete the source afterwards (and all
> backups ;) ) and not having anything lost.
> 
> - It shouldn't set the source repo as origin or it's branches as remote
> tracking branches, as said it should be identical the source repo, just
> "freshly copied" via the "Git aware transport mechanisms".
> 
> - Whether GC or repacking happens, I don't care, as long as nothing that
> is still reachable in the source repo wouldn't get lost (or get lost
> once I run a GC in the copied repo).
> 
> - Whether anything that other tools have added to .git (e.g. git-svn
> stuff) get's lost, I don't care.
> 
> - It should work for both, bare and non-bare repos, but it's okay when
> it doesn't copy anything that is not committed or stashed.
> 
> 
> 
> I'd have said that either:
> $ git clone --mirror URl-to-source-repo copy
> for the direction from "outside" the source to a copy,
> or alternatively:
> $ cd source-repo
> $ git push --mirror URl-to-copy
> for the direction from "within" the source to a copy with copy being an
> empty bare or non-bare repo,
> would do the job.
> 
> But:
> 
> a) but the git-clone(1) part for --mirror:
>    >and sets up a refspec configuration such that all these refs are
>    >overwritten by a git remote update in the target repository.
>    kinda confuses me since I wanted to get independent of the source
>    repo and this ssems to set up a remote to it?
> 
> b) do I need --all --tags for the push as well?
> 
> c) When following
>    https://help.github.com/articles/duplicating-a-repository/
>    it doesn't seem as if --mirror is what I want because they seem to
>    advertise it rather as having the copy tracking the source repo.
>    Of course I read about just using git-clone --bare, but that seems to
>    not copy everything that --mirror does (remote-tracking branches,
>    notes).
> 
>    So I'm a bit confused...
This instructions have 3 repos:
the source, "old", the destination "new" and a temporary one.
As you only push to "new", "new" should have no information about
"old" or "temp".
> 
> 
> 1) Is it working like I assumed above?
> 2) Does that also copy things like git-config, hooks, etc.?
> 3) Does it copy the configured remotes from the source?
> 4) What else is not copied by that? I'd assume anything that is not
>    tracked by git and the stash of the source?

You didn't write if this is a bare repository,
if it is on a local disc, if it is reachable by rsync ?
Linux or Windows ?

For a "full clone" (in the sense of having everything, bit for bit)
I would probably use rsync. (After stopping all activities on the repo)

But I don't know where you repos life, are they bare or not, so there
may be other ways to go.

> 
> 
> Thanks a lot,
> Chris.
> 
