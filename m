Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B687B20A40
	for <e@80x24.org>; Mon, 27 Nov 2017 01:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752268AbdK0BV3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 20:21:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58932 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752222AbdK0BV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 20:21:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E225BA3CA;
        Sun, 26 Nov 2017 20:21:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eRavyuc6hCaLtodr+IGQWJn7Lak=; b=WTSyoJ
        CdN+kYuQvc3bPd+OC7La2/P2csgctRtagkaZIF+yxP3gjY4mrk3leXtk1TRxSoMG
        98wirBNQj8uVtq/In7nBJFjYBnsO+Log8nYbaRSdZ5R0CoKAgKipYKTBTQ1BO4C/
        JGOZ1DACf6vGWfljiGNbNuO3fT6L9v2o4mZCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oRTsZakJ4rhuqGMvn3vsKaOH3FOrm1sy
        Xy+/mMO9tYA/pYPgWpB3uBOtwoGQ5akegt1JcGo/kIQMAa6VgA1C4TLQK3rxrASM
        UgVEV+/jf8VS1hZEhvGS2Malz2kgZgEsJdOvq43INVfg6vLwoj9qSaYJkNDAx5mc
        hXT9M2E6g/k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34D6CBA3C9;
        Sun, 26 Nov 2017 20:21:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A5A3CBA3C5;
        Sun, 26 Nov 2017 20:21:27 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     gennady.kupava@gmail.com
Cc:     git@vger.kernel.org, Gennady Kupava <gkupava@bloomberg.net>
Subject: Re: [PATCH 2/2] trace: improve performance while category is disabled
References: <xmqqvai5lf4a.fsf@gitster.mtv.corp.google.com>
        <20171126201119.24313-1-gennady.kupava@gmail.com>
        <20171126201119.24313-2-gennady.kupava@gmail.com>
Date:   Mon, 27 Nov 2017 10:21:26 +0900
In-Reply-To: <20171126201119.24313-2-gennady.kupava@gmail.com> (gennady
        kupava's message of "Sun, 26 Nov 2017 20:11:19 +0000")
Message-ID: <xmqqpo84fre1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A901380-D311-11E7-AE87-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gennady.kupava@gmail.com writes:

> From: Gennady Kupava <gkupava@bloomberg.net>
>
> - Do the check if the trace key is enabled sooner in call chain.
> - Move just enough code from trace.c into trace.h header so all code
>   necessary to determine that trace is disabled could be inlined to
>   calling functions.

Makes sense.  Will queue.

Thanks.

> +inline int trace_pass_fl(struct trace_key *key) {
> +	return key->fd || !key->initialized;
> +}

;-)
