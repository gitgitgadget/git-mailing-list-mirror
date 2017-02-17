Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88867201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 22:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935084AbdBQWFU (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 17:05:20 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34724 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934415AbdBQWFT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 17:05:19 -0500
Received: by mail-pf0-f194.google.com with SMTP id o64so4871004pfb.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 14:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=csTDDQEQuD9zOYzU2hqRsl8mHQGHlGjCRkOx7mhS7qw=;
        b=vdk83IkNiifktCcFN7axG5SPXu7v3ct+mXlHEnqekmNN+xiKQlF/JRUjbqy34Pf0PQ
         D4Nqjvxul0JMzq12ltlPWejA9nDvbESgPbo5WTWvtnqWP/VDeMqIMExPdeKitvHAd+HB
         knCaKs4IYPmpp4B0drxaej/tjVDC8GIDXPmSolJdosssKhcsonvxOZraY6mv43JJSvmj
         YEb4xcTDWOmJTh7ChW4zqfLUXWMGaLg4IagP9PgUPTVfG4JL68Pt5kd+DjfyTOINp4GI
         +yA5s91WNYC1dafrK/XquyPNGSiKL2DoctziTKe11wft3+0c5gnj/iRqXPmxaEGuNigA
         qthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=csTDDQEQuD9zOYzU2hqRsl8mHQGHlGjCRkOx7mhS7qw=;
        b=iZOy8EQ8kxCno+uEVGQxhdYuNskVi+3UUNGcDzuDQs4v1Qggl7vH4tndo7FSwmJeI4
         Wo4m6W4p5iH9IuxcsrdTcXSMZorujlp3mCY3uxPO0KP9DYQzConsFlkFCFXsqit7ZMIm
         2CiJReiTQIqB4i+55ocpd7b79xxE/BRHINUJ+9xR95JJIvuwBDKe/1/rRT+MXrU7/+f6
         7vQ/81vw4HGeCZeeV6aekfQcSjgAkzdK67qtZ46kqeRHHdTRq3aK+74eJXZppXb67l8l
         oqyPhDbk0LnVori7alTtkMVNGn8sarpY9F1OB7KI/Hl9F13OCOK7WxD9/H98Wqp0L8Xx
         AzEw==
X-Gm-Message-State: AMke39n5145rtUa/dDycbIbl1VRF2dFYuMRpLkt7++rdfMNup2N3kQxqYXxAyb+gQSC4bg==
X-Received: by 10.99.125.17 with SMTP id y17mr12785784pgc.27.1487369118721;
        Fri, 17 Feb 2017 14:05:18 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id g70sm21319061pfb.50.2017.02.17.14.05.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 14:05:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Crowe <mac@mcrowe.com>
Cc:     git@vger.kernel.org
Subject: Re: git diff --quiet exits with 1 on clean tree with CRLF conversions
References: <20170217212633.GA24937@mcrowe.com>
Date:   Fri, 17 Feb 2017 14:05:17 -0800
In-Reply-To: <20170217212633.GA24937@mcrowe.com> (Mike Crowe's message of
        "Fri, 17 Feb 2017 21:26:33 +0000")
Message-ID: <xmqqr32wqxr6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Crowe <mac@mcrowe.com> writes:

> If "git diff --quiet" finds it necessary to compare actual file contents,
> and a file requires CRLF conversion, then it incorrectly exits with an exit
> code of 1 even if there have been no changes.
>
> The patch below adds a test file that shows the problem.

If "git diff" does not show any output and "git diff --exit-code" or
"git diff --quiet" says there are differences, then it is a bug.

I would however have expected that any culprit would involve a code
that says "under QUICK option, we do not have to bother doing
this".  The part you quoted:

> 	if (!DIFF_FILE_VALID(p->one) || /* (1) */
> 	    !DIFF_FILE_VALID(p->two) ||
> 	    (p->one->oid_valid && p->two->oid_valid) ||
> 	    (p->one->mode != p->two->mode) ||
> 	    diff_populate_filespec(p->one, CHECK_SIZE_ONLY) ||
> 	    diff_populate_filespec(p->two, CHECK_SIZE_ONLY) ||
> 	    (p->one->size != p->two->size) ||
> 	    !diff_filespec_is_identical(p->one, p->two)) /* (2) */
> 		p->skip_stat_unmatch_result = 1;

is used by "git diff" with and without "--quiet", afacr, so I
suspect that the bug lies somewhere else.
