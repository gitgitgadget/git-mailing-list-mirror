Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B8071F404
	for <e@80x24.org>; Tue, 23 Jan 2018 04:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751306AbeAWEGe (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 23:06:34 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34672 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbeAWEGd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 23:06:33 -0500
Received: by mail-ot0-f194.google.com with SMTP id x15so4836794ote.1
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 20:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u06uGjybvJJ3oSTSdJkdpGe2BtKccH/ea8kJmALOLdQ=;
        b=Vv9ni40SZ83rnFZ8cL+Rdm/SVZUWIyVm84t3wWxA86JhPKEpS9Ezc7zt7zjn4/xv0U
         wdHWWdip6LxxSfHiBoJR827OKzRZbyDeM9L4vHpeLYKkgyBNzhMmb848zF6N7qB+D6Ez
         /h0d7kHhexF5jRvo3e3Ne3KaIrB1XUA31eRH+lefmtF+Cdk+B4c8XFAHzxVz9eAqgf+6
         6dh92iqfW6OTSjtE1e74tuxR6XJusWq5doWU5ylw/CM5Sa3lk1y0m+LeaHBFgTMAF7e+
         b7ZenN7xJs/eOZkRbQyDfJQohXEIAlNV7DXcHRECRtyFZDoTe3YQA6AusfAv4QigHnG2
         cbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u06uGjybvJJ3oSTSdJkdpGe2BtKccH/ea8kJmALOLdQ=;
        b=tuXS3SMrSAkTq9svL4x56o4d7Mqt0uHG5xEEYa7TMf5KHShqYfDuQM8Kv5dwPuO4b6
         5TUYfbc7nfdad+iKLBKkuFWeAKEJyD9HFvtopcm5nGDbRxEOMuizw3p2cNnHDEsrDww+
         9JTX81Nwv3nk69rx6ytXqAD5URxY+cB8mjvN6X71a5CFp1PGJxJofe3KH64fHcFW5ybB
         /NmehoH5l+NNh3F360MxvErOI22d69sRfuShS0KYov1+pdkQjwNSzucHVC0EcHpVIQqO
         QMY0IP81lXKC2zXQcPt7ftmAiclzx5oZInC5LgiouF0pQQXmWXMNZsxT9AOtrhxT3cna
         7nzQ==
X-Gm-Message-State: AKwxyteZGH3ZN30MIMhsb+7EN6EhYmL1psB/Fqc043SFK+hVQ8YmEuq0
        PYF9RqeVqsBFQVpBT5iZNmRfg1bir6qXrMHTS/E=
X-Google-Smtp-Source: AH8x2278Rg6StNXGGWiS6VCi4LNHISlLdWqqPRS33lITR44DG9X0OBW++5batdqcWyfKCNRTKj+wfCM4dsbOCXgGiY0=
X-Received: by 10.157.53.12 with SMTP id o12mr5904343otc.181.1516680392710;
 Mon, 22 Jan 2018 20:06:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.27.3 with HTTP; Mon, 22 Jan 2018 20:06:02 -0800 (PST)
In-Reply-To: <xmqqfu6xjxrx.fsf@gitster.mtv.corp.google.com>
References: <20180122110334.4411-1-pclouds@gmail.com> <20180122110334.4411-4-pclouds@gmail.com>
 <xmqqfu6xjxrx.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 23 Jan 2018 11:06:02 +0700
Message-ID: <CACsJy8B059uev+HpL=JGDdh+FM19vSFObhp7DB4eAt-u6d7GnQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] read-cache: don't write index twice if we can't write
 shared index
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 23, 2018 at 6:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
>> index af9b847761..d2a8e0312a 100755
>> --- a/t/t1700-split-index.sh
>> +++ b/t/t1700-split-index.sh
>> @@ -401,4 +401,23 @@ done <<\EOF
>>  0642 -rw-r---w-
>>  EOF
>>
>> +test_expect_success SANITY 'graceful handling when splitting index is n=
ot allowed' '
>
> Is SANITY the only prereq we want, or do we want both it and POSIXPERM?
>
> In "git grep SANITY t/" output, we see that they are almost always
> used together.

SANITY test does more or less the same as this one (chmod then verify)
which is the reason I removed POSIXPERM. Looking at other tests
though, they don't do anything different than what I do here and still
require both SANITY and POSIXPERM. I'm adding POSIXPERM back.

>
>> +     test_create_repo ro &&
>> +     (
>> +             cd ro &&
>> +             test_commit initial &&
>> +             git update-index --split-index &&
>> +             test -f .git/sharedindex.*
>> +     ) &&
>> +     cp ro/.git/index new-index &&
>> +     test_when_finished "chmod u+w ro/.git" &&
>> +     chmod u-w ro/.git &&
>> +     GIT_INDEX_FILE=3D"$(pwd)/new-index" git -C ro update-index --split=
-index &&
>> +     chmod u+w ro/.git &&
>> +     rm ro/.git/sharedindex.* &&
>> +     GIT_INDEX_FILE=3Dnew-index git ls-files >actual &&
>> +     echo initial.t >expected &&
>> +     test_cmp expected actual
>> +'
>> +
>>  test_done



--=20
Duy
