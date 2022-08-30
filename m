Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1336ECAAD5
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 20:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiH3UlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 16:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiH3Uk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 16:40:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357CF237E5
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 13:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661892051;
        bh=O4a5bDSAGVesChlRg/1w4Eftgk8uped3C6/T+BVMCwg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=d9ZkYGvt9XMp+0nEeXmmvYZLVZ9ebM4Mj1u6KSkD3b1ZKQoa5bPNV+ELNdqF24nZZ
         OIUvQ7mtBtfXvaMmrU3Wu32uJdukmURbarlDVWSkyZRFPfzYcG43pVf+P4b++A0hMH
         fK+Kug/OafCimb4VDVIRdhy+GMGxryOz6lcW+DlE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N49lD-1pT24A0PZ3-0103Nd; Tue, 30
 Aug 2022 22:40:51 +0200
Date:   Tue, 30 Aug 2022 22:40:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/bisect-in-c, was Re: What's cooking in git.git (Aug 2022, #10;
 Tue, 30)
In-Reply-To: <xmqqilm9k0bc.fsf@gitster.g>
Message-ID: <n1p36n77-2nn5-1740-40q7-9o17p8no994q@tzk.qr>
References: <xmqqilm9k0bc.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CSbzcH+nvAazEdxyZx6ayCMjTU6tRIgFWoQH52XQk2XwnBna0HI
 +YweUs6nrazWKkyZTYzqBpO+qBozE0pEavhb++yKFIUCOuNnZx+0tmUQM+ki9zO1gMx5V9u
 JU10mfiU1Q0iQoR+9GiHttUnEwPE8eWl/aV2JLJ4NFCqqwrz5ZZxHj2H1qVhTtLbalhhK25
 ahS78ycBwXoHWUVH3N25w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mdNaDQe9ql4=:03MX1lrMEHovQ1Sjlr5Bie
 06nbh6Ix9LcMem3ncj3ZA/C7w3hvJ7eZOa1RgQIp3sFnpP6KdoICOy1veE4qLplnjYVms8eUM
 6exUx7YephqhtVLjTDBtnSJnp9T/eRkpdHPXajOdxg6F81m8mBwfnDA4mw56xajig36dD0Mal
 C0jioJaHRBB0oDDqVW3aFsMBICaovkPX4U81L1Qr3SPWIEYp7v34J6THtw8nrFCGeg9G2+XE2
 YgV5A3ToHlRxXRSSZGqge1b4CKzzZxK1H3kGuYb8maySd2HslJcXR7d0VkhkPtZKR+FvE3Xne
 g6tC3QjDlWJlXMuaKjB4Y6EPK2+jL14Z8nqEaB6VUWxVliFxjA4hIQ1a5EGHi8M9xn/HBxCCo
 1JEgY1ZYRJRNx6dJrSGCEAcqtWBw/r23s//8sVpYXG5ZgcXGyvGynKT8sKOHmELQ6dky1WVKS
 KiDHdo2hRO9WBaiWcNkfGw9+pTX1ggWsBlGh8wNIhh3e0oXTBjtc+8YbgDjZrEIuUcHj8DvyI
 i9Xuc9qgKh5QOr9kVRkxBZQ3VdKYjyN3ZCa4qiXkYkr4fs+h1GvvsQPmKiqFO2p3OwtieheVl
 97TvgIRyMV2/vV3ANOoGyMnjJPs7Ph0a5PBChGB2MOLLpMrHcnwcgdS+DtcBIFdHDCrfamE28
 uuGiB7VRaAlgk1uHSGxv1Hpx0Jo5W+r29cbjZnugTbAjahO97ZC+2CvjefpeYwVUcwKwrve51
 ibUB4KxhBYCXI7wivSUsGeXR/8k6c0BIPprkaBCkd1y+DB0/ZDXiqr4tTLrzjfu29ahJo//vb
 yzKmk0V6pX76OImiveyXdT3GWuay3QzRk+sNzOaPPufBjNRImNU2HAKwSe0BGV7idMn8Kemzt
 AvY/w1WD5++ICETHZjQ4MmWbx5tKuiT2JpIZag6Fk2UFBpSR89PcOSy22TFgSCauZbUC6LIK2
 8hMXYq2g4iwjXSi/SdE0KqNRBYkZMmTv9igbJU3QuyGNQrusODBg4M7m6yDgRZYHk0Qij5C1O
 LMm5GzrnxxYNcC9gBNOJlBuc/E/sF55d53wV2YaiZnPf7K66BtJXqAkaw967DL5gPAczHOvlN
 PnR99nd/dP8x8jTFveA9nS2IRdI2FEJdubcWssL16WCOkocUXju2S2KFw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 30 Aug 2022, Junio C Hamano wrote:

> * js/bisect-in-c (2022-08-27) 17 commits
>  - bisect: no longer try to clean up left-over `.git/head-name` files
>  - bisect: remove Cogito-related code
>  - Turn `git bisect` into a full built-in
>  - bisect: move even the command-line parsing to `bisect--helper`
>  - bisect--helper: make `state` optional
>  - bisect--helper: calling `bisect_state()` without an argument is a bug
>  - bisect: avoid double-quoting when printing the failed command
>  - bisect run: fix the error message
>  - bisect: verify that a bogus option won't try to start a bisection
>  - bisect--helper: migrate to OPT_SUBCOMMAND()
>  - bisect--helper: make the order consistently `argc, argv`
>  - bisect--helper: make `terms` an explicit singleton
>  - bisect--helper: simplify exit code computation
>  - bisect--helper: really retire `--bisect-autostart`
>  - bisect--helper: really retire --bisect-next-check
>  - bisect--helper: retire the --no-log option
>  - Merge branch 'sg/parse-options-subcommand' into js/bisect-in-c
>  (this branch uses sg/parse-options-subcommand.)
>
>  Final bits of "git bisect.sh" have been rewritten in C.
>
>  Expecting a (hopefully final) reroll.
>  cf. <20627.86ilolhnnn.gmgdl@evledraar.gmail.com>
>  source: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>

There exist two "rerolls" that were sent since that mail was sent ;-)

Ciao,
Dscho
