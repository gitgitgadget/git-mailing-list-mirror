Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B629BC433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 16:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346381AbiCHQzv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 11:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345576AbiCHQzu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 11:55:50 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE31D4EA31
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 08:54:53 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso2736126pjj.2
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 08:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:to:subject:references
         :in-reply-to:content-transfer-encoding;
        bh=q/dL+5swoRhtyeszO22iOJLCMTeaEirlRwbqDG2TXCo=;
        b=bVONhY99sA7FWCzeJVrnh4RSG6IyhXe5Dz7E0EhVMpyIXm/pKEKBKwCapXcKHmd02/
         KSgclyHhqCcpU/oOqy8tsUcB3TuDaoLzyfK3pgYAEzX5djc7lPLna3rLzdKIjj6TwbgX
         ZaBli3ERLz5s2L6ckll0XOBImatjhu/l7cLy0Ou+RzZOpNva+J687m7FqbuN84g1bIvP
         IjBWVSY4uddAdS/WhqXY01prbIHQ5y2Y3KI3ze1qVfVxeoMUdW0HjMbCXlIdoL5joZld
         kXHGwK/y5dBV9Z51ogBS82RWw1M2ZBmIGzeRUpYgYlxsmA+KXA/dXFWjv1f3T6/FFlsN
         ulOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from:to
         :subject:references:in-reply-to:content-transfer-encoding;
        bh=q/dL+5swoRhtyeszO22iOJLCMTeaEirlRwbqDG2TXCo=;
        b=Y28h99YBllv20UdgOPgllfeIod7eY+h+hE6bnVfNTNRvLRn0rQEVh6l+3VseHqgmkb
         6/Y6SHcmOlMh5duB0Di3mHk68IBtyfK6Tklp/a1rJKgC85HC/Cfqk+btQDqVtivPgPdb
         PVvEARflFxyKvqfpUCYS90nYuc5mUD/6xHleG0lfTSuXOhPgGgZn81DGvqlQueP+Tsnr
         csvnJbHY35AtZpPz+k3NzFLV6uDRzy6j6AdNqLxFUmYiCWTdy2aJqK+KNI2yL0JKCo6O
         v3QKmme4IEQQvY2cIctn7rrG/fttCAbOuYlpIXsNGVcU7DOcp/jvdWUhwy+IUv5yM9bK
         duOw==
X-Gm-Message-State: AOAM530UlOT61MbC9miDmJxbtcpyUC/Hlj7cFH7XTqMiS591d/5NFz4v
        gGraQ7rkfqkuz2CuzK6C5fhJV1vC/DOZpQ==
X-Google-Smtp-Source: ABdhPJwmgXDdnAJ9IwK+hTmcWqCf56c3sosTh+B3WzE4jv3uq75UlBl4d6XL+OQNiHYMTBR0Cf0z2w==
X-Received: by 2002:a17:902:f707:b0:14a:fd51:3b5f with SMTP id h7-20020a170902f70700b0014afd513b5fmr18845040plo.98.1646758493164;
        Tue, 08 Mar 2022 08:54:53 -0800 (PST)
Received: from ?IPV6:2405:201:a800:4df9:5194:c9b1:2d1f:598e? ([2405:201:a800:4df9:5194:c9b1:2d1f:598e])
        by smtp.gmail.com with ESMTPSA id c5-20020a056a00248500b004f6b5ddcc65sm17775416pfv.199.2022.03.08.08.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 08:54:52 -0800 (PST)
Message-ID: <cf8a9316-c81e-2477-a565-1c38a168fc67@gmail.com>
Date:   Tue, 8 Mar 2022 22:24:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   jaydeepjd.8914@gmail.com
To:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH v5] userdiff: add builtin diff driver for kotlin language.
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220306111539.336475-1-jaydeepjd.8914@gmail.com>
 <8799cd42-bb05-a827-187d-33fb03565f21@kdbg.org>
In-Reply-To: <8799cd42-bb05-a827-187d-33fb03565f21@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> I guess that the suffix u is intended to mark unsigned integers. So, I
> would say that the alternatives [fFlL] and [fFlLuU] should be swapped.

Okay.

> Furthermore, is it intentional that you do not recognize the '_' digit
> separator in floating point numbers that begin with a decimal point?

No. I will fix it.

> > +	 /* unary and binary operators */
> > +	 "|[-+*/<>%&^|=!]?==?|--|\\+\\+|<<?=?|>>?=?|&&|\\|[|]?|->|\\.\\*|!!|::|[?:.][.:]"),
> 
> What is the justification that there is still "|&&|\\|[|]?|" instead of
> "|&&|\\|\\||" that I suggested (and I think I stressed that the point is
> that single-character operators are matched elsewhere) and to which you
> said "yes, right"?

Yes. Must have slipped my mind. Sorry.

> Also, the part "|<<?=?|>>?=?|" can match <, >, <=, and >=, all of which
> are matched by other expressions, so you could reduce it to "|<<=|>>=|",
> because that are the only tokens that they must match.

Alright.

So, the final regexes are these, right?: 


	 "[a-zA-Z_][a-zA-Z0-9_]*"
	 /* hexadecimal and binary numbers */
	 "|0[xXbB][0-9a-fA-F_]+[lLuU]*"
	 /* integers and floats */
	 "|[0-9][.]?[0-9_]+([Ee][-+]?[0-9]+)?[fFlLuU]*"
	 /* floating point numbers beginning with decimal point */
	 "|[.][0-9][0-9_]*([Ee][-+]?[0-9]+)?[fFlL]?"
	 /* unary and binary operators */
	 "|[-+*/<>%&^|=!]?==?|--|\\+\\+|<<=|>>=|&&|[||]|->|\\.\\*|!!|::|[?:.][.:]"),


Thanks,
Jaydeep.



