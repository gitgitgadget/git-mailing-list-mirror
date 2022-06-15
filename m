Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99715CCA473
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 20:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245697AbiFOU3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 16:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244033AbiFOU3t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 16:29:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F9B38BFE
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 13:29:48 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id h23so25420877ejj.12
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 13:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Ef5a4rKxuY9zvR//uyiQCIDnO+2kQZl19OsnQun4yHQ=;
        b=Rk8xZy0liXqUbAy0zBjioduJE3wTSCC4SKHW4IAC2lKYnuXpNY/+zBWjD0+NG7JbZk
         L+2Ktbh++BsQgchS//W+susu50BXDMswpKR9Mh1QPAunvAzOG0m43zuQDhUmf6C4qQrh
         tXr2QB/5oD8s7G9+jfCzsGY9qWadXWzro2PFjVWHFLE2ZqC98xinySxbeUcyrqykBoG4
         uNkggwQLyMqbAAJJmh7rOVXDCcc1rK1tcRkQrG7rvNyk6MVq6giMLqc2QsLqkGgGhE5M
         yLnceiEstpGUFctUhOvLITksSC9o02RdHAq06xyKBZPSxYYzEbu/6kTazTxAIeWIUBWi
         FNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Ef5a4rKxuY9zvR//uyiQCIDnO+2kQZl19OsnQun4yHQ=;
        b=TXNatWUXdbTT98BJ8WLyHIDo3K1TdKXEhMJvj8FYYcrZJvIiazJviCyrrmYJlC/9Dp
         oSMdRUPOCcmG/oXi2hKV/Po7c4902hHuN7ZHB9VO61+crG1sMFUgWQstk2u1ZjDO9qKg
         lUpvgRYLHnnIkrBk7uAGOcWAt2RhlrGVSi9+z3OGtXGKVTjE0UWDcamJqHhlB9TwXiiV
         BUeuEetmGUWMcP2JKeR87u6nxhIjH9i/Ccd6f1Lxtgpy4M+K+8gss9jaSUrGJ2zRlO9E
         bhNW/Ly6Pr9v1NQQZ/M9lHjv2ab07Cr3+MSRmfjVkXQ5qeTx851WH5Rh+EhL1pCSTn+6
         hhlA==
X-Gm-Message-State: AJIora+CINwY+VsdKgOZE+Ni3Kd/PWEZP85bmppWGKz4sAl9skf8sfqV
        HR98ysNG0mRS2MzIzw5Yopk=
X-Google-Smtp-Source: AGRyM1s3p6rIEjPwtqpQ14VfVvl4ubQi3TpZ2yaUh3pp32GOgJYvtLRZ/7ggn5OWuj1CZwGvGvux0Q==
X-Received: by 2002:a17:906:c193:b0:718:d076:df7 with SMTP id g19-20020a170906c19300b00718d0760df7mr1508279ejz.358.1655324987059;
        Wed, 15 Jun 2022 13:29:47 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id o18-20020a170906769200b00718f4d4f073sm894702ejm.88.2022.06.15.13.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 13:29:46 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o1Ze6-000tdD-0G;
        Wed, 15 Jun 2022 22:29:46 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/1] tests: add LIBCURL prerequisite to tests needing
 libcurl
Date:   Wed, 15 Jun 2022 22:28:29 +0200
References: <cover-0.1-00000000000-20220615T103609Z-avarab@gmail.com>
 <patch-1.1-353c384d2b1-20220615T103609Z-avarab@gmail.com>
 <xmqq35g5232b.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq35g5232b.fsf@gitster.g>
Message-ID: <220615.861qvpy8jq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 15 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> The existing "CURL" prerequisite is only used in one place, and we
>> should probably name it "CURL_PROGRAM",
>
> True.  It probably wants to become a lazy prerequisite defined only
> in that program.

Yes, I have that fix, but left it out for the "for v2.37.0" ...

>> then rename "LIBCURL" to
>> "CURL" as a follow-up, but for now (pre-v2.37.0) let's aim for the
>> most minimal fix possible.
>
> OK.
>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  t/lib-httpd.sh        | 2 +-
>>  t/t5516-fetch-push.sh | 4 ++--
>>  t/t5601-clone.sh      | 4 ++--
>>  t/test-lib.sh         | 1 +
>>  4 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
>> index 782891908d7..1f6b9b08d1d 100644
>> --- a/t/lib-httpd.sh
>> +++ b/t/lib-httpd.sh
>> @@ -29,7 +29,7 @@
>>  # Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
>>  #
>>=20=20
>> -if test -n "$NO_CURL"
>> +if ! test_have_prereq LIBCURL
>>  then
>>  	skip_all=3D'skipping test, git built without http support'
>>  	test_done
>
> This is not strictly needed in "the most minimal fix possible", is
> it?  Just checking.

I figured if I was adding a $NO_CURL prereq I might as well change the
only existing use of $NO_CURL to use it, which also assures the reader
that our test suite is getting this from somewhere already.

But I'll drop this in a re-roll.
