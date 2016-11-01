Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6962020229
	for <e@80x24.org>; Tue,  1 Nov 2016 17:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753311AbcKARUc (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 13:20:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61218 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751613AbcKARUa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 13:20:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A71949AFC;
        Tue,  1 Nov 2016 13:20:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tB5OdN4jPhFIX9513VlyHsT3AH8=; b=GGE64r
        Sr3lDKXGL0rhlZNRbpaMennoSE7PAGDbmAZtEuo30zmWvmgyeXOLMOAGHYQLIPZl
        WsFLe5oYAipIKn/SGB6DNZexbdBVavptlwkdgLZ0ekqhyuQV/iZZPJaFJlgOP8XB
        dc7Aceim0Rvr1WZhzUW6AV/eybhwf3kV+TbsU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FYIeJ0S7hkiAxDXpQhicqkDfxsTgUo+C
        +E7jQaToQwdLbVKXU828wx1kd8gh5GwJuOCTctQjr4U2z6Yl8FpyaCL3iZdKzU4C
        Li7qnVTFa+FpBRFAOLhdp1Seex6r7+ga2m+tBGgNgsJT9xLYN/FoFU1CcKulENyv
        jKyTSs0OxvY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9270749AFB;
        Tue,  1 Nov 2016 13:20:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D97B49AFA;
        Tue,  1 Nov 2016 13:20:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] submodules: add helper functions to determine presence of submodules
References: <20161027223834.35312-1-bmwill@google.com>
        <1477953496-103596-1-git-send-email-bmwill@google.com>
        <1477953496-103596-2-git-send-email-bmwill@google.com>
        <CAGZ79kamzSPyM65k9ugS0dAJCfGnGvk3m2p+XtCEozCvoZ5+OA@mail.gmail.com>
Date:   Tue, 01 Nov 2016 10:20:27 -0700
In-Reply-To: <CAGZ79kamzSPyM65k9ugS0dAJCfGnGvk3m2p+XtCEozCvoZ5+OA@mail.gmail.com>
        (Stefan Beller's message of "Mon, 31 Oct 2016 16:34:30 -0700")
Message-ID: <xmqq7f8nqfqc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C6AE742-A057-11E6-9072-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

Overall the suggestions from you in this review is good and please
consider anything I did not mention I agree with you.  Thanks.

>> +extern int is_submodule_initialized(const char *path);
>> +extern int is_submodule_checked_out(const char *path);
>
> no need to put extern for function names. (no other functions in this
> header are extern. so local consistency maybe? I'd also claim that
> all other extern functions in headers ought to be declared without
> being extern)

Maybe I am old fashioned, but I'd feel better to see these with
explicit "extern" in front (check the older header files like
cache.h when you are in doubt what the project convention has been).
