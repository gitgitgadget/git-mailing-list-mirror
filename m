Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C38F220248
	for <e@80x24.org>; Sat,  9 Mar 2019 11:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfCILgY (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 06:36:24 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:33855 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbfCILgX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 06:36:23 -0500
Received: by mail-it1-f196.google.com with SMTP id d125so12606227ith.1
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 03:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=RQZJO+lxhy2GvE7BkDYMJisVVmhjxLpQdVcMj6Q0e3k=;
        b=LjwjAgSGd6c1T8xuF5Zcqiu6mVlK3P5BiOxI0wMZsH7l8aOxSQm1n6lEza5mLBb+BR
         c8ydApM+kQDGwjNvjxiPvLgZ5q1rJFzPAuAGUQklpcLdePPCyV+cWPVAsXBtObUeo99u
         nitWaSkzeajvviLsCJEXLek9JhYS8eysj3plZgDevwm0TCk3jAhe1Uk3T1Bv0zgV+RGg
         ZNX7YnJf/n77BA0UB6UyrNPbYlmaWpN9CH1JvRR6u1pbHS0INJ5biz3FSsYRa6M19d5v
         iA1/CCneSHnOpWhJIDMms2M1H7dfOlcej9a3MKaoDoEZdsURcYuNbKZ/wC6B06uIJbHk
         a25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=RQZJO+lxhy2GvE7BkDYMJisVVmhjxLpQdVcMj6Q0e3k=;
        b=j9W7YaItDdriSJoFBZEYcy9AYmz23P0PbZrTxXCF9trjF1DFDHTMoI1y2HvUkxvx/Y
         MP8a7f9wkwwSnVG8R/KUOl0cQRMcOx//v2Sa2TX3DiWACHMX2KEF/PAHMyd8pLPBvvwc
         E3g3QT4YwPjLHHcce3SMvDUmBuvOuvoYf22bHsb/tLWyeM/jcPuMBCnbTz/q96pQRJkN
         qKPDTZfEBBWlJOqSEpCRqdGY3W+tbJryZClTFPqLVWd4PaM3EgmXJCULeTrjEKZ3wOry
         IyQubpAAu1Hv5UepQGU75C9I34czdvXwpdNfEIvt95e2YLkVLvzGvqSEUMp/YOGTquB1
         IJTg==
X-Gm-Message-State: APjAAAXx9mIgEOzIyKj2Wy0KA+1XWLNLja4KK/gElsoAeXrNISKX/Qzj
        +/Y2/qvLstIzH/IEQUWq3pAn2cvlkyGSikWYXzvrgJcT
X-Google-Smtp-Source: APXvYqyINncyv2FBy2l1hGaAiLiUeFhiroZyl3lhkz3usAEbsgH5YJxxSR1smOoORXg+uMjPE9ukPAiwpaJ4ZRtZuaQ=
X-Received: by 2002:a24:7cc4:: with SMTP id a187mr11411359itd.171.1552131382225;
 Sat, 09 Mar 2019 03:36:22 -0800 (PST)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sat, 9 Mar 2019 06:35:58 -0500
Message-ID: <CAH8yC8nMe-LmmS+KvBDATWu-C-FZef2PbT1FpHECGb_paeyYMA@mail.gmail.com>
Subject: --with-curl vs --with-curl-path=PATH
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm trying to build Git and install it in a discardable directory. All
of Git's prereqs have been built and are there.

Git was configured with --with-curl, but it looks like Git cannot find
the cURL built for it (see below). I tried adding -lcurl to LDLIBS but
it does not appear to be honored. cURL is also available from
PKG_CONFIG_PATH, but it does not appear it is being used:

$ PKG_CONFIG_PATH=/var/sanitize/lib64/pkgconfig pkg-config
--print-provides libcurl
libcurl = 7.64.0

My question is, how can I get the behavior of --with-curl-path=<custom
path>? At the moment the only option offered is --with-curl.

$ make V=1
...
make: curl-config: Command not found
...
gcc -I/var/sanitize/include -DNDEBUG -g2 -O2 -fsanitize=undefined
-march=native -fPIC -I. -DHAVE_SYSINFO -DGIT_HOST_CPU="\"x86_64\""
-DUSE_LIBPCRE2 -I/var/sanitize/include -DHAVE_ALLOCA_H
-I/var/sanitize/include -I/var/sanitize/include
-I/var/sanitize/include -I/var/sanitize/include -DSHA1_DC
-DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH_DEFAULT=0
-DSHA1DC_CUSTOM_INCLUDE_SHA1_C="\"cache.h\""
-DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="\"git-compat-util.h\""
-DSHA256_BLK  -DHAVE_PATHS_H -DHAVE_LIBCHARSET_H -DHAVE_STRINGS_H
-DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTONIC
-DHAVE_GETDELIM '-DPROCFS_EXECUTABLE_PATH="/proc/self/exe"'
-DFREAD_READS_DIRECTORIES -DNO_STRLCPY -DSHELL_PATH='"/bin/sh"'
-DPAGER_ENV='"LESS=FRX LV=-c"' -o git-http-fetch -L/var/sanitize/lib64
-fsanitize=undefined -Wl,-R,/var/sanitize/lib64 -Wl,--enable-new-dtags
 http.o http-walker.o http-fetch.o common-main.o \
        -L/var/sanitize/lib64 -Wl,-rpath,/var/sanitize/lib64  libgit.a
xdiff/lib.a  -lpcre2-8 -L/var/sanitize/lib64
-Wl,-rpath,/var/sanitize/lib64 -L/var/sanitize/lib64
-Wl,-rpath,/var/sanitize/lib64 -lz -L/var/sanitize/lib64
-Wl,-rpath,/var/sanitize/lib64 -liconv  -lcharset -lrt -lpthread
/bin/ld: http.o: in function `http_opt_request_remainder':
/home/test/git-2.21.0/http.c:1833: undefined reference to `curl_easy_setopt'
/bin/ld: http.o: in function `process_curl_messages':
/home/test/git-2.21.0/http.c:261: undefined reference to `curl_multi_info_read'
...
