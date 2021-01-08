Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F4DC433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 14:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E90C8208C7
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 14:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbhAHO3y convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 8 Jan 2021 09:29:54 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:57765 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbhAHO3x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 09:29:53 -0500
Received: from oxbsltgw64.schlund.de ([172.19.249.154]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mlvr3-1kGoDq3RUB-00j3mM; Fri, 08 Jan 2021 15:27:13 +0100
Date:   Fri, 8 Jan 2021 15:27:12 +0100 (CET)
From:   - - <sven@nichtgerade.de>
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>
Message-ID: <1441960943.306435.1610116032985@email.ionos.de>
In-Reply-To: <05fafba4-6415-7b61-92ae-112bdc8fd7be@gmail.com>
References: <898607890.216528.1609892347792@email.ionos.de>
 <05fafba4-6415-7b61-92ae-112bdc8fd7be@gmail.com>
Subject: Re: [Bug] 'git submodule update --single-branch' still fetching
 master
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.3-Rev28
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:bc0NgO6nh94BS4Mfa3jbYoUiOUXj9fbZPZCgFxxBFpShUYynRU3
 0XOf//gaUpNvhB4HkzskCw4Fq1Q9lrJMfG4ZTTpwx50q7jFu/mD3WMeVzW7/jy16pJ6+Hlm
 /1iexBSe0JuW+wh8JkJGmGgJEy9J5nhhxr7BEnXzU/ZOeXgpL8XdD3CyniAeuB5JPhlA1d9
 OAe6A1rdv1wrwiODGkLCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CtOa8Er/hkc=:SVOomhQEtO7V0kcAXUSZw1
 lKdHW9TbNFVZIEDQnRoXEbND0vg6Jivbrc9+Sf21rg7YR88z27ngf+fcrUxclmpoDWe+51kj7
 uOE+u4TW9xIND/jsrVIqcT/B0C59AyYzpdHRJCQZyZz85S5WbNHipSEc1/LRcbjLm2TTyir9L
 sFQ3+l2CgQfKgZz1CCQdLBsZ9u1BzeKhGmkbW2p14bS1cEqtsOrtI0Le/FZf9N4iepa2BUp+J
 zv41xfswnSkD8FiysLOW9glxqUPhRqsIuocb2rA/QgVVLyi9z2+v/9azpF81lF1xIflbHwcUG
 AAXHDrtmgBngB2MSizviS07wXmu4ccnVtOO6GlBREblTOS17AqEipOkzJOpAQ1DJPUAcq10mN
 Fw4XlmWKaGCxfiZpmabxXX6sv4D5f6ZZtbciIDJ+DEp7Gm307fyL6sHM+DIiDUqcJ3Pou2nyG
 iBuOjqaI1Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Philippe,

Thanks for your fast and very detailed feedback! Please find below some further details.

> Philippe Blain <levraiphilippeblain@gmail.com> hat am 06.01.2021 20:30 geschrieben:
> 
> 
> Hi Sven,
> 
> Le 2021-01-05 à 19:19, - - a écrit :
> > Hello,
> > 
> > I encountered today some problems while trying to track a single branch with 'git submodule add' and 'git submodule update'. Please find my bug report below.
> > Any help would be very welcome! :)
> > 
> > Kind regards,
> > Sven Krummen
> > 
> > 
> > What did you do before the bug happened? (Steps to reproduce your issue)
> > I've got two repositories, 'project' and 'lib', and I want to add 'lib' into 'project' as a git submodule.
> > The 'lib' repository contains the 'master' branch, which is quite heavy-weighted (~900MB), and a 'light' branch (~10MB) with a mostly unrelated history to 'master'. The 'master' branch is the default branch.
> > Similar to using 'git clone -b light --single-branch path/to/lib' I want to track only the 'light' branch as a submodule to reduce traffic on our build server.
> Thanks for a nice scenario description. Just a note on wording though (to make sure
> we are on the same page): you can't have a submodule "track" a branch, at least
> not in the sense that the submodule is always "checked out" on a branch, and the superproject
> knows that the submodule should always be "on that branch"; that's not how submodules work.
> As specified in [1], the config `submodule.<name>.branch` is only ever used by
> `git submodule update --remote`, i.e. the superproject itself only records at which *commit* the
> submodule is at.

