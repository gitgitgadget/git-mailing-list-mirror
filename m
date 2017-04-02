Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10EC21FAFB
	for <e@80x24.org>; Sun,  2 Apr 2017 11:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751772AbdDBLlO (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 07:41:14 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35087 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751762AbdDBLlM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 07:41:12 -0400
Received: by mail-lf0-f53.google.com with SMTP id j90so60319561lfk.2
        for <git@vger.kernel.org>; Sun, 02 Apr 2017 04:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=FOnDcpOWF8D39UO1JLLnPi+5yFFJ8G6hEo0BHoPvMYg=;
        b=Ls94d+FLKFrQrhvpYqHM4e7Ewmen29Mwpb4osI9PgJYaxmuIs+cnC/ZiruyRTuBPVj
         zysYFj5CVQF8AblPc4KAUEk3KF7HIFe4Q99HxQzAvp3rn8yA/NWZQxE6yAXL4Cf5EzCV
         kSWskThsoezDtlHDedY3YWfRoRbdsjGYI0Og+Vb0SX8qEU1aVMyc53atS4A21rKxMY3h
         7JBYx4xx3BXFQKgKbvTohms29BltZpFnHr8VVym/4DcevykhBecieHI310noLekmfT8X
         9Rm4AO3EAxEyyADWyWuy/xsXrbjrEiuc3Umkwk/3uq79meMY4bzHrjBIk3N7CX+ETNaE
         5yNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=FOnDcpOWF8D39UO1JLLnPi+5yFFJ8G6hEo0BHoPvMYg=;
        b=eEmxunjc/U1rZ07HGLIAGRg9UynlyEsUlDdWwXdV2fA7ulLA4rcYAGIgYw7HwKwKnG
         KsNqcykBOvZtHbMujEOFHuHyZo0cLhptQ0MylWQYKFNavgxpblCFOGBsYd5tF7UG8fcA
         eb7yR9c3buDdJNmNE/+ys6HrqDsLiFjMPEO5Sv77KLDZl3tm6vr02msXFh9JZoOqcbH2
         rLYaJxFOXlRign7itKJzgoT5+tb9tuxrCSkVAFkVtaXjRxE1k//BokCpnqV6nsu3WiLt
         GWuEP3sa9DP0oW+O8nVb9SHVBta1kxSvD918iHE4aA09iPZ7s2BGT6VV/5EnfBUbxWxC
         WdcQ==
X-Gm-Message-State: AFeK/H2MOUGHJeQWrZ8nYJrr9izpu41nGLkyiB9O63uyZaChss+zPXpo9L49ws7PJPeLLA==
X-Received: by 10.46.33.141 with SMTP id h13mr3675987lji.93.1491133270154;
        Sun, 02 Apr 2017 04:41:10 -0700 (PDT)
Received: from [192.168.1.26] (abpo61.neoplus.adsl.tpnet.pl. [83.8.56.61])
        by smtp.googlemail.com with ESMTPSA id v13sm1957758lfi.6.2017.04.02.04.41.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Apr 2017 04:41:09 -0700 (PDT)
Subject: Re: [BUG?] iconv used as textconv, and spurious ^M on added lines on
 Windows
To:     Jeff King <peff@peff.net>
References: <feaeade7-aeb5-fa67-ab29-9106aeadb2a6@gmail.com>
 <20170330200021.c2l5jak3xb5aoxyc@sigill.intra.peff.net>
 <e1a6d44c-b01b-993c-6a22-e6ac0abca03c@gmail.com>
 <20170401060800.hrpqqgdx6t262c7f@sigill.intra.peff.net>
 <63eb5546-0dce-2f69-c2f8-1e777b97c532@gmail.com>
 <20170402074522.4qhannjus4ynwx4i@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <3e35eda2-0240-8504-b56e-f66092cc1775@gmail.com>
Date:   Sun, 2 Apr 2017 13:40:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170402074522.4qhannjus4ynwx4i@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 02.04.2017 o 09:45, Jeff King pisze:
> On Sat, Apr 01, 2017 at 08:31:27PM +0200, Jakub Narębski wrote:
> 
>> W dniu 01.04.2017 o 08:08, Jeff King pisze:
>>> On Fri, Mar 31, 2017 at 03:24:48PM +0200, Jakub Narębski wrote:
>>>
>>>>> I suspect in the normal case that git is doing line-ending conversion,
>>>>> but it's suppressed when textconv is in use.
>>>>
>>>> I would not consider this a bug if not for the fact that there is no ^M
>>>> without using iconv as textconv.
>>>
>>> I don't think it's a bug, though. You have told Git that you will
>>> convert the contents (whatever their format) into the canonical format,
>>> but your program to do so includes a CR.
>>
>> Well, I have not declared file binary with "binary = true" in diff driver
>> definition, isn't it?
> 
> I don't think binary has anything to do with it. A textconv filter takes
> input (binary or not) and delivers a normalized representation to feed
> to the diff algorithm. There's no further post-processing, and it's the
> responsibility of the filter to deliver the bytes it wants diffed.
> 
> Like I said, I could see an argument for treating the filter output as
> text to be pre-processed, but that's not how it works (and I don't think
> it is a good idea to change it now, unless by adding an option to the
> diff filter).

I think that actually there is something wrong.

If textconv really gets normalized representation of pre-image (the index
version) and post-image (the filesystem version), as it should I think,
both pre-image lines ('-') and post-image lines ('+') should use CRLF,
so there should be no warning, i.e. ^M

Or textconv filter gets normalized representation (it looks this way
when examining diff result saved to file with `git diff test.tex >test.diff`;
I were unable to use `tr '\r' 'Q', either I got "fatal: bad config line"
from Git, or "tr: extra operand" from tr), and somehow Git mistakes
what is happening and writes those ^M.

If I understand it correctly, if pre-image, post-image and context
all use the same eol, there should be no warning, isn't it?

> 
>> P.S. What do you think about Git supporting 'encoding' attribute (or
>> 'core.encoding' config) plus 'core.outputEncoding' in-core?
> 
> Supporting an "encoding" attribute to normalize file encodings in diffs
> seems reasonable to me. But it would have to be enabled only for
> human-readable diffs, as the result could not be applied (so the same as
> textconv).

I was thinking about human readable diffs, and 'git show <blob>', same
as with textconv.

> 
> I don't think core.outputEncoding is necessarily a good idea. We are not
> really equipped anything that isn't an ascii superset, as we intermingle
> the bytes with ascii diff headers (though I think that is true of the
> commitEncoding stuff; I assume everything breaks horribly if you tried
> to set that to UTF-16, but I've never tried it).

Well, the understanding would be that the same limitation as for 
core.logOutputEncoding (documented if it isn't) that only encodings that
are ASCII compatibile are supported.
 
-- 
Jakub Narębski

