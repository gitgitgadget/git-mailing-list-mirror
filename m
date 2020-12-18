Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5B2C3526C
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 20:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB2623B52
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 20:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387532AbgLRUda (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 15:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387424AbgLRUd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 15:33:29 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC82C0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 12:32:49 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 23so8588875lfg.10
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 12:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pdKiofLrYJRIRf8zqaR9TpEVBhMSsS83nsod0aItbHc=;
        b=MgH6kSToPPUjUiHm7fWQa6mkKGGjTfG90ajKHisg8d8sjby+uhalyAVoklKp8h1N8t
         DRZWydZDTRNAxKWXrMj1ommamrpImkQ5OchsZv3bDZNAV2cw02jS0nU+CYgI3Zkc+7uy
         /kAmbS438xx2zaQmDzEvrExV0CGGxaiO3TBz/PjBjgHaKstSyELPhMaoYNFiG3XImuB7
         j8AnmMX5XvX78BCgNS+muPJbzHD40JUlBfSnaWK3EP/I6gibS1Nl1R8gUioH4atrpQq+
         Kl9C2QG4wLJvsxkBjU/wxbg/q+oIfT5h/P6/vAI+oEMfLmshT1LNIYoyo5fTeEhTbCAe
         3Zjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=pdKiofLrYJRIRf8zqaR9TpEVBhMSsS83nsod0aItbHc=;
        b=lol94A+7q3cqnUu7RLAuQQc3Ld0gmzU2Z/+tb751Pmc5HR2Pzupeahaje3Zd1/Nd+p
         IKDH680tvByAFPHF3AjNgPfBFQSH+BBdId6Nv2fDyUl2CBEB3mtU9UaP24gmgsN78Jgi
         EhhOle8pBErFXyrZxxNeSi3E9Ec5kMKr3fIrBjJGMz4b0SsjsSQ1S78uDX+7XBA1UxTj
         W9Ws95SeZ5m7g72dDdLwTri96vWZrIkVi6DeavD7prUVBXISYlRlGseX958hvwyjMRBe
         H71mSArUjclQl55KtcbNziBeWD/ljhBudYXnUBpggldCvCfx/zTJuhTzLKY7ClqzIrx4
         7EHw==
X-Gm-Message-State: AOAM532CxnS0lcwBlHvtKhnIsN2GRj9ecIMb+SEKXwQFB/tqH1ZeEvti
        Db0G6CbDQPtTnkiD6x8w5jDBHOJhGmE=
X-Google-Smtp-Source: ABdhPJyNqw7nbDl+DZsZAl55ORu48rKQJ2yPKM3owB+cgawv5ow0UMAyw6G6iIFc8hGF6FvhDNACig==
X-Received: by 2002:ac2:5f52:: with SMTP id 18mr2123779lfz.260.1608323567203;
        Fri, 18 Dec 2020 12:32:47 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id l11sm1031626lfg.288.2020.12.18.12.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 12:32:46 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 26/33] diff-merges: let new options enable diff
 without -p
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201216184929.3924-1-sorganov@gmail.com>
        <20201216184929.3924-27-sorganov@gmail.com>
        <CABPp-BHu2xLZLfwBg+hzNEKQ0K=EyT1HLqJO9=pNzBFf4MqR=A@mail.gmail.com>
        <87wnxfb2gt.fsf@osv.gnss.ru>
        <CABPp-BG4GEmv20YK39M51nzTYVZtcLgD-UbmQLfgynjUhBKx9w@mail.gmail.com>
Date:   Fri, 18 Dec 2020 23:32:45 +0300
In-Reply-To: <CABPp-BG4GEmv20YK39M51nzTYVZtcLgD-UbmQLfgynjUhBKx9w@mail.gmail.com>
        (Elijah Newren's message of "Fri, 18 Dec 2020 09:01:36 -0800")
Message-ID: <87o8iq97o2.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Fri, Dec 18, 2020 at 6:42 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:

[...]

>> >> diff --git a/log-tree.c b/log-tree.c
>> >> index f9385b1dae6f..67060492ca0a 100644
>> >> --- a/log-tree.c
>> >> +++ b/log-tree.c
>> >> @@ -899,15 +899,21 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
>> >>         int showed_log;
>> >>         struct commit_list *parents;
>> >>         struct object_id *oid;
>> >> +       int is_merge;
>> >> +       int regulars_need_diff = opt->diff || opt->diffopt.flags.exit_with_status;
>> >
>> > So rev_info.diff has changed in meaning from
>> > commits-need-to-show-a-diff, to non-merge-commits-need-to-show-a-diff.
>> > That's a somewhat subtle semantic shift.  Perhaps it's worth adding a
>> > comment to the declaration of rev_info.diff to highlight this?  (And
>> > perhaps even rename the flag?)
>>
>> No, the meaning of rev_info.diff hopefully didn't change. rev_info.diff
>> still enables all the commits to pass further once set. It is still
>> exactly the same old condition, just assigned to a variable for reuse.
>> My aim was to avoid touching existing logic of this function and only
>> add a new functionality when opt->merges_need_diff is set.
>>
>> It looks like I rather choose confusing name for the variable, and it'd
>> be more clear if I'd call this, say:
>>
>>   int need_diff = opt->diff || opt->diffopt.flags.exit_with_status;
>>
>> ?
>>
>> What do you think?
>
> I think need_diff would actually be confusing.  It can be false when
> you need diffs (e.g. --diff-merges=cc with no -p, because then you'd
> need diffs for merge commits and not for non-merge commits).  I'd
> stick with your original local variable name.
>
> Perhaps opt->diff hasn't changed meaning and I just had a wrong mental
> model in my head for what it meant, but even then what seems like its
> obvious purpose given its name is mismatched with what it actually
> does.  Since you are already changing struct rev_info in this series,
> this was more a note that a name change or at least a comment for
> opt->diff might be useful.  I mean, you asked a couple times on the
> previous series for help trying to understand it, and I could only
> offer some flailing guesses and Junio responded with a couple bits of
> history.  Clearly, it isn't very clear and this patch reminded me of
> that and made me wonder if we're possibly making it a little harder
> for others further down the road to figure out.

I still don't see why opt->diff is needed in the first place, and
second, why opt->diffopt.flags.exit_with_status check is here? Why
whoever sets opt->diffopt.flags.exit_with_status doesn't just set
opt->diff as well (provided opt->diff is needed in the first place)?

From the aforementioned discussion it looks like opt->diff is an
optimization (maybe a remnant from the times when diff was a separate
script), and that apparently there is some code instance somewhere that
actually relies on the fact that clearing opt->diff is enough to disable
diff machinery (as followed from my experiment of removing the check
altogether and then getting only single seemingly unrelated test
failing.)

Overall, neither have I any idea how to clarify this, nor do I want to
bother in this patch series. It'd be nice though if somebody who really
does understand diff machinery in Git does the job.

Thanks,
-- Sergey
