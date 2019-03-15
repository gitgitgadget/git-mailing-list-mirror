Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76CF020248
	for <e@80x24.org>; Fri, 15 Mar 2019 15:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbfCOPwn (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 11:52:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38066 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfCOPwn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 11:52:43 -0400
Received: by mail-ed1-f65.google.com with SMTP id e10so4119604edy.5
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 08:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=dZ67HNq5FTKCK8HHJBKbQs32VRIvzUhVLGjsl7ppHec=;
        b=aKCdr40m4urVzgkaBaLI9LL0tnNt1cbUvh5c6VEz+4bsvMtbt+R3VUp1L4HcXOK+59
         RIGRcQ6a5BHB/NbpFVkFMih8hXfNjHBQ4NbUCou0jfokTvPyqWySviBbwqb/JUnJN8Iv
         /yUnqcO8y/avT3Ogm6u4HszSZilviFCnPt+OEegaH9bFwBroaSO4X4kKI5MaXRxrVIqa
         VPGOHQDxkjqNL/O9tF1G79t1uOyDtSvYpUsU69wu/D3daDDBvTKy4us8SYj9Vv7WQ371
         VMId2r1P6RiIhQb62QtSMdQIumM+o1zyTGLHemiMu8INOIvDNand9XcgrdzFuWg6fWWV
         Mgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=dZ67HNq5FTKCK8HHJBKbQs32VRIvzUhVLGjsl7ppHec=;
        b=E1TvB+QcChp4+wNqsGxQyDYisIrhjqMtiJkZLJZ7HJsBmmdb9hjis4IzqY5TUM7Ko8
         4DrNxkcTCSooo5MRDhS967Ko/bkUbDzprbVaaoFl1RZ8lDR9kTAI9e+Pl7Bih3sNFu25
         Z8eICVdEWFnSZIdPAEeY7rwjFVMHP/zqDVhm+GjyayO/sii8V18jYtj+l+TDuEky2AFc
         OQsMEqkjULr0/aIW5OnoUv1IpLj+qd0zHtEIR0sXosllFTCYJZaujneMS3DwFKtG+Hmv
         HM8VocEMvsPFJ8OXhW6A38bIsNktw298Yx/s1OSwMM8Ol1CM8C/UlmpqstwWOqMjjbQ4
         o9hA==
X-Gm-Message-State: APjAAAUL5a+ll3igllSkFrzcbJYQtdm986lzNFCw43XszhCgfiFRz9qe
        e9OP0YU86CkwJ5an/As9g/ExPZN/37Q=
X-Google-Smtp-Source: APXvYqzj7zM6+rLIQqToYXZwSqf1AcltJR2kArtzHdsldLAdepOtjSy7eeY//C9pszY4ukN6pT/Ftw==
X-Received: by 2002:aa7:da09:: with SMTP id r9mr3323884eds.7.1552665160754;
        Fri, 15 Mar 2019 08:52:40 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id e11sm485822eja.54.2019.03.15.08.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 08:52:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 7/7] reflog expire: don't assert the OID when locking refs
References: <20190313235439.30439-1-avarab@gmail.com> <20190314123439.4347-8-avarab@gmail.com> <CACsJy8B_rOBB5SvqnQs9hkui+3txGVPcz+H62hWE7oPGb789bg@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CACsJy8B_rOBB5SvqnQs9hkui+3txGVPcz+H62hWE7oPGb789bg@mail.gmail.com>
Date:   Fri, 15 Mar 2019 16:52:39 +0100
Message-ID: <87zhpw9ltk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 15 2019, Duy Nguyen wrote:

> On Thu, Mar 14, 2019 at 7:35 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> During reflog expiry, the cmd_reflog_expire() function first iterates
>> over all reflogs in logs/*, and then one-by-one acquires the lock for
>> each one to expire its reflog by getting a *.lock file on the
>> corresponding loose ref[1] (even if the actual ref is packed).
>>
>> This lock is needed, but what isn't needed is locking the loose ref as
>> a function of the OID we found from that first iteration. By the time
>> we get around to re-visiting the reference some of the OIDs may have
>> changed.
>>
>> Thus the verify_lock() function called by the lock_ref_oid_basic()
>> function being changed here would fail with e.g. "ref '%s' is at %s
>> but expected %s" if the repository was being updated concurrent to the
>> "reflog expire".
>>
>> By not passing the OID to it we'll try to lock the reference
>> regardless of it last known OID. Locking as a function of the OID
>> would make "reflog expire" exit with a non-zero exit status under such
>> contention, which in turn meant that a "gc" command (which expires
>> reflogs before forking to the background) would encounter a hard
>> error.
>
> Passing NULL oid has another side(?) effect, which I don't know if it
> matters at all. Before, the mustexist flag in lock_ref_oid_basic() is
> true. Now it's false. This affects refs_resolve_ref_unsafe() calls in
> there. But that's where I'm stuck.

This case was tricky, I ended up doing the same thing in v3, but now
very carefully explain the rationale since none of it is obvious.

>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index ef053f716c..4d4d226601 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -3037,7 +3037,7 @@ static int files_reflog_expire(struct ref_store *r=
ef_store,
>>          * reference itself, plus we might need to update the
>>          * reference if --updateref was specified:
>>          */
>> -       lock =3D lock_ref_oid_basic(refs, refname, oid,
>> +       lock =3D lock_ref_oid_basic(refs, refname, NULL /* NOT oid! */,
>
> Maybe mention this not oid in the comment block above. Or just drop
> it. Reading this comment without the commit message does not really
> help answer "why not oid?". Or perhaps /* don't verify oid */

Also fixed.

>>                                   NULL, NULL, REF_NO_DEREF,
>>                                   &type, &err);
>>         if (!lock) {
>> --
