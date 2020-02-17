Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2932EC3B1BF
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 00:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB19D22522
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 00:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WVxungPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgBQAKE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 19:10:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60259 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgBQAKE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 19:10:04 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D621F58331;
        Sun, 16 Feb 2020 19:10:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2KZh1vcBA2cTlXxN0oBJIQB18iA=; b=WVxung
        PAz6ck/63kSIpYi0hlQHpDs9DIaumHvrTNFUbifT58FrjrrNj+rG0h6tLfjuQseG
        /zON/jdWImgLpKNZ++X8ft3bq/ONpicx7JYkNFYJOwhJGpqY4P/Kx68CJ7rekRRD
        NYxYb+7CyfxkseXRp6FCs54LowTyZ6tb1j524=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c9hDBDyWoMbvboeajLQSNGfTKejDv2Ey
        U5wtRtOdX9D53vY34+3mfWjDP1+qExjt8KxnJ4WeFOGp+49T5uSviDf3WCibeo9x
        HyR/AYYI7VJYcI10QF6dHpAhs+BKyLog4erJKHE78/yHcd3LCLhnj6oQLpBhXjF8
        XumsnBbo9vc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE94A5832F;
        Sun, 16 Feb 2020 19:10:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B841F5832E;
        Sun, 16 Feb 2020 19:09:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v2 0/2] [RFC][Outreachy] advice: refactor advise API
References: <pull.548.git.1581311049547.gitgitgadget@gmail.com>
        <pull.548.v2.git.1581889150.gitgitgadget@gmail.com>
Date:   Sun, 16 Feb 2020 16:09:58 -0800
In-Reply-To: <pull.548.v2.git.1581889150.gitgitgadget@gmail.com> (Heba Waly
        via GitGitGadget's message of "Sun, 16 Feb 2020 21:39:07 +0000")
Message-ID: <xmqqftfam5ux.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D62F71AA-5119-11EA-956B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Main changes in V2: 1- Rename advise_ng to advise_if_enabled. 2- Add a new
> advise_enabled() helper. 3- Add a list of config variables names to replace
> advice_config[] (used by list_config_advices()). 4- Send an enum parameter
> to the new advise helpers instead of strings. 5- Extract vadvise() from
> advise() and advise_if enabled().


Nice.  There is not much point for me to correct mistakes in the
title of the cover letter, but anyway... I think these changes are
not "refactoring" the API, but these are enhancing, extending or
even revamping the API.  

> To introduce a new advice message, the caller needs to:
>
>  * Add a new_advice_type to 'enum advice_type'
>  * Come up with a new config variable name and add this name to 
>    advice_config_keys[]
>  * Call advise_if_enabled(new_advice_type, "advice message to be printed")
>  * Or call advice_enabled(new_advice_type) first and then follow is by
>    advice("advice message to be printed") as explained earlier.
>  * Add the new config variable to Documentation/config/advice.txt

And I see that now you are going all the way to discard the
string-based keys to enumeration, I think this deserves to be called
"revamp advise API".

> In the future, we can investigate generating the documentation from the list
> of config variables or vice versa to make introducing a new advice much
> easier, but this approach will do it for now.

Yup.  One step at a time.
