Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A54E11F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 16:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933281AbcI1Q7O (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 12:59:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58393 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932771AbcI1Q7M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 12:59:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8103B40040;
        Wed, 28 Sep 2016 12:59:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8O2wKWLSmafdilh2lkSPmZptpqA=; b=YoAcX+
        z7dYsCAFBH8WZxreabz4nR/FvNnmkuhD4nCdmcl+AxJpy8xzAGsiXzgtzfLkJZm7
        5S2Z5j9u0l9hJX/2kfIpvtHyrPNMvjt6YO1QhgHSMtiLNkOVVWpirLC+fHnyPk9n
        tApNik5ug2D4P/qEpQr/AbmC7k2EdkCk4M+UI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YvDNl+oSYB3CIg2nVQjdespajHJvEK30
        U22NRRff2gH3/TsaqbLHr5qksn9WOzWRm9RZWdtWsGla6wv4tGFj15QldqxoGC9h
        dmazNf5M+GMRKc+LxAj7F0YU9ZgyN4VZlOCai8hv8gdtn8w0g4JcOgxtcrP/ur/t
        dViok0UU5J8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 79D1D4003F;
        Wed, 28 Sep 2016 12:59:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F3DAF4003E;
        Wed, 28 Sep 2016 12:59:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 01/11] i18n: add--interactive: mark strings for translation
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
        <1472646690-9699-2-git-send-email-vascomalmeida@sapo.pt>
        <xmqqr387y4le.fsf@gitster.mtv.corp.google.com>
        <1475066620.3257.12.camel@sapo.pt>
Date:   Wed, 28 Sep 2016 09:59:09 -0700
In-Reply-To: <1475066620.3257.12.camel@sapo.pt> (Vasco Almeida's message of
        "Wed, 28 Sep 2016 12:43:40 +0000")
Message-ID: <xmqq4m50klk2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E0976A68-859C-11E6-A14F-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> As far as I understand, %12s means that the argument printed will have
> a minimum length of 12 columns. So if the translation of 'stage' is
> longer than 12 it will be printed fully no matter what. Though in that
> case, the header will not be align correctly anymore:

Exactly.  That was where my suggestion comes from.  In such a case
you may want to raise these numbers so that the fixed part
(i.e. header that you are letting the translators insert their
version of these words) would fit.

As Duy points out in his response to your message, that widening
further needs to take into account how many display columns each
translated words and phrases occupies, not just its byte length.
