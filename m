Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8570DC433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F69C64D73
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhBPMuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 07:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhBPMuD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 07:50:03 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606CEC06174A
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 04:49:22 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id r2so5419768plr.10
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 04:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:mail-followup-to:references:mime-version:in-reply-to:date
         :message-id:subject:to;
        bh=B2BUeZLPx7J05osQ54bqNDFlMjKe656uPDWU/l/cOFs=;
        b=Csh5U2of13F45Y09gpqyNM50TFHEk4vyfeNryC/F2SI8KzoCKqOH55DjeBZ8XM7kBL
         22II0xvqSDB7N9QmwiHDpwg2LdHWkDsq/PTWGEwEEi3ygynwO5Jxc86fxzjj6bik0qBK
         rga4J2EM9t1RAcWdKk9gLzG8jQ4r9rbxTyJRoM0K+1lVRdUko0ns4v5KsgM8Waj383mh
         RkL0z7pXd/ExJ72RbkpZrUULR75JOxVfOmyqbL8uCPX415tt6+EH+BkJa57Rke276+ZS
         NgZqG7VyI3MD2nioesrt3zJZq1qZYsjUK4qm48JJNSfQZwmYzSS5crXEXzUJnilXyGSZ
         CYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mail-followup-to:references:mime-version
         :in-reply-to:date:message-id:subject:to;
        bh=B2BUeZLPx7J05osQ54bqNDFlMjKe656uPDWU/l/cOFs=;
        b=SElD9C+zZHA6ME0JurRMnxFZDD+cNImV4GlHiOIuDigTgXsRwuf/cywJMfPn5AT5cp
         w0msMVGyd+f7RjkRJjfdBwZt8UHSvcQmOd8S4CRJ+WsWXlZnABlRdRDklgs2ZvTjI2EW
         GhJz0LI1OwlZ179w+RTNdngItnAu80y5XRyd7Dpno/Q3LOPSvo6NR2znCgpwXqahbrRP
         w5gZa+Zhvqu7LaPk67mxPFvWf7UMBuPMWUKMNfDCr6Qm7/ey0VhPlLJGeJue+Yf5GmFV
         4xKoWUCXaNm776u9LrO8+GUSTeesiyvEw7K6xFmgV1S1qik0ZO2TVz9GFWNs0ClubekC
         GbUQ==
X-Gm-Message-State: AOAM53035QybRzUni2w3P6WwwtO8NjneyZaw+rtuQu0rxqixPcAcRa0l
        OiEXjdzsmEH7Vcd2k4W3v9xn8NhDz8oC7CaDJyg0jUeM6vs=
X-Google-Smtp-Source: ABdhPJznXJOV4Mb3ob1f42GNO0+XQsjyJzhRrbhFaJysnzuENX5zaf4FEJBA6EOGrgo5FWMdII/LhFj8C3RjtDrDQe0=
X-Received: by 2002:a17:90a:71ca:: with SMTP id m10mr4113686pjs.2.1613479761794;
 Tue, 16 Feb 2021 04:49:21 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Feb 2021 04:49:20 -0800
From:   =?UTF-8?B?SmFuIOKAnEtoYXJkaXjigJ0gU3RhbsSbaw==?= 
        <khardix@gmail.com>
Mail-Followup-To: =?UTF-8?B?SmFuIOKAnEtoYXJkaXjigJ0gU3RhbsSbaw==?= <khardix@gmail.com>, 
        git@vger.kernel.org
References: <CAG+K25Pk0+sOAYuWS2OF7CXLXJLjGMKyBB_SOLpoO5RFiktN5g@mail.gmail.com>
 <xmqqo8gksqr4.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
In-Reply-To: <xmqqo8gksqr4.fsf@gitster.c.googlers.com>
Date:   Tue, 16 Feb 2021 04:49:20 -0800
Message-ID: <CAG+K25NbifB9k9ugU5ZjLAOKxLyfEZcphfZXNS9_Whi6gZcBLA@mail.gmail.com>
Subject: Re: git-send-email: smtpserver in $HOME
To:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000000df90c05bb7388e7"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--0000000000000df90c05bb7388e7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2021-02-15, Junio C Hamano wrote:
> I haven't given too much thought, but offhand do not think of a
> reason why a change like the attached would break things.

Seems reasonable, but I figured I rather ask beforehand.

