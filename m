Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F946C77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 22:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344332AbjD0WuA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 18:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343716AbjD0Wt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 18:49:58 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D282C2129
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 15:49:55 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-517baf1bc93so8900074a12.0
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 15:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682635795; x=1685227795;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yAzrSmVjVWYtQHEh+X60fFHl5srD4bxAw4SdUR24cEc=;
        b=7uciKQJp0PXYGlTjQSbx+L5cxbgBFuWCnnmpZaU3W/iIgmvVSR3kmu+QJaUJnRuLPH
         njDK0NdDM5H4r4gE9U/5pGTSfoQkZ+7OkqLffzh97glLp3JM7V8byVG1uucbe7E1lDrm
         F6vZ0WtPE1HQp5CzdQzYHxruHIB6Jp6gACBr8lpcKgMIrP+uFJvpSnGXONZiU0hqgaLl
         ucXmNJ8q4+e23/6ODG6mpuW5dzqv9mDdUcyv+MpgzeecPsOS6xImWy9FMc8uAwlV1bZU
         LI+JbgHEbikZK95v9J6EESb2VOwhTY8vWAbItgNdy2N2Rb7JCMwYktbHXAMgwFF9XCVU
         BXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682635795; x=1685227795;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yAzrSmVjVWYtQHEh+X60fFHl5srD4bxAw4SdUR24cEc=;
        b=A1wzHzzMrRVivMQzTewVOHXnkCmiC8uFZDAqB/E/cRN0ygNUqtaLsmm+6wulqwHCWW
         gzUggfngoz0rQRl4MLrxlUBjSkBCh0vYRdD2/iEiTpkwmvi/KtxxpChxEQ7U7sWNLwH6
         oLtkZF62eZg3dzd1KUxO+E/FHpm55zhwHO/6PjsRvAV+63BNKiEPNMFhgLSbDl9VZfdp
         RZ4R727ZBxXRVDH1iDHgG+OswgKEf9HpHMMdgR//yG7yF/NF/ccsWzAxGEu5IgJEhaCV
         lDcA2JEdIqlSBlURTMgcwjx+9Fcw9Qf707UE2QCd+L1u/8ifyd8LUK2TYYSqzFjnDj9P
         6BlA==
X-Gm-Message-State: AC+VfDyEXYg6+a7kurHleDLhAcX+oIxsg65wWH3NJ5cnheDEF/uc4qOX
        2ghRkTf3XkndVXfPod+Zdwg91gvGXC+yZg==
X-Google-Smtp-Source: ACHHUZ5y1BLFgPAi1Co0ulEbdcFUB5dIW/UzabDL7RBkpFtn9uHfZhd3GgAIOYQWpYeg6EgIEbA2fdsh9F/WlQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a63:9144:0:b0:520:ac65:e9db with SMTP id
 l65-20020a639144000000b00520ac65e9dbmr781278pge.8.1682635795318; Thu, 27 Apr
 2023 15:49:55 -0700 (PDT)
Date:   Thu, 27 Apr 2023 15:49:53 -0700
In-Reply-To: <xmqqildis89b.fsf@gitster.g>
Mime-Version: 1.0
References: <cover.1681906948.git.ps@pks.im> <6446e3db4702d_cd6129452@chronos.notmuch>
 <ZEekRNuPmObU9Vsq@ncase> <b8225865-7eea-3dcb-247f-10cb22899b2a@intel.com> <xmqqildis89b.fsf@gitster.g>
Message-ID: <kl6lildhlz3i.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 0/8] fetch: introduce machine-parseable output
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> We had some discussion during review club about this, where the idea of
>> using "--porcelain" came up because many commands use that when
>> switching into a machine readable format.
>>
>> In addition, this format not only changes the output but also moves it
>> from being on stderr to stdout, which is a hint that the intended usage
>> of the command is now a little different.
>
> A little different from what?  I do not think the answer would be
> "other program's --porcelain mode", as sending them to stdout would
> be one of the things that make the output easier for programs to
> parse, so it does sound like very much in the same spirit as "git
> status --porcelain" where its output format gets tweaked to be more
> machine friendly.
>
> The output with "--porcelain" option enabled tend to be less human
> friendly and the distinction between Porcelain (for humans) and
> plumbing (for scripts) is reversed in the use of the word there---it
> started as "this is the option for those who write Porcelain
> commands to use", but still it is not a very good name for the
> option.
>
> I am perfectly OK if the plan is to uniformly use --output-format
> (or something equally more descriptive) and migrate and deprecate
> the "--porcelain" option away from existing commands.

I agree that --porcelain is a confusing name that would be nice to
deprecate, but I don't think --output-format captures all of the intent
of "operate in a machine-friendly mode instead of a human-friendly one".
Unfortunately, if we had picked --plumbing from the beginning, I doubt
we would be having this discussion today :/

E.g. machines (Unix ones at least?) like to have output on stdout and to
be able to request NUL-terminated output. It's unfortunate that if we
don't piggyback onto --output-format, we run into option precedence
problems (like Patrick mentioned), but I'd find it more confusing that
--output-format=[porcelain|full|compact] don't behave the same way.

I don't think this puts us in a better spot with regards to option
precedence either. Consider:

  git fetch --output-format=full -z <...>

The only way to respect both options is to have -z affect the
human-readable output, which isn't the end of the world, but it seems
unnecessary.

Perhaps something like --machine instead?
