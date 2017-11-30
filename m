Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AF8C20A40
	for <e@80x24.org>; Thu, 30 Nov 2017 00:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753721AbdK3Ago (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 19:36:44 -0500
Received: from mout.gmx.net ([212.227.15.19]:59830 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753718AbdK3Agn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 19:36:43 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LaXEN-1eyGIT1Jct-00mGA0; Thu, 30
 Nov 2017 01:36:38 +0100
Date:   Thu, 30 Nov 2017 01:36:37 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jonathan Tan <jonathantanmy@google.com>
cc:     gitster@pobox.com, git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3] diff: support anchoring line(s)
In-Reply-To: <20171128184703.155931-1-jonathantanmy@google.com>
Message-ID: <alpine.DEB.2.21.1.1711300134560.6482@virtualbox>
References: <xmqq1skj9o7r.fsf@gitster.mtv.corp.google.com> <20171128184703.155931-1-jonathantanmy@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:qUlMWZ9lvZWbPrsXTMkxTDna/ybj8inDQPDgnozKx9TiflxJcJZ
 NTduo3TiXlHw+1/jK4FwECdo6FYJ5Z53veGazNsc+m6w2b0U7BDJKotyYm4l3wS4B2jgDkF
 AHV6myQRrH2vSTyXBHKzQp3Pca3NNSvYDsSDGLIx/4TYKlsLwrctjhzX4FZPYkTPv1lswzP
 xhYxHl2pCCzyUJ2SDLlYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MxPQjBGHs/8=:kaxhWX5Wx6FMYpKfkM/TQa
 xvZdhAPHLbVqjY5iCuXydnlB5W7EOFDX8AcJIvbPaWi39KNwBWsrS9BiOTeBnYELXJS0PLOZY
 JuwkbQonrJGLmQSKTzdcAsAyI84LjLjagB+FIEqXEwlvibYmplqFaJ02gtLf2Fm1aRZrsBJDs
 sDApuxS8hXSCWt6FIrU0gw0ljmWpe6+4mP0UaBfhTc2K/AVR69QLdNPmuZlgwJ6niRZljxkzb
 jJt6DERseld8On2LtGgLYF1cj6WlkvYv9YtFXdArREOPPTAugHxqgfR8hJ4ZeHm1SgRseDofQ
 dlAKm3NvsMrnuN6LJp/eO67EKwiYSkP5JhuOqmE4sOLKjdnlF0gXAtUdOse9DH7OalqxOvFbl
 MN6tRZFhnhkgg1KFP8DuSVCB7+raPHpe3Xb+/porBpe3R3Q/VyXnfMUH+U1as8tMOe4/jQGfW
 mVxoUgrSg2YmUkwERadpPnKGWJY0jcHowOGJLhsJ+YEsbVw5I9ufEzi6XN8T/NQI1Jkqdbums
 FdVrRcGlJeFS+IupPhtQ2/qkevH4Lop34zEnPACCHSiM88CpjDMq91inT3pYoi3dEktiMxhrT
 sPWRXOrTXD7LedXXW5U7JF2Ak1zmCwceC/RllR7mVz16vsKp1/RmqQ8dlHjRr+zO2g/YC3jC8
 AEmjodZPIqqv7ocL9L6HjuUPPIf8vzn4y5kJVTpxP2HqM8FJu96XSmvODNgKQKc2c5Kz/BOX3
 bqWab2zXEbBVS5wm6J8sjdbPeUVFhU6QUPqXhrHwwry5fOPN4bVe6WDH7n+lwbwmlCU8l9eOu
 cGxT5ZciUwlVnWd1kcE6coIFL9L04n7xdMCJ7/+Hq3gTnjupFo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Tue, 28 Nov 2017, Jonathan Tan wrote:

> @@ -4607,7 +4627,14 @@ int diff_opt_parse(struct diff_options *options,
>  		DIFF_XDL_CLR(options, NEED_MINIMAL);
>  		options->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
>  		options->xdl_opts |= value;
> +		if (value == XDF_PATIENCE_DIFF)
> +			clear_patience_anchors(options);
>  		return argcount;
> +	} else if (skip_prefix(arg, "--anchored=", &arg)) {
> +		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
> +		ALLOC_GROW(options->anchors, options->anchors_nr + 1,
> +			   options->anchors_alloc);
> +		options->anchors[options->anchors_nr++] = xstrdup(arg);

I looked and failed to find the code that releases this array after the
diff is done... did I miss anything?

Ciao,
Dscho
