Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C4441F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 11:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfJIL7L (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 07:59:11 -0400
Received: from mout.gmx.net ([212.227.15.15]:38409 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbfJIL7K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 07:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570622345;
        bh=Roq98qt6xLTa++BkrEOBKtTFJLR2VS0iYgN7y9tWPjo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YZt2z8xPdJsOC9t6n86PEfXpMO7Vs0/oVHnUj2XrIW+ah5xsZlJQ2nYEngeVm2EIy
         GprNoaYT6R1gb/briEyT2fG1UpO7lLaNxipxG0obP1WEa5IQ8h7eoHiBkOmTbXXk7N
         S8f2+I9bQEh/GDofms4qUMRka+fog/TRoQ+4MJ7Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8ykW-1iDEwZ0jUU-0065mU; Wed, 09
 Oct 2019 13:59:05 +0200
Date:   Wed, 9 Oct 2019 13:59:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] Add a helper to reverse index_pos_to_insert_pos()
In-Reply-To: <xmqqeezmkusk.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910091358360.46@tvgsbejvaqbjf.bet>
References: <pull.378.git.gitgitgadget@gmail.com> <81648344bbab4219c0bfc60d1e5f02473ea7d495.1570517329.git.gitgitgadget@gmail.com> <75a9c7ce-893c-6341-ba8d-eed3ccba7ee3@kdbg.org> <xmqq5zkyn2a7.fsf@gitster-ct.c.googlers.com> <623fcd51-5f0d-bc5b-f70d-0224a054ec5c@kdbg.org>
 <nycvar.QRO.7.76.6.1910091015090.46@tvgsbejvaqbjf.bet> <xmqqeezmkusk.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Db2xKJ+p2JlVNMx6qlQLo/USVaHL4JEPzEIjhR08iRTtiZqw4zU
 SAhPg9PmhnnroSIQ8J1UqjjQ/ZBpb0/kJms1pBG4dMxwNCzzhU1KH1lCBouU0LxipD6q2+r
 9FgnP5WMjTMsnnOoLBVR2g3lELGFK25oskozaQ2BN0YyqIP3XM0VrOK2FrF0WO1tnBoj5v3
 h/UTt/EouuT5s0chhBDSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bkVGyzpnhJM=:aZoiTQyri8WM+LrwZa97Jt
 w5Xrk0qNw2hhvLKPMc0UPncZOCSDfsVOkusLgGQbPqLzMYMlCMeNGY/X4ymUT9qXnbCXkcavU
 9URpbslkK6GyyD8v2gtkDc5u0BawrZaFFwFIjfpNzXYj6wz4JT9WSYRaX0fz1r+MjNOTGHe3b
 ZuDSz3T19DQhtYmKknv4maf2U7nvZHe0+MLQAFIU5BM0aq3SXAp79iy4YpXkBXqTZGt2hxRav
 yeZQqRRGNayno1QNbLZl1P5ShPtawDi358bCokC81hw+j5o0gzSNk1BVb9H6N79qfVB1ElxN5
 f3rcDwYNDZecqJoFTFzL775zwP67y7PkcuFUkEsUH8c+jb1aVWaLuq2qawqa95zH9+H+5DJnF
 xEuM19gsmPgCVo6tsxdaenhquPTlenz4tZ+Dbzcr0MFaFTPZomaHIiMiqZFNU6VCil2BNP36u
 ciKwsOY1UmECSMfWSKieMC3d+y3XcKRoDqqtvfQxIfjAPv1GPpEEZCvduuoSBhbxYa2wzgE0d
 uFvoEgvdKn8QecXjBIct6EfYS/eaHi+XHNSO1hmLMCn3BstHCWS9TaOlLEZGGQ1lOZMBHLdrS
 fZZ/qt4kH570+FPII86V/PXRaTbgRvXWK1Si2eZx1Bn3OsGsc+4yZkVDtBexqSxL+TGjjkkJq
 C5oYN/2e68kLBuyX81PO3bLQ58fDxtv36WFafvbXbUoBqYC/96vOZqf44omWkD9/cGPgWAEeL
 skkkIFHiB9i71Jh7DxAR6/t1FjKx3a2qeHnzQKi0LOhbLAmWXs/G5wYpPfOm3c317iRrEpGpF
 ykjxatl51mAY54kAWRu59GK6e6enU6R/xrd7e0XhhwnZN3mhwDeicMMejC8kWTxLmVdkktxaf
 yurO/VfKnWN0SgTiA0cPvaNNVoU9C+SlkUS+d/qSv2jX9aC4CV5ifZ3OFPyesVK8wcdJ0QEtU
 XqDB2bzl+21gx5c0qOlQ/GXvaqink2UvzQSniWGhxb/kSowV07lj8l/wpspv5TCLWCTZPd2Hj
 tcCXwyAk1Bwk8IlHO+hECd6BIzRevHc7IQjSLGedmxOMZuPNIWqR0h7yPO3n4oH5sDpGAVmAD
 1DyakjL1JF+wkpEubxr4WzmlmmYNFzyfe7zFcflpQB8aurF6EDf6HDAPiIOqjYMcsVW8VgP1F
 082iFIm2nn0nUmLHeWrImbr0e2Tga8FO9pYRJ4RFCZVgZtNOD3NTYdgmDthnIxG9z/BDivnCr
 9RqKzcHPAJ7ghaKk5RDKV+hYa/9pp5Uig00f1YRIexxXLtTnvSq0shBmpH9w=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 9 Oct 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > FWIW I actually agree with Junio about the helper, but in hindsight I
> > could have used a better name (not one that is tied to the "index").
> > Something like `unsigned_one_complement()`. But of course, that would
> > say _what_ it does, not _why_.
>
> I personally feel that the particular name is on the better side of
> the borderline.  "st_add3(a, b, c)" says it is about adding three
> size_t quantities, without saying why it exists and should be used
> over a+b+c.  Existence of the helper and calling it alone should be
> a good enough sign that we somehow feel a+b+c is not sufficient [ly
> safe], so we do not call it st_add3_safe() or st_add3_wo_overflow().
>
> Your unsigned-one-complement would fall into the same category, no?

Yes. That's what I meant to say with the "what vs why" argument.

Thanks,
Dscho
