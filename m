Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BA8F1F404
	for <e@80x24.org>; Wed,  7 Mar 2018 19:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965758AbeCGT7t (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 14:59:49 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:34872 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965521AbeCGT7s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 14:59:48 -0500
Received: by mail-wr0-f182.google.com with SMTP id l43so3424315wrc.2
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 11:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8GTvaz7/jKbDaR02+20Z2q4JYckMjG9gxGa0r7xMJK0=;
        b=I+6Uk5RHXJY3tnkgQmgnAUTLJh42JndFQNs/24VbTHz7LP+xqJ6m9ZbZ6DuMV1Y0V+
         QvEOFN2TXr3xN+6lqUHHAr52gYuhe4qT7iuQpJvybha/nE3MNdKE1u5+R6NuULgG0cE8
         aD2ccoefGIYmjidOyDKitfi6dqjFu5z+uHRhd1pCeX4XVIkEta5pRP5Io5aE/V9hx+7n
         YxqzRfOXUGwYQe4AwFbuZq+HDVm9cJLToCUH5riVuE18MyB2BUsOYikNyuTbZaxkwivy
         rXSTAmPseVpTUWVq6scAMoX0BBjK30XoeC9kYa3OPSmWE3bd9MuMrbiMTvywKQE1fHIw
         Avzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8GTvaz7/jKbDaR02+20Z2q4JYckMjG9gxGa0r7xMJK0=;
        b=YBsmPPM4UKsNG3uFp/gF61UREVCerChjzE6f/WnyUWUC7K2VtDajUvCOtOwKjVTsv9
         yNbSrAMHP09I7VmqgCHD+GKkFrZgDVb8brGNC53HuvCC/TUyNprlED87+geLGdCld3PA
         0nszkc/HTcBCdGtK8it1TUJI65JApfb2YWCjHgGYK7oxZrJPWfhrJSxhBKWrQHIrA3ke
         mnGcz2zba3agr3sfVtwhj+kLo5pSL3XZHQPdJFJKuHROcBUHxbLCP74kHaGtbPdBd8wX
         6raDMXr9lDJc9HHXOG9i7fMXpLFYFNUt+1XyWt/Joh97SNpg2QafHIniyGasY5fIDw09
         lzLQ==
X-Gm-Message-State: APf1xPBCsay3zCkd2e7TCIq/qRtvnjKyNnz14fTvmQDtuMNFi3EK472z
        2ZEhJ/2p6afefPnwgu+mkcQ=
X-Google-Smtp-Source: AG47ELtBmstYoSZExYIRGBgLIel4+qLtDbvh4WmBFsZViVSGwu27G7scq3eZ0YdrADAJ60UTHcglPA==
X-Received: by 10.223.132.103 with SMTP id 94mr19480489wrf.275.1520452786633;
        Wed, 07 Mar 2018 11:59:46 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k11sm23111764wre.81.2018.03.07.11.59.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Mar 2018 11:59:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v10 9/9] convert: add round trip check based on 'core.checkRoundtripEncoding'
References: <20180307173026.30058-1-lars.schneider@autodesk.com>
        <20180307173026.30058-10-lars.schneider@autodesk.com>
Date:   Wed, 07 Mar 2018 11:59:45 -0800
In-Reply-To: <20180307173026.30058-10-lars.schneider@autodesk.com> (lars
        schneider's message of "Wed, 7 Mar 2018 18:30:26 +0100")
Message-ID: <xmqqmuzjzmfi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lars.schneider@autodesk.com writes:

> +static int check_roundtrip(const char* enc_name)

The asterisk sticks to the variable, not type.

> +{
> +	/*
> +	 * check_roundtrip_encoding contains a string of space and/or
> +	 * comma separated encodings (eg. "UTF-16, ASCII, CP1125").
> +	 * Search for the given encoding in that string.
> +	 */
> +	const char *found = strcasestr(check_roundtrip_encoding, enc_name);
> +	const char *next;
> +	int len;
> +	if (!found)
> +		return 0;
> +	next = found + strlen(enc_name);
> +	len = strlen(check_roundtrip_encoding);
> +	return (found && (
> +			/*
> +			 * check that the found encoding is at the
> +			 * beginning of check_roundtrip_encoding or
> +			 * that it is prefixed with a space or comma
> +			 */
> +			found == check_roundtrip_encoding || (
> +				found > check_roundtrip_encoding &&
> +				(*(found-1) == ' ' || *(found-1) == ',')
> +			)

The second line is unneeded, as we know a non-NULL found either
points at check_roundtrip_encoding or somewhere to the right, and
the first test already checked the "points exactly at" case.

This is defined to be a comma separated list, so it is unnecessary
to accept <cre,en> == <"FOO, SHIFT-JIS, BAR", "SHIFT-JIS">; if you
allow SP, perhaps "isspace(found[-1]) || found[-1] == ','" to also
allow HT may also be appropriate.  I think "comma or whitespace
separated list" is fine; in any case, the comment near the beginning
of this function does not match new text in Documentation/config.txt
added by this patch.
