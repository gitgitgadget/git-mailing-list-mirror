Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E97FB1F404
	for <e@80x24.org>; Fri,  9 Mar 2018 23:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932486AbeCIXVl (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 18:21:41 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36637 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932358AbeCIXVk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 18:21:40 -0500
Received: by mail-wm0-f66.google.com with SMTP id 188so6590348wme.1
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 15:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Xt2VTmTWmy9VkZOOa7XEho33HuWzsgrhy0sBZhHwnYQ=;
        b=ZdP9GfWtUvwKEuoUW5f88ZKdJeXfSRqrVU7Fb+FoTWPqwDQ/lqCi3YhDEdfGHjdg/x
         phU3HmhTwQfMTBDsCxJ+KIc5Fx5V4AerMZ6CtmMENMeCu5b750YZw04COna6wpoVKVsy
         uup00ePfViSgwQIHjkH06Z9zO15tzjOqNHq48yUZc+rQ/b5eNdf48gO+g+iK0vk3hRZv
         PEZlbapK5khYBA6nRSbCFB496MsaRcrKRrqRaoRZ5ILKqO0ohGlMEm0qZZSxkgtZRyE9
         qyXTWZ/ZrfY5rrVo9lPEpN391xSsN1/ZfdpIdIB1tPPpiW0QVsuanFQhrer5XxVfgWGk
         M0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Xt2VTmTWmy9VkZOOa7XEho33HuWzsgrhy0sBZhHwnYQ=;
        b=G96tgQR0E8pwbIKfftNAsl1mipOBcdcR9fNuFxViTUuHRyFvXEiW/bdIjlEAAScuz3
         8esl03Rk4OBJlkJy+OmuXIokuNRgOc2yviwISaRdEDJbUaRpeFu5to7yN1rG95BNRPQK
         rstHhc6hxbgUIm7tmnLjwda3Mog9CnglZZSSFZtnGphozdWQKCCYFIMOo+VqhKHouNyh
         z5+lQcH9TiZQ62RVDD7Ad5PRVFmEFzcJQaK0TwEg3JPGzf3RNeS1yOB5hH7Zb9aM4E4C
         YQ7RJgfgd5vTVMdT9oFFPQvdKABz5hT9PAzREf3Bcd03XpTSN6yJ1l1MRPXOGLyikQp1
         LN0Q==
X-Gm-Message-State: AElRT7GsUA4sOquo0oLtVTDe1FD7+EvYobrD2xASbio/HAS7YFPuby/e
        Kc6Qdq/fWAZKrPr4pUdH47g=
X-Google-Smtp-Source: AG47ELs3PViQ7quRpvvOAXfN0mOPgrmUI8dNo50ra77BUXTTSDqw0zWU04E+CzO86AQL79czgQdPug==
X-Received: by 10.28.167.208 with SMTP id q199mr375334wme.29.1520637699013;
        Fri, 09 Mar 2018 15:21:39 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d27sm2945622wrd.60.2018.03.09.15.21.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Mar 2018 15:21:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH/RFC v3 07/12] pack-objects: move in_pack out of struct object_entry
References: <20180303024706.31465-1-pclouds@gmail.com>
        <20180308114232.10508-1-pclouds@gmail.com>
        <20180308114232.10508-8-pclouds@gmail.com>
Date:   Fri, 09 Mar 2018 15:21:38 -0800
In-Reply-To: <20180308114232.10508-8-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 8 Mar 2018 18:42:27 +0700")
Message-ID: <xmqq60644yyl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Instead of using 8 bytes (on 64 bit arch) to store a pointer to a
> pack. Use an index isntead since the number of packs should be
> relatively small.
>
> This limits the number of packs we can handle to 16k. For now if you hit
> 16k pack files limit, pack-objects will simply fail [1].
>
> This technically saves 7 bytes. But we don't see any of that in
> practice due to padding. The saving becomes real when we pack this
> struct tighter later.

Somehow 7 and 16k do not add up.

We use 8 bytes in the original code, and a solution that potentially
saves 7 bytes would use only 1 byte instead of the original 8, which
would allow us to index/identify 1<<8 == 256 packs, but for some reason
we can handle up to 16k.

> [1] The escape hatch is .keep file to limit the non-kept pack files
>     below 16k limit. Then you can go for another pack-objects run to
>     combine another 16k pack files. Repeat until you're satisfied.

;-)

> +static inline unsigned int oe_add_pack(struct packing_data *pack,
> +				       struct packed_git *p)
> +{
> +	if (pack->in_pack_count >= (1 << OE_IN_PACK_BITS))
> +		die(_("too many packs to handle in one go. "
> +		      "Please add .keep files to exclude\n"
> +		      "some pack files and keep the number "
> +		      "of non-kept files below %d."),
> +		    1 << OE_IN_PACK_BITS);

OK.
