Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85B531FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 18:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751281AbdBFSNN (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 13:13:13 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34378 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbdBFSNM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 13:13:12 -0500
Received: by mail-pf0-f193.google.com with SMTP id y143so7382477pfb.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 10:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=G6xaMrKhmf7GI3sUD9cRO80X0dSMwbVw0Fkna7hdxGw=;
        b=prg8DcNYabx1xeRiFEKhAAvOPB37ptWb6zKtJRMci39H9vuLywhYympjm9v1t8idQI
         CpWgTUR/YqFLA13SdRy8VAWZE5+By05xIMkHHMRVFz2HKumGWd6MzLKe/gx/lfROKERj
         Gz7FCsVuC/jS91yR/66XNj30N9oe6IoPNwBjpeyBixqljLK8bKduw4RCcg9nyteYFN7h
         9XOJZdMEb2VZB3XBE6JS0XWSVA7ZVoCuAlB7T1HUiKmCuvzg/X9uCYqh3Jt3+giE3uL1
         B/b9PQYp9qKGQFOqhXSVhVxtaGcHXP7tOlIMWpyes5yYPnSIL4u8oVMvip0uaO9VdC7Q
         Ojlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=G6xaMrKhmf7GI3sUD9cRO80X0dSMwbVw0Fkna7hdxGw=;
        b=c0yyLGlgBxBkT0TFLvRi83lwibxn+vpAhCVcS16M4IOpgokNzl58X/j3tyybZoJT2D
         99chYATCFVuG4Xmr/2BE1Yc5wtQS2RvngOhSynTuIUV54uXViSVQYDs9hc0PvcjTGk2p
         awGguvDj0idczYXXm/Xl3ai5QTGeV34jaJo8reTw6SRjKhG1D1x1B2CCgNwIpPiQ1u6v
         ZIT6q3mIlIkXVyeDm/s/KBSn+A/6fWiAmD8ZYu6zFlBiymY6TquEDwiGbi7SyWxWugAM
         iIz1GXEE0naT8COHZYqpc4yWsipqs8A3jP+0O5DkmmCDkB9Ol3RlXcdZunytV2qwR4nJ
         pnJQ==
X-Gm-Message-State: AIkVDXIIMnw7Q0vOtAi6yaylfmpkplgXz7FG38IqyCsPukXWj0yVNH+8WBLTvwmANm9z9A==
X-Received: by 10.84.129.67 with SMTP id 61mr19428279plb.103.1486404791842;
        Mon, 06 Feb 2017 10:13:11 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:310c:cda4:fdbc:2aa2])
        by smtp.gmail.com with ESMTPSA id b67sm4302551pfj.81.2017.02.06.10.13.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Feb 2017 10:13:11 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     David Aguilar <davvid@gmail.com>, Git ML <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH] difftool: fix bug when printing usage
References: <20170205201751.z4rfmy5xxaqg472l@gmail.com>
        <20170205212338.17667-1-davvid@gmail.com>
        <alpine.DEB.2.20.1702061716120.3496@virtualbox>
Date:   Mon, 06 Feb 2017 10:13:10 -0800
In-Reply-To: <alpine.DEB.2.20.1702061716120.3496@virtualbox> (Johannes
        Schindelin's message of "Mon, 6 Feb 2017 17:58:49 +0100 (CET)")
Message-ID: <xmqqinon2nnt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> +test_expect_success 'basic usage requires no repo' '
>> +	lines=$(git difftool -h | grep ^usage: | wc -l) &&
>> +	test "$lines" -eq 1 &&
>
> It may be easier to debug future breakages if you wrote
>
> 	git difftool -h | grep ^usage: >output &&
> 	test_line_count = 1 output &&
> or even better (changing the semantics now):
>
> 	test_expect_code 129 git difftool -h >output &&
> 	grep ^usage: output &&

True.

>> +	# create a ceiling directory to prevent Git from finding a repo
>> +	mkdir -p not/repo &&
>> +	ceiling="$PWD/not" &&
>> +	lines=$(cd not/repo &&
>> +		GIT_CEILING_DIRECTORIES="$ceiling" git difftool -h |
>> +		grep ^usage: | wc -l) &&
>> +	test "$lines" -eq 1 &&
>
> Likewise, this would become
>
> 	GIT_CEILING_DIRECTORIES="$PWD/not" \
> 	test_expect_code 129 git -C not/repo difftool -h >output &&
> 	grep ^usage: output

I agree with the intent, but the execution here is "Not quite".
test_expect_code being a shell function, it does not take the
"one-shot environment assignment for this single invocation," like
external commands do.

> More importantly: When I read $PWD all kinds of alarm bells go off in my
> head, as I immediately think of all the issues we have on Windows due to
> Git's regression test using POSIX paths all over the place.

And we appreciate that somebody who is more familiar with the issue
is watching ;-).

> Insofar as I am the author of the builtin difftool:
>
> Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

OK, thanks.
