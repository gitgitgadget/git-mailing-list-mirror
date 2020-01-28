Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC7BC32771
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 00:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98A92173E
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 00:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vSCZa9Iu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgA1AAw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 19:00:52 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:40768 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA1AAw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 19:00:52 -0500
Received: by mail-pl1-f202.google.com with SMTP id y2so4636566plt.7
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 16:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Q2g0GtM6xlRB9xGrA36vr2KNST5BcbK0I3jYp75WkkQ=;
        b=vSCZa9Iu0C8Q76dlNZyuY61LU089EovuGrfOHPA5IU6YaBFmYKBjXEPbHVna7IToZv
         nN2gII+9kXeoU8CDoSIht7KdzCQmKfJtDF8yRIT+MMlNQczRNEOzY15huEzwFBIJxwsR
         nfDpmmUiU2s5kbvOx1EnSwFYPqPQixRNxP5P7ek1TZJkYKSQkhC27vh5z2IMMKYK4jc9
         ykyEEyqxFf1f6OrvufLAGLLPV3SsHf9fqAZZE+BYTEuuZp7hw2/iTznX9Pue20gFBNkQ
         BL1YkfSCrM8bcpKGfVeBCKvWAkD0RYQyN16jNzog596zfuFb3wJfOIV9NEbcuFByxq1g
         GLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q2g0GtM6xlRB9xGrA36vr2KNST5BcbK0I3jYp75WkkQ=;
        b=FIUnvZ+P95SOj8MZuvQ2Wpji/3yDxmYIPaW0coEeghe+O+RCC0hWRnKxGrQfe04GoQ
         4xqfvembr/bgT6ayhLNJZ22XZ5wwGjAojPO4CACT5v77lP/lMKCoEWDn7jXzodscOAN7
         ummBnFiOtgsEG6SvH6CLFMvxmNyZa6tPZCzEfGr8A1F/U+oMO3dcezlGL4JgknA3zV86
         t6zjAJBvqWjvyAv7OVkvCl98VBnOqpx4CoKrardh3VRvJ9xwdcmM86VuNaoQVFN9bYMe
         9onz+vmqdEszbUDiSuaiJFDe4OW5mK+Trbzv5XJGjeztYgjajzMOZByg8C26kIeuZBdN
         S6IQ==
X-Gm-Message-State: APjAAAWZ0Uz28/c3ypwqpw2INo1lR6m1g3+se5YgJsQa2FN4cX58oRpC
        zzkprgjP1Y5ZKeHA94GVkbrsPC4B3xWHUBNZINGU
X-Google-Smtp-Source: APXvYqwlMzzO4v3UiPg8g/sQG2j3Vj02JH2WEnLdsEqIv9/ikKKRNhUr+ddXj3VdNrwYrv6wmfe239Sj7klL5k5hvuhg
X-Received: by 2002:a63:5525:: with SMTP id j37mr21469058pgb.180.1580169651483;
 Mon, 27 Jan 2020 16:00:51 -0800 (PST)
Date:   Mon, 27 Jan 2020 16:00:47 -0800
In-Reply-To: <9f9febd3f4f7f82178fceac98fcc91cb28a1b3b9.1578438752.git.gitgitgadget@gmail.com>
Message-Id: <20200128000047.176372-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <9f9febd3f4f7f82178fceac98fcc91cb28a1b3b9.1578438752.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: Re: [PATCH v2 1/1] add: use advise function to display hints
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, heba.waly@gmail.com, gitster@pobox.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Heba Waly <heba.waly@gmail.com>
> 
> Use the advise function in advice.c to display hints to the users, as
> it provides a neat and a standard format for hint messages, i.e: the
> text is colored in yellow and the line starts by the word "hint:".
> 
> Also this will enable us to control the messages using advice.*
> configuration variables.

Firstly, sorry for getting back to this so late.

As written, this gives me the impression that advise() is what enables
us to control the messages using configuration variables, but that's not
true - that's done by a separate mechanism in advise.c and .h.
Paraphrasing what Junio wrote [1], the commit message might be better
written as:

  In the "add" command, use the advice API instead of fprintf() for the
  hint shown when nothing was added. Thus, this hint message follows the
  standard hint message format, and its visibility is made configurable.

(Note that I mentioned the "add" command and called it the advice API
instead of the advise() function.)

(Feel free to use this or write your own.)

[1] https://lore.kernel.org/git/xmqqpng1eisc.fsf@gitster-ct.c.googlers.com/

> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index c325167b90..a649805369 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -326,7 +326,7 @@ test_expect_success 'git add --dry-run of an existing file output' "
>  cat >expect.err <<\EOF
>  The following paths are ignored by one of your .gitignore files:
>  ignored-file
> -Use -f if you really want to add them.
> +hint: Use -f if you really want to add them.
>  EOF
>  cat >expect.out <<\EOF
>  add 'track-this'

Also add a test that checks what happens if advice.addNothing is set.
(It seems that we generally don't test what happens when advice is
suppressed. If we consider solely this patch, I'm on the fence of the
usefulness of this test, but if we plan to refactor the advise()
function to take care of checking the config variable itself, for
example, then we will need such a test anyway, so I think we might as
well include at least one such advice test now.)
