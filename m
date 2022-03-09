Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E63C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 12:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbiCIMT0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 07:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiCIMTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 07:19:25 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E623A123BEF
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 04:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646828304;
        bh=Fh+OeUc25k4hsa+BHRQUj6tw/Paomvy9u/1HVr4sVRo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VK4VJztBnDbkE0mWDayu1wRm7podOvGvnwPTRZLJ7mgJs6BwFeFfWISMeVE3IBpCY
         J1FYUHl3wpyy3DA+KO+wRSAsPihSZUcH1eVCrJVYKOtWtH/5wT+hGgFNipI3Su3uHc
         MUoFldF8EZa2VnK5icPBQu8ydrHZ8k8YR9VfGsvE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.147.135] ([89.1.212.224]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZkpR-1nh8Nk3S4d-00Wpuv; Wed, 09
 Mar 2022 13:18:23 +0100
Date:   Wed, 9 Mar 2022 13:18:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philip Oakley <philipoakley@iee.email>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] rebase: `preserve` is also a pull option, tell dying
 users
In-Reply-To: <fd18d7bf-53b6-50ca-12e7-ac66e8fe75da@iee.email>
Message-ID: <nycvar.QRO.7.76.6.2203091317220.357@tvgsbejvaqbjf.bet>
References: <pull.1155.git.1645526016.gitgitgadget@gmail.com> <eb5871db95b12500cc0a6b8b0e3a82ed9e8fcfbd.1645526016.git.gitgitgadget@gmail.com> <220222.868ru27vtt.gmgdl@evledraar.gmail.com> <3e144b59-dce2-ce10-cd9b-eca92eee922c@iee.email>
 <c5197f9d-11eb-5f91-ce33-c196069dc2d8@iee.email> <220223.86mtih6fai.gmgdl@evledraar.gmail.com> <8bd89179-e94b-cc13-6373-1aa9fb539e59@iee.email> <nycvar.QRO.7.76.6.2203071742240.11118@tvgsbejvaqbjf.bet> <fd18d7bf-53b6-50ca-12e7-ac66e8fe75da@iee.email>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rsxn6MVjlC+DQOokHSdI8P9aefcvyEW4ShlUP/hHfKH9Pu89/RO
 wI9tSEgF6eHCoOrctvbgbC0O+XruESoTefcltlfmfSGMGS9akxuPhJxT728NVUzwYcGWKi7
 5nfFaSYXMg1R+/Dwwcfe0lJN3Gv6j3CSZkXbOdvfNY+OuPzf+RC5Qd5p0FHQEUTSXyxqpsL
 7IYwTYu2cJq6OwygbqiSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GGxWKRlVZ9Q=:Wgv8mdc49o1mvij7f/cfvj
 7krA8M8Oexn0vCnXOjhazrWvIwsN+3uKIAL8cn8LCLzwxZcQRFIYEBUiQ39YR49Bg7xRd46NQ
 g3INc35CDmkOCoQoOilpTFFFEEMpf+auzVQu8Or2coG9/sn288susoKQ8xVE6WmUWBEqeJ2Uc
 aDeZPmGoWG0mdokIO2O6vEWh7xOEYhmL4RHaZLQYouOWRorvIGteLQEsNBb4GrANaZF0Qg9bP
 Y3dS9nsEeuTrtOZu07dUyol45GW/17od2Kh1QKyhWpX05bW/tiNv/Ty8UOEdti1LYA1cRhFdG
 Zu2jYkxILe7a44muXwCQg1GqCM6Y78sy6akaLLkvhFR672/FOaVB0StIb1YskD9AnBD7BtsrE
 L40yPMTOlOQwWpxRtvlLwKBgooU/4LL8QLg51qPWnQcF4oE4uWpVG+Ez+7N/fvslRJlG3AWOP
 IoWzsev7/sneXUMxbFBpGePQhWoU5Vw+LiH9+6z+ieTSQ3BRfGtOJQR3ls9Il7S5QDsni5E+/
 jBsdyl6D2S3l4LTTu+VAKFwrPrLsCe/ipt3WlV5efrQVAYWsqsT0Ig5HZklsiNBwJNYaFZ6Gh
 o5YCnL79SbvGpEGo3PRnF3RHCkZE5FJMtSQ601By2LKVqHtk4Du0MWcsqnUm8FGic5dP31Ari
 xSs7jy4G7bGBc5Wu5JaJzH7VFNkIW+C5I0HJIkjkNjKjcdaRhgxGnZmcPI0Q7L1RFFYjGzg76
 ajctVqip8zw6ELZXlpzEGZfjjce/rooQ23AreltQWK/hwi+P5GoVEWTSouISralZWw0DYQDVc
 zfkMSLraGo1PwJFVyJYXbHKa5A9weZFAnhY/WMj3pW7Pzc/eK30CA7VDcXMasqD4Bq+SOifES
 U2/F1MliNy8GcLg2s1wlv+7DSlikQlB/XNSTpZrpQEAL13nb5AOqPAiAg86XG9WJchVFP7iHG
 JV4TWab00WYmrdmcn8GyAE//GLv8fVpA4mkW409yupRk+xUt103VSsqTRqr5HX5i1q1ll5WiT
 ItWcEEA9DcAXkXBNk9K9eBtb2m+0gbE2zCEJITSk7r3LqecMaqlTR3Rnu4xMd3Dpu4Go7/72P
 Mmc3WoAqVW8CKM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Mon, 7 Mar 2022, Philip Oakley wrote:

> On 07/03/2022 16:43, Johannes Schindelin wrote:
> > Hi Philip,
> >
> > On Fri, 4 Mar 2022, Philip Oakley wrote:
> >
> >> I'll have another look at the ways these edge cases could appear, and
> >> try an improve the commit message explanations where the diff doesn't
> >> show sufficient context. It'll be at least next week.
> > Can I punt this patch series back to you? (I sent it upstream on your
> > behalf because I had assumed that you'd want me to, sorry for
> > misunderstanding your intentions.)
> >
> I'm happy to continue to work on this series, and am grateful for your
> support in pushing it through GGG. How is it best to transfer the
> 'ownership' at GGG?

Sadly, I don't know of any way how I could transfer ownership to you, but
maybe you can just open a new one and reference the first thread in the
cover letter?

> I've still got some family issues so it'll be later in the week, or even
> next week before I can update the series.

Sorry to hear that you have issues. These are tough times, and I feel for
you.

Ciao,
Dscho
