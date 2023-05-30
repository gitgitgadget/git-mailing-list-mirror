Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8BAC77B7A
	for <git@archiver.kernel.org>; Tue, 30 May 2023 19:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjE3TMH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 15:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjE3TMF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 15:12:05 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F97106
        for <git@vger.kernel.org>; Tue, 30 May 2023 12:12:01 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2af2db78b38so53371741fa.3
        for <git@vger.kernel.org>; Tue, 30 May 2023 12:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685473919; x=1688065919;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uiRx26Gp7coFeQts+4MeEk2LWUEqB9n6JLI4st3WLW4=;
        b=L741O+Y8Mp5O5VtG6yorbrw2bF+gUtK8uU9o8tgfMM8u8qEKnvSl+PWmZACzHxXKYM
         SkH86w4I6TPdEV4P7JiFM4W4Dgm6+ms7qi0UjhdPIoQLdSrHlwhsRMpp5AlLT99Uu73E
         Qa6mckv9NTRc5KDTcw/fWk4+RG0HnUjEBCFFtco47lXijibI9H0qGQ4zRoIppoJWi0Do
         cvkQWLhIIHHUjwhCK6wUHyphtkRS0YY8/iO84giJ+Rk+uu2b7okQcnppr6J7KbLqvOhZ
         rG5vPUVFu7lZf1uwcZur847T5NUkOtOqFKtPw0ajYppSAj1Wr42pGRmoQ9l++NnV+8VU
         OFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685473919; x=1688065919;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uiRx26Gp7coFeQts+4MeEk2LWUEqB9n6JLI4st3WLW4=;
        b=cR3vlE+Fw+iNUZznoOkhMgT0WOtdWmSB0d6FLL9YGXd7S2A/WibxQe3pflqmoW2ATL
         sCNmF8f0+ilOx3HH/k+QH/xufn5e8nFOk2e/NA5KHKkJls6EUODwmD0c204YpTS5ug10
         Lb/cztp5ISq3qn1RNzt0ZDy93MoOMoMXzZGx/4hsvPxFwzzUyA7ewmNgjJGw5saUWdJD
         Zh/MX1GnWQ6xPO3SoKrHLQ/sPoEx5H1rHjkkG3t2FzTvVH/RUxjitCkXtuIIFJGYnDsQ
         i7ZTwhaKom+Yc6xjkJ5K3fmQEi64LBIBy30FmM824P9nK1DlsTskO3bTMozhMrfhtar9
         PGHg==
X-Gm-Message-State: AC+VfDwNjjTt93b8va+t0N1Ove12Te2u0iAWu/7pRL8vDDn5mRCcCDLB
        0jEJUHS5KvU/rsCqni517UzpPNxeCmHuzl4TMm6qLwQ9RFJHT/yR
X-Google-Smtp-Source: ACHHUZ4hrzvtqafiq9xItD0TDO/EmcTGTNFu0Gz5VfRc6Z59ypZ3sFQ0YDkh0CZnZfp4+EQkraVtF47fovL9py9l/j4=
X-Received: by 2002:a2e:83d6:0:b0:2ad:9c17:a78f with SMTP id
 s22-20020a2e83d6000000b002ad9c17a78fmr1282359ljh.53.1685473919031; Tue, 30
 May 2023 12:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <CA+3o5aPQ3BkbAn3u6qSMCkAfNgTcpjT+_ikdqAkkc69NBGybpw@mail.gmail.com>
In-Reply-To: <CA+3o5aPQ3BkbAn3u6qSMCkAfNgTcpjT+_ikdqAkkc69NBGybpw@mail.gmail.com>
From:   Fraser Hanson <fraser.hanson@gmail.com>
Date:   Tue, 30 May 2023 12:11:47 -0700
Message-ID: <CA+3o5aMu+_7x8WJUfjzR5OBBJPQS+hytuf+Xu+5NY6T8NscgJQ@mail.gmail.com>
Subject: Re: git fetch recursion problem
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following is output from `GIT_CURL_VERBOSE=1 git fetch`.

Each git-remote-https process spawns a sub-process that calls GET
/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git/info/refs?service=git-upload-pack
HTTP/1.1
There is no error, only an HTTP 200 OK response so it is unclear why
git is unsatisfied with the results of this call.

