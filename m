Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 685BF201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 21:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbdBXVZn (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 16:25:43 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36533 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbdBXVZm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 16:25:42 -0500
Received: by mail-pg0-f65.google.com with SMTP id z128so4378051pgb.3
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 13:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cvAKDFa5iIfKergchJHBQ6RJlSVMqb3j9DYUwt4cgYA=;
        b=ll0nOO2OOYfJ0JflepVjQVVcynLGnLaIy7smlFPtAsyQM3DBpHu3xDrhtuuWSjxsVo
         wHb3enYCkUOxPCG00frxlmQYmjkkEcnMbnchi0mwuzXz8h99DvmqtH8pLg+H+C9spBjP
         aw0DzX22RSp7qVeYFBIKWXsDAGZ7QEQKqjI8il2cWNIkwXwiPRU3f6A1WtlpURCWjl5v
         f8R4RG3ENV+0liosjwxeMsRNrwjaq1D1DlnbVMwnD0GkUokobd+EiJxN/ijv7qCVeoBZ
         5zrVDJ5OFO39CPfBJjpYQM6tEBYOTB6qpveQmJ6YQD204NWo7Sq3EjqVvs/NGGordahB
         pOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cvAKDFa5iIfKergchJHBQ6RJlSVMqb3j9DYUwt4cgYA=;
        b=NuyLBEpgSIt8DD/LgYoYldSnx1GOf4kId9g63poRDTwu/mPHPHLhhigxvSLadbPSk5
         Sn9u34G+nrJ8Es2XGaRNyhMtTRr+W/vJKnSH7CnS+dHmQ1zWSEH+kyv4O/KUp1W/6c9Z
         2bcTDGeOGP0wpel+TN0xgzt9MUvI8xFp9Lfm4eGj9SuUmex4kEi3XuZz3Y8ZHt4HZBfC
         pDaoR2pieaxptK2qUU3i6pJzV9CvjftFyQ8OOeJgV+cmoT4e+F2voHBjPxPB2gr/lEzx
         5UFouU0tZXjrbbPjB+9jEHIJsDVFp8zfZwyXaGBwOBgHnlxVAtT0ra4gI2t6N7jVYS2b
         JE7w==
X-Gm-Message-State: AMke39mo84v69V+863gg2WCBpWJHe6ecB9ggssoPxRzkItQt+PN2XX4ceDvRJMbwxyimPw==
X-Received: by 10.98.78.66 with SMTP id c63mr6054940pfb.138.1487971480528;
        Fri, 24 Feb 2017 13:24:40 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f06c:2e0c:850d:31b4])
        by smtp.gmail.com with ESMTPSA id q73sm3141480pfa.129.2017.02.24.13.24.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 13:24:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] refs: parse_hide_refs_config to use parse_config_key
References: <20170224203335.3762-1-sbeller@google.com>
        <20170224203940.hbmfsouw5k67l3h3@sigill.intra.peff.net>
        <20170224210643.max6z2ykm3gbg7lw@sigill.intra.peff.net>
        <xmqq4lzj1e4n.fsf@gitster.mtv.corp.google.com>
        <20170224212025.hcxusnrxijzb5qox@sigill.intra.peff.net>
Date:   Fri, 24 Feb 2017 13:24:38 -0800
In-Reply-To: <20170224212025.hcxusnrxijzb5qox@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 24 Feb 2017 16:20:25 -0500")
Message-ID: <xmqqvarzz3hl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Feb 24, 2017 at 01:18:48PM -0800, Junio C Hamano wrote:
>
>> > While I'm thinking about it, here are patches to do that. The third one
>> > I'd probably squash into yours (after ordering it to the end).
>> >
>> >   [1/3]: parse_config_key: use skip_prefix instead of starts_with
>> >   [2/3]: parse_config_key: allow matching single-level config
>> >   [3/3]: parse_hide_refs_config: tell parse_config_key we don't want a subsection
>> 
>> While you were doing that, I was grepping the call sites for
>> parse_config_key() and made sure that all of them are OK when fed
>> two level names.  Most of them follow this pattern:
>> 
>> 	if (parse_config_key(k, "diff", &name, &namelen, &type) || !name)
>> 		return -1;
>> 
>> and ones that do not immediately check !name does either eventually
>> do so or have separate codepaths for handlihng two- and three-level
>> names.
>
> Yeah, I did that, too. :)
>
> I don't think there are any other sites to convert. And I don't think we
> can make the "!name" case easier (because some call-sites do want to
> handle both types). And it's not like it gets much easier anyway (unlike
> the opposite case, you _do_ need to declare the extra variables.

Yeah, because the rejection of !name as an error is not the only
reason these call sites have &name and &namelen---they want to use
that subsection name after that if() statement rejects malformed
input, so we cannot really lose them.

Thanks.  All three looked good.
