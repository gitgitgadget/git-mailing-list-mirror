Return-Path: <SRS0=J6fK=EP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA66DC2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 07:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51DBE2067D
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 07:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+v0XoBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgKIH3a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 02:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKIH3a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 02:29:30 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B81C0613CF
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 23:29:29 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id g15so7327105ybq.6
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 23:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=paOBjVlpnJQLVAIDKRjkx1nVZFtLVxV/rSTBGW89ECs=;
        b=p+v0XoBIWoEp6SqB4g4dI6VvyfjHfTmF7nIu1h/IQTbPxNshRVRDaizKfs0a1Trwyw
         w/w4oXnps7oLz4RMSbTDbTDxA87vV9t8FaYCcNzL9rsaCD7lX3VzzrqpzKShpnmg6CSh
         agqEQQTB8BWmMULeZ+/ioszjwjddnarK24BBuI6N3Acmoz+Tb5idH0aVWONi+6jLsfmy
         d3u3iWt0ZQB31SriHLm1oC3SCpFeBVzhK1NOKxcO/KyCZhn09ZTWnZLp1k8aum1HdPYu
         zSXpHEtLYJNrUReFDqX3oBfTZy2uk/+1UNLHNp8jDNPWo8euOuA2CNbpN1DEu1rskikv
         L35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=paOBjVlpnJQLVAIDKRjkx1nVZFtLVxV/rSTBGW89ECs=;
        b=i6z9CttmhEQCLzmDwesei/s2TElFa0A2WhtbH7wfdFISqdyIdku8PxvR63gawtxwNl
         HVvNfn1YJasmDDbhyThli1P/FgTiU1ul8UYJYNUtFbBaxmyLWC7Ns04ppZrIBdwBEFWJ
         +ijFQoA6pNOapn3HonmvDc8KBCs4YI38ZnrxnuzJ0LABQjTaX26Q8GNpGk/GD8vBgSRI
         MukHq0wr9oQcA/U596iO4CcfJQ226ej4mpypHyUVTK7+YTOiktnWoaaBKfICVsMz6dGt
         E4Dddn7xgRxMgmUKMdsjjJTYO2tzqaPYOM8GnsZlj/QsSl7gCia383DT9mF/WtpbwPOc
         a7sw==
X-Gm-Message-State: AOAM530UGyD7SRtGPA4txjvwtdagfDfxb8F+EUGudyRTU+Wb0P+oi2vF
        yvn6fERSRnQZY92xAxC/cvT1mLj0SfYMUnF4sTg=
X-Google-Smtp-Source: ABdhPJwsGUAztuCyXyCXrUIyFK72SBYUD91jhhPR2xlIdfEBthwmazX2c79HOLYFy6y5+YlgyKAyDJLS4PIWWROAfAQ=
X-Received: by 2002:a25:5402:: with SMTP id i2mr1351341ybb.238.1604906968332;
 Sun, 08 Nov 2020 23:29:28 -0800 (PST)
MIME-Version: 1.0
References: <xmqqk0uzk452.fsf@gitster.c.googlers.com> <20201107025746.13064-1-worldhello.net@gmail.com>
In-Reply-To: <20201107025746.13064-1-worldhello.net@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 9 Nov 2020 15:29:17 +0800
Message-ID: <CANYiYbHQKshFg=1xAv8MFfSjmFfQ0uJRm3mQBnZMsTd1n7R-Ow@mail.gmail.com>
Subject: Re: [PATCH] t5411: consistent result for proc-receive broken test
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> =E4=BA=8E2020=E5=B9=B411=E6=9C=887=E6=
=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=8810:57=E5=86=99=E9=81=93=EF=BC=9A
> @@ -75,13 +78,18 @@ static void proc_receive_read_commands(struct packet_=
reader *reader,
>                 if (packet_reader_read(reader) !=3D PACKET_READ_NORMAL)
>                         break;
>
> +               if (die_readline)
> +                       die("die with the --die-readline option");
> +
>                 if (parse_oid_hex(reader->line, &old_oid, &p) ||
>                     *p++ !=3D ' ' ||
>                     parse_oid_hex(p, &new_oid, &p) ||
> -                   *p++ !=3D ' ' ||
> -                   die_readline)
> +                   *p++ !=3D ' ') {
> +                       while (packet_reader_read(reader) !=3D PACKET_REA=
D_EOF)
> +                               ; /* do nothing */
>                         die("protocol error: expected 'old new ref', got =
'%s'",
>                             reader->line);
> +               }
>                 refname =3D p;
>                 FLEX_ALLOC_STR(cmd, ref_name, refname);
>                 oidcpy(&cmd->old_oid, &old_oid);

Still have problems under the stress test.  Today I figured out how to
run stress test by setting proper environment variable
GIT_TEST_STRESS_LOAD without consuming too many resources and leading
to random strange errors. E.g.:

    $ GIT_TEST_STRESS_LOAD=3D11 sh  t5411-proc-receive-hook.sh -v --stress

Will send patch v2 later with the following changes:

-- snip --
diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
index ee5717ba0a..9f7fbc5b7a 100644
--- a/t/helper/test-proc-receive.c
+++ b/t/helper/test-proc-receive.c
@@ -78,17 +78,18 @@ static void proc_receive_read_commands(struct
packet_reader *reader,
                if (packet_reader_read(reader) !=3D PACKET_READ_NORMAL)
                        break;

-               if (die_readline)
-                       die("die with the --die-readline option");
-
                if (parse_oid_hex(reader->line, &old_oid, &p) ||
                    *p++ !=3D ' ' ||
                    parse_oid_hex(p, &new_oid, &p) ||
-                   *p++ !=3D ' ') {
+                   *p++ !=3D ' ' ||
+                   die_readline) {
+                       char *bad_line =3D xstrdup(reader->line);
                        while (packet_reader_read(reader) !=3D PACKET_READ_=
EOF)
                                ; /* do nothing */
+                       if (die_readline)
+                               die("die with the --die-readline option");
                        die("protocol error: expected 'old new ref', got '%=
s'",
-                           reader->line);
+                           bad_line);
                }
                refname =3D p;
                FLEX_ALLOC_STR(cmd, ref_name, refname);
-- snap --
