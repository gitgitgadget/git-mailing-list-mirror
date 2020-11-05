Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9A8C4741F
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 14:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C49B20719
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 14:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTtJFBXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbgKEOyS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 09:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730465AbgKEOyS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 09:54:18 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A7CC0613CF
        for <git@vger.kernel.org>; Thu,  5 Nov 2020 06:54:17 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id o70so1587619ybc.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2020 06:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7XTYvhKVy9ECZ/HB/CIcJokEHTzVBwCLW4DGkCfKNE0=;
        b=lTtJFBXfbW3t0M6/pJyqv0T5+BEj/++8TYPBro3SBsF19vpVTkcJbzlcQkxRbc4Cp6
         B86LrCstia7ZikkMRcCPcledT3sS4wEIv24bWq+UfImhGDSE38qGtsqy7SDXAMvrZ6MS
         IcUrol6xdvBmsqCqO+9fQl9+0RqPDs0m25+PtNdw26bWgOOiXRvvy6dy0s8OAkZcNV1T
         6xf7sBufbbQ3HskTIukfR7Mqq3eU7w6mpSvXpjumMLlefWSrxBE7ykY+IgLzB5N2Aeow
         kVSXnEpHfhHV3xccdDqfWw44KDVYm7NkRUR7Fr1mZdp/c/rkoCaYkHT7xBUiqBy/sIDc
         Bi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7XTYvhKVy9ECZ/HB/CIcJokEHTzVBwCLW4DGkCfKNE0=;
        b=t8Y8XSmIrH5IaHmMrRrSDNpLEDoJWjqilG/tS+Xc3cG3ftO3vU4Irx5lKOtxcwrtqa
         kLJIoBbrIegvtu9c0Dahoe9UDe4xpKsZaH4YDJN+hR1fBFQ8vpSrOI45n1/D5YuRzgVj
         NaxazwF+hYY7aZMdkZ8FRf1kf/iXBIF0wpVjRcOEu/vpB2WW8TRRU6QI/buJiAKRZLMK
         NiKfbYTXSd1ztmiq+xRuLIXy3fA65u4S65mTfguGjsms9FZlQk0ob2YOXxh0nWZhAPic
         jhB6xjRJjCX3BVU7Virn7IqCjUU37HF26DlDfzaQhHJSVGTr4Ty9C2ZZJDtTATOpPpXG
         Y89A==
X-Gm-Message-State: AOAM530rQiGEXu9Yh7afLy62DRYAJA4zNpxvMG2cx1Iza8E2gi9UTA8L
        YlxLW/hfbgNdSPlnZXbXQhuf/XrHcfok0bgTyo4=
X-Google-Smtp-Source: ABdhPJwxX70mI192NYV+EhXRXdkoi6ofGjUqrl3oeW/xaXb3dztC16u0IHtSvVxhm1JA4o+VxPJ6CGdfOUqpYzqWFdA=
X-Received: by 2002:a25:2e0f:: with SMTP id u15mr3899081ybu.520.1604588057005;
 Thu, 05 Nov 2020 06:54:17 -0800 (PST)
MIME-Version: 1.0
References: <20200824174202.11710-1-worldhello.net@gmail.com>
 <20200827154551.5966-4-worldhello.net@gmail.com> <nycvar.QRO.7.76.6.2011042236270.18437@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2011042236270.18437@tvgsbejvaqbjf.bet>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 5 Nov 2020 22:54:05 +0800
Message-ID: <CANYiYbFcXN_ARmZ70GQkrQ=uFaf7YPObYcopEOFseON6TQzNpQ@mail.gmail.com>
Subject: Re: [PATCH v19 03/10] receive-pack: add new proc-receive hook
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> =E4=BA=8E2020=E5=B9=B411=
=E6=9C=885=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=886:15=E5=86=99=E9=81=
=93=EF=BC=9A
> not ok 34 - proc-receive: bad protocol (hook --die-readline, builtin prot=
ocol)
> #
> #               test_must_fail git -C workbench push origin \
> #                       HEAD:refs/for/main/topic \
> #                       >out 2>&1 &&
> #               make_user_friendly_and_stable_output <out >actual &&
> #
> #               grep "remote: fatal: protocol error: expected \"old new
> #               ref\", got \"<ZERO-OID> <COMMIT-A> refs/for/main/topic\""
> #               actual &&
> #
> #               git -C "$upstream" show-ref >out &&
> #               make_user_friendly_and_stable_output <out >actual &&
> #               cat >expect <<-EOF &&
> #               <COMMIT-A> refs/heads/main
> #               EOF
> #               test_cmp expect actual
> #
> -- snap --
>
> The output of `actual` reads like this:
>
> -- snip --
> remote: # pre-receive hook
> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
> remote: # proc-receive hook
> fatal: unable to write flush packet: Broken pipe
> send-pack: unexpected disconnect while reading sideband packet
> fatal: the remote end hung up unexpectedly
> -- snap --

In this test case, the "proc-receive" hook sends an error message and
dies earlier. While "receive-pack" on the other side of the pipe
should forward the error message of the "proc-receive" hook to the
client side, but there is no such error message in output. It seems
that the expected error message is overridden by the broken pipe error
message. The broken pipe error is because "receive-pack" sends other
commands to the "proc-receive" hook, but the hook dies earlier.

> Applying G=C3=A1bor's patch as obtained from
> https://lore.kernel.org/git/20190830121005.GI8571@szeder.dev/ seemed to
> help this issue at first, but then turned out not to prevent the same
> issue from happening again.

I think this is the right way to fix this issue, even though I cannot
reproduce this issue in my laptop.

1. In the `run_proc_receive_hook()` function of "receive-pack", should
close the input (proc.in) before reading result from "proc-receive":

--  snip --
@@ -1196,11 +1197,12 @@ static int run_proc_receive_hook(struct
command *commands,
                packet_flush(proc.in);
        }

+       close(proc.in);
+
        /* Read result from proc-receive */
        code =3D read_proc_receive_report(&reader, commands, &errmsg);

 cleanup:
-       close(proc.in);
        close(proc.out);
        if (use_sideband)
                finish_async(&muxer);
-- snap --

2. test helper for proc-receive should consume the input stream before
die earlier:

-- snip --
@@ -79,9 +79,11 @@ static void proc_receive_read_commands(struct
packet_reader *reader,
                    *p++ !=3D ' ' ||
                    parse_oid_hex(p, &new_oid, &p) ||
                    *p++ !=3D ' ' ||
-                   die_readline)
+                   die_readline) {
+                       while (packet_reader_read(reader) !=3D PACKET_READ_=
EOF);
                        die("protocol error: expected 'old new ref', got '%=
s'",
-                           reader->line);
+                               die_readline? "<call with
--die-readline>": reader->line);
+               }
                refname =3D p;
                FLEX_ALLOC_STR(cmd, ref_name, refname);
                oidcpy(&cmd->old_oid, &old_oid);
@@ -136,7 +138,7 @@ int cmd__proc_receive(int argc, const char **argv)
                usage_msg_opt("Too many arguments.",
proc_receive_usage, options);
        packet_reader_init(&reader, 0, NULL, 0,
                           PACKET_READ_CHOMP_NEWLINE |
-                          PACKET_READ_DIE_ON_ERR_PACKET);
+                          PACKET_READ_GENTLE_ON_EOF);

        sigchain_push(SIGPIPE, SIG_IGN);
        proc_receive_verison(&reader);
-- snap --

I will send a standalone patch using git-send-email command line later.

--
Jiang Xin
