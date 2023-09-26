Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79804E7D0C5
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 05:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjIZFaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 01:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjIZFaV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 01:30:21 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648EFF2
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 22:30:14 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59beea5ce93so213943707b3.0
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 22:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695706213; x=1696311013; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5SpZB1oVG03DdZuNpNqic2T/yOxK5Qhrp/2fFDy7tcg=;
        b=hYf9zZNIl1FG4XCULY0xG1sA7dOd7xyGY00Cgg3WAVd7X32dvjC3aq8xK+kNNQqFbD
         J/WUNYzkC3yb8onZkxNnAZDKnb/Lak613smuLuZ6OeMUqCjOzzeF3Ub2ac7L9vj+Jgot
         9A/UYmQWBMtsVb2MuGY8nO0wwIrj5n2ivtHlTzV8lXkSpkx6+tm22lP4pJ54ZhWE1Mb0
         cD4V/htVucSJGIb523e7ULP55P4JW0B1WRB4qNPrPlENFBtTkNN4XU/jkfcCeciUu+xK
         al3cLd+5qLilGce9k6GRhH1QWvGWss8JDtpt8KC/AfGteaw8tTZFZpWuRSMTjF6i315k
         1NVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695706213; x=1696311013;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5SpZB1oVG03DdZuNpNqic2T/yOxK5Qhrp/2fFDy7tcg=;
        b=eFsaJ8XbQQLKnaxdDnvZNK6bH/7hh0Ker7ZFZsOhxpGVCgpvMnFh+4CT/ihvPpKZT+
         3Ut3tV9i+3O0oXJyZiY7q37xBPlpzD2+jrPkG8HhGaWYrnIqNjAgoqTKqwsQFyhVrmHY
         FNp5llOSUbVdhcIspmIcQ9TFPO9EJZaHYiZEzWLr4333iYM0wWczKYMlyvski13pbron
         NM4rIaMSsfIjjODKcnx9y/7VzBGY1I6fCfA+h6vflCxSJuKaXcq8PjOBePWDbV32Gk3z
         4l7e4AsMsb88VRVmyShFxDD19pkaugG9u8evqU66hawaTVKrOTBFYzsi//mI8sVmCbtV
         lhXA==
X-Gm-Message-State: AOJu0YxkfXMSK3pBtd/mUDFr10QKcwiYmSECvqHYARTBUoa6+0THnyIK
        MolC1XCz5qcR0Ui7OemOoWASgW/i+ek=
X-Google-Smtp-Source: AGHT+IFS3kIMzYLQWaWsWLHA695v7NjvHF7lSEsd0Ep95Kzm9vDVGRhE/d56MO+H8VUe2w6UDVU2oWFxBF0=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:690c:3745:b0:59f:4c14:ac5e with SMTP id
 fw5-20020a05690c374500b0059f4c14ac5emr29053ywb.2.1695706213639; Mon, 25 Sep
 2023 22:30:13 -0700 (PDT)
Date:   Mon, 25 Sep 2023 22:30:11 -0700
In-Reply-To: <xmqqil820z25.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
 <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com> <52958c3557c34992df59e9c10f098f457526702c.1694240177.git.gitgitgadget@gmail.com>
 <xmqqr0n4v8ul.fsf@gitster.g> <owlyzg1pjx2f.fsf@fine.c.googlers.com>
 <xmqq1qf1la0q.fsf@gitster.g> <owly8r8yt6cr.fsf@fine.c.googlers.com> <xmqqil820z25.fsf@gitster.g>
Message-ID: <owlywmwdsdr0.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 5/6] trailer: rename *_DEFAULT enums to *_UNSPECIFIED
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Linus Arver <linusa@google.com> writes:
>
>> ... I prefer the
>> WHERE_UNSPECIFIED as in this patch because the WHERE_DEFAULT is
>> ambiguous on its own (i.e., WHERE_DEFAULT could mean that we either use
>> the default value WHERE_END in default_conf_info, or it could mean that
>> we fall back to the configuration variables (where it could be something
>> else)).
>
> Yup.  "Turning something that is left UNSPECIFIED after command line
> options and configuration files are processed into the hardcoded
> DEFAULT" is one mental model that is easy to explain.
>
> I however am not sure if it is easier than "Setting something to
> hardcoded DEFAULT before command line options and configuration
> files are allowed to tweak it, and if nobody touches it, then it
> gets the hardcoded DEFAULT value in the end", which is another valid
> mental model, though.

True.

> If both can be used, I'd personally prefer
> the latter, and reserve the "UNSPECIFIED to DEFAULT" pattern to
> signal that we are dealing with a case where the simpler pattern
> without UNSPECIFIED cannot solve.

SGTM.

> The simpler pattern would not work, when the default is defined
> depending on a larger context.  Imagine we have two Boolean
> variables, A and B, where A defaults to false, and B defaults to
> some value derived from the value of A (say, opposite of A).
>
> In the most natural implementation, you'd initialize A to false and
> B to unspecified, let command line options and configuration
> variables to set them to true or false, and after all that, you do
> not have to tweak A's value (it will be left to false that is the
> default unless the user or the configuration gave an explicit
> value), but you need to check if B is left unspecified and tweak it
> to true or false using the final value of A.
>
> For a variable with such a need like B, we cannot avoid having
> "unspecified".  If you initialize it to false (or true), after the
> command line and the configuration files are read and you find B is
> set to false (or true), you cannot tell if the user or the
> configuration explicitly set B to false (or true), in which case you
> do not want to futz with its value based on what is in A, or it is
> false (or true) only because nobody touched it, in which case you
> need to compute its value based on what is in A.

Thanks for the illustrative example! I don't think we have a case of a
"B" variable here for trailers.

> And that is why I asked if we need to special case "the user did not
> touch and the variable is left untouched" in the trailer subsystem.

I think the answer is "no, we don't need to special case". I'll be
dropping this patch in the next re-roll.

> Thanks.