Agreed & understood. :)

> > To add the submodule to 'project' I tried to run:
> > (a) 'git submodule add -b light path/to/lib'
> > (b) 'git submodule add -b light --single-branch path/to/lib'
> > But git was always fetching the whole 'master' branch of 'lib' before switching to 'light'.
> That's not a bug (in my opinion) since it's in a line with the documentation [1].
> There is no way at the moment for the initial `git submodule add` to pass
> '--single-branch' and '--branch' to the underlying `git clone`.

OK, after further reading the documentation I think I now better understand the intended behaviour of (a) and agree that this is not a bug. However, if this is the default behaviour, I would appreciate a way to somehow pass '--single-branch' and '--branch' to the underlying 'git clone' when calling 'git submodule add'. In my use-case I want to avoid fetching the 'master' branch by any measure, as it is heavy-weighted and simply not needed.
Personally, I think it would be very valuable to introduce the '--single-branch' option to 'git submodule add' to achieve this behaviour (as in (b)).

> > After commiting & pushing everything to 'project''s remote, I started over with a fresh clone of 'project' to test whether 'git submodule update' would only fetch the 'light' branch (typical use-case for our build jobs):
> > (c) 'git clone path/to/project && cd project'
> > (d) 'git submodule update --init --remote --single-branch lib'
> > But again, git was fetching the whole 'master' branch of 'lib' before switching to 'light'. This behaviour seems to be independent of the used options of 'git submodule update'.
> > 
> 
> I can partly reproduce that behaviour. The following script creates "lib" with two branches,
> master and light, that *do not* share any history.
> 
> ~~~
> #!/bin/bash
> 
> TEST_AUTHOR_LOCALNAME=author
> TEST_AUTHOR_DOMAIN=example.com
> GIT_AUTHOR_EMAIL=${TEST_AUTHOR_LOCALNAME}@${TEST_AUTHOR_DOMAIN}
> GIT_AUTHOR_NAME='A U Thor'
> GIT_AUTHOR_DATE='1112354055 +0200'
> TEST_COMMITTER_LOCALNAME=committer
> TEST_COMMITTER_DOMAIN=example.com
> GIT_COMMITTER_EMAIL=${TEST_COMMITTER_LOCALNAME}@${TEST_COMMITTER_DOMAIN}
> GIT_COMMITTER_NAME='C O Mitter'
> GIT_COMMITTER_DATE='1112354055 +0200'
> export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
> export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
> export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
> 
> mkdir test
> cd test
> 
> rm -rf project lib clone
> 
> git init lib && cd lib
> echo "content">file
> git add file
> git commit -m "initial on master in lib"
> git checkout --orphan light
> echo "content">file
> git add file
> git commit -m "initial on light in lib"
> # Switch HEAD back to master
> git checkout master
> cd ../
> 
> git init project && cd project
> echo "content">file
> git add file
> git commit -m "initial in proj"
> git submodule add -b light ../lib
> git commit -m "add lib to project"
> cd ../
> 
> git clone project clone && cd clone
> echo 'RUNNING: git submodule update --init --remote --single-branch'
> # This fails
> git submodule update --init --remote --single-branch
> echo 'RUNNING: ls -al lib'
> ls -al lib
> echo 'RUNNING: git -C lib ls-files -s'
> git -C lib ls-files -s
> echo 'RUNNING: git -C lib branch --all'
> git -C lib branch --all
> echo 'RUNNING: git -C lib config --get remote.origin.fetch'
> git -C lib config --get remote.origin.fetch
> # Try to update again
> echo 'RUNNING: git submodule update'
> GIT_TRACE2=1 git submodule update 2> >(grep -E 'start git fetch|^From|^ \*' )
> ~~~
> 
> The output should end with:
> 
> RUNNING: git submodule update --init --remote --single-branch
> Submodule 'lib' (/Users/Philippe/Code/GIT-devel/test/lib) registered for path 'lib'
> Cloning into '/Users/Philippe/Code/GIT-devel/test/clone/lib'...
> done.
> fatal: Needed a single revision
> Unable to find current origin/light revision in submodule path 'lib'
> RUNNING: ls -al lib
> total 8
> drwxr-xr-x 3 Philippe staff 102 Jan 6 14:03 .
> drwxr-xr-x 6 Philippe staff 204 Jan 6 14:03 ..
> -rw-r--r-- 1 Philippe staff 28 Jan 6 14:03 .git
> RUNNING: git -C lib ls-files -s
> RUNNING: git -C lib branch --all
> * master
> remotes/origin/HEAD -> origin/master
> remotes/origin/master
> RUNNING: git -C lib config --get remote.origin.fetch
> +refs/heads/master:refs/remotes/origin/master
> RUNNING: git submodule update
> 14:14:09.745288 common-main.c:49 start git fetch
> 14:14:09.892463 common-main.c:49 start git fetch origin cc09362ae7314174785faed3e5ee72a8e2db5460
> From /Users/Philippe/Code/GIT-devel/test/lib
> * branch cc09362ae7314174785faed3e5ee72a8e2db5460 -> FETCH_HEAD
> Submodule path 'lib': checked out 'cc09362ae7314174785faed3e5ee72a8e2db5460'
> 
> You can see that the first 'git submodule update --init --remote --single-branch'
> fails. 'ls' and 'ls-files' tell us that the submodule is not checked out,
> and that the submodule index is empty.
> 'git branch' and 'git config' then reveal that indeed only the 'master' branch exists
> in the submodule, so '--single-branch' was passed correctly but not the branch itself.
> Afterwards, issuing 'git submodule update' a second time will issue a simple 'git fetch',
> which will not work because of the single-branch refspec, then it will try fetching
> the commit by its hash, which works, and then it will checkout that commit.

