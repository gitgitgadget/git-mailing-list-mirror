Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A0FC4332F
	for <git@archiver.kernel.org>; Sat, 10 Dec 2022 20:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLJUpj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Dec 2022 15:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJUph (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2022 15:45:37 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5520116586
        for <git@vger.kernel.org>; Sat, 10 Dec 2022 12:45:36 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id s8so12318778lfc.8
        for <git@vger.kernel.org>; Sat, 10 Dec 2022 12:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nkJhxLwuJ75kzUiMisCQOCSal0Ih1vmwlGrhG+llj74=;
        b=Ihf48TtuvfbW8/U6C3y6Cytp+bi7WyJOpmnRwqxAeaBbYFXdjvp0KHj8OdFSXRp2Aq
         QEzjvKGKT1zSeAeE/t2OkD48af6zA/GD4Dil0ccHVJH3cgoSbHM+mHPh2D4L2Pz2mhvo
         Ou9G75soTqu7s0mTXFtKj8Sj5W9jymNxMEgzo4eCoyumWyE/bdl2l/31jIxljFRUehfI
         nsYYycBF5xGeS2f3vvyDBnLaMCaRVJ9nkNKEXlBy/LkuOatyC+NLJ+u+FrUegiavar9o
         /7CIg3BXDKcppJj3jcXR067XiSWoS2BVscnH5Hl1Bj14rFTEoymmUQMH8durZLb4m8vZ
         QTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkJhxLwuJ75kzUiMisCQOCSal0Ih1vmwlGrhG+llj74=;
        b=K253gX6AnUvcg193O8ULYcDEksbFKn4okXp2pUl8o1t56nC0xhbsbVQYQt3evTU58A
         Bo+KL4A7ualPOYwI0HJXff2ns6IvSe2h8MRtSgQAdxa5cc19wv9RX4QqOClvxAbBtPOf
         KYezXHddzGIWTFRH1qcmc92YF10YRU9twk+p/WMKD7/FJkBoKeoOl77Wr8HwoIHAqgRp
         Yi2naAkP1hn/k580uByYKJNB8lJSr4smHJ8nIHGWCcWnSJ0PN1lDfn8HV2dH0q6EKeI+
         b9Ok0fDavGrSpa9luO+ZItrNX8EUuAP3nRsankHbsI51F1yZvIrmvvO/amuS3iRGGjoI
         wYxw==
X-Gm-Message-State: ANoB5pk6lKl/dgAQMoHVgcVgkjESeMJsWIoy0YlpD7kw6JmeHCo/6n0i
        TSKN4B2qVYj491KmjnP8HnqSx5xBaqg=
X-Google-Smtp-Source: AA0mqf6CMoVmohQYdOhX3rP0jiq/GmcOjnrKB7c5NUJXlDIY1ct2K5zVdv6nOFi5H9hUEwC5anQxAw==
X-Received: by 2002:a05:6512:4029:b0:4b5:5da1:5225 with SMTP id br41-20020a056512402900b004b55da15225mr3807712lfb.50.1670705134171;
        Sat, 10 Dec 2022 12:45:34 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h28-20020a056512055c00b00494942bec60sm854285lfl.17.2022.12.10.12.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 12:45:33 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] diff-merges: more features
References: <20221127093721.31012-1-sorganov@gmail.com>
        <kl6lilimepli.fsf@chooglen-macbookpro.roam.corp.google.com>
        <87tu26arzy.fsf@osv.gnss.ru>
        <kl6lcz8tebtk.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Sat, 10 Dec 2022 23:45:32 +0300
In-Reply-To: <kl6lcz8tebtk.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Thu, 08 Dec 2022 15:05:11 -0800")
Message-ID: <87ilijt2c3.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> The last time '-m' issue appeared on the list, it all started here:
>>
>> https://lore.kernel.org/git/CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com/
>>
>> In particular, the final patch and its revert is deeper down this tread:
>>
>> https://lore.kernel.org/git/20210520214703.27323-11-sorganov@gmail.com/#t
>>
>> and
>>
>> https://lore.kernel.org/git/YQyUM2uZdFBX8G0r@google.com/
>
> Thanks, these provide extremely helpful context :) In particular:
>
> - Junio describes this "do nothing unless -p" is given behavior as an
>   accident [1].

I rather read it as Junio saying that "-m does not imply -p" is
historical accident, and yes, it is, provided '-c/--cc' were fixed at
some point, and '-m' was not, so in fact I figure Junio meant: "-m
differs from -c/--cc in not implying '-p'" is historical accident. And
then he suggests to leave it as is, with which I disagree.

In addition, in all the discussions, I believe Junio at least once said
he does see valid usages for current hush '-m':

<quote>
But "stash list" example shows that "log --first-parent -m" without
"-p" in a script has a valid reason, and a change that hurts those
who correctly used a command and an option in a way they were
intended to do _is_ problematic.
</quote>

here:

https://lore.kernel.org/git/xmqqy29chim6.fsf@gitster.g/

