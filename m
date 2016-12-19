Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 535CF203EA
	for <e@80x24.org>; Mon, 19 Dec 2016 14:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753613AbcLSOGf (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 09:06:35 -0500
Received: from mout.gmx.net ([212.227.15.18]:53352 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753222AbcLSOGe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 09:06:34 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lvkwm-1cfqaT2qoW-017YIl; Mon, 19
 Dec 2016 15:06:25 +0100
Date:   Mon, 19 Dec 2016 15:06:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 04/34] sequencer (rebase -i): implement the 'exec'
 command
In-Reply-To: <xmqq7f731pis.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1612191505390.54750@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de> <54d4e8d3673662d1ec806f3f4a779a17effbdaf2.1481642927.git.johannes.schindelin@gmx.de> <xmqq7f731pis.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7To5YQfiUPo35oaWgvp5Baxt2eqBStt91l4uxfDKCcKNaqQjqz+
 52b8k1ej7X9wGP6LUbyGIdLGsS6ctjGpP6rxInspj3YAn5l+v/pLmw/KW38hTfvxEd8psY9
 UXOy83zoHWSGw36VN1oa+eAUoFoOJ7bZBCmL43PJfPtuQkAiZS2y5t4tlAcd54FPxkjPFHf
 89/id1Xai67o1mIyeuASQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mS5MFp1JVU0=:xiiazmxUqXJG/mn9TcW/07
 9ziSr5C1P6iwMW8Ah53wtNmIH55IrviWdY64leZqbN8Pqp8taWkyayKod3u3KfFmPE6gUspza
 ux0anhAf545vSK37VWMnYpZVhZNog3ozA9ifKR2+RVKbLKOJKnl8WIC3gTL3ZgzWLfjml5anR
 vWH/Ul9XlFrkf572E5l3moFXu4i3MP3XZwrUYdcTJRBcCeH36G0RX9jilC6uy9Tpv9/hGXI8h
 jM0MWKA3iyDU1I661GFX9MN/oXA3UTUzsAan5VEkR5r/4ahhNeCqAdtjvfTLPsQgbuPxdhH+B
 Lfah9hM/3z3v63orebBsqriCq5ywyQYSjCe17o5W5ZRfnheslb5/F8SxEN3HEScB6D+bWOk12
 QKqN3OzUS/uMl+Bqacr35T0saOnLutfTRdqh16OM2NUoy7kCBCznwEt0sQU8SlTG6Hs/uR9nT
 qOcTa3jTyfYMibBdK4Shr+NBxWoP0avTp0xGf17UZlbu9p2IVGBRfU8ekF46p6zeDxBh+yRhJ
 Y4aYl3D2yr2x3UGdklKPPayeh0zLMnfOTIXWi2Xk4ldd+O2wX4ohJRZI8ZqgGw/+3qnghIQM/
 fZZL1SS8IMhsSlypModdBomYJuRTPScWpJ4dHZIZHZAOKSi7Y028366RLJ1lUPzSMuljlMDsJ
 KSrna+ZyhuH9YDjvLEbQZwMB6fxz8k8z15n/D4xgigV09+NhTer7wCLie7wZcIxD8A0iimF1e
 maOqKlMZkjNds7yNkA8c21nZioM3X6Sd/KV00qW4B8U23rNezS02Tk+v+SAy/7WSVrg0wpoIq
 Uv7mDP7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 13 Dec 2016, Junio C Hamano wrote:

> Please have "else if" on the same line as "}" that closes the
> "if (...) {" in the same if/else if/else cascade.

Fixed. This affected quite a few more patches than just this one, and
added two more to this already large patch series.

Ciao,
Dscho