Thanks for your work! I can confirm that your script is reproducing the bug.
However, I could observe when removing the '--remote' option, that 'git submodule update' would already fetch & checkout the commit during the first run: 

RUNNING: git submodule update --init --single-branch
Submodule 'lib' (D:/Repositories/test/lib) registered for path 'lib'
Cloning into 'D:/Repositories/test/clone/lib'...
done.
From D:/Repositories/test/lib
 * branch            cc09362ae7314174785faed3e5ee72a8e2db5460 -> FETCH_HEAD
Submodule path 'lib': checked out 'cc09362ae7314174785faed3e5ee72a8e2db5460'
RUNNING: ls -al lib
total 2
drwxr-xr-x 1 krum_sv 1363622  0 Jan  8 13:37 .
drwxr-xr-x 1 krum_sv 1363622  0 Jan  8 13:37 ..
-rw-r--r-- 1 krum_sv 1363622 28 Jan  8 13:37 .git
-rw-r--r-- 1 krum_sv 1363622  9 Jan  8 13:37 file
RUNNING: git -C lib ls-files -s
100644 d95f3ad14dee633a758d2e331151e950dd13e4ed 0       file
RUNNING: git -C lib branch --all
* (HEAD detached at cc09362)
  master
  remotes/origin/HEAD -> origin/master
  remotes/origin/master
RUNNING: git -C lib config --get remote.origin.fetch
+refs/heads/master:refs/remotes/origin/master
RUNNING: git submodule update

