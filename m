Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 395B2201A7
	for <e@80x24.org>; Thu, 18 May 2017 03:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932101AbdERDZR (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 23:25:17 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:32871 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753855AbdERDZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 23:25:16 -0400
Received: by mail-pg0-f68.google.com with SMTP id s62so4206966pgc.0
        for <git@vger.kernel.org>; Wed, 17 May 2017 20:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NdE9Hn/qqeFd++WNyCiTDnTfLwiUG47rZMAh6fVYuFc=;
        b=fkoF4eJg9ALsCULOuTRL9GIvnZNXOELycmGbnYYgZt8kDP4ONZTg6xgPZM286x7AuP
         oMJCZi1IVcQzH4tmtjuscizoNbHmFzBGPedYC4RDUUZMPerM9Oymiw7czS1PfS44P93d
         z7QjThBLyHYdyYKOQDLHcgS8ogQkGAyD8Ew+8B5S/mkcy7GONdPbfgw3u6qOp8XLMopa
         M6vm63pcoLMzy+qCOLffpBaFdcIu3ccAiXHAjvLVPHaIIUGOAcguKo2TACZzK8fVeKJf
         Fh1u5zSk90iB0op9TdvB9z48xdO3XcoyVGoVfSENIhViMTdkZbq7DzeGukg9Bu5AiA9v
         3vGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NdE9Hn/qqeFd++WNyCiTDnTfLwiUG47rZMAh6fVYuFc=;
        b=Al9Nzl/hz8Igthz5X4esv/Id/Rj8iOE8enwbW88KxezvU3waXWzoSq8Ec1D1luIDh6
         E/5RWiEHQl+VXr5epEnsR2OmKimEsE5CFZt+GdoUS0uRcE1JvKH9OFF2yUGIRRsj1tO+
         ca5K3jHCk1gwqStgWFWRRmzoV/GRrZWa9+yKjT0b1n2YYalVkl5oY3nw17/nPmztBjEw
         TLnhHgyYlicP1ydYuo4IFWyJINfb2rwp6Cv4iiNq3Daa1SMAS5q3nj+cj4bfYv4DY1Y1
         cj4arNGlxolVQxqlTpaNuJ0dJmWBy+BWZ8E6d6C5Tp7p9qXLrU3wU9ONdgZuRsLPA/v5
         YIpw==
X-Gm-Message-State: AODbwcCKL/pD/yeGNVT9Bu+U9RTaIRnITQpZb/40EN3q9xLIrBoLnktg
        Cepsr2oAtCkp0g==
X-Received: by 10.99.115.5 with SMTP id o5mr2144761pgc.234.1495077915447;
        Wed, 17 May 2017 20:25:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f155:f4fa:305b:79e3])
        by smtp.gmail.com with ESMTPSA id g23sm5714326pfb.54.2017.05.17.20.25.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 17 May 2017 20:25:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCHv2 12/20] submodule.c: convert show_submodule_summary to use emit_line_fmt
References: <20170514040117.25865-1-sbeller@google.com>
        <20170517025857.32320-1-sbeller@google.com>
        <20170517025857.32320-13-sbeller@google.com>
        <xmqq8tlwxdp3.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbCYiDRbf2+uXANqBiR9sG4ir4m6VK5+t1LS-kE7T1aQg@mail.gmail.com>
Date:   Thu, 18 May 2017 12:25:14 +0900
In-Reply-To: <CAGZ79kbCYiDRbf2+uXANqBiR9sG4ir4m6VK5+t1LS-kE7T1aQg@mail.gmail.com>
        (Stefan Beller's message of "Wed, 17 May 2017 14:05:10 -0700")
Message-ID: <xmqqinkyvobp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>> +static void show_submodule_header(struct diff_options *o, const char *path,
>>>               struct object_id *one, struct object_id *two,
>>>               unsigned dirty_submodule, const char *meta,
>>>               const char *reset,
>> ...
>> How does capturing these lines help moved line detection, by the
>> way?  These must never be matched with any other added or removed
>> line in the real patch output.
>
> Why?

What are buffered are not patch text, but informational text like
"Submodule X contains untracked content", etc.  When a text file is
modified elsewhere and lost a line that happened to say the same
contents, we do not want to consider that such a line was moved to
where a submodule had an untracked file.

I have a suspicion that the two-pass buffering is done at too high a
level in this series.  Doesn't the code (I haven't reached the end
of the series) update emit_line() to buffer the patch text and these
non-patch text with all the coloring and resetting sequences?
Because the "ah, this old line removed corresponds to that new line
that appears elsewhere?" logic do not want to see these color/reset
sequence, the buffering code needs to become quite specific to how
the current diff code is colored (e.g. a line must be painted in a
single color and have reset at the end) and makes future change to
color things differently almost impossible (e.g. imagine how you
would add a "feature" that paints certain words on added lines
differently?).

Ahh, yes, I see NEEDSWORK comment in patch 19/20.  

Yes, I agree that this code really should be working in terms of
offsets into pre/post images when finding matching changes, which
probably should happen without letting fn_out_consume produce fully
colored textual diff output in the first pass.  For the purpose of
"moved lines detection", the logic to match a stretch of preimage
lines with postimage lines do not want to bother with "--- a/$path"
headers, and it does not want to care if a line that begins with '+'
needs to be added by calling emit_add_line() that knows how to check
ws errors or the payload needs to be painted in green.  After the
first pass determines which added lines are not true addition but
merely moved, the second pass would know how that '+' line needs to
be painted a lot better (e.g. it may not be painted in green).
Letting fn_out_consume() call emit_add_line() only to compute
information (e.g. "'+'? ok, green") that the first pass does not
want to see and the second pass will compute better is probably not
a good longer term direction to go in.

Having said that, we need to start somewhere, and I think it is a
reasonable first-cut attempt to work on top of the textual output
like this series does (IOW, while I do agree with the NEEDSWORK and
the way this series currently does things must be revamped in the
longer term, I do not think we should wait until that happens to
start playing with this topic).

Thanks.



