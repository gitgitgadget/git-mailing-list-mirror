Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6B0C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 22:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240148AbiEYWYV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 18:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiEYWYU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 18:24:20 -0400
Received: from pb-sasl-trial20.pobox.com (pb-sasl-trial20.pobox.com [173.228.157.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EA7BA99C
        for <git@vger.kernel.org>; Wed, 25 May 2022 15:24:19 -0700 (PDT)
Received: from pb-sasl-trial20.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id 8CAA02E208;
        Wed, 25 May 2022 18:24:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x8ElNpRoisaXp7aCjuyr7ZnsZNM=; b=tUjgv9
        92POSe4vZp99171/GyR9acSKdQgOCZHSVL6yhNzY9ZCCqjeM/yFVMPKisAxhNGvL
        yROXi4JxB0u74v8sYqCmerBoWyzuBnVR6L3B5Cb3iFoh4/IgvlDVkfLQZ4ZGoUCi
        UsTA+blqRF+r5u1PTseaBH4aOklhByCdDUD/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T1Cb7g/kLi3ZvckhFeLEXSFAXOhuR2pk
        YajUdh4kEFFdQrc8OopbwlrMXzjduOx9Fu6XmqnN9gjgSkDIY9g6W9HE04NbOKwU
        ybkTv20xX3QohEWVEIki4afbAKmlDpBXfrN9ltxfKgEjJEr0zKTyrswCWMYWzCY9
        jSVY7XIOmMw=
Received: from pb-smtp20.sea.icgroup.com (pb-smtp20.pobox.com [10.110.30.20])
        by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id 71A972E207;
        Wed, 25 May 2022 18:24:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 595A618B383;
        Wed, 25 May 2022 18:24:13 -0400 (EDT)
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
        <xmqqzgj545md.fsf@gitster.g>
Date:   Wed, 25 May 2022 15:24:12 -0700
In-Reply-To: <xmqqzgj545md.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        25 May 2022 15:19:54 -0700")
Message-ID: <xmqqtu9d45f7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67E52F4E-DC79-11EC-99C6-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jiang Xin <worldhello.net@gmail.com> writes:
>
>>  ## Gettext tools cannot work with our own custom PRItime type, so
>>  ## we replace PRItime with PRIuMAX.  We need to update this to
>>  ## PRIdMAX if we switch to a signed type later.
>> +$(LOCALIZED_C_GEN_PO): .build/pot/po/%.po: %
>> +	$(call mkdir_p_parent_template)
>> +	$(QUIET_XGETTEXT) \
>> +	    if grep -q PRItime $<; then \
>> +		(\
>> +			sed -e 's|PRItime|PRIuMAX|g' <$< \
>> +				>.build/pot/po/$< && \
>> +			cd .build/pot/po && \
>> +			$(XGETTEXT) --omit-header \
>> +				-o $(@:.build/pot/po/%=%) \
>> +				$(XGETTEXT_FLAGS_C) $< && \
>> +			rm $<; \
>> +		); \
>> +	    else \
>> +		$(XGETTEXT) --omit-header \
>> +			-o $@ $(XGETTEXT_FLAGS_C) $<; \
>> +	    fi
>
> My build (a random hack on top of 'seen') is getting this message
>
> $ make
> Makefile:2755: target '.build/pot/po/archive.c.po' given more than once in the same rule
> Makefile:2755: target '.build/pot/po/archive.c.po' given more than once in the same rule
>     SUBDIR git-gui
>
> I haven't changed archive.c in particular relative to 'seen', and
> .build/pot/po directory seems to be empty (understandably---I have
> not run the po/ stuff myself lately).

Well, I lied.  I am doing the random hack while in a conflicted
state coming from an interrupted merge that had conflicts in the
archive.c.

Perhaps we need some logic to dedup "ls-files" output?
