Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,UPPERCASE_50_75 shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1C3020288
	for <e@80x24.org>; Fri, 21 Jul 2017 14:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753111AbdGUOjN (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 10:39:13 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:55799 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754028AbdGUOjM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 10:39:12 -0400
Received: from [172.31.17.246] (unknown [103.90.76.125])
        (Authenticated sender: jn.avila)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 746CE13F760;
        Fri, 21 Jul 2017 16:39:02 +0200 (CEST)
Subject: Re: [PATCH] PRItime: wrap PRItime for better l10n compatibility
To:     Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <worldhello.net@gmail.com>
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr>
 <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com>
 <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com>
 <CANYiYbEcMrriaor9OT4c2qtfh9Ja5NJ9KBSxa3XhPAuoN0t42A@mail.gmail.com>
 <xmqq60epfy27.fsf@gitster.mtv.corp.google.com>
 <CANYiYbFROuyXso2ZKuJWDp4cSwpBu=bNAbC-yZtEyDwkbUcAhQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1707191456010.4193@virtualbox>
 <xmqq8tjkm3ly.fsf@gitster.mtv.corp.google.com>
 <xmqqo9sfkm32.fsf@gitster.mtv.corp.google.com>
 <xmqqfudrkkci.fsf@gitster.mtv.corp.google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
Message-ID: <f00aeb42-75ad-d5ec-b4fb-c80b48827db4@free.fr>
Date:   Fri, 21 Jul 2017 16:38:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqfudrkkci.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 20/07/2017 à 20:57, Junio C Hamano a écrit :
>
> +	git diff --quiet HEAD && git diff --quiet --cached
> +
> +	@for s in $(LOCALIZED_C) $(LOCALIZED_SH) $(LOCALIZED_PERL); \

Does PRIuMAX make sense for perl and sh files?

> +	do \
> +		sed -e 's|PRItime|PRIuMAX|g' <"$$s" >"$$s+" && \
> +		cat "$$s+" >"$$s" && rm "$$s+"; \
> +	done
> +
>  	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C)
>  	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_SH) \
>  		$(LOCALIZED_SH)
>  	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_PERL) \
>  		$(LOCALIZED_PERL)
> +
> +	git reset --hard
>  	mv $@+ $@
>  
>  .PHONY: pot


