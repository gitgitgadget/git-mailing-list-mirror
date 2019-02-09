Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCB501F453
	for <e@80x24.org>; Sat,  9 Feb 2019 18:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfBISGZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 13:06:25 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39784 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfBISGY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 13:06:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id f16so9115556wmh.4
        for <git@vger.kernel.org>; Sat, 09 Feb 2019 10:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=eYRoGl3ojgvLNloxpWmPBFJfiKT3BIY5qAJGz2vbvpw=;
        b=TTLxfWDf0uYdcqcc+VBaMkVChsR8NlnCjloQkk46+BB/tBrXf9ektGjXhoX4dNT+K4
         7KEvdPjPBz++YJXRXBZJkpVXcyzpE+KZ+q1Me83lNiutw37eCn0HP8fWk5igbFHnMMg6
         Q88XXCC9OlTEun5/D8GhkNjkR2tgarSfnOF8RgBrem5WuOhyRGSkrGI+hs1pee+zbHYy
         M6V15ewgooLMraUwjgggFkust/6kvqFEz/b3jWSWzopUEdXGGXjvuU1A7Jh+tFaG1oPF
         RZNHjmA6B9IFl2xoDgv7BDDTZxfHov+FLmDFo0+pfQvFs9Hw1dax1t76dQdUS+RNDMD7
         cToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=eYRoGl3ojgvLNloxpWmPBFJfiKT3BIY5qAJGz2vbvpw=;
        b=Cgq9x2pkEAXHe74xNNaUiAuAJ4vKN9X5fri3MnH9582GdZIE8tD/WCKfuLGISnEPaM
         Eraj46AqWYcv/jDUwXyZTSVXFUKneIImDPMcecLLYV04T2Vs4qhg/uCfwSiiQ1fCvu1Y
         IesxSbZkUJ8pPfM1wf7QkRsVTr/5D9Kjf45vMKZkS8hRcx5DGMVDZyafp7og5zI9OHMF
         fFr/DfHPdP6k6IQFC4ocO1/nYz48IyaoNouGSjYIPqyZr3v7N2OPvwZrMCFc+/YxZsWC
         Ork1MFIBZyoXoSNehr+JBMWQN2b+fW9SnlIhxYbL5OzZ5V6+GnuN7ZkEvUWnCTYfHmkS
         ky2A==
X-Gm-Message-State: AHQUAubvwBLv6rcohkDEyZTpQXJ+SVhzb2FPL3lxYDBcOVMxiXTtSNbb
        xuCT13uaj4yIKZyjGJR/m0E=
X-Google-Smtp-Source: AHgI3IaEOCvHomayXq7Vc3DKNMriTsy5ODLqrrUT1B5Zlj3ca73kNVGHyjaoXnvezWhK7dY2KJt+3g==
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr6784937wrw.316.1549735582670;
        Sat, 09 Feb 2019 10:06:22 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v6sm12222172wrd.88.2019.02.09.10.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 10:06:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Luke Diamand <luke@diamand.org>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <ldiamand@roku.com>
Subject: Re: [PATCHv2] git-p4: ticket expiry test: use a fake p4 to avoid use of 'sleep'
References: <20190208190231.8134-1-luke@diamand.org>
        <20190208201445.GB10587@szeder.dev>
Date:   Sat, 09 Feb 2019 10:06:20 -0800
In-Reply-To: <20190208201445.GB10587@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Fri, 8 Feb 2019 21:14:45 +0100")
Message-ID: <xmqq4l9ckfab.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Fri, Feb 08, 2019 at 07:02:31PM +0000, Luke Diamand wrote:
>> +# create a fake version of "p4" which returns a TicketExpiration based
>> +# on $EXPIRY, for testing login expiration
>> +create_fake_p4() {
>> +	(
>> +		cd "$git" && mkdir expire-p4 &&
>> +		cat >>expire-p4/p4 <<-EOF &&
>> +		#!/usr/bin/python
>
> I think this should be $PYTHON_PATH.

OK.

Luke, I think our mails / work crossed and the tip of 'master'
already has a removal.  Please make this into a separate patch that
adds (or, resurrects with an improved version) the test for the next
cycle.

Thanks.
