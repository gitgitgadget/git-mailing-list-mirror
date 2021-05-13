Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3165FC433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 08:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDC3D6142C
	for <git@archiver.kernel.org>; Thu, 13 May 2021 08:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhEMI5J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 04:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhEMI5I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 04:57:08 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272BFC061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 01:55:59 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p11so24243187iob.9
        for <git@vger.kernel.org>; Thu, 13 May 2021 01:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=koordinates.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s1PBEJDT+iDrwCKmssGycorZCN/CNOC4yeooz8tl3bs=;
        b=Hr9lnFdGBmVR0tLuIAn9J5FVs7iT5Y0IN3gj+HSQ8D31UXWYluFAowG6jgGNB+SSWo
         A+FrgZNXrsIZOmqvc705qtg+O3ycJ7t1yhg9clGiF76qoF61eriEQ/mOBdJ7hKdkongI
         DZesuJAY0w7pxNLUSKWcf0E9kJ3SYpRIPmo5ZHyApf107KTfwdRFF5fW4MzPi2UiPTZw
         vBfzPb9r5FQ5owV+jiCxrOr8GlH0kVMl8C+6GEBiQqGtx1l48caZUAOlVLp37oYR4E9k
         nOijfm7lvrjKtZe78fDOUMwqZWqyvgae8x5ZUS8BTkpQViO/nTbWggNDpLkYVbdwmGF7
         5z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s1PBEJDT+iDrwCKmssGycorZCN/CNOC4yeooz8tl3bs=;
        b=kn2SFeCBkSE54HXUKhgSUcKr/CM2DuttfShrIgfiK9NvNJjCO1OOVmYSISSe8XhJEu
         R+zvGZ4YV1kazXSDyRr/5uCXr2nz73Mb27O2fLIZBQBmKMPJPTiW3hcEmM161+SBjMuT
         4PdP49lRPBqtIXLwtEgLBDwZQ58qBv8/piqknhCOpLlRM9N9AsBLFuKkKnknXhfnlRmG
         xaqfiS/+kqwdvPx+NXBT4NYPm19X8KLnD34MOqcJQXBPSj7MxFoX9aPbqfg8mJUw2bOC
         qgU3OZrcd6EeetwZygbME2op8Eca4X5DUiyKBVA6JJV1r4R3cJmPkLpsZiFiMharo46E
         tzRg==
X-Gm-Message-State: AOAM533tmSzOrQYzPL1A7SjqVGIyZ/y3xUHFf9MwhH50SS/lCsgt7Ua9
        c4qOn03xRWXQZ2T6cZ272bspfYh5433u6q/h8Iq//A==
X-Google-Smtp-Source: ABdhPJxcEuCo6nnCaddulxApQuQR1eG5GSUXjuuH3etOUZ9L7JE0DaNXniL0LpnHPcU+GUq4/PQSSELevS2ZWDGQNtc=
X-Received: by 2002:a05:6638:3c8:: with SMTP id r8mr36248151jaq.112.1620896158574;
 Thu, 13 May 2021 01:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAD2i4DALKgw2wG6QGs-oQhAHnS3AG1j1BSq2bxjPojVOtw+WjA@mail.gmail.com>
 <609b4eea1088a_678ff208ba@natae.notmuch> <20210512040926.GN12700@kitsune.suse.cz>
 <609b63e48fd49_6d7da2086@natae.notmuch> <20210512064733.GP12700@kitsune.suse.cz>
 <CAD2i4DBF3Tvf62Zyh0XnNH=5ifTD2QQNL5Fx01UHMzoTn3OMVw@mail.gmail.com>
 <20210512170153.GE8544@kitsune.suse.cz> <609c112066acd_71bd1208aa@natae.notmuch>
 <20210512180418.GF8544@kitsune.suse.cz> <609c2f98932f3_71bd120840@natae.notmuch>
 <20210513074622.GG8544@kitsune.suse.cz>
In-Reply-To: <20210513074622.GG8544@kitsune.suse.cz>
From:   Robert Coup <robert.coup@koordinates.com>
Date:   Thu, 13 May 2021 09:55:42 +0100
Message-ID: <CAFLLRpJeU3BFKmsGgFoKQRLCw-uGRRH1Ob7PZBHUEQu_Pqshgw@mail.gmail.com>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Varun Varada <varuncvarada@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michal,

On Thu, 13 May 2021 at 08:47, Michal Such=C3=A1nek <msuchanek@suse.de> wrot=
e:
>
> That would be the situation if you comented on the patch adding 'impact'
> before it was merged.

As a lurker (and there are a lot more of us than people who email the
list), this comes across to me as veering well into bad faith. Because
it wasn't picked up at the time it can never be improved? Code doesn't
work that way, neither should any other aspect of the project.

Non-native English speakers outnumber native ones about 3:1 [1], and
even within native English speaking countries there are variances in
common vocabulary. This sort of stuff trips up non-native speakers
though (and the lack of rules in English makes it difficult enough) -
why would we want to make understanding Git harder for people when
there's a simple improvement to be had?

Rob :)

[1] https://en.wikipedia.org/wiki/English-speaking_world#cite_ref-Two_thous=
and_million_2-1
