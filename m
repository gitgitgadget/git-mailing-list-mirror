Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838FEC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 09:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiHJJJn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 05:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiHJJJn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 05:09:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB857E83D
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 02:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660122578;
        bh=CbMzkXXN2LVuGzcrSg1oozk+5bCJnXxBjKilG6asK6M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FbFT/Ftn3hD2hRMA9Aif8oTaFm+f6YfSLzSkHChcc2JgSDyf/fv+Ycai6dY8P/9I7
         TT0AaZ2AX0A7vcWxRpDw96vRdCJdcKFt462D/RIaCMY+cIm4I9xA7FuQ5LVRPqyYRA
         q/8mzxFDY1Y2MXe4lDwX/VvZ7o36tzG41kT2Y270=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.204.74] ([89.1.214.151]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXGvG-1ntXf20yVC-00YjSm; Wed, 10
 Aug 2022 11:09:38 +0200
Date:   Wed, 10 Aug 2022 11:09:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v5 3/6] pack-bitmap-write: learn pack.writeBitmapLookupTable
 and add tests
In-Reply-To: <CAPOJW5yNQvO3quG91jjC9pT-+NNhJta+H_E2R9-1wUzR+rPXnw@mail.gmail.com>
Message-ID: <68r08n47-9o07-351s-710q-786q69429q86@tzk.qr>
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com> <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com> <59b465e5a7817c145172f25e73ad807c7ba67e84.1658342304.git.gitgitgadget@gmail.com> <p3r70610-8n52-s8q0-n641-onp4ps01330n@tzk.qr>
 <CAPOJW5xBUaAJtOvrefwbXv_WDTLa=6PTL5kEoOpRQfqqFAx3oA@mail.gmail.com> <6s4n3600-q5p7-92sr-4206-non3s8rr3n46@tzk.qr> <CAPOJW5yUi471cfAXuXaM4BCzVsfZ15J1Era4NuEpxEnmY6md9Q@mail.gmail.com> <p69r38sn-1ppn-q66q-9089-59394pq78772@tzk.qr>
 <CAPOJW5zYndyqwyN8xOcRQnwebqXciY-25hNL3fU=V5ac8fCpNA@mail.gmail.com> <s714sq49-o13q-5417-0o21-6397s3646q9o@tzk.qr> <CAPOJW5yNQvO3quG91jjC9pT-+NNhJta+H_E2R9-1wUzR+rPXnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SH4bfB282SZeSH9rTmzyy5TUggmkDQHPwLyii/k7vyARIIGfB1u
 64VL8jUDcK2ldujgRjxCVBbjHLEcC7SxMMr1dJVKUnkSTtHQPz6CdQ2lj7WMtQzDNNg/e3G
 LnSaG0skbTOpQh0LOAYZKPnn5lSUeTnmAMXA2b495HKgCRl3tsIgzfX/MreB6DzQvurytsx
 raOgd8OvuYsQ+Cxlq0Rjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QyOFPqqLLtM=:Ci5Inoz834ETzLmNkZoPQB
 dL4gOuepte80eO0H4iKUvS0p09f5LAxptSnSJI3ZSBnWyTIkZFt5+26WL80qxlrDzSe2zllgO
 UdL5x0tKbLJFUqNXBYcp/yUFzA3ZT7yO09p31dM4E/ybgGBn7HW4e2DbJ1T+0UR0+mffihsrI
 MqtYrhZpphVrNNEif7riu22yCCOkTEss44CdQjyQApUD0lhFFs2XLtv3mNNreUIsL1UcnHacK
 u0f0q29pBMf8NjzTVMMKAR2C3uqMeE9d/7UHrGFDI+UgZg5fB2ls3hHwxBQhoXt5RZVzOrh/l
 vFtYuylhLyoWrcXCmf/4mMtg4WDw7UbyDUSsyUTDOHRtep8VHKyfAqnIf8D2P2+T9Y61Fq7hP
 g2v+o0rPVeubt0gKqiyFwI2bmtvVSLVbq9KVOASycVCgam7Gd/QoULPMlHoVRim0/xU7rg8m2
 ddGQOQkQLu8PBGaLI1Ef1MmNFGhHRN2jIJvfv/Apvprn3MM1FYRdPuwpO89lEys8xsocOT96h
 WtMu4WBEaCJUazW8O7pQDw4c0+qHkcadhzcD7y4D+O+EhA27ChywTH5BKEo+8LAXmaOdC+bJH
 iLY0H75x3uPp+0wBxozXCwfdjVGcbREIwjNmAPjOqCIt9EOlQTjFoEBtTenhUTo4DibdeStqp
 DrA4T+TnVrHnVcTtG3KfEYi4SFcJRQl2AkQm3+OnvCoT1eFWaHd9tyoq8JJtsJ+TBKKj87Im/
 gAlsOtVfqBhPIJ7xvkdDHsxVB6ydt4VPG9Tv9fhRmbJg32smj2lwl4gJueLMCow1Vbol0JF81
 1WzARNppxxjrr5Kz51dr19HGUXJjjIyPwvR4ioo/bcZlCNcJlvpFvZGj7AadIh1YmpoeVGzQ/
 3j6bf98sKTQimHqdjGrzKfZ7NODhsQvr6UVfFeY6W2N/1cXCLMHBNtBWkXH5a73yt0TL1j7x6
 Y8PJ68pYfitd4xOtoP9zFsVuPBr0V8tbp9/uXB9A12uUl6VMmsO/TpMn/vehlmIZp5ChPMHjh
 V6de8Mdca69jiJD4q2kRIvt1r7+hAKMUt9QfDA0Pcg3H+DSCapLLvuOVjpkupsiiDiwpMVNCk
 QXNOGmKNXo8DWcsT5nIssi7RBf8YT+VTGaulokMtTv/21O346fgPJYriA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhradeep,

On Tue, 9 Aug 2022, Abhradeep Chakraborty wrote:

>  I noticed in the 'setup partial bitmaps' test case that if we comment
> out the line `git repack &&` , it runs successfully.
>
>     test_expect_success 'setup partial bitmaps' '
>         test_commit packed &&
>         # git repack &&
>         test_commit loose &&
>         git multi-pack-index write --bitmap 2>err &&
>         ...
>     '

That's interesting. Are the `.bitmap` and `.midx` files updated as part of
that `repack`?

Ciao,
Dscho
