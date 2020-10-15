Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D20C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 20:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95114206E5
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 20:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732732AbgJOU5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 16:57:47 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:32808 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732684AbgJOU5r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 16:57:47 -0400
Received: by mail-ej1-f68.google.com with SMTP id c22so130954ejx.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 13:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=se3vwudbnz6cBOOTmDoKgHtkftZ0GX9GAviqOVmHZxE=;
        b=VWef+oVW91sSF9doRPFPTpCUIJwdnhlnlw+sue7lRePHsqOLDiBt297aHaVqFY/e+Q
         FM+jWnyM8VTMtjk+KturOl/60ym0IdsOOpvB77sXkTx+CK/TbP4HDur5vLxTkFC3+Ec3
         QhlMrUDbHlUwJLZhxXRS3wmZASWr0YztVFoT14yA8V0rkgUUyDvlpf3Zlv48QzHdeh6o
         Gem/gohXmglv+S02SaI+BCgucVWE+db7FSAKDvNlZQk+7z66LZZucrPHiSZpo+MlEMYx
         Rpy9uvMAk0io4ZLwROn/4IUS8jp0063FukXgFJCzqCjF1TFOXLlg97fUtjJdWJrNeDFV
         vcsw==
X-Gm-Message-State: AOAM532AqK3qVwK1h8TTSUcsjo6jpp7NeyL+WgPAmwJcXJaSzdGaooMk
        fjYY8DYsk4Py99egRl09D40Qr9CtyECCXxk29ic=
X-Google-Smtp-Source: ABdhPJxDTGDrCn23MZBbdb/g+tzMh5SrZZsUy0ko3duL0qIHFyxYJVFdtZO/LeRebP0JPZbqn16VmXxKPBRntlaLtcw=
X-Received: by 2002:a17:907:435b:: with SMTP id oc19mr169554ejb.311.1602795465803;
 Thu, 15 Oct 2020 13:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.879.git.git.1602794790.gitgitgadget@gmail.com> <c9637d70caed8a265096fa701833eca3ed52d0f3.1602794791.git.gitgitgadget@gmail.com>
In-Reply-To: <c9637d70caed8a265096fa701833eca3ed52d0f3.1602794791.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 15 Oct 2020 16:57:35 -0400
Message-ID: <CAPig+cQ=WjqfN68GcpaJBC4zjP_q2KnY9k15ErWkFM08TyCVjA@mail.gmail.com>
Subject: Re: [PATCH 2/4] t6423: more involved directory rename test
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 15, 2020 at 4:46 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Add a new testcase modelled on a real world repository example that
> served multiple purposes:

A couple minor style nits I noticed while quickly running my eye over
the patch...

> +               for i in `test_seq 1 88`; do
> +                       echo content $i >dir/unchanged/file_$i
> +               done &&

'do' on its own line, and prefer $(...) over `...`:

    for i in $(test_seq 1 88)
    do
        echo content $i >dir/unchanged/file_$i
    done &&

(Not necessarily worth a re-roll, though.)
