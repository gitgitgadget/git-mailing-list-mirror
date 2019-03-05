Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2287202BB
	for <e@80x24.org>; Tue,  5 Mar 2019 06:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfCEG3N (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 01:29:13 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51016 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfCEG3N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 01:29:13 -0500
Received: by mail-wm1-f67.google.com with SMTP id x7so1356815wmj.0
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 22:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=r5VWp4ylP3GppHyefR/FVHRQ/jMRfmn9jgfelaXEPqk=;
        b=jLX39EXLEWVSILPwFXioxIVJ26PCHSihOOoeEbgnZ3G1U6WCYZ9lOHzzlT5iBOQ9Ah
         WVc8VAkhbw9KhxZcPDlAPvDOCa4Pbi/6+m2UcG/W5kwa0HmMl1rKX9/3vrVqkEUN789V
         iGkGWk85VJw2PHS46RFST07ZqIOH/CDtkeplfaS+qj3Twp7pj9sI5CKH+LPIVt7CeNqu
         q/k8EP7i1AMHGOemYDtQH8vdOSGMTivRgiwyCTJKnf/uYNkve6lx765BYytBWe3q9McE
         gkK/4ghzInJXH0T8Aqv1NcA4MIltYeUil8E8Fmhb6OBU6USZgeKU6UD/7Ch777PuXySI
         7u+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=r5VWp4ylP3GppHyefR/FVHRQ/jMRfmn9jgfelaXEPqk=;
        b=LuTJfOx83GHL9i67aVZfuieKPgHamlHfULBrT8svfspkCayhf/mIG6Dz+WrrLlTbSL
         iGJUbjInLhIRcv4HaiHZcw95mweXK/uXegzvHP3cEmhUvLvD+g9JdHcZUz8JId0jVGyi
         TPcOolWz3ZsiKK8I0MDHSWdzshkSfC8OgO47BMNeGyirmyTZCnUKPBQyMwfTgicw7uEM
         Zz4goUifeiiucKnd+wGEjN+iyQc4RG0IErujswTwJdZhXcZzTcef6bZjHah14btt9LFV
         wGD6AqIy1H++SvqCX+aThy51woc91R2tn217LKvmgWlOi2pmVR7cEZAz0bAz0xz8RvEQ
         XG+Q==
X-Gm-Message-State: APjAAAXg8wiKGg9E1EVmYDxG1Zr/KlGrJnKQprDt0xBx5Q7sCzFsRYOz
        b9R3D4PDlyFkZ06m7bpdekxfTlB92a0=
X-Google-Smtp-Source: APXvYqx7k23tg2euWACxmDQ7TPH2S9lZbDzlaXWOGnT1XZnkUOXBb4+PqBB+p+UUlf8sXubX2KcKGA==
X-Received: by 2002:a7b:ce88:: with SMTP id q8mr1501198wmj.34.1551767349934;
        Mon, 04 Mar 2019 22:29:09 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v10sm14168984wrn.26.2019.03.04.22.29.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 22:29:06 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 03/21] range-diff: first rudimentary implementation
References: <pull.1.v5.git.gitgitgadget@gmail.com>
        <pull.1.v6.git.gitgitgadget@gmail.com>
        <08b8c3fc45253737ef6ca860e6cbe3ee6211d7a6.1534159977.git.gitgitgadget@gmail.com>
Date:   Tue, 05 Mar 2019 15:29:06 +0900
In-Reply-To: <08b8c3fc45253737ef6ca860e6cbe3ee6211d7a6.1534159977.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 13 Aug 2018
        04:33:04 -0700 (PDT)")
Message-ID: <xmqqr2blvnpp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +		else if (!line.buf[0] || starts_with(line.buf, "index "))
> +			/*
> +			 * A completely blank (not ' \n', which is context)
> +			 * line is not valid in a diff.  We skip it

I noticed this while wondering how somebody could teach range-diff
to honor --notes=amlog while preparing the patches to be compared
[*1*], but this assumption goes against what POSIX.1 says these
days.

    It is implementation-defined whether an empty unaffected line is
    written as an empty line or a line containing a single <space> character.

cf. http://pubs.opengroup.org/onlinepubs/9699919799/utilities/diff.html#tag_20_34_10_07

We need to insert ", as we disable user's diff.suppressBlankEmpty
settings" before ".  We skip it" (and if we get affected by the
setting, we need to fix it; it is not ultra-urgent, though).

[Footnote]

*1* ... which I do not have a good answer to, yet.  As discussed
earlier, the diffopt passed into the show_range_diff() machinery is
primarily meant for the final output (i.e. how the matching patches
from the two iterations are compared) and not about how the patches
to be compared are generated.  Worse, --notes=amlog (and possibly
other useful options) are parsed by "git log" side of the machinery,
not "git diff" side that populates diffopt.
