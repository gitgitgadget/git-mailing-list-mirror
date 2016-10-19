Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F85920986
	for <e@80x24.org>; Wed, 19 Oct 2016 18:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944266AbcJSSO0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 14:14:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52998 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S944216AbcJSSOY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 14:14:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5BFBA46F2E;
        Wed, 19 Oct 2016 14:14:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qOIdK2iowVv1LmaB5Vsq54Yhg54=; b=dmOQJa
        G13gH1PUyC9ZGwRaSg/fl6+OiQJ5AREkYkzZYajpq2mif/Yw934lYPfJ8g29Ar8L
        /55nqmiQl9xpG3eqfG+oYiMDhvP+J6zVUGIV7K2iAAVkrIANRQ9H6ZGBL+dHGrNu
        MJXs+g+ANHok05+lCRLlzBkhsKktq905wB/qU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WvYT3vclu+eHNFCHMY2HQc8FDP2SVGQ6
        n8S5ahOdPVn1wLTquHtblKqScKkcJLVL04mmI7cJld6O9gDCsrY17XotG7N8nby1
        h0qYIjEmlAg9r8XKirbqoWpj/dD9LqIeQLfQfJbK/0+/lKdwigzEd6iuM1bRJuFB
        2LD88Xv+W9Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5471046F2C;
        Wed, 19 Oct 2016 14:14:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C9AD446F2B;
        Wed, 19 Oct 2016 14:14:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        Jakub =?utf-8?Q?Na?= =?utf-8?Q?r=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v4 01/14] i18n: add--interactive: mark strings for translation
References: <20161010125449.7929-1-vascomalmeida@sapo.pt>
        <20161005172110.30801-1-vascomalmeida@sapo.pt>
        <20161010125449.7929-2-vascomalmeida@sapo.pt>
Date:   Wed, 19 Oct 2016 11:14:14 -0700
In-Reply-To: <20161010125449.7929-2-vascomalmeida@sapo.pt> (Vasco Almeida's
        message of "Mon, 10 Oct 2016 12:54:36 +0000")
Message-ID: <xmqqy41kkxzd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8F29A4E-9627-11E6-AA34-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

>  	} else {
> -		print "No untracked files.\n";
> +		print __("No untracked files.\n");
>  	}

Not a big deal, but this makes me wonder if we want to do this
instead

		print __("No untracked files.") . "\n";

so that translators do not have to remember to keep the final LF.

It seems there are some more hits of strings that end with "\n"
inside __(...) in this patch, so it probably is OK.
