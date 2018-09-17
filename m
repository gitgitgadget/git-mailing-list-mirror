Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 846DB1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 21:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbeIRDPK (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:15:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38910 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbeIRDPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 23:15:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id t25-v6so271212wmi.3
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 14:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=2JKqD9b7GnSieBGsyhqKPGxybe0xgvBzkw8aaFS+q30=;
        b=UbwLkvCO4QUhLiEmGId/Q8hYDIk5DdQCCOvUBNwohmZ+hhMWDw+gwHDYhJxJ9Y0fQU
         Lv/NCr414r4JtvO4KJa9THvJSpz4Wuvu2jJEsQWzN9ivnBvnLVXXh60CQanuPkCpgVGG
         2YDkXVQI8vNaTkf6zqBshp+2fsRVXzTezfw2w2PsTqRJdqh4wN/w8ATYxcTeJl1Cv+6Y
         X2zpI4E+5FJ0Yl1IiklppCiPja2WyQm6LyTG3SkwmT7EY3zoqJszzG+9ndXyXL6F7Ip8
         1v4OApuErBybfk1jk1phVT49GEslbkb69pwwiitKcSPG1KV4BQD7n1ttogcRgajHEVJe
         gqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=2JKqD9b7GnSieBGsyhqKPGxybe0xgvBzkw8aaFS+q30=;
        b=RvMcv4HCBWxLWk7pLX+OlJsxQ4euetY54xy4BEs6McpUvtQOE3Uq/ZgX7cirCdmfhE
         vv+1PUcnDwHy3AqVahC9/cW4BChggs/HqnT0nSQslzn5+818GHr+/kGobho/tn2hBMKv
         kQo5ELDVz/++F/7fdJFelWK+JHPas8d77Y3FK7Rb0IMxr5RoigAJANiBwrWPqsLkTe0v
         qM9+6RQ4AAO5HR88EAsYFF/J3yHv0Hc+E9q3m4iKNjSmW0s06R9qGYpfr7Gdar8Sbg+8
         93R5UKU+2xr1uUndKW5sH+3+MTHuS0TYH028W/jYpBqUbyrCAzuUyFQsWzLbydvcBIXZ
         aeOA==
X-Gm-Message-State: APzg51BzWs6O/y5f7llgL76U/gPscsMQ5bKo+aQR0eATZdmuddWuAmmL
        3c4PSspE2ZJmZu/zBSkDOGU=
X-Google-Smtp-Source: ANB0VdZ0sSOCjls5EY6BZRwnyG00KZgFVUJ+e/TAW3oFxAdSf5wOUGltYFLAIZgKwQkTtXFadjDmNg==
X-Received: by 2002:a1c:4d09:: with SMTP id o9-v6mr13758588wmh.134.1537220756452;
        Mon, 17 Sep 2018 14:45:56 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h18-v6sm23851947wru.42.2018.09.17.14.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 14:45:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Todd Zullinger <tmz@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t5551-http-fetch-smart.sh: sort cookies before comparing
References: <20180907232205.31328-1-tmz@pobox.com>
        <20180907235508.GB32065@sigill.intra.peff.net>
        <20180908032841.GK7192@zaya.teonanacatl.net>
        <20180908161712.GA9016@sigill.intra.peff.net>
Date:   Mon, 17 Sep 2018 14:45:55 -0700
In-Reply-To: <20180908161712.GA9016@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 8 Sep 2018 12:17:12 -0400")
Message-ID: <xmqqd0tb6bn0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yes, I think sorting the expect file would work fine. I'm OK with that,
> or just leaving a comment. The comment has the bonus that it does not
> cost an extra process at runtime. I'd probably use a sort if we expected
> the list to be long and complicated, since it makes life easier on a
> future developer. But since there are only 2 lines, I don't think it's a
> big deal either way (or even just leaving it as-is without a comment is
> probably OK).

Let's have "| sort" if only for its documentation value.  That way
we do not have to remember the list must be sorted.

Here is what I'll merge to 'next'.

-- >8 --
From: Todd Zullinger <tmz@pobox.com>
Date: Fri, 7 Sep 2018 19:22:05 -0400
Subject: [PATCH] t5551-http-fetch-smart.sh: sort cookies before comparing
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With curl-7.61.1 cookies are sorted by creation-time¹.  Sort the output
used in the 'cookies stored in http.cookiefile when http.savecookies
set' test before comparing it to the expected cookies.

¹ https://github.com/curl/curl/commit/e2ef8d6fa ("cookies: support
  creation-time attribute for cookies", 2018-08-28)

[jc: Also use a part of the patch by Thomas Gummerer that sorts the
expected output, which makes it easier to maintain.]

Signed-off-by: Todd Zullinger <tmz@pobox.com>
Helped-by: Thomas Gummerer <t.gummerer@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5551-http-fetch-smart.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 771f36f9ff..d13b993201 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -206,7 +206,7 @@ test_expect_success 'dumb clone via http-backend respects namespace' '
 cat >cookies.txt <<EOF
 127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
 EOF
-cat >expect_cookies.txt <<EOF
+cat <<EOF | sort >expect_cookies.txt
 
 127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
 127.0.0.1	FALSE	/smart_cookies/repo.git/info/	FALSE	0	name	value
@@ -215,7 +215,7 @@ test_expect_success 'cookies stored in http.cookiefile when http.savecookies set
 	git config http.cookiefile cookies.txt &&
 	git config http.savecookies true &&
 	git ls-remote $HTTPD_URL/smart_cookies/repo.git master &&
-	tail -3 cookies.txt >cookies_tail.txt &&
+	tail -3 cookies.txt | sort >cookies_tail.txt &&
 	test_cmp expect_cookies.txt cookies_tail.txt
 '
 
-- 
2.19.0

