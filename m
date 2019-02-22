Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8167E1F453
	for <e@80x24.org>; Fri, 22 Feb 2019 05:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbfBVFAf (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 00:00:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39564 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfBVFAf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 00:00:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id l5so930104wrw.6
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 21:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=jKnS51G5dwoxBQD1NiZPALfOpFrLNx2OSVLgUZ4eBJY=;
        b=QaHepY+jrVZfAF/K0m2qXu1pgKl071HcLeegDVvvXgXUTRCqIreLlQvUyFITI+QsQd
         Dk5/DgDqP+7n2SiHDSzmaZ/j5UuPpdGbGenwcfm2qrYwZsXPNr5+2fIvYV3D1rPuUlLY
         lDKGUL5Q+vL5r9sn7c624n2z2nuBnlORrN3Vbz/UofvCKzAEKb/RVUw4Phu7vCVe6lLq
         ExjC5zxUNy/Uh/stcsYn1skR6e+yPnt6oaBulfGKEXSRsDa8T9Q6qNKsX3OS76WwOM9q
         s7k7WhRUkVnCZqsNt7NTd4U1cIdkZ1W4B7T6vHZ5IFvMegBAb6jEb29Rm1B7Zs2ZWo3p
         MAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=jKnS51G5dwoxBQD1NiZPALfOpFrLNx2OSVLgUZ4eBJY=;
        b=TJZvHc7cJICf0AlwlRoeOPQENBweUROjATGP1vrdfuBvgO2AcAK9lSCNEhKWOJPWES
         7KdhRZHZ1upNU4PzMFffC+CRPVgVpxZABxDILr05fxdWy5rAXBfQABZjKQLi0u7hta4X
         OsJXYtzPdHbnNoRNt2JZHXzZ6I13NWUPiaqNLnqEK1FZM3OQu2GnA++ZxyY0Ut+HBbfM
         SnMIfuBfopZPRSfSm2ShEzbqVyIEO2DtJYfWWwJwntimSGEaCTAmxitW5PQYalaueixU
         zseO8Bty50vUN8LQI3D3NYxWZdQGJlfW7oZICuwnniKRjH4IeefF8ay4l5DFjhDKq48k
         0Xlg==
X-Gm-Message-State: AHQUAuar+l+JuhDzX5gSCLHcMQC5P8piajUE0CZqRR5zzO6EiPizV9eC
        OzAkdfGz1BbiDFEhsNnTs90=
X-Google-Smtp-Source: AHgI3Ia6wsXNFbJ711voK6Lmglk8x+lm08FM58V+3zi1qiXsZcUAfeKZfwI4wwvHKsh1nmRSInwk7A==
X-Received: by 2002:adf:e706:: with SMTP id c6mr1352666wrm.278.1550811633190;
        Thu, 21 Feb 2019 21:00:33 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a14sm163775wrr.13.2019.02.21.21.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 21:00:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Sebastian Staudt <koraktor@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 1/2] tests: fix unportable "\?" and "\+" regex syntax
References: <xmqq8sybz7b2.fsf@gitster-ct.c.googlers.com>
        <20190221192849.6581-2-avarab@gmail.com>
Date:   Thu, 21 Feb 2019 21:00:32 -0800
In-Reply-To: <20190221192849.6581-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 21 Feb 2019 20:28:48 +0100")
Message-ID: <xmqqa7ios9hr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Fix widely supported but non-POSIX basic regex syntax introduced in
> [1] and [2]. On GNU, NetBSD and FreeBSD the following works:
>
>     $ echo xy >f
>     $ grep 'xy\?' f; echo $?
>     xy
>     0
>
> The same goes for "\+". The "?" and "+" syntax is not in the BRE
> syntax, just in ERE, but on some implementations it can be invoked by
> prefixing the meta-operator with "\", but not on OpenBSD:

Yup, thanks for testing, spotting and fixing.  I do recall finding
one of these during my review during recent couple of cycles, but
apparently eyeballing will not always catch everything X-<.
