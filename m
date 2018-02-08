Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E9C51F576
	for <e@80x24.org>; Thu,  8 Feb 2018 08:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751094AbeBHIIO (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 03:08:14 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37890 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeBHIIN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 03:08:13 -0500
Received: by mail-qt0-f196.google.com with SMTP id z10so5119040qti.5
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 00:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Cx4l0xxAJp9k50J9vM/xvnbfoetMhmUqAZqZ8cG5V7U=;
        b=IG2IMt10ibHuesNN9p+DgOprSnUPHHzGbHj+Wm84aEveXdqN8hiMexeFXudqJtHXBp
         d3cbYZNkHfXLaL+YhxbcAVmwLL5bPAGQskro9sx+w78ueqslpXWGLK+JvH8vJSmw1sBT
         t7GNdOdbqwbtUwnxOVkidWPHt+oablufJvlhb5dGg5D3wQWqvhN0gvcGlRJfdTTK7EkG
         2JYS6j3UIycLoGSoZ5n1A1nT5WOf9WL7argCrx2/dUr2vSAbEdNEqFNmEHbWpp4VQP0z
         6cMJlfHBCeXuuHlptnEUNwe5i0UHav8rTGIs39Rj1jd6jXSZJ5pbxxKkRtE5Ks2P5OVw
         Fspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Cx4l0xxAJp9k50J9vM/xvnbfoetMhmUqAZqZ8cG5V7U=;
        b=DD5KsR4qTTW1OJ6uRF0A9935m9bUNnHQNIlkYvRGsf0ipCGT0YpRAswSIk52fp5O3H
         7bzA7Ut/EqPuG2x+48VYO1M0reK4StQ8J0iwCtlhzzwkLGofG2RY8yHSS9/Y9hJe1sHH
         Eg/lciidMYLuoxu0xyk/dkoBL8mw6nJxYhYG79n/sOgcK+TC+RwOeP3FYKL7QTYOFzHd
         Ma2esrs4S+GJtDRrHPj5TQ/XRBIN2N1SAVp2vRpOZ7EHetGuIBh8dEgHC1hAQoeyy6xx
         JsI8VLW7MHALoiVu5oB66oEROnljnG9gPNGd6F4Ed2c+vK3a8seYWfbAM/kPfuh1THN8
         n9cQ==
X-Gm-Message-State: APf1xPDJhWN+Ybamkg9sMWbljq/IrO6nfnlawUwyoM+EsW3c+P5Wa04u
        fwZkHJEcIO9nM9wUuj8DElkDxSUKxAuduPx0QLo=
X-Google-Smtp-Source: AH8x224VxJU2ri+QeEKpCZZfKD/eCylC/l3cHBd+ULr6Pg6s87Vs5PEd2IwDLCDo5za/Co6133DZcVk+XGmkQYbL3fs=
X-Received: by 10.237.37.68 with SMTP id w4mr13008223qtc.242.1518077292426;
 Thu, 08 Feb 2018 00:08:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Thu, 8 Feb 2018 00:08:11 -0800 (PST)
In-Reply-To: <20180207234359.31493-1-sbeller@google.com>
References: <CAPig+cQZr=UN3KC3LnaKy=oUYd1inbtDgi_pDuhPXf9HgFOdNw@mail.gmail.com>
 <20180207234359.31493-1-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 8 Feb 2018 03:08:11 -0500
X-Google-Sender-Auth: NEeVFDc7h3kVAyGDldEZqi8BhXs
Message-ID: <CAPig+cQejz+1ZWep31hw0pjxUoewRt+-2WATtw6PEusfvhn8EA@mail.gmail.com>
Subject: Re: [PATCH] send-email: error out when relogin delay is missing
To:     Stefan Beller <sbeller@google.com>
Cc:     Ramkumar Ramachandra <artagnon@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, mina86@mina86.com,
        mst@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jan Viktorin <viktorin@rehivetech.com>, zxq_yx_007@163.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 7, 2018 at 6:43 PM, Stefan Beller <sbeller@google.com> wrote:
> [...]
> Error out for now instead of potentially confusing the user.
> As 5453b83bdf (send-email: --batch-size to work around some SMTP
> server limit, 2017-05-21) lays out, we rather want to not have this
> interface anyway and would rather want to react on the server throttling
> dynamically.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/git-send-email.perl b/git-send-email.perl
> @@ -379,6 +379,9 @@ unless ($rc) {
> +die __("When a batch size is given, the relogin delay must be set\n")
> +       if defined $relogin_delay and not defined $batch_size;

This only makes sense is 'batch-size' is specified but not 'relogin'.
If the other way around, then the error is confusing. How about this
instead?

    "--batch-size and --relogin must be specified together"

...or something.
