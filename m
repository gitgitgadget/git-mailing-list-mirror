Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1F2C4167D
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 05:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbiKWFC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 00:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbiKWFCE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 00:02:04 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC89E0CA4
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 21:02:03 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id y14-20020a17090a2b4e00b002189a1b84d4so853208pjc.2
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 21:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zP/0l56/1zO6RHHXlKbzIfSEZ1ACiUDVJ465QlX1bjg=;
        b=g8dzWPu4ShJOFvNbE5Q2+UEn6L2PyMBCdFFLPjYuMujnGTIiaNj8b8viTA5kJyDghJ
         EcBnECNR3UGuNE38szBzy5q2c0L3U02p654wGWNgUZMGTsxDPvMZNWsB71rpdPxKuYDQ
         1ZNBFSSClcURBvfagg/Ggx9wNkY+yXdfnGmTzqQnhvon/KqjF8NtVut1jSarMmT177cc
         0HxWTRv8A77b4EIs9oY3waZ9j40sGE/FObuCTL839CqwGcUhhian1PVcL4+Lik5OvFBU
         E+EF4eXxMRgZsYwn6CjXi7WXZwQnVXd+t0YTbWLMKfpwMOdkEnrqJ0FgAgCq4UQ4wZna
         CyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zP/0l56/1zO6RHHXlKbzIfSEZ1ACiUDVJ465QlX1bjg=;
        b=YI1hF3tMT0wVl4IOVKpQv7lK5kQ3jjVJpdRNs/TLUAmcBGpUSV5rLeQxMRdjqzkrez
         K5I9/Sh2EeHvucOS0Ww2TX37cubAMxQBilKdUwVgS0gK6hOrd1PBxLMBctL2nd7wbznt
         CQXmr7FOHyEWNvSMp9Oa6ye8uakdQKijS+yDJn5IQitKlSaLLBW+BFz/kt4IcYjjBWB8
         oXvjWnDwEN5hH3F4Uyxx+69vlHgXeGElHWz8af4CV1iQLc7FWB0DU5hH2U15D7qoM6Z8
         u1TPUgtMHXJ7unKqv+VxjfmyyuqGubD0IWSD4FNK73vbBNPO/1kz+1yJEB2Xd9buG6rd
         1kAQ==
X-Gm-Message-State: ANoB5pnWSIqIkCQxSzBZGN5f6qKYPs77pGGQuuqYSpWMjYSNm13frdge
        Whz0ceI0Ql+kcfvMpYvRKH8EFESEqeb6bH/GnQc=
X-Google-Smtp-Source: AA0mqf7xBDUzIgI9jvrQDDDVZy1KwiZ1Yr1htzX2oNXLKeEWHO85uz5ckpS+yHNPPEBssR0zpGQ4MyADKJS/qHPcoGk=
X-Received: by 2002:a17:902:848d:b0:186:8516:cd5f with SMTP id
 c13-20020a170902848d00b001868516cd5fmr7862772plo.11.1669179723210; Tue, 22
 Nov 2022 21:02:03 -0800 (PST)
MIME-Version: 1.0
References: <pull.1423.v3.git.1669033620.gitgitgadget@gmail.com>
 <pull.1423.v4.git.1669126703.gitgitgadget@gmail.com> <2f0bffb484beccf58f2440ed5e2c04a1ba26e6c3.1669126703.git.gitgitgadget@gmail.com>
 <61b42a7c-5772-dec2-c895-386f1613ac35@dunelm.org.uk>
In-Reply-To: <61b42a7c-5772-dec2-c895-386f1613ac35@dunelm.org.uk>
From:   Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date:   Wed, 23 Nov 2022 14:01:51 +0900
Message-ID: <CAF5D8-vMLNzi4F06MoLvWV3XBe62B6VTqtXs4VCjsFKMVQkv-A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] git-jump: invoke emacs/emacsclient
To:     phillip.wood@dunelm.org.uk
Cc:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 23, 2022 at 1:40 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> > +     # Wait for completion of the asynchronously executed process
> > +     # to avoid race conditions in case of "emacsclient".
> > +     eval "$editor --eval \"(prog1 (switch-to-buffer-other-frame (compilation-start \\\"cat $@\\\" 'grep-mode)) (delete-other-windows) (while (get-buffer-process (current-buffer)) (sleep-for 0.1)) (select-frame-set-input-focus (selected-frame)))\""
>
> I just tried this out in a frame (window for non emacs users) showing
> two files and the (delete-other-windows) call replaced both of them with
> the grep buffer. It would be nicer if it created a new window in the
> current frame or showed the grep buffer in one of the existing windows.

Thanks for your feedback.

The first point is that you want to keep the same window configuration
as before you do git jump, and reuse existing window (like M-x grep), right?

I think "(delete-other-windows)" was superfluous, so I'll remove it.
Will it do what you want?
- In case of  editor="emacsclient", it will try to keep window configuration.
- In case of editor="emacsclient -t" and editor="emacs", it will
create two window
configuration (up and down).

> If I delete (delete-other-windows) then the first time I run "git jump"
> it shows the grep buffer in the frame I already have open, but then if I
> run it again without closing the grep buffer it opens a new frame. I
> wonder if it would be better just to close the buffer if it exists
> before creating the new one or pass NAME-FUNCTION argument to
> compilation-start that creates unique names.

I've also seen a new frame being created unintentionally.
It is caused by the wrong use of switch-to-buffer-other-frame.
I'll try to fix.
-- 
Yoichi NAKAYAMA
