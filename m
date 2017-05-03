Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EF901F829
	for <e@80x24.org>; Wed,  3 May 2017 18:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbdECST1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 14:19:27 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33093 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752090AbdECSTR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 14:19:17 -0400
Received: by mail-pf0-f169.google.com with SMTP id q20so16372787pfg.0
        for <git@vger.kernel.org>; Wed, 03 May 2017 11:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eJ+ZwVeyaC4DlH3eBZ6FqBpt9PlS1+qrBE7jxOhmTnQ=;
        b=KNVXB4xFwrOeQTleWNGAWwEHCeq52GT2C4YP0yf4c5jvBATM8Y2UKsdDAySdpn31JR
         FedJinKHFDUFZy3NW4E0w8JqUNvE6TNXTaLk98xJktsk9Hxxbm1uuQN7maZsQcrGWuLK
         uKdiKN6QjNiMVqVZP8OxOSStlesF8JPArnqoteH62MdHeqcacv64aqcCxpozyUnH5dnV
         bNnlDimQYwuhGcjNRfRzaJN/iiU0V+kojrIUmqsUOd/+NamxZtSnNe2WWIjPVq9Xt8Jq
         WzHvTziyaXOjT6N1WJiP8FWT6eS4vNcVPre0GGw/F++STf4M90+4WffeFJ8ta+xtpRoP
         Rtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eJ+ZwVeyaC4DlH3eBZ6FqBpt9PlS1+qrBE7jxOhmTnQ=;
        b=pCR+dWTcft544OwI2VXA1cEQEiSMNAc+q1S5lR9670McpICWD5O/5wdwZGADO+DzQS
         qzmb68xlcbY63cNhRP/gLdqZYWRWmghrPKnhGNbMEyAKWTgfCYyZJOEghIoAfDgyxYOc
         n7Zd9Qx3XnkNHSnNp+bgMRYcz8tS5/4P6tZpOs228+NHTavGXONR4ZiJ9L5a75jOyrIv
         c31lsM9QjAThoQyWVEe+2SlsDTEolm7fjSQzo+09tRhyOoy/NeXDdVGe3kzBsLd6NH6+
         KfgK8GSzyBhHrkkvrIQRbUkUB+xJLm8lYn5wBOJmL24s7sXL9QPd4YGwYTUFUXGo5Y6h
         VQkQ==
X-Gm-Message-State: AN3rC/5kPXFFbgsa2p/JL21nwX8elQRcBFWGC6HRcuImKQjW99MAjL/L
        6QHjdut21OdJeJl/7AoUvMB5JMLoWa1I
X-Received: by 10.99.60.81 with SMTP id i17mr30335822pgn.183.1493835556724;
 Wed, 03 May 2017 11:19:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Wed, 3 May 2017 11:19:16 -0700 (PDT)
In-Reply-To: <20170503032932.16043-2-sxlijin@gmail.com>
References: <xmqqshkof6jd.fsf@gitster.mtv.corp.google.com> <20170503032932.16043-1-sxlijin@gmail.com>
 <20170503032932.16043-2-sxlijin@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 3 May 2017 11:19:16 -0700
Message-ID: <CAGZ79kauf5tAEv1JJCbTsuKhPYFKq0DVChBBt2EjHxRRZEzYAw@mail.gmail.com>
Subject: Re: [PATCH 1/7] t7300: skip untracked dirs containing ignored files
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 2, 2017 at 8:29 PM, Samuel Lijin <sxlijin@gmail.com> wrote:
> If git sees a directory which contains only untracked and ignored
> files, clean -d should not remove that directory.

Yes that states a fact; it is not clear why we want to have this test here
and now. (Is it testing for a recently fixed regression?)
Are you just introducing the test to demonstrate it keeps working later on?
Do you plan on changing this behavior in a later patch?)

> ---
>  t/t7300-clean.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> index b89fd2a6a..948a455e8 100755
> --- a/t/t7300-clean.sh
> +++ b/t/t7300-clean.sh
> @@ -653,4 +653,14 @@ test_expect_success 'git clean -d respects pathspecs (pathspec is prefix of dir)
>         test_path_is_dir foobar
>  '
>
> +test_expect_success 'git clean -d skips untracked dirs containing ignored files' '
> +       echo /foo/bar >.gitignore &&
> +       rm -rf foo &&
> +       mkdir -p foo &&
> +       touch foo/bar &&
> +       git clean -df &&
> +       test_path_is_file foo/bar &&
> +       test_path_is_dir foo
> +'

The test makes sense, though I am wondering if we can integrate
this test into another test e.g. "ok 15 - git clean -d".

Is the -f flag needed?

Thanks,
Stefan
