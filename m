Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59B80208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 17:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756382AbdHYRpH (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 13:45:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54926 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756115AbdHYRpG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 13:45:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E122295E68;
        Fri, 25 Aug 2017 13:45:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=whFvQIdpEza0YiKdrli9pkA9+o4=; b=noNVwY
        jmHfhWA5HTDpA5nVWshNedU+KJModBTlQu/8gjL0/GU0oHEV3Va7kLW1+07tBkA2
        qCYBpjOaSE4gYUnSWiVfUbr7XsyXIlzTLF5VXuh9bQIU0H4l5gdZDrvUlGAgycWx
        uu06vaIfUis7EKhidiLHT923/3Y+d7Bj/LV/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DYveDmmiaNu069rgLCRNrY4Q2NhAnhoi
        oSYx1lU8FzrSfPrJk/JWL5El8jrzjEUjW4nppSimyrjwcdkUt0VSoCTsMFE1b2fE
        DJaKf8bZF/rJ5xa/lCKc+vpJRuRd8uwba6jkWLM0h0U0ZsFVCNawygBqM7qQURmU
        jLVafYDi5uE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D623195E66;
        Fri, 25 Aug 2017 13:45:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3BC8295E65;
        Fri, 25 Aug 2017 13:45:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        sbeller@google.com, jonathantanmy@google.com
Subject: Re: [RFC 3/7] protocol: tell server that the client understands v2
References: <20170824225328.8174-1-bmwill@google.com>
        <20170824225328.8174-4-bmwill@google.com>
Date:   Fri, 25 Aug 2017 10:45:04 -0700
In-Reply-To: <20170824225328.8174-4-bmwill@google.com> (Brandon Williams's
        message of "Thu, 24 Aug 2017 15:53:24 -0700")
Message-ID: <xmqqtw0vsfrz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20F1B116-89BD-11E7-80CB-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> +		/* If using a new version put that stuff here after a second null byte */
> +		strbuf_addch(&request, '\0');
> +		strbuf_addf(&request, "version=%d%c", 2, '\0');
> +		/* subsequent supported versions can also be added */
> +		strbuf_addf(&request, "version=%d%c", 3, '\0');

Isn't this last one meant only as a comment?
