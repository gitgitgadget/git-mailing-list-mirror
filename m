Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D30E0203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 16:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757226AbcGZQxk (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 12:53:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58476 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757170AbcGZQxj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 12:53:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CCFC92E71F;
	Tue, 26 Jul 2016 12:53:37 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uNQNMPL0jqoG2k8lad3VDtNPqJ8=; b=JJ1zvI
	0IcuBrKE5hkwJYedWs+EEeJKrNkQU/GHdMK+93ZfDFyN7LJl8ilvLLkAX7kcmuKt
	BB5yMiIuXHTlHvO0EoKs8oWPOEMzfSLPRoyhW4eqUhNL+5wVxGxUMGHWkH4zMhOu
	XAu+yvvwvvz56ZShE/T1njkkQvd8ApYt2aFaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AEX+NfYqvsaHgmllZhrzL67G0Pf0dnC/
	eDQr47qUIBdn6wbhvlVmyWEVggOBf7Avg0ykrcg8fhCJ+Mlj+jyUP29eNIwmS3s2
	ueNkQzz4kQt5Gm21h51/eMCVzR2nmo3rdn3yGWPTbP060+4MkzzBHJlxBbDbvGcO
	Wcs4dckbhzU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C4EC62E71E;
	Tue, 26 Jul 2016 12:53:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4FD7A2E71D;
	Tue, 26 Jul 2016 12:53:37 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Vasco Almeida <vascomalmeida@sapo.pt>
Cc:	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] t5510: skip tests under GETTEXT_POISON build
References: <1469439068-2724-1-git-send-email-vascomalmeida@sapo.pt>
	<1469537934-16676-1-git-send-email-vascomalmeida@sapo.pt>
Date:	Tue, 26 Jul 2016 09:53:35 -0700
In-Reply-To: <1469537934-16676-1-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Tue, 26 Jul 2016 12:58:54 +0000")
Message-ID: <xmqq4m7c2ve8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F3A4C22-5351-11E6-ACEF-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> Skip tests when running under GETTEXT_POISON build and run them with
> C_LOCALE_OUTPUT prerequisite.
>
> These tests are irrelevant under GETTEXT_POISON because they test text
> output alignment which GETTEXT_POISON turns useless.
>
> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> ---
>  t/t5510-fetch.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 6bd4853..668c54b 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -688,7 +688,7 @@ test_expect_success 'fetching with auto-gc does not lock up' '
>  	)
>  '
>  
> -test_expect_success 'fetch aligned output' '
> +test_expect_success C_LOCALE_OUTPUT 'fetch aligned output' '
>  	git clone . full-output &&
>  	test_commit looooooooooooong-tag &&
>  	(
> @@ -703,7 +703,7 @@ test_expect_success 'fetch aligned output' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_success 'fetch compact output' '
> +test_expect_success C_LOCALE_OUTPUT 'fetch compact output' '
>  	git clone . compact &&
>  	test_commit extraaa &&
>  	(

Makes sense, will queue.

This is a tangent, but it may make sense for us to start thinking
about retiring one of the two prerequisites, GETTEXT_POISON and
C_LOCALE_OUTPUT.  Back when 5e9637c6 (i18n: add infrastructure for
translating Git with gettext, 2011-11-18) introduced the former,
test_have_prereq did not support a negated prerequisite, so the
commit added GETTEXT_POISON prerequisite; if we had the modern
test_have_prereq, we would have written

    test_expect_success GETTEXT_POISON '...'

that appear in t0205 as

    test_expect_success !C_LOCALE_OUTPUT '...'

I would think.
