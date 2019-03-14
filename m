Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14303202BB
	for <e@80x24.org>; Thu, 14 Mar 2019 03:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfCND2k (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 23:28:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35705 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfCND2j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 23:28:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id y15so1269079wma.0
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 20:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=degiJAYQIG3/qtmR38UxadedxmQ5aiEIFCzfL7V+OMM=;
        b=IpegcXAOGhGvmt4iylKJapqxxB6u3uDgUobblIX1ICS2gabtdMBr7OIeqA8MgEMVCL
         +N6ZZ/lkLtdJZgsrmfiQb0CZXDpWsjzf7D4IdpZSkrp9I+s3w5kdJvisMWYloR0h92UD
         vOFZmt79vOvr2Y0ZRAAjxr5055pifYr7SgHv+12eO2bmfHRv0AE7UU8wVltd6e4QQjr9
         GYMe1ans0Erajg5TTM6EmWzSLyRGJ4Tki7uxgcNiTRXCOuEG0YZRMZXqnbNltvY0MXB6
         lKfES9AZrN1iRxSE43Yuus5xZtgakrABHIYGsaX2GL1OZeJ8K8bEMcvN831wwxdouo3h
         gihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=degiJAYQIG3/qtmR38UxadedxmQ5aiEIFCzfL7V+OMM=;
        b=muPK/9o+c66HzFYqcHoQyMp8eaOd4nE/o+ePeKc3bC3cCFCBSZ4DQtVQgD1O1dU2Sm
         EGxCk/ijA+5X67DDBSmOH9Fi++oh2OP9I7sJYvcOEEUAGO5/0uK8FHM9DQ2Ry9SFRKhy
         uwJB+BWyem7qm1WBwFkFVSoxAggtDW/qGA778otFeoaSK7umFLMvKr7x6MtaiBYJkxS2
         S8Zw4RXSxzKWJGpHu/RvfSsI6E3fpBFl1ACMD5Kqi0XEUOvBitXnZHF+csTyETsGnntD
         h3Vp1GMvYMURXLM6MZevhnOTtUK9yuStuWIjZmXcaa9YUfyueO2cgGLcKX/u5aFwqUNd
         NpaA==
X-Gm-Message-State: APjAAAURQfS5oqoZHdpHAev1Qy+GF35+EWI2GMB33iLJx1OK0xUCiRyN
        oAjRkuKnxf8vA5eM1qfZQBk=
X-Google-Smtp-Source: APXvYqxT2DkrHkx+0He3oGb4uivZ2qNIHfPU/u2wLjb7N6Mq4gdYj7YSkYtfq1ZOarKQt6LksFdb/w==
X-Received: by 2002:a1c:eb17:: with SMTP id j23mr807209wmh.86.1552534116422;
        Wed, 13 Mar 2019 20:28:36 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id t2sm13548806wra.9.2019.03.13.20.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 20:28:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 05/11] tests: use 'test_atexit' to stop httpd
References: <20190313122419.2210-1-szeder.dev@gmail.com>
        <20190313122419.2210-6-szeder.dev@gmail.com>
Date:   Thu, 14 Mar 2019 12:28:35 +0900
In-Reply-To: <20190313122419.2210-6-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Wed, 13 Mar 2019 13:24:13 +0100")
Message-ID: <xmqqd0mub0d8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>  t/lib-git-svn.sh                              | 5 -----
>  t/lib-httpd.sh                                | 6 +-----
>  t/t0410-partial-clone.sh                      | 2 --
>  t/t5500-fetch-pack.sh                         | 3 ---
>  t/t5510-fetch.sh                              | 2 --
>  t/t5537-fetch-shallow.sh                      | 2 --
>  t/t5539-fetch-http-shallow.sh                 | 1 -
>  t/t5540-http-push-webdav.sh                   | 2 --
>  t/t5541-http-push-smart.sh                    | 1 -
>  t/t5542-push-http-shallow.sh                  | 1 -
>  t/t5545-push-options.sh                       | 2 --
>  t/t5550-http-fetch-dumb.sh                    | 1 -
>  t/t5551-http-fetch-smart.sh                   | 1 -
>  t/t5561-http-backend.sh                       | 1 -
>  t/t5581-http-curl-verbose.sh                  | 2 --
>  t/t5601-clone.sh                              | 2 --
>  t/t5616-partial-clone.sh                      | 2 --
>  t/t5700-protocol-v1.sh                        | 2 --
>  t/t5702-protocol-v2.sh                        | 2 --
>  t/t5703-upload-pack-ref-in-want.sh            | 2 --
>  t/t5812-proto-disable-http.sh                 | 1 -
>  t/t9115-git-svn-dcommit-funky-renames.sh      | 2 --
>  t/t9118-git-svn-funky-branch-names.sh         | 2 --
>  t/t9120-git-svn-clone-with-percent-escapes.sh | 2 --
>  t/t9142-git-svn-shallow-clone.sh              | 2 --

I see most of these changes are removal of stop_httpd because it is
done as part of start_httpd() to arrange it to be called at exit.

But ...

> @@ -176,7 +175,7 @@ prepare_httpd() {
>  start_httpd() {
>  	prepare_httpd >&3 2>&4
>  
> -	trap 'code=$?; stop_httpd; (exit $code); die' EXIT
> +	test_atexit stop_httpd
>  
>  	"$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
>  		-f "$TEST_PATH/apache.conf" $HTTPD_PARA \
> @@ -184,15 +183,12 @@ start_httpd() {
>  		>&3 2>&4
>  	if test $? -ne 0
>  	then
> -		trap 'die' EXIT
>  		cat "$HTTPD_ROOT_PATH"/error.log >&4 2>/dev/null
>  		test_skip_or_die $GIT_TEST_HTTPD "web server setup failed"
>  	fi
>  }
>  
>  stop_httpd() {
> -	trap 'die' EXIT
> -
>  	"$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
>  		-f "$TEST_PATH/apache.conf" $HTTPD_PARA -k stop
>  }

... I see we lost many "trap 'die' EXIT" in the orignal.  Is that
something we want to lose as part of this commit?  It does not make
sense, at least to me, to add a "test_atexit die" and I am mostly
wondering what these traps were trying to do in the original.

