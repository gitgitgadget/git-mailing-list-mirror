Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E32091F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 21:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfACVlk (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 16:41:40 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]:36745 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbfACVlj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 16:41:39 -0500
Received: by mail-qk1-f179.google.com with SMTP id o125so20515374qkf.3
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 13:41:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WWHBZcZMMMvFvpVTvQS1IlFqAD51guMUXJ1VWqKxvDI=;
        b=ryDBQDqR+rGo4HIcBz4zwbJftgvKwbLUi0VSiuXCZeqD8eo74VctW+pwgvUt2DiZdf
         ErmkuB3ORfvCr1ogfmqvmVd4L1mOZzLySw+1raA6uvMjMlFSd6g4miCC+UrChbHMRSTU
         XqTLzbbymYCq9Z62pyVo+RJcy/mdG/ZQ1UnC5pqNqiX83Wjsg+Rwn6vgzAvmR0FkRKHx
         277IXIyIqYQt6opLkQ+I9l173QGONhl+riGIQCiETUzuMRB4U0PzIvK7C2NXsJuuYx91
         dgcmIylzQnvCCC0Cz8w79sVBlJSj+RaonXbbjv0v+Cja6gCpUkj+S6WBhre9vNVoH9AG
         zd9g==
X-Gm-Message-State: AJcUukcpFK1gNjQ3xIo0Ts8/zQCqKuXoB72URZauuwLVvYU7ZKLyo8ZU
        QSVhQnia9qEvIbrUhCasCCVcPJzB7DwRz91br2k=
X-Google-Smtp-Source: ALg8bN6G9bVHtoDIcw92BIFnyKXjL1G7mw1rz6iO7OeWgb6v+IsvckCQTp3DoZFjW0xDL1bvcnxHejETkkzRrk1x2z0=
X-Received: by 2002:a37:a44e:: with SMTP id n75mr46797759qke.26.1546551698804;
 Thu, 03 Jan 2019 13:41:38 -0800 (PST)
MIME-Version: 1.0
References: <20190103210351.13920-1-randall.s.becker@rogers.com> <20190103210351.13920-4-randall.s.becker@rogers.com>
In-Reply-To: <20190103210351.13920-4-randall.s.becker@rogers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 3 Jan 2019 16:41:29 -0500
Message-ID: <CAPig+cSdheCx-Ucnmg5eSXyNhyGPFF3L6N_Nc5uXQdc8Ytx2DA@mail.gmail.com>
Subject: Re: [Patch v5 3/4] git-compat-util.h: add FLOSS headers for HPE NonStop
To:     randall.s.becker@rogers.com
Cc:     Git List <git@vger.kernel.org>,
        "Randall S. Becker" <randall.becker@nexbridge.ca>,
        "Randall S . Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 3, 2019 at 4:04 PM <randall.s.becker@rogers.com> wrote:
> The HPE NonStop (a.k.a. __TANDEM) platform cannot build git without
> using the FLOSS package supplied by HPE. The convenient location
> for including the relevant headers is in this file.
>
> The NSIG define is also not defined on __TANDEM, so we define it
> here as 100 if it is not defined only for __TANDEM builds.
>
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
> diff --git a/git-compat-util.h b/git-compat-util.h
> @@ -397,6 +397,17 @@ static inline char *git_find_last_dir_sep(const char *path)
> +#ifdef __TANDEM
> +#include <floss.h(floss_execl,floss_execlp,floss_execv,floss_execvp)>
> +#include <floss.h(floss_getpwuid)>
> +#ifndef NSIG
> +/* NonStop NSE and NSX do not provide NSIG. SIGGUARDIAN(99) is the highest
> +   known, by detective work using kill -l as a list is all signals
> +   instead of signal.h where it should be. */

Style nit: With two minor exceptions, all other multi-line comments in
this file are formatted as:

/*
 * Multi-line
 * comment.
 */
