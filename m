Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1334FC43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9CC2469F
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfLMU72 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 15:59:28 -0500
Received: from 195-159-176-226.customer.powertech.no ([195.159.176.226]:36360
        "EHLO blaine.gmane.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfLMU72 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 15:59:28 -0500
Received: from list by blaine.gmane.org with local (Exim 4.89)
        (envelope-from <gcvg-git-3@m.gmane.org>)
        id 1ifs1w-0011vv-9u
        for git@vger.kernel.org; Fri, 13 Dec 2019 21:59:20 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Achim Gratz <Stromeko@nexgo.de>
Subject: Numbers with specific base (was: [PATCH] userdiff: remove empty subexpression from elixir regex)
Date:   Fri, 13 Dec 2019 21:59:13 +0100
Organization: Linux Private Site
Message-ID: <87tv64ymam.fsf@Rainer.invalid>
References: <20191213173902.71541-1-emaste@FreeBSD.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Cancel-Lock: sha1:NMfH4hhzIz1/+6BeAt7ZtkKj78U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Nothing to do with the patch from Ed, but the regex following his
correction matches a lot of things that decidedly are not "Numbers with
specific bases" as it claims to do in the comment.

Ed Maste writes:
>  PATTERNS("elixir",
>  	 "^[ \t]*((def(macro|module|impl|protocol|p)?|test)[ \t].*)$",
>  	 /* Atoms, names, and module attributes */
> -	 "|[@:]?[a-zA-Z0-9@_?!]+"
> +	 "[@:]?[a-zA-Z0-9@_?!]+"
>  	 /* Numbers with specific base */
>  	 "|[-+]?0[xob][0-9a-fA-F]+"

Here, things like "+0bad" would match as a base 2 number, which doesn't
seem right.  If it's intended to match that broadly, I'd have expected a
comment to that effect.  Maybe something like

"|[-+]?0b[01]+|[-+]?0o[0-7]+|[-+]?0x[0-9a-fA-F]+"

or (if the resulting group is not a problem someplace else)

"|[-+]?0(b[01]+|o[0-7]+|x[0-9a-fA-F]+)"

to more specifically match only what the comment says?



Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

SD adaptation for Waldorf rackAttack V1.04R1:
http://Synth.Stromeko.net/Downloads.html#WaldorfSDada

