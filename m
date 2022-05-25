Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C639C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 22:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236725AbiEYWUz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 18:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345388AbiEYWUC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 18:20:02 -0400
Received: from pb-sasl-trial20.pobox.com (pb-sasl-trial20.pobox.com [173.228.157.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAC7674F2
        for <git@vger.kernel.org>; Wed, 25 May 2022 15:20:01 -0700 (PDT)
Received: from pb-sasl-trial20.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id B69D72E1F6;
        Wed, 25 May 2022 18:19:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MGS3E7MSZTfU/zgZbLrpVPz8igY=; b=EkAdtS
        84CXLUPbyRcyil+18UyzBg06kvU0xyK36+TCehAjAcOBc53XK4482gwbDC28ycka
        BIi8UZt1vmKceLlfjEpYwBzjA4EwKn/LYCV34hAz9cBAgrG7uSDtYCW6FHh35yuG
        h9YuGCw6k7NapCwKuiFeZOuiXB74mBBnYGlBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dJMB+oHIax1Lxh3LSredfqXFGKqrof+9
        bW6Rs4zGzyhBAZzJfbYPstjtLwBFV1dkHzli+BvT8vXhlorfjRoICoJ2Z4Xivwc/
        +qsUJBhD7tyef24Q8yEiRTymNeXC/BOCYgdnew6rpqxUoSajK0IyY6m1vgiIpRji
        u3TQu1y7PCA=
Received: from pb-smtp21.sea.icgroup.com (pb-smtp21.pobox.com [10.110.30.21])
        by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id 98A612E1F3;
        Wed, 25 May 2022 18:19:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 38F61196FAD;
        Wed, 25 May 2022 18:19:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v4 3/9] Makefile: have "make pot" not "reset --hard"
References: <20220523012531.4505-1-worldhello.net@gmail.com>
        <20220523152128.26380-4-worldhello.net@gmail.com>
Date:   Wed, 25 May 2022 15:19:54 -0700
In-Reply-To: <20220523152128.26380-4-worldhello.net@gmail.com> (Jiang Xin's
        message of "Mon, 23 May 2022 23:21:22 +0800")
Message-ID: <xmqqzgj545md.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE095AE4-DC78-11EC-B422-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

>  ## Gettext tools cannot work with our own custom PRItime type, so
>  ## we replace PRItime with PRIuMAX.  We need to update this to
>  ## PRIdMAX if we switch to a signed type later.
> +$(LOCALIZED_C_GEN_PO): .build/pot/po/%.po: %
> +	$(call mkdir_p_parent_template)
> +	$(QUIET_XGETTEXT) \
> +	    if grep -q PRItime $<; then \
> +		(\
> +			sed -e 's|PRItime|PRIuMAX|g' <$< \
> +				>.build/pot/po/$< && \
> +			cd .build/pot/po && \
> +			$(XGETTEXT) --omit-header \
> +				-o $(@:.build/pot/po/%=%) \
> +				$(XGETTEXT_FLAGS_C) $< && \
> +			rm $<; \
> +		); \
> +	    else \
> +		$(XGETTEXT) --omit-header \
> +			-o $@ $(XGETTEXT_FLAGS_C) $<; \
> +	    fi

My build (a random hack on top of 'seen') is getting this message

$ make
Makefile:2755: target '.build/pot/po/archive.c.po' given more than once in the same rule
Makefile:2755: target '.build/pot/po/archive.c.po' given more than once in the same rule
    SUBDIR git-gui

I haven't changed archive.c in particular relative to 'seen', and
.build/pot/po directory seems to be empty (understandably---I have
not run the po/ stuff myself lately).

