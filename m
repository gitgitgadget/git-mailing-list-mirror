Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F78C46467
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 08:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbjAKImd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 03:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237426AbjAKImB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 03:42:01 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE976548
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 00:41:14 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id bx6so15307098ljb.3
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 00:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/xP6EddmTtGuWYbF+Dl4qdOgpvhV8p4y5smA3SA/RTk=;
        b=aQdMNtyfKGi8UR/lvgAL9VKQi10s0JtYqlGSGj91CnGZwrsSvh1HAAEL+ZQWgxRWGo
         mq34Df+REUlOPcpLQVMXla+fszi9ed8+4Rpxu40SUtTM+ALVm45S7sxwdolQ0DIAxE3G
         4uIobABpwqMr23O5QfWECqRAwnZK7ZCj2VASsDkSStgaqwKQGgkICWAd+xNIlujdviGZ
         zagO2oJOVrTElbAULPxUQ9gfxXmyOzrTTrJMagoygfEVvRw9ZAV2Jq9UjYCzR13TbYov
         teIikqeOMiU4b0Dzht17S+N4ae0M59gLmfqxXIf9BVSN5SpqVxmr5bH1qrenoeEoST8W
         cAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xP6EddmTtGuWYbF+Dl4qdOgpvhV8p4y5smA3SA/RTk=;
        b=deMuSmnDdbdWv3Z34lRzbY3mxMQ26y0x+nbVuNCkNFnpGhhj0+rIFG9AABmHQcc+bE
         DhHi47JBXxm64LuAnH2TJ9+PffQK31spfoXF+Nr6STxujyYc+g5S9kJ/KLotAv4GIK3m
         tph3UlSZBrI2oP+4gKmu9TK4XeIGLs3I4zLIui1/E1vo1xFHbjq+2jfmClL/hvNpv6L9
         LKjl0gy6Uw0ZA/O77ymhOkBcYMtuFnsaVJkFPGck0ci4JoLFcC4dUG2umQR8H766T5kh
         2X0NhcdUzLqaiMa7Xo6EH4qwOkbs3jtoD64u/lpRmVOCEG+cSDX1ETF9++jeF8rWFfAe
         osbQ==
X-Gm-Message-State: AFqh2kp7hS3N9Gri9aSv19ZdoTVVenP8Z9UGl09d485rNaCHvMZXu3tf
        z4D5QscuGJQzG82Maft+84RrW7mJP+6AmuvGVGY=
X-Google-Smtp-Source: AMrXdXvgQe+ufgUW3Wm8GpT4jdmgy5puFIgCeqQHboXEUrDJgx179a/kusP6wz97fI+cDvbUTUVbIXbtuu1rGN/KlFI=
X-Received: by 2002:a2e:b0d5:0:b0:27f:b2a7:1f1a with SMTP id
 g21-20020a2eb0d5000000b0027fb2a71f1amr4919727ljl.325.1673426472617; Wed, 11
 Jan 2023 00:41:12 -0800 (PST)
MIME-Version: 1.0
References: <PH7PR12MB779560B6C003FEE76E4F2471F1FE9@PH7PR12MB7795.namprd12.prod.outlook.com>
 <CABPp-BE_FLFL3-s3936zWWfaORBPim14A-oqVNo+8gx+CMduHA@mail.gmail.com>
 <PH7PR12MB7795ED45E989E2EDE2364049F1FF9@PH7PR12MB7795.namprd12.prod.outlook.com>
 <CABPp-BGh17pH1DUgPOoaDKBcKay3NAyi4js-HnEKAAyYUBSoYQ@mail.gmail.com>
