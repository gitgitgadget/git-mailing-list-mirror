Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A20C55179
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 14:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27E3720780
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 14:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CH6wGX9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754016AbgJ0OYX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 10:24:23 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44918 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2901571AbgJ0OYW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 10:24:22 -0400
Received: by mail-ot1-f66.google.com with SMTP id m26so1082679otk.11
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 07:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dWs6UXcFvO5/WFYIcehv2f2hoWoTsLRT8tFX7NOOtLo=;
        b=CH6wGX9iqSLBEu18kFe/AuusFxBe+AE9OudL3SOipyC/DyIS399qMO2eAmGVkLIIID
         C3YG4lkUWn7JlqYThy+wOUZx06+ok9tXomoWJDJCxJ8AeQGXI96TogHUFPdILHUDsJ/4
         gMePAWclPQPnW4uCO4Q8Vn7H6t2lowuF/TsPodFsQTDo/USkXZqyFYdrkrGEEoPF/qup
         Ot4YdzJ4mGCu0urbozzWnlsWvWuTMuDRi+nFFALk8CYHxbiB/uZTwOvnRD0OS1MFQoA2
         5tcaq4Eyair42aMmR7nlzNI3GHgAvCfO9w/xGLNwk3OLno3+aU3pg0GzVncJ0AThv2Xq
         HasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dWs6UXcFvO5/WFYIcehv2f2hoWoTsLRT8tFX7NOOtLo=;
        b=nKn1CLKHBzTUP9IsFTOoFxdvRtautr0JxcRD80SYdVlI+JdvtFH7/na0QagQAAlytr
         Vn1t4hI7EwCRvNQv5flaRagkfHs21hrfED7tuVhN8XWFAMo+6Q9ZmMHBcWNH5ef8Duqa
         vWJQjb8nl8FQxSDrVQApNcJDqJgxecob7Z02ZFsSKfbSMqSy2Y6rs5Rnum0NelMKM2M/
         vA05kmvFMSAk1hXQrkoWlmaelhvdCZTvA5DQoJwbtIcKj+3t2s/ZfBPadR/U2M3yDuHy
         yfX3KN9b7P1UMDXAgPv4+SQD0ocT6GpHPXI65VHaObKht8eNrVhzidTefvON+mN0bt7+
         EwsQ==
X-Gm-Message-State: AOAM532omWj/3J76NbSqvSgLZq22exeBeswFMGZ+iyODwAeOdShwCHkD
        3ipUvEmIBK61pdmYOxfCDzhpCd6Fl4xcZyLUQvE=
X-Google-Smtp-Source: ABdhPJyrABt/5RBTkW/g4SsvC/34GpFdL6BtwgsSS3NCZ2TMIdtABJ+k4fo8fqnJSDPABX2eGIqlE/YCgMLBNheuCwQ=
X-Received: by 2002:a9d:23a6:: with SMTP id t35mr1548022otb.210.1603808660924;
 Tue, 27 Oct 2020 07:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAPSFM5e9tXx_LuwNK+e1wOjaHb6kiTCEt3WeL851KAbTPNsEow@mail.gmail.com>
 <6a2005e7-6b8b-2bf4-91fa-55feadd65897@gmail.com>
In-Reply-To: <6a2005e7-6b8b-2bf4-91fa-55feadd65897@gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Tue, 27 Oct 2020 19:54:09 +0530
Message-ID: <CAPSFM5fbZN0uv9SgB-d4SR53ZFw8cOkgFmUK-Gns+c=yAmcP1w@mail.gmail.com>
Subject: Re: [Outreachy]: Help for Outreachy Application
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 26 Oct 2020 at 16:06, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
Hi Phillip,

> Hi Charvi
>
> On 25/10/2020 07:43, Charvi Mendiratta wrote:
> > Hi Everyone!
> >
> > It has been about more than two weeks, since I joined the mailing
> > list. Till now I have contributed to the microproject - "Modernize the
> > test script" [1] that is accepted by Junio. Also I would like to Thank
> > you all for the help and feedback on my first patch series. I learned a
> > lot about the git command itself, how to work in a community with the
> > mailing list and will try my best to get involved in the review
> > discussions.
> >
> > I have read the Outreachy projects and am interested in the project
> > "Improve droping and rewording commits in Git interactive rebase". I
> > spent some time understanding the project and have gone through its
> > detailed explanation in the issue[2].
>
> Thanks for your interest in the project
>

