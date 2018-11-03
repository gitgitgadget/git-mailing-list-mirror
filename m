Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 894F81F453
	for <e@80x24.org>; Sat,  3 Nov 2018 00:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeKCJlb (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 05:41:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36346 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeKCJlb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 05:41:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id a8-v6so3193446wmf.1
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 17:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TZZfIqNAb0+xnGNqnrRM4B6RvXuB9zg1dRYPuIxp34Q=;
        b=DZ/n+7+VLtVQ3H+RErb7jDPMnhN6ErhL+/0s/V6ozWEBU/QmRp66rmJKAaM7xb+Ch2
         uM52MUWyIwR1AA1FPeZdhh4R1p6SbF3KX86HbiXtu9Fbe8+r4MUoTHxOO5mXJGe9CZqY
         ORRRLuFuMCeavbHwNqiNAZDQ9nJb7VxR6BnBVJ5weNyBMBDR3jL5j5JrifisbsU0Msaz
         WwgJMa1mL34nRWKPATwhOHpooOTVmpW8Q9OAwiDvxVjpunCYV05aGXurR/hVsvhSHG6O
         5QEQFBk5ckJXF1+V2k2laH77+qnd7NumMqZoYz4A/1TB4R/T6N3iWneWGSsYnWa0kV+9
         KhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TZZfIqNAb0+xnGNqnrRM4B6RvXuB9zg1dRYPuIxp34Q=;
        b=qTBmm3Df7LdIYY4dD2bCuPpD9P4/+j20P9aupIC+/oPmRHzNTnkhPYjspdszZXGt/6
         Uxubf7Uv+SJ/k3Yl7TT1VmH05NGWeMR6Eel2ZAxxOVO/YKllS2DL0vqYby/xO3uUYTLV
         hCl68g6wUjLYpAu4P6LoDyK4UaUQcCKBbYMadNKNDP6pQi/OBEw7KnrObJR+xkwoTQHl
         QRsv+vVVL7qLF6Lo1bp0q8XE1LNkhfgphpxVY5PMUfxsHQQ5Blm2SPxcal/GoDAnrHKm
         ricjalbyHLQo3wjtk3JMn2jWKpoagiQjBBILNlGC/y8d86Ca04qKi2/c5r3RT4zh9xox
         uHug==
X-Gm-Message-State: AGRZ1gK7in8RiUQzCFO2lFDuvSBt2IB02yQsaSXClfS9OAqZG94IB17w
        W43Mpc3A37cCxykXx7CdTRg=
X-Google-Smtp-Source: AJdET5eKT4AJBhYg5EdyutlL/nTz2ME+pi/62c9l4HNn01uT1pW2cmQfgicsGAIIygw/5Xh93u+kiQ==
X-Received: by 2002:a1c:9355:: with SMTP id v82-v6mr97657wmd.128.1541205126468;
        Fri, 02 Nov 2018 17:32:06 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h16-v6sm3992878wrb.73.2018.11.02.17.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 17:32:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 3/9] diff: avoid generating unused hunk header lines
References: <20181102063156.GA30252@sigill.intra.peff.net>
        <20181102063606.GC31216@sigill.intra.peff.net>
        <CAGZ79kZb7kMhkE=EWRtR8tpkQCY3v8rWugHvq24TFGHpBxmygw@mail.gmail.com>
        <20181102201549.GA17228@sigill.intra.peff.net>
Date:   Sat, 03 Nov 2018 09:32:02 +0900
In-Reply-To: <20181102201549.GA17228@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 2 Nov 2018 16:15:49 -0400")
Message-ID: <xmqqr2g3ngql.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> to have *some* names there, for the sake of a
>> simply described coding style without many exceptions
>> (especially those exceptions that rely on judgement).
>
> Fair enough.

For the record, there aren't "many" exceptions to the rule that was
suggested earlier: if you refer to parameters by name in the comment
to explain the interface, name them and use these names [*1*].

> Squashable patch is below; it goes on 34c829621e (diff: avoid generating
> unused hunk header lines, 2018-11-02).
>
> Junio, let me know if you'd prefer a re-send of the series, but it
> doesn't look necessary otherwise (so far).

Giving them proper names would serve as a readily usable sample for
those who write new hunk-line callbacks that do not ignore them, so
what you wrote is good.  Let me squash it in.

Thanks.  If this were to add bunch of "unused$n" names to the
parameters to this no-op function, only to "have *some* names
there", I would have said that it is not even worth the time to
discuss it, though.

> diff --git a/xdiff-interface.h b/xdiff-interface.h
> index 7b0ccbdd1d..8af245eed9 100644
> --- a/xdiff-interface.h
> +++ b/xdiff-interface.h
> @@ -39,7 +39,9 @@ extern int git_xmerge_style;
>   * Can be used as a no-op hunk_fn for xdi_diff_outf(), since a NULL
>   * one just sends the hunk line to the line_fn callback).
>   */
> -void discard_hunk_line(void *, long, long, long, long, const char *, long);
> +void discard_hunk_line(void *priv,
> +		       long ob, long on, long nb, long nn,
> +		       const char *func, long funclen);
>  
>  /*
>   * Compare the strings l1 with l2 which are of size s1 and s2 respectively.
>
> -Peff

[Footnote]

*1* You may say that the "if you refer to parameters by name" part
relies on judgment, but I think it is a good thing---it makes poor
judgment stand out.

When describing a function that takes two parameters of the same
type, for example, you could explain the interface as "take two ints
and return true if first int is smaller than the second int" in
order to leave the parameters unnamed, but if you gave such a
description, it is so obvious that you are _avoiding_ names.  Not
using names when you do not have to is good, but nobody with half an
intelligence would think it is good to give a bad description just
to avoid using names.
