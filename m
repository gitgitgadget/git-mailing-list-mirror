Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCFD61F424
	for <e@80x24.org>; Thu, 26 Apr 2018 01:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeDZBZr (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 21:25:47 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36019 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751212AbeDZBZq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 21:25:46 -0400
Received: by mail-wm0-f50.google.com with SMTP id n10so9931220wmc.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 18:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Rs05nxDtFv+gEMMBb+W7cSUh4MemfcKBMH0wCJw3O24=;
        b=Qmiy4coOI/kHvpc2zhV8IpArbZeORFU8qjpq2k8Jb0ltUCcXBcd99WxWvegpo8Pr45
         KHn0u2zM2b36Z29HM1q+FRvXQytP9pCOht6aMzmZT81OMW/3zVegi20u78UE78cU5d2f
         21q9boR5Tul2FGy/H7GXyIm1JtwHpl+DcUdv7UI78zgHHGJ8XNKlaAh3cUBqC1/4tisO
         9x2seZi7K+goUVqapvNn5gFyPp/QuJUiLi2xqV3XiEOH+5w1nga4gHJ+GAuCiN9IufGx
         g+JqqCk0C3FEk8+r7yZ/sKUto+7w6xpxleqsFT/r3TfVFexJj6D7oVkt+q2q+e2RchQQ
         Lekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Rs05nxDtFv+gEMMBb+W7cSUh4MemfcKBMH0wCJw3O24=;
        b=tvS17x1JUILnt3RhehpGHyHzFS16e8bxb0rdXokhRsz15z7435XLngQcE4vFGv+Z4Q
         zqQqBr6h3IJ3uo50ejhW5uXpumw2JBNefsy5ffbKBKnrCHjDU+Z/si8OhsSF7jfHcWl/
         2iOVLBinfPOiHhBlzoxodOuCtmDxl+BeeEGcQmGyaV0ghqVgBwpTX0CA93O4ggcOa7bq
         jvG4NiWKGDusOq2Q4A+4UdJDEfshV0C3olvEHTosi80HPxJcgvt0rpWmEjsQCApMs61I
         kkoETbe1Yij/cBznSNgAJv3+8oInvcV13EcO6vxUw7b4y384gJakL8cl6RO01tBEqhcj
         Z0iw==
X-Gm-Message-State: ALQs6tDbB7L1P50YKKTBTs4mi2HdEsw/60qfRYwrfvlJLb3L6INDH8jt
        Ht71QwQTUvBaZxCn6RZWwzA=
X-Google-Smtp-Source: AB8JxZrDbyuBYM2qRj9RZtEcuLK4KpdJmXfmqZ4LnBwXllky8EoNU8XI4Oax4qKseGATIXflib+yJQ==
X-Received: by 10.28.195.85 with SMTP id t82mr685281wmf.129.1524705944663;
        Wed, 25 Apr 2018 18:25:44 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a13-v6sm8999714wrn.6.2018.04.25.18.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Apr 2018 18:25:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     "Robin H. Johnson" <robbat2@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
References: <20180413170129.15310-1-mgorny@gentoo.org>
        <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
        <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com>
        <robbat2-20180425T060717-325652820Z@orbis-terrarum.net>
        <xmqqin8f4qoq.fsf@gitster-ct.c.googlers.com>
        <ad4d0d66-58f4-5cab-d314-a30a50e8ad32@xiplink.com>
Date:   Thu, 26 Apr 2018 10:25:43 +0900
In-Reply-To: <ad4d0d66-58f4-5cab-d314-a30a50e8ad32@xiplink.com> (Marc
        Branchaud's message of "Wed, 25 Apr 2018 11:18:26 -0400")
Message-ID: <xmqqefj24v3c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marc Branchaud <marcnarc@xiplink.com> writes:

>> But Git is not an archiver (tar), but is a source code control
>> system, so I do not think we should spend any extra cycles to
>> "improve" its behaviour wrt the relative ordering, at least for the
>> default case.  Only those who rely on having build artifact *and*
>> source should pay the runtime (and preferrably also the
>> maintainance) cost.
>
> Anyone who uses "make" or some other mtime-based tool is affected by
> this.  I agree that it's not "Everyone" but it sure is a lot of
> people.

That's an exaggerated misrepresentation.  Only those who put build
artifacts as well as source to SCM *AND* depend on mtime are
affected.

A shipped tarball often contain configure.in as well as generated
configure, so that consumers can just say ./configure without having
the whole autoconf toolchain to regenerate it (I also heard horror
stories that this is done to control the exact version of autoconf
to avoid compatibility issues), but do people arrange configure to
be regenerated from configure.in in their Makefile of such a project
automatically when building the default target?  In any case, that is
a tarball usecase, not a SCM one.

> Are we all that sure that the performance hit is that drastic?  After
> all, we've just done write_entry().  Calling utime() at that point
> should just hit the filesystem cache.

I do not know about others, but I personally am more disburbed by
the conceptual ugliness that comes from having to have such a piece
of code in the codebase.
