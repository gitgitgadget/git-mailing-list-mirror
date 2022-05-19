Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1969DC433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 18:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243672AbiESSMk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 14:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242701AbiESSMi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 14:12:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28A3D9E99
        for <git@vger.kernel.org>; Thu, 19 May 2022 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652983937;
        bh=gwklDHIPH6ll2P211CMY/127Y9LOodwiFc70tn6tYrQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aU6TP9s3gbZRXonEtvUGsXDlSWPu8pu1hp6njpicz9GZ4L0edxq2rctbICSCqCxvT
         04QIOwLENzpAB8YMdzJvIaPMCIGAIiS3IdrsnQ25ypXxD7086T7QrxTQnz/hWxw/h8
         mAxXaR50Rzr/9JsjOBa1E/0k5GxnrR6iDdH5YDh0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.215.85]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8hZD-1nwRbE0NBB-004kfB; Thu, 19
 May 2022 20:12:17 +0200
Date:   Thu, 19 May 2022 20:12:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     rsbecker@nexbridge.com
cc:     'Junio C Hamano' <gitster@pobox.com>,
        'Johannes Schindelin via GitGitGadget' 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        =?UTF-8?Q?'Ren=C3=A9_Scharfe'?= <l.s.r@web.de>,
        'Taylor Blau' <me@ttaylorr.com>,
        'Derrick Stolee' <stolee@gmail.com>,
        'Elijah Newren' <newren@gmail.com>
Subject: RE: [PATCH v4 2/7] archive --add-file-with-contents: allow paths
 containing colons
In-Reply-To: <03d801d864bc$85fe62a0$91fb27e0$@nexbridge.com>
Message-ID: <nycvar.QRO.7.76.6.2205192010210.352@tvgsbejvaqbjf.bet>
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>        <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>        <fdba4ed6f4d5ed4f78404e0a0c5b338c22678533.1652210824.git.gitgitgadget@gmail.com> <xmqqmtfp6ohc.fsf@gitster.g>
 <03d801d864bc$85fe62a0$91fb27e0$@nexbridge.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5Y9QFHvIijx2mV2fnMM3xPrmbSNsHR7qtAGLqLu4AsRw9h/n9uv
 pA4ybVtCvEJJwwJc44M7ASGCUAg9hcL3Et6sWWhdPrAx4ORu+dnks29D46Ais4fhQezc+AY
 7isU8fAAEAcA/1Jc/rH2BMpz+VS3C522QM5JaYD4wz+HkhjEqyqZ2gcV1/0tganDvlPevO+
 Dg9sWvXaS4DDzYfYhinHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uh/zt0kiEkM=:ULKDg/IAyxgexQQVPf7YCP
 kfaFA7Q4RQQHGQpihhe5poFydsI60/zb3pzFOSIVW/4nfNVLUbx/Q2oC8phZux+k1Tsh9W0LB
 4Lms4tVEJlNU6Y5e/LDxbLlWn02V7UNJzi7G80CdIh3WRb4qqQgtoVhhc72iY9ev9+pY6dhQk
 1ANofy24wl1OrqEBzmLgGJe/WRfaf0ri9sW2U8ZNgw8IRn88BtdLwTmjEAa7Jxwrtmfs/CdCJ
 g5O4xiJ2yHw+RRf7iyZLykYSFMpsm+DeJa4pBClq7WxSvhOHEShSCzeCmHsiITs741nwpT0fK
 lq/NAR7zTktXo/8O+xmbOJiybn9z1jvegD3DBRJasACO36J0Nv5XakbfSU26jY3pR0Mdbss53
 f/euCBvoaEgnyjwpx3R2cU63A3jNmBovqLpkCCtDYj7OSROBeKzJ0UxaFVyUQOyE5fjqZHklY
 63VEw0umRLHChggtNkudl5YodBWle6UwXtvVmikV9EgEP3f0/CXYbnZtoyoxSMLX6i+wZwyuf
 ItmcwEZTdZgFTcirpTtLZihNAkD+gd1bcAvmEVHTxTJNUB/8wgxVvUegndHVbPJRLarpkReyc
 ntIGnuDkJHKTFpKZD8FAyOGgjMeNNWn99b7v8tPU/OgX/mcwAyNTAVhfopKU691zSK6MVYMzG
 IkyqlSAKp32LnTPi/8GYpazZXUxzGOVRecrPBoCXmQoaum8dN2Gohp6WWiv063G/tHspnD7GU
 Bg+w+RgCu63ctUB8qEKGLuOk7eOd2/S/pGcs1y/qIFC4e8oNO//a1hv1bKhU5couEH+lb/0IH
 xjNuUbRWY2Q1/50CBNsotLyQuvpY4jeiZF64Z7NfAy6j93y9GWVWFmPikXxOjNFe69NjrWpWV
 geQ7GYNhTLLqv6PWi9OcXhvziphpbrZyI3ltghXVKWM+6sfULsK0FPUSj/3kCD1cX48KJcNg8
 733f3nrfGct3l5HY46XZc97dLTZHqJmWByh9Sq+rJvmI5bFO3OSoO0D956Va4knZMm1QuZO6q
 a9s/GT4c5R+cLlmOC2GwWNtkfnrw3TQOd4Fx2znEKkVVwg6Pn0+pxyMjUZMAIhLB05DwHqsaz
 MfcZwJtbULXNttZZ//yKBWXBg24Qx4kv4p5mQQOk6N6Vg/ucxTaqj/dSQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Randall,

On Tue, 10 May 2022, rsbecker@nexbridge.com wrote:

> On May 10, 2022 5:57 PM, Junio C Hamano wrote:
> >"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> >writes:
> >
> >>  	git archive --format=3Dzip >with_file_with_content.zip \
> >> +		--add-file-with-content=3D\"$QUOTED\": \
> >>  		--add-file-with-content=3Dhello:world $EMPTY_TREE &&
> >>  	test_when_finished "rm -rf tmp-unpack" &&
> >>  	mkdir tmp-unpack && (
> >>  		cd tmp-unpack &&
> >>  		"$GIT_UNZIP" ../with_file_with_content.zip &&
> >>  		test_path_is_file hello &&
> >> +		test_path_is_file $QUOTED &&
> >
> >Looks OK, even though it probably is a good idea to have dq around $QUO=
TED, so
> >that future developers can easily insert SP into its value to use a bit=
 more common
> >but still a bit more problematic pathnames in the test.
>
> A test case for .gitignore in this would be good too. People on our
> exotic platform do this stuff as a matter of course. As an example, a
> name of $Z3P4:12399334 being used as a named pipe (associated with the
> unique name of a process) actually has been seen in the wild recently.
> My solution was to wild card this and/or contain it in an ignored
> directory.

The `--add-file-with-content` option, which this test case is all about,
specifically does not heed `.gitignore`. Is this what you want to test? If
so, I don't think that's necessary. Unless you expect some future version
to introduce a patch by mistake that makes `--add-file-with-content`
subject to the `.gitignore` rules.

Ciao,
Dscho
