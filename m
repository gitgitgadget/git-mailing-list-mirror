Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ADA51F42D
	for <e@80x24.org>; Thu, 24 May 2018 17:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031381AbeEXRDN (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 13:03:13 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:42889 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031158AbeEXRDM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 13:03:12 -0400
Received: by mail-vk0-f66.google.com with SMTP id j7-v6so1453493vkc.9
        for <git@vger.kernel.org>; Thu, 24 May 2018 10:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=592QuatnRD3uNNrA8c/pSV/hlI4psZBVbp8g9HDeYtM=;
        b=NQy+l4gkg/WJJiqskMdECeIeUatZ4q8es5bjWY/b7VEabVPdjz9kR4+T31eZDKEw3B
         3/irqRDjA8jk1PR1i+xW5+sj4sz8yA1X7RAvaewj2rezrkOW70+lRdLkxOCMv8BZ0Hw9
         FLzUfvqgnZTvRIp7dSl8xZp6EYH/SzGf6fWPZ1pLx45wKX9SEcv/9uBiSWVl8N74e42p
         08LrdH4t16OnY0WZiDAN1Zj690hZO31+o5azkT5t/Yxkvr9fZLmWZ46sP9zxbcSUv5A6
         oruiWBUcCPjDgB2t2ZXLfiUw2UDprJpNdn12Y/wPIDlfawMcZdipqs7+JbpS+6n/3wwM
         rjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=592QuatnRD3uNNrA8c/pSV/hlI4psZBVbp8g9HDeYtM=;
        b=sCuwKYiKwEHzRY07D5GmAzNgr2SyLkwmjX4N2gHmvNCFFjLipZ5Saw6nLO4tVMyZ+j
         fP7shfvTL/MEYejaryAr8aGAuVrMJPWD1rk0SdPszuXonAhjrRHO5XWe4G6efiQj1HYx
         MeT0Zl1NR19dupANlEdrkU4yiI65E1ehw+rWhQHeT+YD63z8bZ4kHtxg4XbCbP2Y/T3f
         46M45ri9mqX6McH2fIU7jmzbZ7vwP8EVfVB5taTnq025FOgPRAoamWHlKbZrC+Z1+XiH
         U5ea2BmylIxLNfmT8S+18ozIGlQ8p0itNVi3j8sD9/5/oPPYnrPtX5NQ1sBIOtQw8Ga2
         yjdw==
X-Gm-Message-State: ALKqPwcS8JCrXkbbpTouY+MIymPwpHaEkym+HuU8d/y0kXYDdi31fWb3
        lH1IiyrSNMdavnh7zjwsJ0jB796zBlUWZSZE6iU=
X-Google-Smtp-Source: AB8JxZocLQIHSFz+AnLCpJSglfi03mve1SFydB9e2oN2pQzgWAcmNZG/cQ0YGYoGWmh5+1PqQvUjwtS/lOLSpoAAlg8=
X-Received: by 2002:a1f:c155:: with SMTP id r82-v6mr5239800vkf.76.1527181390748;
 Thu, 24 May 2018 10:03:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f04:0:0:0:0:0 with HTTP; Thu, 24 May 2018 10:03:09
 -0700 (PDT)
In-Reply-To: <20180524100507.32305-1-szeder.dev@gmail.com>
References: <20180524070439.6367-1-newren@gmail.com> <20180524070439.6367-3-newren@gmail.com>
 <20180524100507.32305-1-szeder.dev@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 24 May 2018 10:03:09 -0700
Message-ID: <CABPp-BGS27ScX7R7GUv6oEHdynjWOzgeoYvS-759wh936-APWA@mail.gmail.com>
Subject: Re: [PATCH 2/5] t6036, t6042: use test_line_count instead of wc -l
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 24, 2018 at 3:05 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
>> --- a/t/t6036-recursive-corner-cases.sh
>> +++ b/t/t6036-recursive-corner-cases.sh
>> @@ -65,9 +65,12 @@ test_expect_success 'merge simple rename+criss-cross =
with no modifications' '
>>
>>               test_must_fail git merge -s recursive R2^0 &&
>>
>> -             test 2 =3D $(git ls-files -s | wc -l) &&
>> -             test 2 =3D $(git ls-files -u | wc -l) &&
>> -             test 2 =3D $(git ls-files -o | wc -l) &&
>
> Here 'git ls-files -o' should have listed two untracked files ...
>
>> +             git ls-files -s >out &&
>> +             test_line_count =3D 2 out &&
>> +             git ls-files -u >out &&
>> +             test_line_count =3D 2 out &&
>> +             git ls-files -o >out &&
>> +             test_line_count =3D 3 out &&
>
> ... but now you expect it to list three.  I was about to point out the
> typo, but then noticed that you expect it to list one more untracked
> file than before in all subsequent tests...  now that can't be just a
> typo, can it?
>
> Please mention in the commit message that when using an intermediate
> file to store the output, 'git ls-files -o' will list that file, too,
> that's why the number of expected untracked files had to be adjusted;
> so future readers won't have to figure this out themselves.

How does adding the following to the commit message sound?

    Changing to use test_line_count means using an intermediate file to sto=
re
    the output, which means that 'git ls-files -o' will have an additional
    file to list, which means that the number of lines expected in some tes=
ts
    will therefore change as well (unless the same intermediate file was us=
ed
    to capture the output of a previous command).

I'll include that in my next roll of the series after waiting for any
other fixups folks point out.  Sorry for the trouble.

As always, thanks for taking a look!
