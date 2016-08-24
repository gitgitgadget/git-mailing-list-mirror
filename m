Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD8601F859
	for <e@80x24.org>; Wed, 24 Aug 2016 07:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932196AbcHXHJU (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 03:09:20 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35549 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbcHXHJT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 03:09:19 -0400
Received: by mail-it0-f66.google.com with SMTP id f6so1235241ith.2
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 00:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=J6g+O0iyPScawmXiTto9mlurcAb/FWqNatzC9Oqbl94=;
        b=g8fh7LOz2FEOznd/CMsQwL5VPDkK7eTH7r3euLlfV7Pq2jvf1cnKolt8s+0UjA4Gsg
         DzwKyzCzViDkEIFYbOqhmS/U3EkKsk6F6AFde+ZgL1oasmKiQtdQ9HmWPLcGuqSjQi+G
         KRdyD+2B6csFrzckL+Pb9TxtOpPKsItYYdgx1qHBG2djE/lSNu00JpJRPtuhWH/x9K9X
         U0E0jvRgr24z7Ory64EV20psD10CNtbb1nVZjw74jGQ1NX2Rt87VF4942Ki1KYLaxL79
         pGBOzNT+RPkahOQ5eDXf/vgYmJrR8C9YKUQ1zUfk148bYChqDaOtYQfUSTEQ0YEQbbvf
         ocAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=J6g+O0iyPScawmXiTto9mlurcAb/FWqNatzC9Oqbl94=;
        b=hiB5mlruOMLD6BhAUmr6pohaPfotv9ou8A9vTEeAl6FAU8j3WVlWABZbZRgMw3+yjP
         fFj702NFlJywadg0h+hP7bU4wDvXMrdbRWLAkFXd9ls/J32ghysUiuiJDupzWGPlxC4g
         +r4NczJYOgLFLwsT9/ND3q+cbWBDug8TbDOScBzhQTsYMR9on5+nDsncMyevypZsCqqr
         9Vt/fW7FnW1PlO5xBTdWSH5lydhxIrjxn7BpWxpBQI7mbuISedLKESwT8gJcpT/5Y89P
         fPn2gBcoCMd1qiaxsxeJtf9Y69A+FGdOZfH8RepUTQlhxRJQFE8+PRi73Iox46Wog6GZ
         UETQ==
X-Gm-Message-State: AE9vXwNRKleQq5jxptLs6OOm891aWF6FSvSiEh1L8KKN8H8mFohSviByaygqI0Xco5thLaPIHUrEet1AK2VWEA==
X-Received: by 10.107.25.14 with SMTP id 14mr2385966ioz.168.1472022558354;
 Wed, 24 Aug 2016 00:09:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.130.1 with HTTP; Wed, 24 Aug 2016 00:09:17 -0700 (PDT)
In-Reply-To: <6dc5e927cbdd1847db5b6cd75041609dd1e1f76d.1471968378.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <6dc5e927cbdd1847db5b6cd75041609dd1e1f76d.1471968378.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 24 Aug 2016 03:09:17 -0400
X-Google-Sender-Auth: 7-BXu1CPezpV5b8Nx3yWzKeiX90
Message-ID: <CAPig+cSX_F-vQ_zSrTU6BQSfMeU=5V3krE7xgmBL=g=Jr8i2MA@mail.gmail.com>
Subject: Re: [PATCH 01/15] sequencer: lib'ify write_message()
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 12:06 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> To be truly useful, the sequencer should never die() but always return
> an error.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/sequencer.c b/sequencer.c
> @@ -180,17 +180,20 @@ static void print_advice(int show_hint, struct replay_opts *opts)
> -static void write_message(struct strbuf *msgbuf, const char *filename)
> +static int write_message(struct strbuf *msgbuf, const char *filename)
>  {
>         static struct lock_file msg_file;
>
> -       int msg_fd = hold_lock_file_for_update(&msg_file, filename,
> -                                              LOCK_DIE_ON_ERROR);
> +       int msg_fd = hold_lock_file_for_update(&msg_file, filename, 0);
> +       if (msg_fd < 0)
> +               return error_errno(_("Could not lock '%s'"), filename);
>         if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
> -               die_errno(_("Could not write to %s"), filename);
> +               return error_errno(_("Could not write to %s"), filename);

Does this need to rollback the lockfile before returning[*]?

[*] I'm not terribly familiar with the lockfile mechanism and I don't
have a lot of time to study it presently, so ignore me if this is a
stupid question.

>         strbuf_release(msgbuf);
>         if (commit_lock_file(&msg_file) < 0)
> -               die(_("Error wrapping up %s."), filename);
> +               return error(_("Error wrapping up %s."), filename);
> +
> +       return 0;
>  }
