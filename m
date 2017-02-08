Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D7DE1FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 18:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751030AbdBHSL5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 13:11:57 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33692 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbdBHSL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 13:11:57 -0500
Received: by mail-pg0-f66.google.com with SMTP id 194so15807808pgd.0
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 10:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0QAm6PKKDeSDeaeW4nC/NtGZFaE3ao0WO6uospM40DI=;
        b=iL/dxCacq88BKgp7VaXpI/atn+zjqOVcG6+Py5suPlcLLrkA5SxjaiPMy6bFmnd4n0
         OkfcvQqY/41MtJcQgXzsI8b4fqRLJKUwmL5sTzXFGYsiaAJI9rVuzE6zN3wILlIBaQVJ
         YfWH2Bravpd/jB6PigumhbzcQz44OzFXcGhoNgBWq98/vwfGVRpS3oU382NF3nccqaZB
         eLIynK3VUFaqfVDcG5sx0A6KxzPi6Y8O0+fYv+F/2Nq+sTzi8q6EUbjfewdaUCEfF1iF
         ecqc2NAjLtAQAFG1zoQzXNIYe21B40B8MEiwQ5zJB+aqRkH3bKzabS65OjhNz0s9tvnz
         gV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0QAm6PKKDeSDeaeW4nC/NtGZFaE3ao0WO6uospM40DI=;
        b=Q1pMOFm3CJeNg8xQh+HRdwsgQwh17bqtvkFBI3SnxyoGZzJ86B2QzFnisC/5TIT+1G
         Vu5cLMI37E6nvgo2IR2kUSqzIquErphdQL/9f9xswdTTLU4GEAB15mxSEWOnu1Y25aUg
         onxkymrL3j+Q/h7zzijcKtNBMH8qxuWZSmfbz071+jgOHcf0aY+O7dCABDBgx+fetY04
         HJK8O8z8K6EiiRwyJ1iUhgSCjz7uJsxBMgA3ummR1fuLAVuAax32PxxTMwW/XbcYUgDQ
         GmvSvahiumttja9S5p9jPS2AQQRpvBIuVnmXKlYodVbiwzZ+8PE20MdDjAG0EACZexIk
         +JAA==
X-Gm-Message-State: AIkVDXLkVdEINc2PtZUH+8H1g6AlWvcD+0WVDIjzYdldw4L0kgL8FwgOwEsIgeLi9kqPWw==
X-Received: by 10.84.138.165 with SMTP id 34mr35488299plp.37.1486577516217;
        Wed, 08 Feb 2017 10:11:56 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:7c20:fa7c:46cb:2209])
        by smtp.gmail.com with ESMTPSA id l71sm22261956pga.13.2017.02.08.10.11.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 10:11:55 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH] push options: fail properly in the stateless case
References: <20170208010954.19478-1-sbeller@google.com>
Date:   Wed, 08 Feb 2017 10:11:54 -0800
In-Reply-To: <20170208010954.19478-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 7 Feb 2017 17:09:54 -0800")
Message-ID: <xmqqpoiswo0l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> When using non-builtin protocols relying on a transport helper
> (such as http), push options are not propagated to the helper.
>
> Fix this by propagating the push options to the transport helper and

The description up to this point is VERY readable and sensible.  But
that makes the title sound a bit strange.  I read it as if it were
saying "stateless case can never support push-options so fail if the
caller attempts to use one", but that does not seem to be what is
going on.

> adding a test that push options using http fail properly.

Sounds sensible.  What end-user visible effect does this fix have?
IOW, what feature do we use "push-option" for?

Ahh, OK, so you need to describe that there are two issues in order
to be understood by the readers:

 (1) the helper protocol does not propagate push-option
 (2) the http helper is not prepared to handle push-option

You fix (1), and you take advantage of the fact (2) to ensure that
(1) is fixed in the new test.

With such an understanding, the title makes (sort of) sense and you
wouldn't have to be asked "what end-user visible effect/benefit does
this have?"

> +'option push-option <c-string>::
> +	Transmit this push option.
> +

There is no "c-string" in the current documentation used or
defined.  The closest thing I found is

    ... that field will be quoted in the manner of a C string ...

in git-status page, but I do not think you send the value for an
push-option after running quote_c_style(), so I am puzzled.

I'd rather see 'option push-option <string>' as the bullet item, and
in its description say how arbitrary values (if you allow them, that
is) can be used, e.g. "Transmit <string> encoded in such and such
way a the value of the push-option".
