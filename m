Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E6E8201A4
	for <e@80x24.org>; Mon, 15 May 2017 04:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752646AbdEOEXb (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 00:23:31 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35902 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751924AbdEOEXa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 00:23:30 -0400
Received: by mail-pg0-f66.google.com with SMTP id h64so10608286pge.3
        for <git@vger.kernel.org>; Sun, 14 May 2017 21:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FjpdrHzJ4xnQnWNxERtm6kipVegYGeHIKVU3vj9nLts=;
        b=gYBDsbbgpNxjvnEIPeowkauJI2LpEAgBb/umP2mjVI0dv66iAYd6T7BUi4eOqJD2AZ
         e0NKkXeKgUm8jud2HibThNC4DRpclftZXIadObKzo16hUJGnoptI4dLHx9aDf+37ujFj
         o8wmsscf2kJcoiTv/87+bE05xLFs9VzcWUhzDAOLT5qBZOcVYAaIhYJ24pHJPDupu09P
         l4Bfvm+BMsXfr3GiUt6rdHiIEsbtx7NW1SxyYAN9djsE5enZd+0+mXKjGrtXq6lEJABT
         hg5IbfPCVcqKhoM30DYBrVt+6uP8gots/VNW/Y74W81+IS5tIOIy9wkbCo1iGCzVy/9t
         swSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FjpdrHzJ4xnQnWNxERtm6kipVegYGeHIKVU3vj9nLts=;
        b=Ho0qDjUDHk8MAOSTE6lmLN0DMb7OsK+Bl9bPgpsiiMaEo/lrsi/3cpDJNGIVCND5H1
         3JB7Lp58OLafQTkiwoKj0XKrcrNYR5VxLuBRMVAdpfEqV3h4OYd+PI4wJkdQx2vvPiuR
         jmUFLrG3nA6u0v5hrYfPZJcquNiRc4P0eYIj3oduF1G/hbPkVT3jW3MLyY2Yh6Cn+D6q
         Za6hf2kPiGlPoLywNn9viF9bAblt9q0vga3Y1p4t0DqhB8Sxf0vC130U8mSkAvBBrepR
         JMdY6s7zFSFdoxsdozqErCN26tJ1A9FHgUaw5vk09spaq60hcreS3O1LvAaGxf99sRnC
         WtUg==
X-Gm-Message-State: AODbwcA3G58CiFHXiMWaYzqYzlTi1Rcb9M2JEgsx1SLEbm/2OBuyNYKQ
        2E9Zs0VPpfky0A==
X-Received: by 10.84.233.200 with SMTP id m8mr5681285pln.118.1494822209441;
        Sun, 14 May 2017 21:23:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b170:f9ed:5f25:7ab5])
        by smtp.gmail.com with ESMTPSA id d3sm16745658pfb.110.2017.05.14.21.23.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 14 May 2017 21:23:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brian Malehorn <bmalehorn@gmail.com>
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH] interpret-trailers: obey scissors lines
References: <20170514035652.rn5npxxflku6s5k4@sigill.intra.peff.net>
        <20170514083349.24979-1-bmalehorn@gmail.com>
        <20170514083349.24979-2-bmalehorn@gmail.com>
        <xmqqk25iwz7l.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 15 May 2017 13:23:26 +0900
In-Reply-To: <xmqqk25iwz7l.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 15 May 2017 12:55:42 +0900")
Message-ID: <xmqq7f1iwxxd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>         This can be done by the same logic as the existing helper
>         function, wt_status_truncate_message_at_cut_line(), uses,
>         but it wants the caller to pass a strbuf to it.  Because the
>         helper function ignore_non_trailer() used by the command
>         takes a <pointer, length> pair, not a strbuf, steal the
>         logic from wt_status_truncate_message_at_cut_line() to
>         create a new wt_status_strip_scissors() helper function that
>         takes <poiter, length> pair, and make ignore_non_trailer()
>         call it to help "interpret-trailers".  Since there is only
>         one caller of wt_status_truncate_message_at_cut_line() in
>         cmd_commit(), rewrite it to call wt_status_strip_scissors()
>         helper instead and remove the old helper that no longer has
>         any caller.
>
> The last paragraph would have saved me from getting puzzled.

And re-reading the above, wt_status_strip_scissors() does not sound
right to me.  

Yes, I am bikeshedding at this point, but names matter.  I prefer to
keep the distinction between the two clear by not calling the
cut_line[] array "scissors", but in any case, the new function is
not about "finding" the cut-line or scissors, in other words,
wt_status_locate_scissors() is not a good name either (we do not say
"not found" when there is none).

We are locating the logical end of the commit log message.  It ends
at "---\n", if exists, in the output of "git format-patch", and it
ends at the cut-line, if exists, in "commit -v" editor buffer, and
if there aren't these funny End-Of-Message marks, then we return the
location of the last byte.  IOW, the helper function you added will
be the place to add more logic in the future if we ever found the
need to notice other kinds of "logical end" markers (which may be
ones we will invent in the future) while accepting a proposed commit
log message.

So how about calling it wt_status_locate_end() or something like
that, without limiting ourselves only to the "scissors"?
