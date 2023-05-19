Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D55C77B75
	for <git@archiver.kernel.org>; Fri, 19 May 2023 03:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjESDwc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 23:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjESDwa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 23:52:30 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472071A7
        for <git@vger.kernel.org>; Thu, 18 May 2023 20:52:29 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-ba81e7269a2so402138276.1
        for <git@vger.kernel.org>; Thu, 18 May 2023 20:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684468348; x=1687060348;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqwOdCIkmKE3hix3aAuLeCIEQ7EyMeAoX+/DvrJqeDM=;
        b=Oc4z7OSgO7PBoA0A7Uy8gVu7kYMM80eGree2kBOceOZyqAHJA9ZblJUcl2LS5tg8/m
         ZpwHAgFlOoPEEWz0Tw5tRAi5tY7jnpXQE5TGF8B5bJpCYzPoSyK+EoOOloybqEudN9MD
         4oEvqC5wZNYxrov0uT4PaGwRLEqk/vKedw/wRb/1VxJiV4V5Nc6LStt0Nk7WlyDI1Ewo
         qZlhdpL78xwdLp6ycJ0P6QRX+qkdmnBCVduOMIzk3LhabRE12b5JNyDpI1bO7Rzzg3oj
         a5pmNvxGX8siODgLF02cYD9HODQ5YngFixMbwNOCoqRW0tH6+7ciqBc16LdI291jN4No
         Q0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684468348; x=1687060348;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xqwOdCIkmKE3hix3aAuLeCIEQ7EyMeAoX+/DvrJqeDM=;
        b=MafsINCetc2744GoIMpv2e/BsFysjgaPmPDjphUdisZwMyQ+kpZhjY51eP9melYT1Y
         LJDd2L1sKp7s7WrGQGS+seixa0dmUglYtC7vKaZNjQjSnHXUzvhub1BNu32JrXh8cWyq
         Axgy0UtUDjC+TOdTMX+IOjelk2EcrpWyXaGtADXhfFiMsVO7ml261rMV2rUFT38OUJ/K
         /JUjPuTQIv+kvkuy1bgNGUwppChcSk44NOj/XCtxx4nfTkuPsZvYopvZg59Xyroge6T9
         19/qk86RUhf1veljtL4ZnRR6CVURAEhMUw9Ohvht4rUaOmqZoi0xEuBpzAVaRVQdK3Si
         LLkw==
X-Gm-Message-State: AC+VfDwtr1jPLD/+X4RFbsjatWsUlmNMsAl/2DPeRsCxeJuC15ZtuUw3
        Us1SYJgNpH/uagWwsWyQQKY=
X-Google-Smtp-Source: ACHHUZ6PGAV9ZJphZFgP9Ly92FasLQgcGD2SSgMd/PZ01/kD0TLP8pgQLn1oiztq77r3d0rkcnUWqw==
X-Received: by 2002:a81:9b45:0:b0:560:db2b:bc7e with SMTP id s66-20020a819b45000000b00560db2bbc7emr735032ywg.3.1684468348330;
        Thu, 18 May 2023 20:52:28 -0700 (PDT)
Received: from epic96565.epic.com ([2620:72:0:6480::10f])
        by smtp.gmail.com with ESMTPSA id m203-20020a8171d4000000b00560df23d30csm875370ywc.117.2023.05.18.20.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 20:52:27 -0700 (PDT)
References: <pull.1471.v2.git.git.1679478573.gitgitgadget@gmail.com>
 <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
 <fe442c2041b01985a4ecb0f2e9651231af2a439b.1684152793.git.gitgitgadget@gmail.com>
 <CAPig+cTSp3+RDbULeOXpfXwXw35tj3o-CTrpaeRPSB8remKk4A@mail.gmail.com>
 <xmqqilcta4j2.fsf@gitster.g>
User-agent: mu4e 1.11.1; emacs 29.0.91
From:   Sean Allred <allred.sean@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Sean Allred <allred.sean@gmail.com>
Subject: Re: [PATCH v3 1/6] show-ref doc: update for internal consistency
Date:   Thu, 18 May 2023 22:51:36 -0500
In-reply-to: <xmqqilcta4j2.fsf@gitster.g>
Message-ID: <m07ct5uged.fsf@epic96565.epic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> writes:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Mon, May 15, 2023 at 8:13=E2=80=AFAM Sean Allred via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>>> - Use inline-code syntax for options where appropriate.
>>> - Use code blocks to clarify output format.
>>>
>>> This patch also swaps out 'SHA-1' language for the implementation-
>>> agnostic 'OID' term where appropriate in preparation for supporting
>>> different hashing algorithms.
>>>
>>> Signed-off-by: Sean Allred <allred.sean@gmail.com>
>>> ---
>>> diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-re=
f.txt
>>> @@ -96,7 +96,13 @@ OPTIONS
>>> -The output is in the format: '<SHA-1 ID>' '<space>' '<reference name>'.
>>> +The output is in the format:
>>> +
>>> +------------
>>> +<oid> SP <ref> LF
>>> +------------
>>>  $ git show-ref --head --dereference
>>> @@ -110,7 +116,13 @@ $ git show-ref --head --dereference
>>> -When using --hash (and not --dereference) the output format is: '<SHA-=
1 ID>'
>>> +When using `--hash` (and not `--dereference`), the output is in the fo=
rmat:
>>> +
>>> +------------
>>> +<OID> LF
>>> +------------
>>>  $ git show-ref --heads --hash
>>
>> Is the difference in case ("<oid>" vs. "<OID>") intentional between
>> these two examples?
>
> I think it is an incomplete fix based on the suggestion I made for
> the previous round,
>
>  cf. https://lore.kernel.org/git/xmqqsfdwenn3.fsf@gitster.g/

Nice catch; this has been fixed for the next iteration.

--
Sean Allred
