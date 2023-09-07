Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972DBEC8758
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 20:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbjIGUVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 16:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237136AbjIGUVL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 16:21:11 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C101BD6
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 13:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1694118054; x=1694722854; i=l.s.r@web.de;
 bh=qBcKmev0yGur/Qno4lssNrb9E7IN2ECPKqwuMo3kkow=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=j4HckKMYCRYUReBmf0JZtfYeAeAxzc5G3hs+JCxO8P7iVX4dfdvDYN4aZtOzGki8UXBW6dh
 OHVXJhynCHSBSJp/hXbjTUWPqUbxrr769JGAquomx2jWzPOzPSeXHX3YqWw7HpQ1oJSIxPB0m
 1XyHFMDuFIfIY08rCrcv4i9bsnGsKasYVGIkCthkqpjrcPa4PZv2caG1mWTkPwtKlG8ywjQ2n
 UDX5OBW28Ev7EEu95qpLqZYP3pj72HIw+wtVt+Yw1belCL6JzjN63SkncaNfubec9eQDOY4B0
 85T/+7jlNHEG+Lue1bEudyf0RnjXzzSxjdulfOobycpLJFl9RFdA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.74]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5UkC-1pXlVM0nXu-016wFf; Thu, 07
 Sep 2023 22:20:54 +0200
Message-ID: <724641d2-1cba-3768-6008-01e8a1cdca4e@web.de>
Date:   Thu, 7 Sep 2023 22:20:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] grep: use OPT_INTEGER_F for --max-depth
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
References: <4d2eb736-4f34-18f8-2eb7-20e7f7b8c2f8@web.de>
 <20230905072122.GG199565@coredump.intra.peff.net>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230905072122.GG199565@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G5csiJpVCh0rSNHUfAoyunGVPhe95Nq5Rrp79KXNl8Dt/G91d5Q
 4iuGezWJua3Vou5vbZhoSqw263n1kYJno5K77VhZ8Qukz8vSQ8bERRY5gLR8YRHcXCc5csS
 ufL3XSYk0udTi6lNco3j41wB2yfjdm4KP1mtWV0Z75VZJTyECBanrRPopZydVBoWt+Mfe0r
 BgtGS+WVUFoEuco2Gm8RA==
UI-OutboundReport: notjunk:1;M01:P0:8LWRAKCIoMc=;fwUEGwnjElVUq7qK8QbP+DLLp01
 S90rQRPgXEU+6FNubUDTLCGPIaPnbeElK+S2NmwzpFVI64hu0xVkuGIx2FZtx+PplNckV00ho
 /5I78FBJVvufdTPxmnZYHf8IrER2y02EIyzQw7toyMF2z/V0UQcWECumo6S5Nczd1bqYNEDBY
 qsqBReu/kg5GZTHRajSEqM4vL4kFlxC7n0Y/JbKY6MVbOpVeo99rfji4GsUXvuK4RRJfIGd+v
 B8dvvLSJL+adgwIOu5YeogKiwG/JTDAR0BMCDWrGGzJM4EYtkK+HIzPJDTrmXa0v9XWWwPgdu
 Bak+QrqBv/U666LgP0+G8qHoQpv/NtXQuxm3GkVZ1tp2DwVT2UBUmRLD5bUsw0qXxfvnZs8oX
 0BK3nNaGXTXXH3B7KzLXYmLVw1mKkwlChqU0Dk95qXhJ+EshheUn5QzMhfMhQgXQ7TrIhyG45
 l7+a5W77vbqmJQbMKz0p3/t0hdrLbHfWNCQ5LIL4Y4xdZiluqBGtFtC3BClENCmsxk1T8ZGx0
 4Rl/MScbFUU/fkB59x88qebElBbHXOvU9/2OB/HBDvieZh9iWnxKA5sH+HaxMVKlkm465Szov
 fgNIDsOK6+wH6D+UsAV6Cx03OT2YUA2G1K7HqcT2vNO8EIpzUqo24X/56D/uzIQD3ea5xF8d8
 k4JUv+aujPLFEYTsjstcwinNGvc9JE0g+rvKtvEtUTgnkgJmxc5nRVB3X/ipHCW7yfnA5ELa5
 DnFrnzWjD8Im6b66qgL8AyzPNznVpwodJY6xWU3xKjLnEZflMpRoKq9DO1ndbVOoRMFSmE4en
 dwDqSgnrTBzJ5ZAxLSglH25sOZ1/s+HyRzwH4El4awfBFnrAwtIV7Knh+bIUvj8ZBPjEHT4+g
 Q4IHRVt6HxQrzuf9xiNO3ysfmY4s9aYtaTYOfZDZdBBp/jeMnDQx3twUk90j+drzuCixCZQPP
 drHAsg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.09.23 um 09:21 schrieb Jeff King:
> On Sat, Sep 02, 2023 at 08:54:54PM +0200, Ren=C3=A9 Scharfe wrote:
>
> In general, I wonder how many of the results from:
>
>   git grep '{ OPTION'
>
> could be converted to use the macros and end up more readable. There are
> a number of OPTARG ones, which I guess can't use macros. Looks like
> there are a handful of others (mostly for OPT_HIDDEN).

Indeed, and I have a semantic patch for that, but mostly because the
macros allow injecting a type check.

OPTARG would need a new macro to allow specifying the default value.  Or
is there a variadic macro trick that we could use?

Ren=C3=A9
