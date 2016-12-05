Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3CC61FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 19:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbcLETZb (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 14:25:31 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36558 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751433AbcLETZa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 14:25:30 -0500
Received: by mail-pg0-f50.google.com with SMTP id f188so139246771pgc.3
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 11:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IihYalb09expQYuXaYGinY/hfu2Z7f38CvHC0yKA5ME=;
        b=HiltN/V2E8ea6qBZwUct5AOJUksUuwO7iCuadolG2HKfqQt2aMcjNUwPHHG7SsMh2v
         44pG0Iu5OtnO3ZKpNpwkmobWqvUfrDgByU4+B3n/dV8nO6RuZ4WsVzlihHUop4F7Jy9I
         /ili+4M2Kv9vzqUKrkMMIJFzLl53JQv/CVGFiVkZ5DGw8jQ0McCxPJEdzc+zZMKCk94J
         dAQsA5yJ0szLlIIxlBVvfnrlVNM66toH6GGh35Yo4VFhNQPjX0hbMwG0k4vpuorJatg4
         k4WmWQvzVew5xpnO7KRwxzZd8KiZqpORS8jiyTYk2k6Sddrj8C51sLmci2XoUxTaBPkR
         ltIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IihYalb09expQYuXaYGinY/hfu2Z7f38CvHC0yKA5ME=;
        b=c2Pp4LU4GYT7pP/Q9IzhJAyBJTQcFzOmtliabVKXEz6LyrGfrBTTWjF/NPrOgwwoAQ
         YAXZtcEPmlN4OljBjNrnQw8v4SypUloOlViygzLzEXiwSIUo3LuuHyO/Rqdm/YF6ZQMq
         F6WCVpotiPGznakaZSJy6xtesy08VrPv7udZH9MbFBH0l8xq8tcNEcs9Ulo9IOSbHjmr
         Ug6gF34530Qxkto4mAiRrUVYuOBO+B8n4acq8ew9y+ZdDuxlGf0/dYmwNDtudQllUTSl
         s0rqgm74yKC+UEHpwU3b5ZOvQoGPCNWzVaGhcrxI87KNN/T6SZ08+FkcHBbWa0n6rYu4
         IuNg==
X-Gm-Message-State: AKaTC00bQ/6s+Oo2f3yuG0tGx2bsizIknSKHKDuMXA7esJNIRnUqc1eIpZ+GYvmdppKAfD0a
X-Received: by 10.98.99.197 with SMTP id x188mr58324429pfb.179.1480965929716;
        Mon, 05 Dec 2016 11:25:29 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:20ca:c78:1a67:9579])
        by smtp.gmail.com with ESMTPSA id t89sm29259270pfe.50.2016.12.05.11.25.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 05 Dec 2016 11:25:28 -0800 (PST)
Date:   Mon, 5 Dec 2016 11:25:27 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     David.Turner@twosigma.com, git@vger.kernel.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net, gitster@pobox.com
Subject: Re: [RFC PATCHv2 15/17] checkout: recurse into submodules if asked to
Message-ID: <20161205192527.GA68588@google.com>
References: <20161203003022.29797-1-sbeller@google.com>
 <20161203003022.29797-16-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161203003022.29797-16-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/02, Stefan Beller wrote:
>  
>  test_expect_success '"checkout <submodule>" honors diff.ignoreSubmodules' '
> @@ -63,6 +70,260 @@ test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .git/
>  	! test -s actual
>  '

Should you use test_must_fail and not '!'?

-- 
Brandon Williams
