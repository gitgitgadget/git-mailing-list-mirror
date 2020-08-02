Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29991C433E0
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 16:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0056A206F6
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 16:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLl8lmoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgHBQDh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 12:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgHBQDg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 12:03:36 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E97C06174A
        for <git@vger.kernel.org>; Sun,  2 Aug 2020 09:03:36 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k8so13329487wma.2
        for <git@vger.kernel.org>; Sun, 02 Aug 2020 09:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wp4F3zHo92BeuRTsqI+tpWnD+PUChkXmdu+9n3s3un0=;
        b=kLl8lmocbxvH6zJEU5y7Ed2aPiKWMDzm7ESv8hkTpu6u9qTuANIzi0gZY4NymfMHxC
         hRSOWc9F/JaNmcVkv3mg/8dPNWEu2MdWCpiRLGCTH5LIMzXL09FTcx82LUhmBN86O/Ri
         2HzqJ1IihuSetpw7L4Qqpx6gOUus9+b2Mfeu6dc5mWqsWeHzDDMgeaacIEWLz0vClBF5
         IqkQLHKFkUZ1PlCEW7tp5BuUv2FEhHQ71/TLS7Fbyg4uflZY6x2qrJ0gO1g+rZsdkU5/
         7kyyyh0wxIffytlYCu/F9nTfk4U4wosW3Ns9B4TFCsksLIieVHY/03ujib6m5FA5NQ9d
         hOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wp4F3zHo92BeuRTsqI+tpWnD+PUChkXmdu+9n3s3un0=;
        b=bsThSaiKb7shodOKa8t7XF/09ADXHNWYgHipUzKinCDAu7DkIndybF0fT2j3D7zIcE
         GxxmFkbe8giCZ/J0IFLQV2s4R3kBiPUuFGZ79unSCKchgnszGMvyW1CEYrz1F6McrT2T
         bpkNdwbOvUMSuLxWPo2RnfHyiAcALU47nf7HcoMYkevlB9LqS70iXbgJRNYRFbOepWET
         l8Pk8ptqFidifLupHfUncPvr2xymuECP3em8X/aqx91hsR9r4+PMELeIDHrX1m3q/W+A
         RkTrqs9PBvtbeZaJySAj+IyxEbuMCL8+HKmwEjhJXhOQYAv2eU9a4XAdwb+MkXY9VyE0
         IYbg==
X-Gm-Message-State: AOAM532l3y9rgU+0jlmycIoZ5hEuDwYyfCXYWHGr+7vsCFxN0fZ269Ud
        u5xPqNMe84hXoVnWYvC8YS30bmzwpotItY7cgLk=
X-Google-Smtp-Source: ABdhPJwNl9krGPaTBk7fuTojHSGRQaRJiUOzLMy0NhalmJYwSeuCAwhUFQvTkkqhgkGl41CoaXiTZCZinAhaE60zEAM=
X-Received: by 2002:a1c:41c5:: with SMTP id o188mr3041249wma.187.1596384214689;
 Sun, 02 Aug 2020 09:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <6722ade6-971e-7ecc-e8f0-7f595ca0b0ff@web.de>
In-Reply-To: <6722ade6-971e-7ecc-e8f0-7f595ca0b0ff@web.de>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sun, 2 Aug 2020 09:03:23 -0700
Message-ID: <CAPx1GvdJ-4Yyf7Vm1OdhaW2TZp77HOfGxoGw0R2fKfEuHQkqOg@mail.gmail.com>
Subject: Re: [PATCH] upload-pack: use buffered I/O to talk to rev-list
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One suggestion here:

On Sun, Aug 2, 2020 at 7:41 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Like f0bca72dc77 (send-pack: use buffered I/O to talk to pack-objects,
> 2016-06-08), significantly reduce the number of system calls and
> simplify the code for sending object IDs to rev-list by using stdio's
> buffering and handling errors after the loops.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  upload-pack.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index 86737410709..9f616c2c6a6 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c

[snip]

> @@ -640,12 +636,11 @@ static int do_reachable_revlist(struct child_proces=
s *cmd,
>                 }
>                 if (reachable && o->type =3D=3D OBJ_COMMIT)
>                         o->flags |=3D TMP_MARK;
> -               memcpy(namebuf, oid_to_hex(&o->oid), hexsz);
> -               if (write_in_full(cmd->in, namebuf, hexsz + 1) < 0)
> -                       goto error;
> +               fprintf(cmd_in, "%s\n", oid_to_hex(&o->oid));

The fprintf() call here *can* return an error, e.g., if the
connection has died.  If it does, it should set things up so that
a later ferror(cmd_in) returns true.

>         }
> -       close(cmd->in);
>         cmd->in =3D -1;
> +       if (fclose(cmd_in))
> +               goto error;

The fclose() call doesn't necessarily check ferror().  (The
FreeBSD stdio in particular definitely does not.)  It might
be better to use:

    failure =3D ferror(cmd_in);
    failure |=3D fclose(cmd_in);
    if (failure) ...

here, or similar.  (The temporary variable is not needed,
but someone might assume `if (ferror(fp) | fclose(fp))` is
a typo for `if (ferror(fp) || fclose(fp))`.)

(Note: my sample isn't properly indented as gmail does not
let me insert tabs easily)

Chris