> Looking at commit 132f600b06 (clone: pass --single-branch during,
> --recurse-submodules, 2020-02-20), which introduced the '--single-branch'
> option for 'git submodule update', it seems that what we have at the moment
> is partly a documentation bug, i.e. the doc should say
> "Clone only the history leading up to the remote HEAD during update",
> and not mention '--branch' at all. I'm CC-ing Emily and Peff who were involved
> in that series. Looking at the mailing list thread where
> this feature was discussed [2], it seems that mentioning 'branch' in the description
> of 'single-branch' was just a leftover from v1 of the series that was forgotten
> in later iterations.

I do not fully agree that this is just a documentation bug, as in my use-case I do not want fetch the 'master' branch at all (~900MB vs. ~10MB traffic on our build servers for each job). As you can see in the output above the remote HEAD (pointing to 'master') will be fetched any time. However, for fetching the 'light' branch, or the corresponding commit by hash, this traffic would not be necessary.
In the example script this problem is not so obvious as the 'master' branch does not contain any large files.

> Also,looking at the code, the '--remote' option has no effect at all for the initial clone
> of the submodule. It is only taken into account after the initial clone.
> I think it would make sense for it to also influence the initial
> clone, so that it would behave as you expect, i.e. the code looks at the branch
> in '.gitmodules' and this branch is passed to the underlying 'git clone' if '--single-branch'
> was passed to 'git submodule update'.

Please see above the different behaviour with or without the '--remote' option - I guess we have here two closely related bugs.
Besides that, I agree that the '--remote' option should also influence the initial clone.

> > What did you expect to happen? (Expected behavior)
> > (a) or (b) To create a submodule which is tracking the 'light' branch of 'lib' and to fetch *only* this branch.
> That would be a diffenret feature request, and I think it does make sense
> for (b) to work. I don't think that '--branch' should automatically
> imply '--single-branch' though (i.e. I don't think (a) should change
> behaviour).

Yes, adding the '--single-branch' option to 'git submodule add' would be very helpful!

> > (d) To fetch and checkout *only* the 'light' branch of 'lib'.
> > 
> > 
> > What happened instead? (Actual behavior)
> > (a) Fetching 'master' (or the full 'lib' repo?), then checking out the 'light' branch.
> Yes, this does a plain 'git clone' so all branches are fetched.
> 
> > (b) Error as option '--single-branch' is not supported for 'git submodule add'.
> > (d) Fetching 'master' (or the full 'lib' repo?), then checking out the 'light' branch.
> As my script above shows, this does fetch only the 'master' branch, and then *if* we issue
> a second 'git submodule update' it then fetches the required commmit by hash and checks it out.
> It would be nice if you could send a reproducer (i.e. a complete script like the above) that
> shows exactly the behaviour you are seeing, if indeed in your scenario it really checks out
> the 'light' branch. I'm not sure I understand how that could happen...

Sorry, I think I was describing the behaviour of 'git submodule update --init --single-branch' instead
of 'git submodule update --init --remote --single-branch' (I've been playing around with a lot of different setups). 
Your script is reproducing this bug quite well when omitting the '--remote' option, so I recommend to stay with this baseline.

> > What's different between what you expected and what actually happened?
> > As the 'master' branch of 'lib' is quite heavy-weighted, I do not want to fetch 'master' at all. By using the option '-b light' to specify which branch shall be tracked, there is no need to fetch other branches besides 'light'. I'm not sure if it is really necessary for 'git submodule add' to fetch anything, as this could also be done by a subsequent 'git submodule update'.
> In the past, 'git submodule add' used to not clone the submodule at all,
> but this was deemed not very useful so now it does 'git clone' underneath.
> 
> > Anything else you want to add:
> > This issue could be related to: https://stackoverflow.com/questions/61483547/how-to-shallow-pull-submodule-that-is-tracked-by-branch-name
> 
> 
> Hope that helps,
> 
> Philippe.
> 
> [1] https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt--bltbranchgt
> [2] https://lore.kernel.org/git/20200108231900.192476-1-emilyshaffer@google.com/t/#u

Thanks for your help! :)

Kind regards,
Sven Krummen
