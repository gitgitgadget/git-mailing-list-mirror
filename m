Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A45D20248
	for <e@80x24.org>; Mon, 25 Mar 2019 02:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfCYCav (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 22:30:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36984 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbfCYCav (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 22:30:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so8300177wrm.4
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 19:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=O8nSt+VA6iqGo2WZnJg6/5FBnT/v2Hu8CDLv0dmaWas=;
        b=BZbrpl4n1gX6oIAgv9LEc765hGESsNYVVzk7fkvGSNAtKETcIEzTclFsRcytNJThsS
         /UGtW3tbH6F9gP+g7a1Ym0mr0SdDIKx8k2R4Vx8YREOnh1oTOBBZZLb2M2jrdY3vOQp2
         uOovEeVPDYSE82fWSkaj1USawbyALBpcKCEKjMd/reknkFwYV+pHHgJmy+RsYpYMDuoF
         sskovOglbvF0q53oNX6m/+fpuk1+Kvax4IF4/B4A7P+DuTy1V4brLFfJnZzyGO2Y9uqK
         BEmiygzkMNiJOvHLWmGrW/W4Ax0WUkQ28wBTZ4z9w/yKiC+WvIEpBeoNdDAuRPP9rJFA
         j53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=O8nSt+VA6iqGo2WZnJg6/5FBnT/v2Hu8CDLv0dmaWas=;
        b=LxV2W8tdx0mDfDSmw8RPxR7h150Xzhvx+CSHKkoWihEQuf5/WzAJswFWNXUb0Q79Qw
         PCYB1OMfTgikZiBbqU7twh58d82xLRx73CFPnPcWQknNWdLiWdmhzDAyDXIjsdO0thvJ
         fE7vad0yZ5HQP6+j02pDLONZ/ZqJYB0NKmgQvJPyAqLZP34dUyNGQFHDHrb+I4Qf92Ih
         ODr/dR6ymO5fjn/wjrxSG2LP3n0oAu1d4pm8RQlpTQScvQQch+2k4aqWB8uHiLUgJgvo
         7lbdVxXt/0wg03hG60VqrGJr36mN1Ckgux/TVrZTMJ15cufZ/IqaaGx5U64ilwJoCsUz
         NvHg==
X-Gm-Message-State: APjAAAV57IvC3648gvnx2ztrdxkTjKBz+hdNWNsFJyJ5F0Ovt9WNpPqV
        nFejbLlBnIw02RvoDt9NwdaGXeDQUf8=
X-Google-Smtp-Source: APXvYqyqBFB9eNj2Kx+MwSJ3EQ8uI0aGc2hPUWxK5SsuQNhpaW10rkKUyQR4+WXxVzXYW4t4IYzXxg==
X-Received: by 2002:a5d:564d:: with SMTP id j13mr13599077wrw.155.1553481048963;
        Sun, 24 Mar 2019 19:30:48 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id v10sm14362373wrn.26.2019.03.24.19.30.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 19:30:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, jason.karns@gmail.com, me@ttaylorr.com
Subject: Re: [PATCH v2] config: correct '**' matching in includeIf patterns
References: <20190323034535.23364-1-pclouds@gmail.com>
        <20190324131755.26821-1-pclouds@gmail.com>
Date:   Mon, 25 Mar 2019 11:30:47 +0900
In-Reply-To: <20190324131755.26821-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 24 Mar 2019 20:17:55 +0700")
Message-ID: <xmqqa7hjofc8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> The current wildmatch() call for includeIf's gitdir pattern does not
> pass the WM_PATHNAME flag. Without this flag, '*' is treated _almost_
> the same as '**' (because '*' also matches slashes) with one exception:
>
> '/**/' can match a single slash. The pattern 'foo/**/bar' matches
> 'foo/bar'.
>
> But '/*/', which is essentially what wildmatch engine sees without
> WM_PATHNAME, has to match two slashes (and '*' matches nothing). Which
> means 'foo/*/bar' cannot match 'foo/bar'. It can only match 'foo//bar'.
>
> The result of this is the current wildmatch() call works most of the
> time until the user depends on '/**/' matching no path component. And
> also '*' matches slashes while it should not, but people probably
> haven't noticed this yet. The fix is straightforward.

> +test_expect_success 'conditional include with /**/' '
> +	mkdir foo/bar &&
> +	git init foo/bar/repo &&
> +	(
> +		cd foo/bar/repo &&
> +		echo "[includeIf \"gitdir:**/foo/**/bar/**\"]path=bar7" >>.git/config &&
> +		echo "[test]seven=7" >.git/bar7 &&
> +		echo 7 >expect &&
> +		git config test.seven >actual &&
> +		test_cmp expect actual
> +	)
> +'

That's cute ;-)

Thanks for quickly working on the fix with an incredibly short
turnaround time since the initial report.

P.S. I expect to be offline for most of the week (packing, moving
and unpacking.  Even though the places packing and unpacking happens
are within 1 kilometer radius, that does not make it less hassle
X-<).  See you guys next month.