> - Jonathan Nieder notes that this change accidentally broke scripts
>   where "-m" probably wasn't doing anything useful, but we wanted to
>   avoid breaking the scripts for backwards compatibility anyway [2].
>
> I got the sense that the closest thing to an intentional use case of
> "-m" is for users who thought that "-m" would affect path limiting [3],
> although it doesn't actually do that.

I don't think so. Dunno why you got such feeling. It's rather that for
some time "--first-parent -m" was the only way to produce *most* useful
form of "-m" format: show diff with respect to the *first* parent only,
whereas without "--first-parent" "-m" produced diff output for *every*
parent in turn(!) giving extremely confusing result. Please notice how
--first-parent appears in most of those discussions.

Overall, the (simplified) history of '-m' goes like this, as far as I
can tell:

0. Original '-m', documented only for 'diff-tree'. The diffs were
   produced to all the parents that was probably very logical for
   plumbing 'diff-tree', as it reflects symmetric nature of merge
   commits in the DAG, that is the core of git data model.

   However, while "git log -p" does not produce patches for merge
   commits (apparently to get rid of often large output), '-m' in fact
   enforces the output for merge commits, in the format produced by
   'diff-tree -m', i.e., diffs to all the parents in turn.

   [The latter was probably the first mistake, it should have rather
   produced the diff with respect to the first parent that is more
   suitable for "git log" being porcelain, to show changes introduced by
   the commit to the mainline, exactly as for non-merge commits]

1. '-c' is introduced, then '--cc' is introduced, with semantics similar
   to '-m' with respect to '-p', but different kinds of output.

   At this point we have consistent behavior of '-m', '-c', and '--cc'
   with respect to '-p', none of which produce any output unless '-p' is
   specified as well.

2. '-c' and '--cc' are changed to imply '-p'[0]. '-m' is left alone,
   supposedly forgotten as being undocumented for "git log" and of
   limited use, due to its large and surprising output.

   [I think that was the second mistake, forgetting to change '-m'
   accordingly]

3. '-m' is changed to produce diff with respect to the first parent only
   when '--first-parent' is specified [1]. '-m' finally starts to
   (sometimes) give useful output, and starts to be actually used,
   but only together with '--first-parent' most of times.

   BTW, this is the first time '-m' has been documented as part of "git
   log": "This patch properly documents the -m switch, which has so far
   been mentioned only as a fairly special diff-tree flag."

   [I think there are more mistakes here: not changing '-m' to imply
   '-p' at this point, and not producing single-parent diff even without
   '--first-parent']

4. "--first-parent" is suggested to imply "-m"(!) to let "--first-parent
   -p" to produce diff for merge commits[2]. That in turn needed an
   option that will negate implied "-m", and that's where
   --[no-]diff-merges was suggested.

   Please notice that if '-m' implied '-p' (as it should) at this point,
   there should be little needed for these patches, as just saying "git
   log --first-parent -m" would produce required result. So, mistakes
   above caused a need to fix them.

5. At this point, in the referenced discussion I suggested
   '--diff-merges=on|off' instead of '--[no-]diff-merges', to allow for
   further extensions.

6. '--diff-merges=' option actually born to provide some missing
   functionality and to get rid of inconsistencies[3].

7. '-m' format becomes configurable using new "log.diffMerges"
   configuration[4] so that we can make it conveniently useful even
   without "--first-parent". This was immediately implemented in
   generalized manner to allow to configure '-m' to produce not only
   single-parent diff, but any supported format.

8. As a reply to yet another request on the mailing list "why '-m'
   produces no output", I tried "-m imply -p" patch series[5], which
   were accepted, but then the last patch only(!) from the series, that
   actually introduced required behavior, has been reverted.

   This left me feel I got some unfinished job to do.

9. These patch series, trying "-m imply -p" again, now more carefully.

> So what I've reads so far suggests that "do nothing unless -p" (aka
> --diff-merges=hide) is not actually useful, and we should just drop
> it.

Again, I've tried exactly this before, and that was first accepted, and
then reverted, that's why --diff-merges=hide has been introduced in
these series, to address the issues raised during revert request.

References:

[0]: Showing merges easier with "git log":

https://lore.kernel.org/git/1440110591-12941-1-git-send-email-gitster@pobox.com/

[1]: git log -p -m: Document, honor --first-parent

https://lore.kernel.org/git/20100210011149.GR9553@machine.or.cz/

[2]: making --first-parent imply -m:

https://lore.kernel.org/git/20200728163617.GA2649887@coredump.intra.peff.net/

[3]: git-log: implement new --diff-merge options:

https://lore.kernel.org/git/20201221152000.13134-1-sorganov@gmail.com/

[4]: git log: configurable default format for merge diffs

https://lore.kernel.org/git/20210413114118.25693-1-sorganov@gmail.com/

[5]: diff-merges: let -m imply -p

https://lore.kernel.org/git/20210520214703.27323-1-sorganov@gmail.com/

Thanks,
-- Sergey Organov