In-Reply-To: <CABPp-BGh17pH1DUgPOoaDKBcKay3NAyi4js-HnEKAAyYUBSoYQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 11 Jan 2023 00:41:00 -0800
Message-ID: <CABPp-BHBEng3=_mLgdKu+ZNGfSZdcZUZZCX-p9two+af+GecfQ@mail.gmail.com>
Subject: Re: Reducing Git Repository size - git-filter-repo doesn't help
To:     fawaz ahmed0 <fawazahmed0@hotmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 10, 2023 at 6:18 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Jan 10, 2023 at 12:18 AM fawaz ahmed0 <fawazahmed0@hotmail.com> wrote:
> >
> >
> > > Note that git-filter-repo only changes the size of the _local_ repo.
> >    You made an additional clone within GitHub Actions, and then
> >    filter-repo shrinks *that* clone.  Even if you had deleted all copies
> >    of older files you don't want anymore locally (which is suspect as I
> >    noted above), your force pushing isn't going to shrink the size of the
> >    repo on the server (i.e. on GitHub) since there are pull requests in
> >    your repo that GitHub won't allow you to overwrite via force-push, and
> >    those pull requests still hold on to the old history.
> >
> > Thanks for your inputs. Yes, the issue is with the GitHub itself (I have verified it locally), so when I force push this reduced sized repo to Github and reclone it back the size gets back to  4+ GB.
> > So what do you suggest?
>
> Well, digging a bit further, I see:
> ```
> $ git ls-remote https://github.com/fawazahmed0/currency-api
> 5536f2096aec71cee6d35772697ce1efc6148521 HEAD
> 5536f2096aec71cee6d35772697ce1efc6148521 refs/heads/1
> 7ed955eebe2e5a670566d5fb4e11142bae6afed6 refs/heads/patch-1
> 0292ec7340ec1ac8cd11d5839b8a25dd0c1db38f refs/pull/1/head
> fa18a4ae50cc8ad84643d1f1f92da77c35139bbc refs/pull/16/head
> bca74c53f66681f2d74a98d2f785e1610abeb794 refs/pull/18/head
> 4da5bcd8c7852bb306059a856f95e9bc1aeaefd3 refs/pull/47/head
> 5f1408be857734745a7a3349e9d16a8200e993be refs/pull/49/head
> 00ff16478e95f11347bc3e769e310c1a254579c9 refs/pull/57/head
> 5e3121acaddc7be810f2b9ad92641a04f9b923fb refs/pull/58/head
> 8afe04f52b8174c789691b4097c70f95d33c99c4 refs/pull/59/head
> 55b0d38d156145d8f9726746da7bb4d5ba9d988c refs/pull/60/head
> bca74c53f66681f2d74a98d2f785e1610abeb794 refs/reviewable/pr18/r1
> 4da5bcd8c7852bb306059a856f95e9bc1aeaefd3 refs/reviewable/pr47/r1
> 5f1408be857734745a7a3349e9d16a8200e993be refs/reviewable/pr49/r1
> 00ff16478e95f11347bc3e769e310c1a254579c9 refs/reviewable/pr57/r1
> 5e3121acaddc7be810f2b9ad92641a04f9b923fb refs/reviewable/pr58/r1
> 8afe04f52b8174c789691b4097c70f95d33c99c4 refs/reviewable/pr59/r1
> 55b0d38d156145d8f9726746da7bb4d5ba9d988c refs/reviewable/pr60/r1
> ```
>
> So, you have 19 references.  And according to the output of the job
> you linked, you only force pushed refs/heads/1.  That means the other
> branches and refs are holding on to the old history.  You'll either
> need to delete or rewrite refs/heads/patch-1, and
> refs/reviewable/pr{18,47,49,57,58,59,60}/r1 as well.  Rewriting the
> refs/reviewable stuff may confuse and mess up Reviewable if you ever
> look at those reviews again; it may be that deleting those refs
> results in a cleaner error message within Reviewable.
>
> You also need to have refs/pull/{1,16,18,47,49,57,58,59,60}/head all
> rewritten too, but you don't have access.  You need to get GitHub
> support to do that.  If they don't ask for the exact filtering you
> have done, and are only "clearing caches", then it's not going to do
> anyone any good.  Those references need to be filtered the same way,
> or else those special refs need to be deleted.  But please do note
> that you should not ask them to do that until you've already cleaned
> up all the stuff that you can.
>
> The steps look roughly as follows:
>
> 1. Clone the repository.  Since you have refs outside of refs/heads/
> and refs/tags/ (namely refs/reviewable/), you'll need a mirror clone.
> Also, make sure to NOT use a partial clone (which would defeat steps 2
> & 5).
> 2. Note the size of the *local* clone ('du -hs' should come in handy).
> 3. Run `python3 git-filter-repo --analyze`, and look at the reports it
> generates to find out the big files/directories and all the names of
> those paths.
> 4. Filter the repository.
> 5. Verify that the local clone actually shrinks from your filtering
> operation (not just has fewer commits, but 'du -hs' now reports a much
> smaller number).  If it does not shrink as much as expected, run
> `python3 git-filter-repo --analyze` again and see if you missed
> alternate historical names of some files or whether you only filtered
> what turned out to be small files or whatever.
>
> Note that step 3 is important.  Rather than guessing what is big and
> taking up lots of space, you find out what is big and take action upon
> it.  For example, you once committed the node_modules/ folder.  I do
> not know its size (too lazy to do a full clone and find out), but
> those are often quite large.  Creating a commit that deletes that
> directory does not remove it from history, only from the current
> version.  So, expunging that directory from history may be important.
> There may be other nuggets you find too, such as alternate names of
> files that also need to be deleted if you've renamed things.
>
> After you've succeeded with all the above:
> 6. force push *all* references back to GitHub -- or at least the ones
> that GitHub will permit you to force push (should be everything other
> than refs/pull/*).  If you only force push your "1" branch, you still
> leave every other reference holding on to the old history.
> 7. Contact GitHub support to ensure they clean up the remaining
> references (i.e. the refs/pull/* ones) _and_ clear their caches.  They
> will either have to ask for what filtering you did so they can do it
> as well, or they'll need to nuke those pull requests.
> 8. Wait to hear back
> 9. Check the `git ls-remote
> https://github.com/fawazahmed0/currency-api` output again.  If the
> refs/pull/* lines still exist and still have the same hashes at the
> beginning of their lines, GitHub did not filter those references and
> they are still holding on to the old history.  Contact them again, and
> either get them to filter those refs the same way you filtered yours,
> or get them to delete those pull requests.

I may need to take this partially back.  Since you've already
contacted GitHub support, they may have already done filtering on
these references and further filtering of those isn't needed.  It may
be that after filtering the references and your control and pushing
those all back, that no further work is needed.

> > I have already contacted Github few days back, and they have cleared the cache etc for this repo.(but that did not reduce any size). ( I will try contacting them again)
>
> Contacting them now is a waste of their time.  Filter your repo first.
> Your whole repo (implying you need a mirror clone rather than a
> regular clone given you have the unusual refs/reviewable/* references
> that need filtering too).  And push the whole repo back, not just a
> single branch.
