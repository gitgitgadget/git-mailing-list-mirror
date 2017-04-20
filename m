Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8547207BC
	for <e@80x24.org>; Thu, 20 Apr 2017 11:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944429AbdDTL47 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 07:56:59 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:33374 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944425AbdDTL45 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 07:56:57 -0400
Received: by mail-oi0-f46.google.com with SMTP id y11so15359731oie.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 04:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6pffeNRDAY5nRLsc8UN0sMNDon8tqoN2Hruf2meWGNg=;
        b=lvuazDKkZ2p1vGgkcS7BFdqe0DLQtZcctmeVs+LaB2gM+BBqodTQ3gNg5Zj28yfqc9
         EzyBT/nDKsmrNJLcMe9wzJsAHIm80GN9f3A4c4M09Oxbzg1cqSPzPztdFoF1q+o5LShr
         H8kvZS+K+qyOEBFKvKU3zNE7jsGkjyXJxUUFXteivYiBlyOAWqTtypiK8IG1lAgfWcN/
         6rLOd8hKX4peld4uiqGoB1kx4rxkINvziB9UElPHnnkb4SmcmFBNBENakgW+Z+9ql1wR
         3/0RFPIkwsmaQIFs8mu1XDsZ6tAKIdL2M47J66+tCeOX1VQOLDIGTQ7/zES9SazW+mn1
         eOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6pffeNRDAY5nRLsc8UN0sMNDon8tqoN2Hruf2meWGNg=;
        b=OhHPWVWqrnYBEAWoXZ15/vGkqExyBd12BRPSREu2SfYeGIHRYSIlq8RBRsIoaYZ4e7
         U4Lnr+7GPtgRjiZd/DdcvwwnHuM77ijpToobirIJBH+UzSeLOGXhIdQ23mf3AfqQFTnR
         PNs+6rLekkAlgEqMIomtZW4ZQqLWBUjz5uM0LLHYinqaKrBylgLY3yyvfnjSYKzxXtoH
         6JNq7DaOrGYq7DNjcBTPDILv6Hqovfi0nG4te2F4mhAThhTFt1mxkaLLF79AbBwhAfSm
         GeNk20ivcdJOqWGIedYhvaCQPJO/CrxsybFLicqjcqODtdgdiPGJY+vqyZySOy95WhLZ
         HfZQ==
X-Gm-Message-State: AN3rC/4ORZdzz2irDfA2cT5QXpF8m82IWsDzcblyIY+WqXj497itIkhg
        oo2wMnlGNc2w5vA9fAGOWa16zQXvlw==
X-Received: by 10.157.68.146 with SMTP id v18mr3913823ote.128.1492689415824;
 Thu, 20 Apr 2017 04:56:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Thu, 20 Apr 2017 04:56:25 -0700 (PDT)
In-Reply-To: <a74cf309-fb16-2f45-8189-d1d0c655dea4@kdbg.org>
References: <20170419110145.5086-1-pclouds@gmail.com> <20170419110145.5086-6-pclouds@gmail.com>
 <a74cf309-fb16-2f45-8189-d1d0c655dea4@kdbg.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 20 Apr 2017 18:56:25 +0700
Message-ID: <CACsJy8A1aR-=QqqZdw+i5Hv2kXptTzYcn5tFsMBDYk6vBwUwZg@mail.gmail.com>
Subject: Re: [PATCH v3 05/12] refs: move submodule slash stripping code to get_submodule_ref_store
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2017 at 5:02 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 19.04.2017 um 13:01 schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
>>
>> @@ -1558,7 +1543,17 @@ struct ref_store *get_submodule_ref_store(const
>> char *submodule)
>>  {
>>         struct strbuf submodule_sb =3D STRBUF_INIT;
>>         struct ref_store *refs;
>> +       char *to_free =3D NULL;
>>         int ret;
>> +       size_t len;
>> +
>> +       if (submodule) {
>> +               len =3D strlen(submodule);
>> +               while (len && submodule[len - 1] =3D=3D '/')
>
>
> What is the source of the value of 'submodule'? Is it an index entry? Or =
did
> it pass through parse_pathspec? In these cases it is correct to compare
> against literal '/'. Otherwise, is_dir_sep() is preferred.

I've looked at the callers. Yes it is a path and is_dir_sep() should
be used. Since this has been like this in the current code, unless
there's some more changes in this series or you insist, I would hold
this change back, wait for this series to settle and submit it later
(I'll have to do that anyway to kill the get_main_store() call in this
function).
--=20
Duy
