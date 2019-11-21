Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83135C432C3
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 19:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E7B2067D
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 19:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="MMW9wV3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfKUTCH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 14:02:07 -0500
Received: from mout.web.de ([212.227.15.4]:60493 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbfKUTCH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 14:02:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574362925;
        bh=wqPNHDYPSPD7sBcZkeyPXPACY5d7g1SbK1H4PwpqR60=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=MMW9wV3IJNpEZvPl5Cu3kZasekndLtes87Dw03o3toJ6+DALnqUPXLBzW8OkCovYI
         Jl+A8N2pXzxyenAQ+GqzuK7lErxRqB0rg8el3/fP3nVMfsUmFcrGt1SfWeh7bXNl7u
         zfLLxxD1OPRu5H7ouzrtLslwBDwSNi4Q1LjUrZqg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LqUKH-1huO6O3HYf-00e5Ot; Thu, 21
 Nov 2019 20:02:05 +0100
Subject: Re: coccinelle: improve array.cocci
To:     Markus Elfring <Markus.Elfring@web.de>, git@vger.kernel.org
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <05ab1110-2115-7886-f890-9983caabc52c@web.de>
 <fd15e721-de74-1a4f-be88-7700d583e2f9@web.de>
 <50b265f0-bcab-d0ec-a714-07e94ceaa508@web.de>
 <f28f5fb8-2814-9df5-faf2-7146ed1a1f4d@web.de>
 <0d9cf772-268d-bd00-1cbb-0bbbec9dfc9a@web.de>
 <d291ec11-c0f3-2918-193d-49fcbd65a18e@web.de>
 <d053612d-107b-fdb2-b722-6455ef068239@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <4f55b06b-35f3-da06-ae86-8a4068f78027@web.de>
Date:   Thu, 21 Nov 2019 20:02:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d053612d-107b-fdb2-b722-6455ef068239@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t4aumS3yqt0v9Nb+fYFWL/rRjP/AQjNPyRKtVqHHoeaH7Q2TbD7
 pLeRNC7nPdM96YRFjFd9f76n4e1d/NA6GgV7842rmL9rIeoTPZjV0W74anewpKLULtdkXQ8
 AG6+0x7jvl6SxElgSW3FuaPjAHLCRN071sbeOa7Od4FYwn9b/n2rJkgFGTy4Dd8Nf+jDm1z
 YpKU71ev+Uy7oeaDhd3nA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HkEMdEm5nAc=:13m9YuD14xkuoZYsAo5azE
 WcpdHmS+iz18X/zzG3pslSUK8IxPDaVniDA1CcCVIStUsMsFcOdlawYNBfbDPSX/5IBjtnzUt
 nFHo0L78gs2w7XZ371yQDTUmEDAJi+7eLV3h/LszCvF9GHu6dqq9pYvNEVOq0bYssvUNbKj1v
 0VMt9axxlYWEabX+SsjUoGpDldkN/y3v4z7diz8xIRprogp7sijqdxh4JxkfQZzTlpvhDQ9Qk
 tzDncF36NUj8gVXwgin6lslc5gVbNp9Tzk4lBpzPO6YTJA0jAbe3JQKOQsZltKr2ueI4vXx2K
 UExsHxJYkPGrQa/lVEyk9ocR8T5NEBGb5aod5HLxuQjZi7zpnB8zPImDuOxueCg72m0U4UXU3
 WzrH2mlmCfwrgbRz7L3RW2juxXXNop+baNM6SKSo2730hlyCMNfU5piTttgbvLR4kmE8GHIKN
 +HvkW8JlpE+kb87eUggqKxX+ebvuRJWA7XkoQcIsl4ycDYkbUF2hQWDrwFt+WX0eyyjLAWDmH
 iJptgwJ2idd/PHuROjMOffSHAWzPJS/mzxyg1Cy4nyaah9ivKg0tXHnC5LvtB9Q0H7OYiAGe1
 xuoxJo/zsR8P52u42tt3pnnl26FK1V3cmhSyThEd/+DdJOnsEdoE1401JWdShKeEQhH/OuB7q
 IcfiYn6wktXrqRFsPvSzvKcTZAaJOm0Oq7AX0Xo/bsycHaOZYzPeo4bJ2uBf5cTFe/5CDQDdd
 4AHrH7MT5Yys8acDkIaQO2nKFb1nwuEKVndvXV6G2keby2C8vKPs9Dj4rab1+pt+Ixa/nNY71
 yI1Yqc7LlFBJEhA4jHmhQI12v5LBFVRIlDT3IqCTu65HSF1wSX8oYoWqGdtwloRFcrn3UDsB/
 NcMCEkbZLPS4t96RgfuMTK9DTesp/N6foGzmhdLkvkCYKfrmgNqOYwaBHQdi+vctEmAEBxTxN
 ioXNOL9MMQvSt4WeXvADui6xwQbH5idn9YhoF9yrH1+9+l084/AtihWYuBTqoOyjMYB066+iH
 FQ2P/UEY62vVu6oTay9VbIRQzPjEkxCbtp2LxDD/8QIU8gWcMLa0QpD14ydy34U2B7qZ1dnqU
 HahSplE1wz2TCQuTXZdupA0mTWRGgHTLQZ/0k2IaZoXefLbaINP0s7cmNzdfwFmqI3aRsyc5Y
 tqcogV+YzBOxeocnfrPNFfLeOSnlj+EFitkhEwyO8aE3c1O/SaJBXEeqgPBDyf2v4Ab5q//SY
 4qF0XyT/r6dPJG5WK3R2pN7UnCKcZN9oKanLBZw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.11.19 um 10:01 schrieb Markus Elfring:
>> I don't like that ALLOC_ARRAY is handled in the same rule, as it is
>> quite different from the other two macros.
>
> This case distinction can share a few metavariables with the other
> transformation approach, can't it?

Can it can, but should it?  In my opinion it should not; separate
concerns should get their own rules.  That's easier to manage for
developers.  I suspect it's also easier for Coccinelle to evaluate,
but didn't check.

>> Coccinelle needs significantly longer to apply the new version.
>
> This can happen because of a more complete source code search pattern,
> can't it?

Perhaps.

> The data processing can benefit from parallelisation (if desired.)
> https://github.com/coccinelle/coccinelle/blob/66a1118e04a6aaf1acdae89623=
313c8e05158a8d/docs/manual/spatch_options.tex#L745

Right.  I use MAKEFLAGS +=3D -j6, which runs six spatch instances in
parallel for the coccicheck make target of Git instead.

>> Here are times for master:
>
> The SmPL script execution times can be analysed also directly with
> the help of the Coccinelle software by profiling functionality.
> https://github.com/coccinelle/coccinelle/blob/66a1118e04a6aaf1acdae89623=
313c8e05158a8d/docs/manual/spatch_options.tex#L736

OK, so --profile allows to analyze in which of its parts Coccinelle
spends the extra time.

>> The current version checks if source and destination are of the same ty=
pe,
>> and whether the sizeof operand is either said type or an element of sou=
rce
>> or destination.
>
> The specification of metavariables for pointer types has got some conseq=
uences.
>
>
>> The new one does not.
>
> I suggest to use a search for (pointer) expressions instead.
> This approach can trigger other consequences then.

Why don't we need to check the type?

>> So I don't see claim 4 ("Increase the precision") fulfilled,
>
> I tried to express an adjustment on the change granularity by the plus
> and minus characters at the beginning of the lines in the semantic patch=
.

Hmm, to me "precision" means to transform exactly those cases that are
intended to be transformed, i.e. to avoid false positives and negatives.
What you seem to mean here I'd rather describe as "reduce duplication".

> The SmPL disjunctions provide also more common functionality now.
>
>
>> quite the opposite rather.
>
> The search for compatible pointers can become even more challenging.

It's what we currently have, in an a clunky way.

>> I think an automatic transformation should only be generated if it is s=
afe.
>
> Different expectations can occur around safety and change convenience.
>
> Would you eventually work with SmPL script variants in parallel accordin=
g
> to different confidence settings?

Me?  No.  If I can't trust automatic transformations then I don't want
them.  I can already generate bugs fast enough manually, thank you
very much. :)

Ren=C3=A9