I apologize for late replies, as I thought to spend some more time in
understanding the project.

> > As mentioned that the first task is to implement --reword option in
> > 'git commit'. Regarding this, I am unable to understand how it will
> > work upon rebase --autosquash?
>
> The idea is that --autosquash will rearrange the todo list so that the
> reword! commits get squashed into the commits they reword (by changing
> 'pick' to 'fixup' or maybe a new command) and the message from the
> reword! commit is used for the new commit rather than the message from
> the original commit that we squash the reword! commit into.
>

Thanks for the detailed explanation, now I can easily co relate this with
--fixup / --squash.

> > and regarding the task to include --drop option. In issue[2] it's
> > clear to add this as an option in git revert but at the Outreachy page
> > in the Internship task section, it's mentioned to implement --drop
> > option in git reset. So, there is a bit of confusion regarding the
> > correct way to implement.
>
> Yes getting the user interface right for creating the drop commits will
> be part of the project I think.
>
> > I also looked into archives of the mailing list and found the
> > patches[3] submitted by Philip for --reword option in git commit and
> > need some more pointers about its status and how to start with its
> > code ?
> > Also, in the issue[2] as commented by Phillip regarding the patches[4]
> > that implements reword. I would like to know if I can start with that
> > mentioned work, if available.
>
> Whoever takes on this project is very welcome to use my patches as a
> starting point. The code in the patches is sound as far as I know and
> the I believe the test coverage is reasonable (though that would need to
> be checked). They are lacking any documentation and there has been a
> change to the way empty commits are handled by rebase since they were
> written so "rebase -i: always keep empty amend! commits" will need
> looking at and could probably be dropped.
>

Okay, I will note these points .

> We will also need to decide on the best UI for the --reword idea. My
> patches were developed a couple of years ago before I was aware of
> dscho's idea and so implement a slightly different UI to the one
> outlined in the github issue (they call 'reword!' 'amend!' instead). I'm
> not that keen on adding another option to `git commit` to create yet
> another flavor of fixup commit, we'll need to agree a way forward on that[1]
>

I agree that we need to look into options for creating reword! commit
and drop! commit and its integration with interactive rebase .

Also, considering this I think there can be two possibilities :

As mentioned by Junio [1] that we can extend the existing '--fixed <commit>'/
'--squash <commit>', to implement reword! commit as mentioned in the issue[2]
by Dscho . or as you have mentioned to change the semantics of
'git commit --fixup/squash".
And, if we consider the above then for drop! commit, I wonder if we
can implement
it in the same way as mentioned in issue [2] by adding the --drop
option to 'git revert'.

Secondly, as you have mentioned here [3], there could be a `rewrite` command
as a wrap of `rebase -i` . But regarding this, I want to once confirm
if this can be a
solution of this project or is it need to be done later on.

Please correct me if I am wrong.

Thanks and Regards,
Charvi

[1] https://lore.kernel.org/git/xmqqft77glhn.fsf@gitster.c.googlers.com/
[2] https://github.com/gitgitgadget/git/issues/259
[3] https://lore.kernel.org/git/95cc6fb2-d1bc-11de-febe-c2b5c78a6850@gmail.com/

> Best Wishes
>
> Phillip
>
> [1]
> https://lore.kernel.org/git/95cc6fb2-d1bc-11de-febe-c2b5c78a6850@gmail.com
>
> >
> > Thanks and Regards,
> > Charvi
> >
> > [1] https://public-inbox.org/git/20201021124823.2217-1-charvi077@gmail.com/
> > [2] https://github.com/gitgitgadget/git/issues/259
> > [3]
> > https://public-inbox.org/git/pull.736.git.1600695050.gitgitgadget@gmail.com/
> > [4] https://github.com/phillipwood/git/commits/wip/rebase-amend
> >
>
