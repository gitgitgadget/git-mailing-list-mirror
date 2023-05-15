Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111E3C77B75
	for <git@archiver.kernel.org>; Mon, 15 May 2023 08:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjEOIrp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 04:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjEOIro (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 04:47:44 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D22ED
        for <git@vger.kernel.org>; Mon, 15 May 2023 01:47:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f450815d02so37821445e9.0
        for <git@vger.kernel.org>; Mon, 15 May 2023 01:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684140461; x=1686732461;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k7faE5nvxz8/dn4DHaOwy6gk/ZDxIs9hXSBVQOML2fk=;
        b=BSXj1SR/iHhO0c8DdzGviJpSFJPksE3LXBc+HAgaFBUzy9Wi3N0BQ1tyNkS11esTAt
         ISM7VufI7++UzIhrmZh8brIvT2rmKG1vtWAn2YuvVfgEvadgGNRYRcPLnd2jqpDKW+sy
         MnGvM1GQBJam1osYTaYiK0kXVx+JxkuKgoGGFBr3Z6x2u0QNDEWcQsCLhk8Jm9tAFPHZ
         9H+5rXwSwse0+O5A0a7zZ2P8jcft+f953h4yVE5w4PHgm4xl9gQ1cQdp/1h5oV/VC9V3
         GjwAZkPTq2vze0t7SXFs9VeAkVaXV1t1/sJYa+YQ0W+W3F69CUR61oHS7s3peX0pRL/+
         hItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684140461; x=1686732461;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k7faE5nvxz8/dn4DHaOwy6gk/ZDxIs9hXSBVQOML2fk=;
        b=LQz7p7phcGhhRr5xZIxiwO2jAzuHRroqaKpI8acVgCqF5OVh619pI4ZR1u1HnUBhA/
         W3nC8AFbHCQ4yGcRyf4DBrKrw7t+Es95DHLC0Rv2HvsJpfmzj7Y8PN3p2xlzZMqUK3I3
         FvNFNTFkeuQ5yh4AEXmirZO76qv4DD5rRp7cFGcFk2PoGx9ULbxXl3niklXnK7dEmHc8
         6G1OpuzSWJ0/fly42ZoFeG/M9wzDWYAjtkk612mByaxv5I79DLF0PLZSFZV4wiCc+c/a
         D9KYEZ6UJeGMKE1DO5In6C4ZHljOJJNqJ9tMjueSWwHaAPTdgDMqFE3EK/QVJNWz20Tp
         3E6Q==
X-Gm-Message-State: AC+VfDxxCWtxlQKZmoidxqLRBz84oVefUVT5RO2Ro2m9gdkdgPalY4xO
        50WvS7dHRVWUgY1om9CduoG/i572Lxc=
X-Google-Smtp-Source: ACHHUZ6bGFWWJuHeT63gIxWxx5TI64sZMC8N6FzkZ9NCBG2rqWs9yi0cdCkUSz2+MxLnSs7hXNZTsg==
X-Received: by 2002:a1c:4c04:0:b0:3f4:2158:68ae with SMTP id z4-20020a1c4c04000000b003f4215868aemr20647794wmf.15.1684140460708;
        Mon, 15 May 2023 01:47:40 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id n18-20020adfe792000000b002f7780eee10sm31772763wrm.59.2023.05.15.01.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 01:47:40 -0700 (PDT)
Message-ID: <ec139b78-1d36-f894-e39f-f29877a67b18@gmail.com>
Date:   Mon, 15 May 2023 09:47:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 1/1] cat-file: quote-format name in error when using -z
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
References: <xmqqilfhctrr.fsf@gitster.g>
 <20230510190116.795641-1-toon@iotcl.com>
 <20230510190116.795641-2-toon@iotcl.com> <xmqqpm782be6.fsf@gitster.g>
 <87h6sh6f81.fsf@iotcl.com> <xmqqy1ltqygb.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqy1ltqygb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/05/2023 17:57, Junio C Hamano wrote:
> Toon Claes <toon@iotcl.com> writes:
> Stepping back a bit, how big a problem is this in real life?  It
> certainly is possible to create a pathname with funny byte values in
> it, and in some environments,letters like single-quote that are
> considered cumbersome to handle by those who are used to CLI
> programs may be commonplace.  But a path with newline?  Or any
> control character for that matter?  And this is not even the primary
> output from the program but is an error message for consumption by
> humans, no?
> 
> I am wondering if it is simpler to just declare that the paths
> output in error messages have certain bytes, probably all control
> characters other than HT, replaced with a dot, and tell the users
> not to rely on the pathnames being intact if they contain funny
> bytes in them.

We could only c-quote the name when it contains a control character 
other that HT. That way names containing double quotes and backslashes 
are unchanged but it will still be possible to parse the path from the 
error message. If we're going to munge the name we might as well use our 
standard quoting rather than some ad-hoc scheme.

Best Wishes

Phillip

   That way, with the definition of "work" being "you
> can read the path out of error messages that talk about it", paths
> with bytes that c-quote mechanism butchers, like double quotes and
> backslashes, that have worked before will not be broken, and paths
> with LF or CRLF in them that have never worked would not work, but
> at least does not break the input stream of whoever is reading the
> error messages line by line.
> 
> I dunno.
> 
> 
