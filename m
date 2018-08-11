Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFA021F404
	for <e@80x24.org>; Sat, 11 Aug 2018 10:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeHKNGV (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 09:06:21 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:46087 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbeHKNGV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Aug 2018 09:06:21 -0400
Received: by mail-io0-f193.google.com with SMTP id i18-v6so9899036ioj.13
        for <git@vger.kernel.org>; Sat, 11 Aug 2018 03:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uH2tFhqGZ57ZMdBs42tfBZsLuvSeCBFf30f+TGGgb64=;
        b=FsPVNOK/Ylmwb9G7oikC3pGI4GAsQOXntTO1xXTykbNysGl8pGJsbPbhnoXhXS9YxV
         v9itjmxyOlUZ1bK+WCFybKJAJsnD+eRK0vzrYK2fZzEMpSdlteZz+6mbOy6RMkSHSz8n
         iYNFSkFXhK+d6ebCNARsLQG4w74L7ZVXTsJWbaGIuLbe1sigBeRlmPwIv7W095NIZTWk
         GUeEFsJUUzDot1qnDccRE4Pkoipd3R0lsC93w1OlLKnuhT/0vUS0xcl/7wkRi8Vqvu37
         8eT8U2exho/NztQoRAAb6jwDuy21hQ/Tf9pG+pIsw6FieVntGyHaRE9D0zxxehXAW7gX
         XZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uH2tFhqGZ57ZMdBs42tfBZsLuvSeCBFf30f+TGGgb64=;
        b=LvlKZIDDZxepklXk3T5pXPf4Ledfo4Qa6hFY83jLinT1bgZT+7vp7WnBmsRvwdcQ0J
         YFBQqvNI+n86jR2nKZsiUAW31ElllKunR48cB2bo/LOzNF0Eb09CIUlKF/pUGiMDHuB+
         zbddIIlP/cOAWUbUX7piVhBuqAoYpY62tX5LqsXCemnE8yRG8o2kuW2xkjOWVg5cEPw8
         BcULCVP3JAfo5VHJ3bT//oNHKfjI+UQdyDDTOUlrT74SC4HVF/UChY54piDmbprCIdNB
         QothruZJ4UdlUJ4fMPPd7SsxDamp3ZEoDroeigyfJ0zl93dMCH5L70nl2WorMGIje37N
         8Ltw==
X-Gm-Message-State: AOUpUlFn+DYLrUd/yQ1DolmWNB+bz1JyElM9Zr3ISZeLTgkXWq+3xgRH
        XIfj2C3rGLlzcAh0UlFSPmaTBSvAu3IDQ/EmaCQ=
X-Google-Smtp-Source: AA+uWPw2OydiR8vZEZsa4FOqDJi8OHUeOG8BA96kaLUlLTNUj2cMKXzU8XPVu1rBtCemz2QTG9LAE6PfqHHHJJMr9oY=
X-Received: by 2002:a6b:5a08:: with SMTP id o8-v6mr8404505iob.5.1533983553118;
 Sat, 11 Aug 2018 03:32:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:228d:0:0:0:0:0 with HTTP; Sat, 11 Aug 2018 03:32:32
 -0700 (PDT)
In-Reply-To: <20180811090418.26674-1-szeder.dev@gmail.com>
References: <20180809155532.26151-1-chriscool@tuxfamily.org>
 <20180809155532.26151-3-chriscool@tuxfamily.org> <20180811090418.26674-1-szeder.dev@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 11 Aug 2018 12:32:32 +0200
Message-ID: <CAP8UFD0uoOKyUkNDrQgzcf6rGtnd9-Jk26swtzdyNDeCHefYJA@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] Add delta-islands.{c,h}
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 11, 2018 at 11:04 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>> diff --git a/delta-islands.c b/delta-islands.c
>> new file mode 100644
>> index 0000000000..448ddcbbe4
>> --- /dev/null
>> +++ b/delta-islands.c
>
>> +static void deduplicate_islands(void)
>> +{
>> +     struct remote_island *island, *core =3D NULL, **list;
>> +     unsigned int island_count, dst, src, ref, i =3D 0;
>> +
>> +     island_count =3D kh_size(remote_islands);
>> +     list =3D xmalloc(island_count * sizeof(struct remote_island *));
>
> Please use ALLOC_ARRAY here.

Ok, I have made the following changes in the branch I will send next.

diff --git a/delta-islands.c b/delta-islands.c
index 92137f2eca..22e4360810 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -322,8 +322,7 @@ static int island_config_callback(const char *k,
const char *v, void *cb)

                if (island_regexes_nr >=3D island_regexes_alloc) {
                        island_regexes_alloc =3D (island_regexes_alloc + 8)=
 * 2;
-                       island_regexes =3D xrealloc(island_regexes,
-                                       island_regexes_alloc * sizeof(regex=
_t));
+                       REALLOC_ARRAY(island_regexes, island_regexes_alloc)=
;
                }

                if (*v !=3D '^')
@@ -425,7 +424,7 @@ static void deduplicate_islands(void)
        unsigned int island_count, dst, src, ref, i =3D 0;

        island_count =3D kh_size(remote_islands);
-       list =3D xmalloc(island_count * sizeof(struct remote_island *));
+       ALLOC_ARRAY(list, island_count);

        kh_foreach_value(remote_islands, island, {
                list[i++] =3D island;

Thanks!