>  git-send-email.perl | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git c/git-send-email.perl w/git-send-email.perl
> index 1f425c0809..ff58ac5046 100755
> --- c/git-send-email.perl
> +++ w/git-send-email.perl
> @@ -1006,6 +1006,8 @@ sub expand_one_alias {
>  		}
>  	}
>  	$smtp_server ||=3D 'localhost'; # could be 127.0.0.1, too... *shrug*
> +} elsif ($smtp_server =3D~ /^~/) {
> +	$smtp_server =3D glob($smtp_server);
>  }

This introduces a special case just for handling $smtp_server=E2=80=A6
I was thinking something in the way of the following:

diff --git a/git-send-email.perl b/git-send-email.perl
index 1f425c0809..84c07daf6d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -268,7 +268,6 @@ sub do_edit {
 );

 my %config_settings =3D (
-    "smtpserver" =3D> \$smtp_server,
     "smtpserverport" =3D> \$smtp_server_port,
     "smtpserveroption" =3D> \@smtp_server_options,
     "smtpuser" =3D> \$smtp_authuser,
@@ -294,6 +293,7 @@ sub do_edit {

 my %config_path_settings =3D (
     "aliasesfile" =3D> \@alias_files,
+    "smtpserver" =3D> \$smtp_server,
     "smtpsslcertpath" =3D> \$smtp_ssl_cert_path,
 );

This turns the smtpserver option into a "path setting",
which does the user expansion.
My concern was that if there is a SMTP server actually named
i.e. `~someone.example.org`, this change would break that.
Of course, the question is if something like that
is possible or supported=E2=80=A6

I have not yet allocated enough time to figure out how to run
and/or modify the test suite, so I do not know if this would actually
break something. I will try to do that in the near future.
--
Jan Stan=C4=9Bk =E2=80=93 Khardix

--0000000000000df90c05bb7388e7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7d0d6820c69ef6df_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSXpCQUFCQ2dBZEZpRUVZdjczM3Vsa24w
UVpmdWczS1hMeUEzc2tPMjBGQW1BcnYwOEFDZ2tRS1hMeUEzc2sKTzIzTmRRLzlGT3B3Z3VPbHR3
NHBUd3B3NWYvVG5vQkhDQzRLT1ZmZEVXL21IMTZTcDhiT3lrbDU0YURROG5PRAozTFkwRzFVVnBX
dzFxU3B5ZUMwa29McTFLejdacDk3MEVua2hJUmZYM01Da0w4bjdlL2IyWXFIWnlhNFBKSHczCmli
TC9aWFFsazVJOVhzQm8yR1BIOGYzcGNkb1FweUdneVVTYy9YYkxBT0xwVkRaNUU4bWtNREZZV2Na
b3o5MUEKeWllK3pheWVnVk41YWNqYXpPSFpCZ1ZwaXJwZ2RWMnBmVUxsWmhGbzUxNFhjTTBqNCta
ZGJQSTlTeHo3MzhEeQpHUU5uR21mMWVsM1ViRld0amh2YzM1Y00vazN3a2twb0d4YzZpbzBUazQ0
QS9rSmhpUUJ4M0pSR00xb0owN2dsCktya04yK0Y3TUFiSURqdXpvdStHSUVRVGdzT3R6UEtWd0l0
WHNPNkRMQlFvUDJxa1c4dzZYQVZXOVhJV0JINkEKYnAwUXIvYjlINWxENkd4VEw5NXkzN1RHNnRP
VTJNb1ZKYVBCTkx2VnlWd1JmQ1BmMDF6MTc1ZmNiTkN6NVdGbQovZFd6Zk1HMGlRUnFNN2xqbkxs
dVRRTmNDRUtZYVhmZTAzSFNtOXd0MHpKb2xpNmV0T2cydFVnMmJvOFFBeUozCmZGeTJ4Wk5PUW94
M3BSNWZlcXkwWktMQkNHcFl3azRYSEFNNCt1dTk5MDBzT3lSQzM0eGg5ZnYyaEFob0JsZkoKQU9k
dmZFVE5nNld5S09Edk1BRXdyY3RvemlYaDAxN3BqeFZ1ZTNsTlY3b2VJZndHVGlEOUt2NjBOZDZi
WUJRVQpvc29ubmpBUmxSY0FTUUp3UHJLcmUzT091cEJmVnphTThZTHdMODI4NXdBbG1xMUFGSFE9
Cj1lZXVtCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=
--0000000000000df90c05bb7388e7--
