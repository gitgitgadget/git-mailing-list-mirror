Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 060E22023D
	for <e@80x24.org>; Wed,  1 Mar 2017 12:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752285AbdCAMHt (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 07:07:49 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:36015 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbdCAMHs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 07:07:48 -0500
Received: by mail-ot0-f196.google.com with SMTP id i1so3990263ota.3
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 04:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ibhSJPvQk8wKIN2HEX23VfDN28Ro+0JBQWqHjuIrNvg=;
        b=Y5WyeOrrl33vZd5dP1pdq/314Wc+c5Os1a8++R+/aSZu+P5izf1Z+82xNBGo3bfBjT
         Rh6MZvwyINAY8FauzSBHSQRqHgyaJ3Ncp5uZcuPTh+KqJlR2WUlzW2zD+J4dk5VTqlQt
         h2AcY9XtBNMtfzjUH5962L5UZiMEwPDl0gbBnRHsNS1boBAZR2y/J0jEHFE3O8Jm/Ksg
         l+jQM4wJHQrY4br7qbyyuuUa81S5lz6OUI/uL4rAaQ/qlgFvjUqJS8yX7VMlBqFdBViO
         RxMGUxx8i1lMca2R4Plh+XTwp3/vf2eN0I6T7r6g3TPLKbhI/c+9l7eoVTev1IqM/zcy
         71DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ibhSJPvQk8wKIN2HEX23VfDN28Ro+0JBQWqHjuIrNvg=;
        b=bUim8x1+Nga49PzAvY2UmElhgH1GdHTb0xXWQMHWaqWgELRzV4oP/YM30ptcY0k6Kl
         GMIHR4nKBKs/XMYRug2UTqe3KjnQXVpPWxAFsXFz4VVwPwhMU9FDjHpb33eGQJGrAxOh
         5d1EG67PqkXLfoNDCeARAErjvmC1ZfjrZa2+ErLzDPC9zhy0ajJedT+NhdD7aymbKF5c
         9Uf3ZQGNtEbG+uCmE8lgI6tybo7j0I2DD0l7N07RoYOWefZNNB3z4GdnziCIV00hidD2
         oF0y+gIJVS7zroCkMORTMxX4FXnpxdMWhIbb5PzkhwS5oNdfASZiK2J2QHWLNFKHF+N4
         s1qw==
X-Gm-Message-State: AMke39nTY9oOV/125oDuOVRZ6ypZMSA1nMymCyJeM9akbE2EqcfBbhIa/IGQffMGNmX5OuMsLvE/UfjZQ1/uSQ==
X-Received: by 10.157.18.132 with SMTP id g4mr4339373otg.10.1488369994754;
 Wed, 01 Mar 2017 04:06:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Wed, 1 Mar 2017 04:06:04 -0800 (PST)
In-Reply-To: <0bef1e49-e96b-1666-9b88-f4262c2aeeba@alum.mit.edu>
References: <20170218133303.3682-1-pclouds@gmail.com> <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-10-pclouds@gmail.com> <0bef1e49-e96b-1666-9b88-f4262c2aeeba@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 1 Mar 2017 19:06:04 +0700
Message-ID: <CACsJy8ArGqrRCsVgpumu1u4+1_2chWARgLG_2Kmpq5p-nmcWfg@mail.gmail.com>
Subject: Re: [PATCH v5 09/24] refs.c: introduce get_main_ref_store()
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 1, 2017 at 12:51 AM, Michael Haggerty <mhagger@alum.mit.edu> wr=
ote:
> On 02/22/2017 03:04 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  refs.c | 16 ++++++++++++----
>>  1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index 81b64b4ed..dab1a21ac 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1456,15 +1456,23 @@ static struct ref_store *ref_store_init(const ch=
ar *submodule)
>>       return refs;
>>  }
>>
>> +static struct ref_store *get_main_ref_store(void)
>> +{
>> +     struct ref_store *refs;
>> +
>> +     if (main_ref_store)
>> +             return main_ref_store;
>> +
>> +     refs =3D ref_store_init(NULL);
>> +     return refs;
>
> Unnecessary temporary variable?

That's the price for doing too much mechanical conversion :-P On
second read, I think I did that on purpose (or by luck) because the
"kill register_ref_store" patch needs this intermediate "refs" so we
can save it to main_ref_store. Cleaner future patch for the minor
uncleanliness in the current one.
--=20
Duy
