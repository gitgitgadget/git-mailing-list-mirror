Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C2D61F859
	for <e@80x24.org>; Mon, 15 Aug 2016 06:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbcHOGdt (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 02:33:49 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:38709 "EHLO
	mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbcHOGds (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 02:33:48 -0400
Received: by mail-it0-f46.google.com with SMTP id n128so973884ith.1
        for <git@vger.kernel.org>; Sun, 14 Aug 2016 23:33:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AfPUKTGnqsGMQ4FUAnlnG8a9fuJQ18rxFaFbq2xWjZ4=;
        b=fQAclqouvxx8iVGOFAPpOTSouFbGf2HBfpx9XsX95XFsKgPDEcna/n5EX/4Hx9hvt/
         XLeo3E7TVlhudJYZ3WwII0qP1uvF2x8OT9Ijdnos/BdfwnH2xVmKai/UhJGZ3BqaB7ca
         ugYUuuBS3KIZ8wgRvIH46Rb0jnMSESAH1bAyUaaVj5xve7ErxZ52ZHveXW2FG8kCmLDo
         /caVkOWApK2QdwuxKItG+plCuRwGQ0pksDategNA9x7ghep7F/sHhRkfpSBKhHvfPC6K
         wsT14NOSZM1fAAlLAS7C+NUAHlOKcJrAZrNb2dr6jQRNhfA78WdidOWVS4gmMDVqIysP
         gz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AfPUKTGnqsGMQ4FUAnlnG8a9fuJQ18rxFaFbq2xWjZ4=;
        b=V+9x5JgE5HnPOq5dcG8vF3hJX/k0TX0+UL4tnqlXeSPNKj73FqBDovleF9YLn6gnbf
         QD5neuwhHsOU1rlhdKSgue/ROkwDLx/vV0G5ABjUpEJVG9wBtsRNe62QclzK9R+GF3KW
         A9J9MvIXnsnrTSmw+0W1OuikODQhx7+8U2N9EYpcbNSVF0XbuwSsXzFx488l5L2P2qRd
         5GRSsYm/s2lWUASzlVDfteyBne7oQzdBUC68SyXRDRS62lPKvb0K34d9O5RkujtlyaNC
         Go0MPo1VzP1WCkDKynwjPoqQX5jjjPc9duArTIkPwAKi5naqn9/YG+WWNR0GJrhavKtF
         Fh4A==
X-Gm-Message-State: AEkoouumq/HiJhExnCk+L6Vg/2URoJDmlva7X7ikjYFeUg5t099vPs3NlIaKokkUSR8de1rjcHAx3wjsW1nGF5VY
X-Received: by 10.36.92.206 with SMTP id q197mr12531065itb.46.1471242827287;
 Sun, 14 Aug 2016 23:33:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Sun, 14 Aug 2016 23:33:46 -0700 (PDT)
In-Reply-To: <20160813085904.lykoihh4v2lf4yuj@sigill.intra.peff.net>
References: <cover.1470259583.git.mhagger@alum.mit.edu> <7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
 <20160804075631.jakbi5dbsbxsqcpr@sigill.intra.peff.net> <e4232cba-aae8-8426-c730-7914bb750363@alum.mit.edu>
 <20160813085904.lykoihh4v2lf4yuj@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Sun, 14 Aug 2016 23:33:46 -0700
Message-ID: <CAGZ79kaMSkRfkBng_Epq+2T_q--VkKQ6-m=M_jPkzeYcxuDKWA@mail.gmail.com>
Subject: Re: [PATCH 8/8] diff: improve positioning of add/delete blocks in diffs
To:	Jeff King <peff@peff.net>
Cc:	Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

> Is there a case where the compaction heuristic produces a better result
> than this indent heuristic? AFAICT, you have not found one, and I'd be
> surprised if there is one, because this _seems_ like a superset
> generally. I suppose there is always the possibility that the empirical
> knobs behave badly in some particular case that the compaction heuristic
> just happens to get right, but it should be quite rare.

This is how I understand it as well. I would not mind to remove the
blank-line-suggested-split heuristic.

Maybe we can enable Michaels heuristic with the same
config/command line flag, i.e. "the flag changes its algorithm"?
Then people, who read the prior announcement don't have to
do anything, while we keep it as an experimental feature for the
next release and auto-on it after that?

We could also be a bit more aggressive and auto-on the new
heuristic with the old heuristic removed and we only have an
(undocumented) emergency-off knob for one or two releases?

Thanks,
Stefan
