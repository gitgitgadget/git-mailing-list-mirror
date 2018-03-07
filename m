Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BF0B1F404
	for <e@80x24.org>; Wed,  7 Mar 2018 19:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965858AbeCGTtc (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 14:49:32 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50478 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965718AbeCGTt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 14:49:29 -0500
Received: by mail-wm0-f67.google.com with SMTP id w128so7111356wmw.0
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 11:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gsgPVy4E+ef3umE3P+Pun0TEuiz+NekKzBtwc8LlNv4=;
        b=FGzl/uizoAyQlxmrDpFM9L6Ns99YqyYmbgpW2LMqigSOKwzraH2CgjeZVrA2HBhlhd
         mprq+NvN6r+mN3hrea6CKNnx7+b04SF0hKKWOhrnm0rUJOieGcNsJIALPo0m3ysf4zXV
         /i3a3Wp9o1zqAXmW1MjRmoee2z18AOLCXyex2jB9MghcU4ENcDFgAVio1Sfkm50WvXdt
         iNkiHruuVH+w9afsrLhcHQlB5cK0FDZdep0UoHmoWt9sdbO7ZX+oPCiqUZWNDv1z0Hty
         1UDB/jLRjMQ0EO4I8l9Ogzk6Zekd+wEeUX3zYttbd/givZ/LcEGfPlqSyrT0WeJpnmO8
         LOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gsgPVy4E+ef3umE3P+Pun0TEuiz+NekKzBtwc8LlNv4=;
        b=YteG5xchH/kjQiYyGsOouEtEIPSeljrqPvnLuakGKArnVzafsot3XiYJ8/dcfO45UZ
         WO5UnVWQBcpWuX72tiVk/bvvSPCew2ix18R+p2FuoR0b+I3kVGo3otxY1v9ZjVm9EL8/
         YcNnnrH5Dzt0XESTfRsLxPNrcJMgtwMoHny2bHum4eHTVS4Ujq6GBzK1grv6RayZhikS
         1dnJvjG4y0v+dlo5XQ5E903s/menRyXVo5UwJL8dIKopUHSOeuO5h6dQfwQ45hk57l4h
         IEHLNRFh3FYMDUtBcrvAh8FMjvDtYPL/X72NwLwC+slwOu8TbcCgWH0pw5AOzI0Hlgra
         gqsw==
X-Gm-Message-State: AElRT7EKdtA8b8w4n2C6aAKNJOKp3S7ivxqmTMGGRPboTZAZsIpLjJGW
        mNlU/v6JLKOwLeURaBFIECA=
X-Google-Smtp-Source: AG47ELtWepnkMgzI/cGr3vNFU5johK0w1lMgLHAMS51xSlfx0bW0zn7S1KbWeM5rRsADukraOxgJ7Q==
X-Received: by 10.28.164.196 with SMTP id n187mr14081665wme.141.1520452168227;
        Wed, 07 Mar 2018 11:49:28 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b45sm20601008wrb.79.2018.03.07.11.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Mar 2018 11:49:27 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v10 7/9] convert: check for detectable errors in UTF encodings
References: <20180307173026.30058-1-lars.schneider@autodesk.com>
        <20180307173026.30058-8-lars.schneider@autodesk.com>
Date:   Wed, 07 Mar 2018 11:49:27 -0800
In-Reply-To: <20180307173026.30058-8-lars.schneider@autodesk.com> (lars
        schneider's message of "Wed, 7 Mar 2018 18:30:24 +0100")
Message-ID: <xmqqr2ovzmwo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lars.schneider@autodesk.com writes:

> +static int validate_encoding(const char *path, const char *enc,
> +		      const char *data, size_t len, int die_on_error)
> +{
> +	/* We only check for UTF here as UTF?? can be an alias for UTF-?? */
> +	if (startscase_with(enc, "UTF")) {
> +		/*
> +		 * Check for detectable errors in UTF encodings
> +		 */
> +		if (has_prohibited_utf_bom(enc, data, len)) {
> +			const char *error_msg = _(
> +				"BOM is prohibited in '%s' if encoded as %s");
> +			/*
> +			 * This advice is shown for UTF-??BE and UTF-??LE encodings.
> +			 * We cut off the last two characters of the encoding name
> +			 # to generate the encoding name suitable for BOMs.
> +			 */

Yuck.  The code pretends to abstract away the details in a helper
has_prohibited_x() yet the caller still knows quite a lot.

> +			const char *advise_msg = _(
> +				"The file '%s' contains a byte order "
> +				"mark (BOM). Please use %s as "
> +				"working-tree-encoding.");
> +			char *upper_enc = xstrdup_toupper(enc);
> +			upper_enc[strlen(upper_enc)-2] = '\0';
> +			advise(advise_msg, path, upper_enc);
> +			free(upper_enc);

I think this up-casing is more problematic than without, not from
the point of view of the internal code, but from the point of view
of the end user experience.  When the user writes utf16le or
utf-16le and the data does not trigger the BOM check, we are likely
to successfully convert it.  I do not see the merit of suggesting
UTF16 or UTF-16 in such a case, over telling them to just drop the
byte-order suffix from the encoding names (i.e. utf16 or utf-16).

If you are trying to force/nudge people in the direction of
canonical way of spelling things (which may not be a bad idea), then
"utf16le" as the original input would want to result in "UTF-16"
with dash in the advise, no?

On the other hand, if we are not enforcing such a policy decision
but merely explaining a way to work around this check, then it may
be better to give a variant with the smaller difference from the
original (i.e. without up-casing).
