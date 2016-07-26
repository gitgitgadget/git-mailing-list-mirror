Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8621203E4
	for <e@80x24.org>; Tue, 26 Jul 2016 21:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161040AbcGZVSS (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 17:18:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57746 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161030AbcGZVSR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 17:18:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F13A3073D;
	Tue, 26 Jul 2016 17:18:15 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bh/S9omX2syHLXgpR+b8cIDBkVs=; b=Mvgv4z
	VohtosnqCP0mkjav7Z/50il2AuYT2D2e/ii5xEOQ0oSOyjhtZ0tAUBKXVj/ZiDmt
	t5Uzlavijyw52CyFk/UxE/o+/DhXXQoyOzl1JyPyZjqinBowuQn37ge4C8baACQA
	sET8vUftR39seAvqwnnCCgRacXfonZahutDjw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E+GeHJQlp7PD2UvWaQI5MFMIOZub9+OZ
	GhMYZkpq9ME7TsTIjnAmKLrmHND3/VK2pP9yWejE5THq6uxRs51EzuDYYHYX3DjQ
	u+dmiDLamNPXl4OQqoquX+WefRBGYMSBCyyHMQ4fFv4UtFeFtauVhQT9Y6H9F3lU
	sFAJSrX4HIs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6712C3073C;
	Tue, 26 Jul 2016 17:18:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D36113073B;
	Tue, 26 Jul 2016 17:18:14 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v8 00/41] libify apply and use lib in am, part 2
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
Date:	Tue, 26 Jul 2016 14:18:12 -0700
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org> (Christian
	Couder's message of "Mon, 27 Jun 2016 20:23:48 +0200")
Message-ID: <xmqqzip4xfmz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7704DD22-5376-11E6-9B7B-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Sorry if this patch series is still long. I can split it into two or
> more series if it is prefered.
> ...
> Christian Couder (41):
>   apply: make some names more specific
>   apply: move 'struct apply_state' to apply.h
>   builtin/apply: make apply_patch() return -1 or -128 instead of
>     die()ing
>   builtin/apply: read_patch_file() return -1 instead of die()ing
>   builtin/apply: make find_header() return -128 instead of die()ing
>   builtin/apply: make parse_chunk() return a negative integer on error
>   builtin/apply: make parse_single_patch() return -1 on error
>   builtin/apply: make parse_whitespace_option() return -1 instead of
>     die()ing
>   builtin/apply: make parse_ignorewhitespace_option() return -1 instead
>     of die()ing
>   builtin/apply: move init_apply_state() to apply.c
>   apply: make init_apply_state() return -1 instead of exit()ing
>   builtin/apply: make check_apply_state() return -1 instead of die()ing
>   builtin/apply: move check_apply_state() to apply.c
>   builtin/apply: make apply_all_patches() return 128 or 1 on error
>   builtin/apply: make parse_traditional_patch() return -1 on error
>   builtin/apply: make gitdiff_*() return 1 at end of header
>   builtin/apply: make gitdiff_*() return -1 on error
>   builtin/apply: change die_on_unsafe_path() to check_unsafe_path()
>   builtin/apply: make build_fake_ancestor() return -1 on error
>   builtin/apply: make remove_file() return -1 on error
>   builtin/apply: make add_conflicted_stages_file() return -1 on error
>   builtin/apply: make add_index_file() return -1 on error
>   builtin/apply: make create_file() return -1 on error
>   builtin/apply: make write_out_one_result() return -1 on error
>   builtin/apply: make write_out_results() return -1 on error
>   builtin/apply: make try_create_file() return -1 on error
>   builtin/apply: make create_one_file() return -1 on error
>   builtin/apply: rename option parsing functions
>   apply: rename and move opt constants to apply.h
>   Move libified code from builtin/apply.c to apply.{c,h}
>   apply: make some parsing functions static again
>   environment: add set_index_file()
>   write_or_die: use warning() instead of fprintf(stderr, ...)
>   apply: add 'be_silent' variable to 'struct apply_state'
>   apply: make 'be_silent' incompatible with 'apply_verbosely'
>   apply: don't print on stdout when be_silent is set
>   usage: add set_warn_routine()
>   usage: add get_error_routine() and get_warn_routine()
>   apply: change error_routine when be_silent is set
>   builtin/am: use apply api in run_apply()
>   apply: use error_errno() where possible

I finally found time to get back to finish reviewing this.

The early part up to and including "apply: make some parsing
functions static again" looked good and we could treat them as a
continuation of the earlier cc/apply-introduce-state topic, which
has been merged to the 'master' already.

I got an impression that the patches in the remainder of the series
were not as polished as the earlier ones, except for the last one,
which should be reordered and be part of the early preparation step
if possible.

Thanks.