09:24:59.990256 git.c:439               trace: built-in: git fetch
09:24:59.992794 run-command.c:655       trace: run_command:
GIT_DIR=.git git remote-https origin
https://repomirror.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
09:25:00.006532 git.c:725               trace: exec: git-remote-https
origin https://repomirror.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
09:25:00.007191 run-command.c:655       trace: run_command:
git-remote-https origin
https://repomirror.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
09:25:00.023290 http.c:699              == Info: Couldn't find host
repomirror.corporate.com in the (nil) file; using defaults
09:25:00.029420 http.c:699              == Info:   Trying 10.60.16.190:443...
09:25:00.137589 http.c:699              == Info: Connected to
repomirror.corporate.com (10.60.16.190) port 443 (#0)
09:25:00.137756 http.c:699              == Info: ALPN: offers h2
09:25:00.137774 http.c:699              == Info: ALPN: offers http/1.1
09:25:00.144804 http.c:699              == Info:  CAfile: /etc/ssl/cert.pem
09:25:00.144822 http.c:699              == Info:  CApath: none
09:25:00.145105 http.c:699              == Info: [CONN-0-0][CF-SSL]
(304) (OUT), TLS handshake, Client hello (1):
09:25:00.247453 http.c:699              == Info: [CONN-0-0][CF-SSL]
(304) (IN), TLS handshake, Server hello (2):
09:25:00.247781 http.c:699              == Info: [CONN-0-0][CF-SSL]
TLSv1.2 (IN), TLS handshake, Certificate (11):
09:25:00.250670 http.c:699              == Info: [CONN-0-0][CF-SSL]
TLSv1.2 (IN), TLS handshake, Server key exchange (12):
09:25:00.251240 http.c:699              == Info: [CONN-0-0][CF-SSL]
TLSv1.2 (IN), TLS handshake, Server finished (14):
09:25:00.257051 http.c:699              == Info: [CONN-0-0][CF-SSL]
TLSv1.2 (OUT), TLS handshake, Client key exchange (16):
09:25:00.257084 http.c:699              == Info: [CONN-0-0][CF-SSL]
TLSv1.2 (OUT), TLS change cipher, Change cipher spec (1):
09:25:00.257145 http.c:699              == Info: [CONN-0-0][CF-SSL]
TLSv1.2 (OUT), TLS handshake, Finished (20):
09:25:00.353682 http.c:699              == Info: [CONN-0-0][CF-SSL]
TLSv1.2 (IN), TLS change cipher, Change cipher spec (1):
09:25:00.354049 http.c:699              == Info: [CONN-0-0][CF-SSL]
TLSv1.2 (IN), TLS handshake, Finished (20):
09:25:00.354143 http.c:699              == Info: SSL connection using
TLSv1.2 / ECDHE-RSA-AES256-GCM-SHA384
09:25:00.354190 http.c:699              == Info: ALPN: server did not
agree on a protocol. Uses default.
09:25:00.354222 http.c:699              == Info: Server certificate:
09:25:00.354274 http.c:699              == Info:  subject: C=US;
ST=California; O=Company, Inc.; CN=proxy.corporate.com
09:25:00.354303 http.c:699              == Info:  start date: Jun 11
00:00:00 2022 GMT
09:25:00.354327 http.c:699              == Info:  expire date: Jun 11
23:59:59 2024 GMT
09:25:00.354400 http.c:699              == Info:  subjectAltName: host
"repomirror.corporate.com" matched cert's "repomirror.corporate.com"
09:25:00.354452 http.c:699              == Info:  issuer: C=GB;
ST=Greater Manchester; L=Salford; O=Sectigo Limited; CN=Sectigo RSA
Organization Validation Secure Server CA
09:25:00.354476 http.c:699              == Info:  SSL certificate verify ok.
09:25:00.354624 http.c:646              => Send header, 0000000295
bytes (0x00000127)
09:25:00.354660 http.c:658              => Send header: GET
/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git/info/refs?service=git-upload-pack
HTTP/1.1
09:25:00.354680 http.c:658              => Send header: Host:
repomirror.corporate.com
09:25:00.354699 http.c:658              => Send header: User-Agent: git/2.40.1
09:25:00.354717 http.c:658              => Send header: Accept: */*
09:25:00.354736 http.c:658              => Send header:
Accept-Encoding: deflate, gzip
09:25:00.354755 http.c:658              => Send header:
Accept-Language: en-CA, *;q=0.9
09:25:00.354827 http.c:658              => Send header: Pragma: no-cache
09:25:00.354921 http.c:658              => Send header: Git-Protocol: version=2
09:25:00.354940 http.c:658              => Send header:
09:25:00.453443 http.c:699              == Info: Mark bundle as not
supporting multiuse
09:25:00.453568 http.c:646              <= Recv header, 0000000017
bytes (0x00000011)
09:25:00.453586 http.c:658              <= Recv header: HTTP/1.1 200 OK
09:25:00.453602 http.c:646              <= Recv header, 0000000037
bytes (0x00000025)
09:25:00.453617 http.c:658              <= Recv header: Date: Mon, 29
May 2023 16:25:00 GMT
09:25:00.453632 http.c:646              <= Recv header, 0000000033
bytes (0x00000021)
09:25:00.453646 http.c:658              <= Recv header: Server:
Apache/2.2.15 (Red Hat)
09:25:00.453661 http.c:646              <= Recv header, 0000000046
bytes (0x0000002e)
09:25:00.453674 http.c:658              <= Recv header: Last-Modified:
Sun, 28 May 2023 10:15:35 GMT
09:25:00.453689 http.c:646              <= Recv header, 0000000037
bytes (0x00000025)
09:25:00.453703 http.c:658              <= Recv header: ETag:
"42e2b247-4a13-5fcbe403f497b"
09:25:00.453750 http.c:646              <= Recv header, 0000000022
bytes (0x00000016)
09:25:00.453808 http.c:658              <= Recv header: Accept-Ranges: bytes
09:25:00.453851 http.c:646              <= Recv header, 0000000023
bytes (0x00000017)
09:25:00.453874 http.c:658              <= Recv header: Content-Length: 18963
09:25:00.453890 http.c:646              <= Recv header, 0000000019
bytes (0x00000013)
09:25:00.453904 http.c:658              <= Recv header: Connection: close
09:25:00.453919 http.c:646              <= Recv header, 0000000041
bytes (0x00000029)
09:25:00.453932 http.c:658              <= Recv header: Content-Type:
text/plain; charset=UTF-8
09:25:00.453949 http.c:646              <= Recv header, 0000000002
bytes (0x00000002)
09:25:00.453964 http.c:658              <= Recv header:
09:25:00.551101 http.c:699              == Info: Closing connection 0
09:25:00.551165 http.c:699              == Info: [CONN-0-0][CF-SSL]
TLSv1.2 (IN), TLS alert, close notify (256):
09:25:00.551212 http.c:699              == Info: [CONN-0-0][CF-SSL]
TLSv1.2 (OUT), TLS alert, close notify (256):
09:25:00.551491 http.c:699              == Info: Couldn't find host
repomirror.corporate.com in the (nil) file; using defaults
09:25:00.551509 http.c:699              == Info: Hostname
repomirror.corporate.com was found in DNS cache
09:25:00.551561 http.c:699              == Info:   Trying 10.60.16.190:443...
09:25:00.658191 http.c:699              == Info: Connected to
repomirror.corporate.com (10.60.16.190) port 443 (#1)
09:25:00.658452 http.c:699              == Info: ALPN: offers h2
09:25:00.658479 http.c:699              == Info: ALPN: offers http/1.1
09:25:00.658552 http.c:699              == Info: SSL re-using session ID
09:25:00.658784 http.c:699              == Info: [CONN-1-0][CF-SSL]
TLSv1.2 (OUT), TLS handshake, Client hello (1):
09:25:00.755274 http.c:699              == Info: [CONN-1-0][CF-SSL]
TLSv1.2 (IN), TLS handshake, Server hello (2):
09:25:00.755437 http.c:699              == Info: [CONN-1-0][CF-SSL]
TLSv1.2 (IN), TLS change cipher, Change cipher spec (1):
09:25:00.755535 http.c:699              == Info: [CONN-1-0][CF-SSL]
TLSv1.2 (IN), TLS handshake, Finished (20):
09:25:00.755555 http.c:699              == Info: [CONN-1-0][CF-SSL]
TLSv1.2 (OUT), TLS change cipher, Change cipher spec (1):
09:25:00.755586 http.c:699              == Info: [CONN-1-0][CF-SSL]
TLSv1.2 (OUT), TLS handshake, Finished (20):
09:25:00.755660 http.c:699              == Info: SSL connection using
TLSv1.2 / ECDHE-RSA-AES256-GCM-SHA384
09:25:00.755679 http.c:699              == Info: ALPN: server did not
agree on a protocol. Uses default.
09:25:00.755693 http.c:699              == Info: Server certificate:
09:25:00.755694 http.c:699              == Info:  subject: C=US;
ST=California; O=Company, Inc.; CN=proxy.corporate.com
09:25:00.755740 http.c:699              == Info:  start date: Jun 11
00:00:00 2022 GMT
09:25:00.755749 http.c:699              == Info:  expire date: Jun 11
23:59:59 2024 GMT
09:25:00.755848 http.c:699              == Info:  subjectAltName: host
"repomirror.corporate.com" matched cert's "repomirror.corporate.com"
09:25:00.755879 http.c:699              == Info:  issuer: C=GB;
ST=Greater Manchester; L=Salford; O=Sectigo Limited; CN=Sectigo RSA
Organization Validation Secure Server CA
09:25:00.755888 http.c:699              == Info:  SSL certificate verify ok.
09:25:00.755959 http.c:646              => Send header, 0000000241
bytes (0x000000f1)
09:25:00.755976 http.c:658              => Send header: GET
/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git/HEAD
HTTP/1.1
09:25:00.755983 http.c:658              => Send header: Host:
repomirror.corporate.com
09:25:00.755989 http.c:658              => Send header: User-Agent: git/2.40.1
09:25:00.755995 http.c:658              => Send header: Accept: */*
09:25:00.756001 http.c:658              => Send header:
Accept-Encoding: deflate, gzip
09:25:00.756008 http.c:658              => Send header:
Accept-Language: en-CA, *;q=0.9
09:25:00.756015 http.c:658              => Send header: Pragma: no-cache
09:25:00.756022 http.c:658              => Send header:
09:25:00.852762 http.c:699              == Info: Mark bundle as not
supporting multiuse
09:25:00.852921 http.c:646              <= Recv header, 0000000017
bytes (0x00000011)
09:25:00.852996 http.c:658              <= Recv header: HTTP/1.1 200 OK
09:25:00.853018 http.c:646              <= Recv header, 0000000037
bytes (0x00000025)
09:25:00.853033 http.c:658              <= Recv header: Date: Mon, 29
May 2023 16:25:00 GMT
09:25:00.853049 http.c:646              <= Recv header, 0000000033
bytes (0x00000021)
09:25:00.853063 http.c:658              <= Recv header: Server:
Apache/2.2.15 (Red Hat)
09:25:00.853078 http.c:646              <= Recv header, 0000000046
bytes (0x0000002e)
09:25:00.853091 http.c:658              <= Recv header: Last-Modified:
Tue, 09 May 2023 13:33:51 GMT
09:25:00.853106 http.c:646              <= Recv header, 0000000035
bytes (0x00000023)
09:25:00.853184 http.c:658              <= Recv header: ETag:
"4319f275-17-5fb42ce4c3e23"
09:25:00.853209 http.c:646              <= Recv header, 0000000022
bytes (0x00000016)
09:25:00.853357 http.c:658              <= Recv header: Accept-Ranges: bytes
09:25:00.853513 http.c:646              <= Recv header, 0000000020
bytes (0x00000014)
09:25:00.853535 http.c:658              <= Recv header: Content-Length: 23
09:25:00.853551 http.c:646              <= Recv header, 0000000019
bytes (0x00000013)
09:25:00.853565 http.c:658              <= Recv header: Connection: close
09:25:00.853582 http.c:646              <= Recv header, 0000000041
bytes (0x00000029)
09:25:00.853595 http.c:658              <= Recv header: Content-Type:
text/plain; charset=UTF-8
09:25:00.853613 http.c:646              <= Recv header, 0000000002
bytes (0x00000002)
09:25:00.853626 http.c:658              <= Recv header:
09:25:00.853701 http.c:699              == Info: Closing connection 1
09:25:00.853746 http.c:699              == Info: [CONN-1-0][CF-SSL]
TLSv1.2 (IN), TLS alert, close notify (256):
09:25:00.853818 http.c:699              == Info: [CONN-1-0][CF-SSL]
TLSv1.2 (OUT), TLS alert, close notify (256):
09:25:00.860085 run-command.c:655       trace: run_command: git -c
fetch.negotiationAlgorithm=noop fetch origin --no-tags
--no-write-fetch-head --recurse-submodules=no --filter=blob:none
--stdin
09:25:00.872999 git.c:439               trace: built-in: git fetch
origin --no-tags --no-write-fetch-head --recurse-submodules=no
--filter=blob:none --stdin
09:25:00.874628 run-command.c:655       trace: run_command: git
remote-https origin
https://repomirror.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
09:25:00.884027 git.c:725               trace: exec: git-remote-https
origin https://repomirror.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
...

From this point it repeats until killed (start over from line 3, git.c:725...)

I put together what I think is an equivalent curl command.  Running
this command does return a list of refs.

curl -isSL --user-agent 'git/2.40.1' -v
https://repomirror.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git/info/refs\?service\=git-upload-pack

The log output shows a TLS result code 256 which looked suspicious to
me.  However the curl command shows an identical TLS notify code after
fetching the list of refs.

Any clues as to how to debug this further would be appreciated, I'm stuck.
