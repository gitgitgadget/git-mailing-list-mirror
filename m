Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3F6520248
	for <e@80x24.org>; Fri, 15 Mar 2019 11:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfCOLK7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 07:10:59 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37436 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfCOLK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 07:10:58 -0400
Received: by mail-it1-f194.google.com with SMTP id z124so10166817itc.2
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 04:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mWuZozd20xeTSZ7IgtVLNO0xfC0ztohGtAvVN77TEbY=;
        b=MnInT/ANKATI9270nHX3hKfY4kx62jA7q4wGCDXyGX2cW2kCFHFAxH1WhP1O+jUXkS
         BNdehMBlr7pCMd4EK/TJJCj9P44GhuvS3UW6IZG99xEy1rhlARd3W4ur6FkSZyKCpkmZ
         QKOcBTfcuEgG+w6IG5FGVxlKJ6T3uW1DVZuTiFb4NTf96oWsOkw9W3n9+jvfomNV7Xn/
         hqtR4KDs8sNIOq/00KTVbbJ06CMAfjgIUo6WK3t/MKHBmS5mz7eW0ZM5t9EibqBly7OY
         rXXAdOleO3Tg+vOIQlKoKuRt5QzuY0jWNKGcE7179lnkGYOwo0qSdaRaZ12CacF0+k5U
         qujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mWuZozd20xeTSZ7IgtVLNO0xfC0ztohGtAvVN77TEbY=;
        b=QWeXzMC+B6ZtryuQG/R+c/Ownq7OLUFq6o0ebJnPURoOsB+MmzCYdnKHefe3KFGBzw
         qnAfqAB/EXvw++MeIxs5Cy4JnlrZZBfk5LaKfBxDG08JJ9oOKZ6cS61b+0pDcIP3Ysy2
         FYWEMTSFdKFF3Q+Gix0FfmdQ79MmP9erU9GHrXBmpJsO+/jIMYwMQG9cgftqSjhTCKvH
         qC15LOe5x+taSu2XgsfEkghxssjgcS5nPdvfK4JVAGcoSA/voBZKh0xaUGWgnB6WahKw
         a9PsjovQXH//S7/6Qjihf4oKTaPqqRLH67pkE2Or9FVYtJHgcptkaJCtUeh6YIpY+dVF
         Z0Tg==
X-Gm-Message-State: APjAAAV6WjH6GYZmKpI4Cb4HUhDYLALhBcgKS+rSD22B2UKQrQMIWJcw
        PzTtjFQJ/Q+3SYiSeIklg+NEL66hhv1IaVEVy7I=
X-Google-Smtp-Source: APXvYqzgPp1x84LeGEGSi1J6QWWWqCmEreqsZzBYaduLkgzG8SaqJIOiOg2PPWXtOLyQJtLJMevGPiSrUsvaCFbZpz8=
X-Received: by 2002:a24:7542:: with SMTP id y63mr1628566itc.70.1552648257368;
 Fri, 15 Mar 2019 04:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190313235439.30439-1-avarab@gmail.com> <20190314123439.4347-8-avarab@gmail.com>
In-Reply-To: <20190314123439.4347-8-avarab@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 15 Mar 2019 18:10:31 +0700
Message-ID: <CACsJy8B_rOBB5SvqnQs9hkui+3txGVPcz+H62hWE7oPGb789bg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] reflog expire: don't assert the OID when locking refs
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 7:35 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> During reflog expiry, the cmd_reflog_expire() function first iterates
> over all reflogs in logs/*, and then one-by-one acquires the lock for
> each one to expire its reflog by getting a *.lock file on the
> corresponding loose ref[1] (even if the actual ref is packed).
>
> This lock is needed, but what isn't needed is locking the loose ref as
> a function of the OID we found from that first iteration. By the time
> we get around to re-visiting the reference some of the OIDs may have
> changed.
>
> Thus the verify_lock() function called by the lock_ref_oid_basic()
> function being changed here would fail with e.g. "ref '%s' is at %s
> but expected %s" if the repository was being updated concurrent to the
> "reflog expire".
>
> By not passing the OID to it we'll try to lock the reference
> regardless of it last known OID. Locking as a function of the OID
> would make "reflog expire" exit with a non-zero exit status under such
> contention, which in turn meant that a "gc" command (which expires
> reflogs before forking to the background) would encounter a hard
> error.

Passing NULL oid has another side(?) effect, which I don't know if it
matters at all. Before, the mustexist flag in lock_ref_oid_basic() is
true. Now it's false. This affects refs_resolve_ref_unsafe() calls in
there. But that's where I'm stuck.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index ef053f716c..4d4d226601 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3037,7 +3037,7 @@ static int files_reflog_expire(struct ref_store *re=
f_store,
>          * reference itself, plus we might need to update the
>          * reference if --updateref was specified:
>          */
> -       lock =3D lock_ref_oid_basic(refs, refname, oid,
> +       lock =3D lock_ref_oid_basic(refs, refname, NULL /* NOT oid! */,

Maybe mention this not oid in the comment block above. Or just drop
it. Reading this comment without the commit message does not really
help answer "why not oid?". Or perhaps /* don't verify oid */

>                                   NULL, NULL, REF_NO_DEREF,
>                                   &type, &err);
>         if (!lock) {
> --
--=20
Duy
