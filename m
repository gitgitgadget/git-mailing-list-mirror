Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD37C28D13
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 02:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242215AbiHTCve (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 22:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiHTCvc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 22:51:32 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CC6B5E4C
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 19:51:29 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s11so7577921edd.13
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 19:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc;
        bh=K0vIBTYb9igPu3tImFgzC2Pa/00xU2M9aK+khn8j9kQ=;
        b=P+TmNj0s/up+RDjH3d4u14kniaemhap5VQSkYVsyzllg2hzqHZ4RjHj2cW8P40Rrxl
         4uvDpulsG1dnXM3MnCQ7J+aOCTNtoqUi38CABl82lVdacBmv46QwsnnRiKV5od2MGkDt
         f7WB3d0F68ktBHrwoENphO02TPcadyxyw1nAopTcL9/CcO8OHi98Yov3wqaR9906FJce
         3ufvHqoZ4eOQYbM1RDr8n9zWw8AuTIxjFCyioAPa9+wG1SI2WXKrgJCNXLLIVvK7vuHB
         j4GIOsjBKcEEtdUu5HFF37u8+zMHqgt1+2+POye7q1I47U38GKRVvkmvQBDTr0umhlTn
         PAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc;
        bh=K0vIBTYb9igPu3tImFgzC2Pa/00xU2M9aK+khn8j9kQ=;
        b=jVulwsGzqXvHiGfGcLVZwsaYeK1/Yda5VsCB0KNAcAmNE9GW0ZCChU+9eOJ4bfwkRy
         JkV+zHaGP6jxn9B7K81Z2p7rrCUhZHJOJ/o9r2UtG2Y4Q9oVft3r/6m3TkS5ssRVrT3Z
         l+dmUtSR5QO/8tW0iolbMDTgb4wMsntGmmddGUPd8mIk/tzD29ssZ/2yBOeJWXis3eWM
         PCgNLhBd6fPBdVdFaIZUGBU4X74gM8wXioqAhedX/WNM0Q7RkTH5WsSdVI4PATVm8wqR
         CPn+SxUhbEoybs9fo8IhhZN1+QhiXPGdG02yVgElwuq0VXMt8VQxmrdOpd5dNZn2oYcu
         lsRw==
X-Gm-Message-State: ACgBeo3sOFmYveDOXX1yXKb/bF+JnuuispeyX+9bFp+d4LSTEL2X7TBc
        Z9Ks9ux2gTpRjwcdYPt0gzOFXMU2Jl6nFGofTujzGZaR9mpcqgMc
X-Google-Smtp-Source: AA6agR7xyPlyI+m8al6Ve1n/qRyoeIfutNm5WTVlUkENli5wVoCBlOV8v5fR/u+F7rIBe8BAOWXdANBz7FML+hRVoYk=
X-Received: by 2002:a05:6402:2216:b0:445:eb9a:bfb5 with SMTP id
 cq22-20020a056402221600b00445eb9abfb5mr8304753edb.36.1660963887682; Fri, 19
 Aug 2022 19:51:27 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?546L5bCP5bu6?= <littlejian8@gmail.com>
Date:   Sat, 20 Aug 2022 10:51:16 +0800
Message-ID: <CADmGLV32OAg6HU+n1UsP2Fq-MjcyUsFFF=q0_jZCB0JEop5VUg@mail.gmail.com>
Subject: git clone with basic auth in url directly returns authentication
 failure after 401 received under some git versions
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

I want to git clone with basic auth in url, such as git clone
http://xxx:xxx@xxx.xxx/xxx/xxx

What did you expect to happen? (Expected behavior)

Clone successfully

What happened instead? (Actual behavior)

fatal: Authentication failed

What's different between what you expected and what actually happened?

When I use git v2.36.2  (docker image is alpine/git:v2.36.2) to clone
with basic auth in url, when receiving the 401, it directly returns
authentication failure, even recv head has www-authenticate: Basic
realm=3DRestricted,
and no request is send again. I think it should send request with
authorization: Basic header after receive 401.
And use git v2.34.2 (docker image is alpine/git:v2.34.1) to clone it works =
well.


Anything else you want to add:

$ server git version: git version 2.30.2

 Below is the GIT_CURL_VERBOSE information between 2 versions

 GIT_CURL_VERBOSE info with v2.36.2 (docker image is alpine/git:v2.36.2) Ou=
tput:
 $ docker run -it -e GIT_CURL_VERBOSE=3D1 5de1a96efc49  clone
http://xxx:xxx@xxx.xxx/xxx/xxx
Cloning into 'xxx'...
10:54:06.204996 http.c:664              =3D=3D Info:   Trying xxx.xxx.xxx.x=
xx:80...
10:54:06.235057 http.c:664              =3D=3D Info: Connected to xxx.xxx
(xxx.xxx.xxx.xxx) port 80 (#0)
10:54:06.235347 http.c:611              =3D> Send header, 0000000221
bytes (0x000000dd)
10:54:06.235406 http.c:623              =3D> Send header: GET
/xxx/xxx/info/refs?service=3Dgit-upload-pack HTTP/1.1
10:54:06.235665 http.c:623              =3D> Send header: Host: xxx.xxx
10:54:06.235677 http.c:623              =3D> Send header: User-Agent: git/2=
.36.2
10:54:06.235687 http.c:623              =3D> Send header: Accept: */*
10:54:06.235701 http.c:623              =3D> Send header:
Accept-Encoding: deflate, gzip, br
10:54:06.235712 http.c:623              =3D> Send header: Pragma: no-cache
10:54:06.235727 http.c:623              =3D> Send header: Git-Protocol: ver=
sion=3D2
10:54:06.235779 http.c:623              =3D> Send header:
10:54:06.240590 http.c:664              =3D=3D Info: Mark bundle as not
supporting multiuse
10:54:06.240658 http.c:611              <=3D Recv header, 0000000020
bytes (0x00000014)
10:54:06.240677 http.c:623              <=3D Recv header: HTTP/1.1 302 Foun=
d
10:54:06.240692 http.c:611              <=3D Recv header, 0000000037
bytes (0x00000025)
10:54:06.240700 http.c:623              <=3D Recv header: Date: Fri, 19
Aug 2022 10:54:06 GMT
10:54:06.240713 http.c:611              <=3D Recv header, 0000000025
bytes (0x00000019)
10:54:06.240723 http.c:623              <=3D Recv header: Content-Type: tex=
t/html
10:54:06.240737 http.c:611              <=3D Recv header, 0000000021
bytes (0x00000015)
10:54:06.240753 http.c:623              <=3D Recv header: Content-Length: 1=
54
10:54:06.240801 http.c:611              <=3D Recv header, 0000000024
bytes (0x00000018)
10:54:06.240812 http.c:623              <=3D Recv header: Connection: keep-=
alive
10:54:06.240828 http.c:611              <=3D Recv header, 0000000100
bytes (0x00000064)
10:54:06.240839 http.c:623              <=3D Recv header: Location:
https://xxx.xxx/xxx/xxx/info/refs?service=3Dgit-upload-pack
10:54:06.240847 http.c:611              <=3D Recv header, 0000000022
bytes (0x00000016)
10:54:06.240857 http.c:623              <=3D Recv header: Via: HTTP/1.1 SLB=
.25
10:54:06.240868 http.c:611              <=3D Recv header, 0000000002
bytes (0x00000002)
10:54:06.240876 http.c:623              <=3D Recv header:
10:54:06.240884 http.c:664              =3D=3D Info: Ignoring the response-=
body
10:54:06.241141 http.c:664              =3D=3D Info: Connection #0 to host
xxx.xxx left intact
10:54:06.241331 http.c:664              =3D=3D Info: Clear auth, redirects
to port from 80 to 443
10:54:06.241350 http.c:664              =3D=3D Info: Issue another request
to this URL: 'https://xxx.xxx/xxx/xxx/info/refs?service=3Dgit-upload-pack'
10:54:06.241480 http.c:664              =3D=3D Info: NTLM-proxy picked AND
auth done set, clear picked
10:54:06.248582 http.c:664              =3D=3D Info:   Trying xxx.xxx.xxx.x=
xx:443...
10:54:06.254035 http.c:664              =3D=3D Info: Connected to xxx.xxx
(xxx.xxx.xxx.xxx) port 443 (#1)
10:54:06.254672 http.c:664              =3D=3D Info: ALPN: offers h2
10:54:06.254723 http.c:664              =3D=3D Info: ALPN: offers http/1.1
10:54:06.267498 http.c:664              =3D=3D Info:  CAfile:
/etc/ssl/certs/ca-certificates.crt
10:54:06.267561 http.c:664              =3D=3D Info:  CApath: none
10:54:06.267838 http.c:664              =3D=3D Info: TLSv1.3 (OUT), TLS
handshake, Client hello (1):
10:54:06.277311 http.c:664              =3D=3D Info: TLSv1.3 (IN), TLS
handshake, Server hello (2):
10:54:06.277427 http.c:664              =3D=3D Info: TLSv1.2 (IN), TLS
handshake, Certificate (11):
10:54:06.278079 http.c:664              =3D=3D Info: TLSv1.2 (IN), TLS
handshake, Server key exchange (12):
10:54:06.278272 http.c:664              =3D=3D Info: TLSv1.2 (IN), TLS
handshake, Server finished (14):
10:54:06.278609 http.c:664              =3D=3D Info: TLSv1.2 (OUT), TLS
handshake, Client key exchange (16):
10:54:06.278685 http.c:664              =3D=3D Info: TLSv1.2 (OUT), TLS
change cipher, Change cipher spec (1):
10:54:06.278797 http.c:664              =3D=3D Info: TLSv1.2 (OUT), TLS
handshake, Finished (20):
10:54:06.284962 http.c:664              =3D=3D Info: TLSv1.2 (IN), TLS
handshake, Finished (20):
10:54:06.285064 http.c:664              =3D=3D Info: SSL connection using
TLSv1.2 / ECDHE-RSA-AES128-GCM-SHA256
10:54:06.285082 http.c:664              =3D=3D Info: ALPN: server accepted =
h2
10:54:06.285101 http.c:664              =3D=3D Info: Server certificate:
10:54:06.285116 http.c:664              =3D=3D Info:  subject: CN=3D*.xxx.x=
xx
10:54:06.285133 http.c:664              =3D=3D Info:  start date: Apr  8
00:00:00 2022 GMT
10:54:06.285254 http.c:664              =3D=3D Info:  expire date: Apr  9
23:59:59 2023 GMT
10:54:06.285317 http.c:664              =3D=3D Info:  subjectAltName: host
"xxx.xxx" matched cert's "*.xxx.xxx"
10:54:06.285364 http.c:664              =3D=3D Info:  issuer: C=3DUS;
O=3DDigiCert Inc; CN=3DRapidSSL TLS DV RSA Mixed SHA256 2020 CA-1
10:54:06.285374 http.c:664              =3D=3D Info:  SSL certificate verif=
y ok.
10:54:06.285460 http.c:664              =3D=3D Info: Using HTTP2, server
supports multiplexing
10:54:06.285508 http.c:664              =3D=3D Info: Copying HTTP/2 data
in stream buffer to connection buffer after upgrade: len=3D0
10:54:06.285902 http.c:664              =3D=3D Info: h2h3 [:method: GET]
10:54:06.285956 http.c:664              =3D=3D Info: h2h3 [:path:
/xxx/xxx/info/refs?service=3Dgit-upload-pack]
10:54:06.285977 http.c:664              =3D=3D Info: h2h3 [:scheme: https]
10:54:06.285996 http.c:664              =3D=3D Info: h2h3 [:authority: xxx.=
xxx]
10:54:06.286011 http.c:664              =3D=3D Info: h2h3 [user-agent: git/=
2.36.2]
10:54:06.286019 http.c:664              =3D=3D Info: h2h3 [accept: */*]
10:54:06.286029 http.c:664              =3D=3D Info: h2h3
[accept-encoding: deflate, gzip, br]
10:54:06.286039 http.c:664              =3D=3D Info: h2h3 [pragma: no-cache=
]
10:54:06.286048 http.c:664              =3D=3D Info: h2h3 [git-protocol: ve=
rsion=3D2]
10:54:06.286075 http.c:664              =3D=3D Info: Using Stream ID: 1
(easy handle 0x7f4673e9e210)
10:54:06.286401 http.c:611              =3D> Send header, 0000000219
bytes (0x000000db)
10:54:06.286459 http.c:623              =3D> Send header: GET
/xxx/xxx/info/refs?service=3Dgit-upload-pack HTTP/2
10:54:06.286473 http.c:623              =3D> Send header: Host: xxx.xxx
10:54:06.286481 http.c:623              =3D> Send header: user-agent: git/2=
.36.2
10:54:06.286495 http.c:623              =3D> Send header: accept: */*
10:54:06.286562 http.c:623              =3D> Send header:
accept-encoding: deflate, gzip, br
10:54:06.286604 http.c:623              =3D> Send header: pragma: no-cache
10:54:06.286647 http.c:623              =3D> Send header: git-protocol: ver=
sion=3D2
10:54:06.286694 http.c:623              =3D> Send header:
10:54:06.286835 http.c:664              =3D=3D Info: Connection state
changed (MAX_CONCURRENT_STREAMS =3D=3D 128)!
10:54:06.296853 http.c:611              <=3D Recv header, 0000000013
bytes (0x0000000d)
10:54:06.296907 http.c:623              <=3D Recv header: HTTP/2 401
10:54:06.296924 http.c:611              <=3D Recv header, 0000000037
bytes (0x00000025)
10:54:06.296939 http.c:623              <=3D Recv header: date: Fri, 19
Aug 2022 10:54:06 GMT
10:54:06.296952 http.c:611              <=3D Recv header, 0000000047
bytes (0x0000002f)
10:54:06.296964 http.c:623              <=3D Recv header: content-type:
application/json; charset=3DUTF-8
10:54:06.297008 http.c:611              <=3D Recv header, 0000000020
bytes (0x00000014)
10:54:06.297023 http.c:623              <=3D Recv header: content-length: 6=
9
10:54:06.297035 http.c:611              <=3D Recv header, 0000000070
bytes (0x00000046)
10:54:06.297043 http.c:623              <=3D Recv header: traceparent:
00-ad497b554e2addf5b0a94937024187c4-138a06a14cd9ed47-01
10:54:06.297083 http.c:611              <=3D Recv header, 0000000042
bytes (0x0000002a)
10:54:06.297099 http.c:623              <=3D Recv header:
www-authenticate: Basic realm=3DRestricted
10:54:06.297116 http.c:611              <=3D Recv header, 0000000002
bytes (0x00000002)
10:54:06.297125 http.c:623              <=3D Recv header:
10:54:06.297313 http.c:664              =3D=3D Info: Connection #1 to host
xxx.xxx left intact
fatal: Authentication failed for 'http://xxx.xxx/xxx/xxx/'

 GIT_CURL_VERBOSE info with v2.34.2 (docker image is alpine/git:v2.34.1) Ou=
tput:
$ docker run -it -e GIT_CURL_VERBOSE=3D1  aaee7a44d8d4  clone
http://xxx:xxx@xxx.xxx/xxx/xxx
Cloning into 'xxx'...
11:11:10.183612 http.c:664              =3D=3D Info:   Trying xxx.xxx.xxx:8=
0...
11:11:10.190536 http.c:664              =3D=3D Info: Connected to xxx.xxx
(xxx.xxx.xxx) port 80 (#0)
11:11:10.190719 http.c:611              =3D> Send header, 0000000221
bytes (0x000000dd)
11:11:10.190798 http.c:623              =3D> Send header: GET
/xxx/xxx/info/refs?service=3Dgit-upload-pack HTTP/1.1
11:11:10.190815 http.c:623              =3D> Send header: Host: xxx.xxx
11:11:10.190828 http.c:623              =3D> Send header: User-Agent: git/2=
.34.2
11:11:10.190836 http.c:623              =3D> Send header: Accept: */*
11:11:10.190844 http.c:623              =3D> Send header:
Accept-Encoding: deflate, gzip, br
11:11:10.190875 http.c:623              =3D> Send header: Pragma: no-cache
11:11:10.190883 http.c:623              =3D> Send header: Git-Protocol: ver=
sion=3D2
11:11:10.190891 http.c:623              =3D> Send header:
11:11:10.196034 http.c:664              =3D=3D Info: Mark bundle as not
supporting multiuse
11:11:10.196086 http.c:611              <=3D Recv header, 0000000020
bytes (0x00000014)
11:11:10.196104 http.c:623              <=3D Recv header: HTTP/1.1 302 Foun=
d
11:11:10.196120 http.c:611              <=3D Recv header, 0000000037
bytes (0x00000025)
11:11:10.196133 http.c:623              <=3D Recv header: Date: Fri, 19
Aug 2022 11:11:10 GMT
11:11:10.196272 http.c:611              <=3D Recv header, 0000000025
bytes (0x00000019)
11:11:10.196289 http.c:623              <=3D Recv header: Content-Type: tex=
t/html
11:11:10.196305 http.c:611              <=3D Recv header, 0000000021
bytes (0x00000015)
11:11:10.196318 http.c:623              <=3D Recv header: Content-Length: 1=
54
11:11:10.196362 http.c:611              <=3D Recv header, 0000000024
bytes (0x00000018)
11:11:10.196396 http.c:623              <=3D Recv header: Connection: keep-=
alive
11:11:10.196413 http.c:611              <=3D Recv header, 0000000100
bytes (0x00000064)
11:11:10.196429 http.c:623              <=3D Recv header: Location:
https://xxx.xxx/xxx/xxx/info/refs?service=3Dgit-upload-pack
11:11:10.196463 http.c:611              <=3D Recv header, 0000000022
bytes (0x00000016)
11:11:10.196504 http.c:623              <=3D Recv header: Via: HTTP/1.1 SLB=
.27
11:11:10.196544 http.c:611              <=3D Recv header, 0000000002
bytes (0x00000002)
11:11:10.196555 http.c:623              <=3D Recv header:
11:11:10.196564 http.c:664              =3D=3D Info: Ignoring the response-=
body
11:11:10.196649 http.c:664              =3D=3D Info: Connection #0 to host
xxx.xxx left intact
11:11:10.196718 http.c:664              =3D=3D Info: Issue another request
to this URL: 'https://xxx.xxx/xxx/xxx/info/refs?service=3Dgit-upload-pack'
11:11:10.196869 http.c:664              =3D=3D Info: NTLM-proxy picked AND
auth done set, clear picked!
11:11:10.202506 http.c:664              =3D=3D Info:   Trying xxx.xxx.xxx:4=
43...
11:11:10.208418 http.c:664              =3D=3D Info: Connected to xxx.xxx
(xxx.xxx.xxx) port 443 (#1)
11:11:10.208923 http.c:664              =3D=3D Info: ALPN, offering h2
11:11:10.208964 http.c:664              =3D=3D Info: ALPN, offering http/1.=
1
11:11:10.221901 http.c:664              =3D=3D Info:  CAfile:
/etc/ssl/certs/ca-certificates.crt
11:11:10.221963 http.c:664              =3D=3D Info:  CApath: none
11:11:10.222300 http.c:664              =3D=3D Info: TLSv1.3 (OUT), TLS
handshake, Client hello (1):
11:11:10.233108 http.c:664              =3D=3D Info: TLSv1.3 (IN), TLS
handshake, Server hello (2):
11:11:10.233296 http.c:664              =3D=3D Info: TLSv1.2 (IN), TLS
handshake, Certificate (11):
11:11:10.233803 http.c:664              =3D=3D Info: TLSv1.2 (IN), TLS
handshake, Server key exchange (12):
11:11:10.233952 http.c:664              =3D=3D Info: TLSv1.2 (IN), TLS
handshake, Server finished (14):
11:11:10.234129 http.c:664              =3D=3D Info: TLSv1.2 (OUT), TLS
handshake, Client key exchange (16):
11:11:10.234311 http.c:664              =3D=3D Info: TLSv1.2 (OUT), TLS
change cipher, Change cipher spec (1):
11:11:10.234429 http.c:664              =3D=3D Info: TLSv1.2 (OUT), TLS
handshake, Finished (20):
11:11:10.240556 http.c:664              =3D=3D Info: TLSv1.2 (IN), TLS
handshake, Finished (20):
11:11:10.240640 http.c:664              =3D=3D Info: SSL connection using
TLSv1.2 / ECDHE-RSA-AES128-GCM-SHA256
11:11:10.240655 http.c:664              =3D=3D Info: ALPN, server accepted =
to use h2
11:11:10.240705 http.c:664              =3D=3D Info: Server certificate:
11:11:10.240724 http.c:664              =3D=3D Info:  subject: CN=3D*.xxx.x=
xx
11:11:10.240743 http.c:664              =3D=3D Info:  start date: Apr  8
00:00:00 2022 GMT
11:11:10.240751 http.c:664              =3D=3D Info:  expire date: Apr  9
23:59:59 2023 GMT
11:11:10.240769 http.c:664              =3D=3D Info:  subjectAltName: host
"xxx.xxx" matched cert's "*.xxx.xxx"
11:11:10.240792 http.c:664              =3D=3D Info:  issuer: C=3DUS;
O=3DDigiCert Inc; CN=3DRapidSSL TLS DV RSA Mixed SHA256 2020 CA-1
11:11:10.240807 http.c:664              =3D=3D Info:  SSL certificate verif=
y ok.
11:11:10.240873 http.c:664              =3D=3D Info: Using HTTP2, server
supports multiplexing
11:11:10.240912 http.c:664              =3D=3D Info: Connection state
changed (HTTP/2 confirmed)
11:11:10.240926 http.c:664              =3D=3D Info: Copying HTTP/2 data
in stream buffer to connection buffer after upgrade: len=3D0
11:11:10.241310 http.c:664              =3D=3D Info: Using Stream ID: 1
(easy handle 0x7ff7c6f93ab0)
11:11:10.241507 http.c:611              =3D> Send header, 0000000219
bytes (0x000000db)
11:11:10.241539 http.c:623              =3D> Send header: GET
/xxx/xxx/info/refs?service=3Dgit-upload-pack HTTP/2
11:11:10.241593 http.c:623              =3D> Send header: Host: xxx.xxx
11:11:10.241612 http.c:623              =3D> Send header: user-agent: git/2=
.34.2
11:11:10.241623 http.c:623              =3D> Send header: accept: */*
11:11:10.241632 http.c:623              =3D> Send header:
accept-encoding: deflate, gzip, br
11:11:10.241642 http.c:623              =3D> Send header: pragma: no-cache
11:11:10.241653 http.c:623              =3D> Send header: git-protocol: ver=
sion=3D2
11:11:10.241662 http.c:623              =3D> Send header:
11:11:10.241944 http.c:664              =3D=3D Info: Connection state
changed (MAX_CONCURRENT_STREAMS =3D=3D 128)!
11:11:10.252717 http.c:611              <=3D Recv header, 0000000013
bytes (0x0000000d)
11:11:10.252792 http.c:623              <=3D Recv header: HTTP/2 401
11:11:10.252811 http.c:611              <=3D Recv header, 0000000037
bytes (0x00000025)
11:11:10.252829 http.c:623              <=3D Recv header: date: Fri, 19
Aug 2022 11:11:10 GMT
11:11:10.252849 http.c:611              <=3D Recv header, 0000000047
bytes (0x0000002f)
11:11:10.252863 http.c:623              <=3D Recv header: content-type:
application/json; charset=3DUTF-8
11:11:10.252874 http.c:611              <=3D Recv header, 0000000020
bytes (0x00000014)
11:11:10.252887 http.c:623              <=3D Recv header: content-length: 6=
9
11:11:10.252938 http.c:611              <=3D Recv header, 0000000070
bytes (0x00000046)
11:11:10.252956 http.c:623              <=3D Recv header: traceparent:
00-f423b7618abb5590f143da20b2febda1-e63b3c81e9e9dd7b-01
11:11:10.252973 http.c:611              <=3D Recv header, 0000000042
bytes (0x0000002a)
11:11:10.252984 http.c:623              <=3D Recv header:
www-authenticate: Basic realm=3DRestricted
11:11:10.253028 http.c:611              <=3D Recv header, 0000000002
bytes (0x00000002)
11:11:10.253036 http.c:623              <=3D Recv header:
11:11:10.253050 http.c:664              =3D=3D Info: Ignoring the response-=
body
11:11:10.253439 http.c:664              =3D=3D Info: Connection #1 to host
xxx.xxx left intact
11:11:10.253504 http.c:664              =3D=3D Info: Issue another request
to this URL: 'https://xxx.xxx/xxx/xxx/info/refs?service=3Dgit-upload-pack'
11:11:10.253611 http.c:664              =3D=3D Info: Found bundle for host
xxx.xxx: 0x7ff7c6fbb590 [can multiplex]
11:11:10.253679 http.c:664              =3D=3D Info: Re-using existing
connection! (#1) with host xxx.xxx
11:11:10.253783 http.c:664              =3D=3D Info: Connected to xxx.xxx
(xxx.xxx.xxx) port 443 (#1)
11:11:10.253856 http.c:664              =3D=3D Info: Server auth using
Basic with user 'git'
11:11:10.253893 http.c:664              =3D=3D Info: Using Stream ID: 3
(easy handle 0x7ff7c6f93ab0)
11:11:10.254109 http.c:611              =3D> Send header, 0000000290
bytes (0x00000122)
11:11:10.254171 http.c:623              =3D> Send header: GET
/xxx/xxx/info/refs?service=3Dgit-upload-pack HTTP/2
11:11:10.254184 http.c:623              =3D> Send header: Host: xxx.xxx
11:11:10.254276 http.c:623              =3D> Send header: authorization: Ba=
sic
11:11:10.254302 http.c:623              =3D> Send header: user-agent: git/2=
.34.2
11:11:10.254313 http.c:623              =3D> Send header: accept: */*
11:11:10.254325 http.c:623              =3D> Send header:
accept-encoding: deflate, gzip, br
11:11:10.254343 http.c:623              =3D> Send header: pragma: no-cache
11:11:10.254356 http.c:623              =3D> Send header: git-protocol: ver=
sion=3D2
11:11:10.254366 http.c:623              =3D> Send header:
11:11:10.326732 http.c:611              <=3D Recv header, 0000000013
bytes (0x0000000d)
11:11:10.326883 http.c:623              <=3D Recv header: HTTP/2 200
11:11:10.326918 http.c:611              <=3D Recv header, 0000000037
bytes (0x00000025)
11:11:10.326943 http.c:623              <=3D Recv header: date: Fri, 19
Aug 2022 11:11:10 GMT
11:11:10.326954 http.c:611              <=3D Recv header, 0000000059
bytes (0x0000003b)
11:11:10.326973 http.c:623              <=3D Recv header: content-type:
application/x-git-upload-pack-advertisement
11:11:10.327000 http.c:611              <=3D Recv header, 0000000053
bytes (0x00000035)
11:11:10.327023 http.c:623              <=3D Recv header: cache-control:
no-cache, max-age=3D0, must-revalidate
11:11:10.327088 http.c:611              <=3D Recv header, 0000000040
bytes (0x00000028)
11:11:10.327114 http.c:623              <=3D Recv header: expires: Fri,
01 Jan 1980 00:00:00 GMT
11:11:10.327138 http.c:611              <=3D Recv header, 0000000018
bytes (0x00000012)
11:11:10.327149 http.c:623              <=3D Recv header: pragma: no-cache
11:11:10.327164 http.c:611              <=3D Recv header, 0000000002
bytes (0x00000002)
11:11:10.327176 http.c:623              <=3D Recv header:
11:11:10.327501 http.c:664              =3D=3D Info: Connection #1 to host
xxx.xxx left intact
warning: redirecting to https://xxx.xxx/xxx/xxx/
11:11:10.328628 http.c:664              =3D=3D Info: Found bundle for host
xxx.xxx: 0x7ff7c6fbb590 [can multiplex]
11:11:10.328730 http.c:664              =3D=3D Info: Re-using existing
connection! (#1) with host xxx.xxx
11:11:10.328845 http.c:664              =3D=3D Info: Connected to xxx.xxx
(xxx.xxx.xxx) port 443 (#1)
11:11:10.328899 http.c:664              =3D=3D Info: Server auth using
Basic with user 'git'
11:11:10.328956 http.c:664              =3D=3D Info: Using Stream ID: 5
(easy handle 0x7ff7c6f93ab0)
11:11:10.329168 http.c:611              =3D> Send header, 0000000362
bytes (0x0000016a)
11:11:10.329286 http.c:623              =3D> Send header: POST
/xxx/xxx/git-upload-pack HTTP/2
11:11:10.329305 http.c:623              =3D> Send header: Host: xxx.xxx
11:11:10.329313 http.c:623              =3D> Send header: authorization: Ba=
sic
11:11:10.329326 http.c:623              =3D> Send header: user-agent: git/2=
.34.2
11:11:10.329340 http.c:623              =3D> Send header:
accept-encoding: deflate, gzip, br
11:11:10.329365 http.c:623              =3D> Send header: content-type:
application/x-git-upload-pack-request
11:11:10.329444 http.c:623              =3D> Send header: accept:
application/x-git-upload-pack-result
11:11:10.329485 http.c:623              =3D> Send header: git-protocol: ver=
sion=3D2
11:11:10.329583 http.c:623              =3D> Send header: content-length: 1=
64
11:11:10.329594 http.c:623              =3D> Send header:
11:11:10.329819 http.c:664              =3D=3D Info: We are completely
uploaded and fine
11:11:10.447431 http.c:611              <=3D Recv header, 0000000013
bytes (0x0000000d)
11:11:10.447496 http.c:623              <=3D Recv header: HTTP/2 200
11:11:10.447516 http.c:611              <=3D Recv header, 0000000037
bytes (0x00000025)
11:11:10.447524 http.c:623              <=3D Recv header: date: Fri, 19
Aug 2022 11:11:10 GMT
11:11:10.447574 http.c:611              <=3D Recv header, 0000000052
bytes (0x00000034)
11:11:10.447591 http.c:623              <=3D Recv header: content-type:
application/x-git-upload-pack-result
11:11:10.447639 http.c:611              <=3D Recv header, 0000000053
bytes (0x00000035)
11:11:10.447649 http.c:623              <=3D Recv header: cache-control:
no-cache, max-age=3D0, must-revalidate
11:11:10.447660 http.c:611              <=3D Recv header, 0000000040
bytes (0x00000028)
11:11:10.447670 http.c:623              <=3D Recv header: expires: Fri,
01 Jan 1980 00:00:00 GMT
11:11:10.447679 http.c:611              <=3D Recv header, 0000000018
bytes (0x00000012)
11:11:10.447687 http.c:623              <=3D Recv header: pragma: no-cache
11:11:10.447701 http.c:611              <=3D Recv header, 0000000070
bytes (0x00000046)
11:11:10.447717 http.c:623              <=3D Recv header: traceparent:
00-3134d9583a00d714098ad8db7a2f7777-10b2626d4765359f-01
11:11:10.447727 http.c:611              <=3D Recv header, 0000000002
bytes (0x00000002)
11:11:10.447736 http.c:623              <=3D Recv header:
11:11:10.662595 http.c:664              =3D=3D Info: Connection #1 to host
xxx.xxx left intact
11:11:10.684884 http.c:664              =3D=3D Info: Found bundle for host
xxx.xxx: 0x7ff7c6fbb590 [can multiplex]
11:11:10.684972 http.c:664              =3D=3D Info: Re-using existing
connection! (#1) with host xxx.xxx
11:11:10.685045 http.c:664              =3D=3D Info: Connected to xxx.xxx
(xxx.xxx.xxx) port 443 (#1)
11:11:10.685122 http.c:664              =3D=3D Info: Server auth using
Basic with user 'git'
11:11:10.685194 http.c:664              =3D=3D Info: Using Stream ID: 7
(easy handle 0x7ff7c6f93ab0)
11:11:10.685431 http.c:611              =3D> Send header, 0000000388
bytes (0x00000184)
11:11:10.685462 http.c:623              =3D> Send header: POST
/xxx/xxx/git-upload-pack HTTP/2
11:11:10.685528 http.c:623              =3D> Send header: Host: xxx.xxx
11:11:10.685579 http.c:623              =3D> Send header: authorization: Ba=
sic
11:11:10.685597 http.c:623              =3D> Send header: user-agent: git/2=
.34.2
11:11:10.685636 http.c:623              =3D> Send header:
accept-encoding: deflate, gzip, br
11:11:10.685671 http.c:623              =3D> Send header: content-type:
application/x-git-upload-pack-request
11:11:10.685685 http.c:623              =3D> Send header: accept:
application/x-git-upload-pack-result
11:11:10.685695 http.c:623              =3D> Send header: git-protocol: ver=
sion=3D2
11:11:10.685704 http.c:623              =3D> Send header: content-encoding:=
 gzip
11:11:10.685741 http.c:623              =3D> Send header: content-length: 1=
9678
11:11:10.685945 http.c:623              =3D> Send header:
11:11:10.686431 http.c:664              =3D=3D Info: We are completely
uploaded and fine
11:11:11.165227 http.c:611              <=3D Recv header, 0000000013
bytes (0x0000000d)
11:11:11.165334 http.c:623              <=3D Recv header: HTTP/2 200
11:11:11.165358 http.c:611              <=3D Recv header, 0000000037
bytes (0x00000025)
11:11:11.165370 http.c:623              <=3D Recv header: date: Fri, 19
Aug 2022 11:11:11 GMT
11:11:11.165391 http.c:611              <=3D Recv header, 0000000052
bytes (0x00000034)
11:11:11.165403 http.c:623              <=3D Recv header: content-type:
application/x-git-upload-pack-result
11:11:11.165414 http.c:611              <=3D Recv header, 0000000053
bytes (0x00000035)
11:11:11.165430 http.c:623              <=3D Recv header: cache-control:
no-cache, max-age=3D0, must-revalidate
11:11:11.165490 http.c:611              <=3D Recv header, 0000000040
bytes (0x00000028)
11:11:11.165501 http.c:623              <=3D Recv header: expires: Fri,
01 Jan 1980 00:00:00 GMT
11:11:11.165518 http.c:611              <=3D Recv header, 0000000018
bytes (0x00000012)
11:11:11.165537 http.c:623              <=3D Recv header: pragma: no-cache
11:11:11.165553 http.c:611              <=3D Recv header, 0000000070
bytes (0x00000046)
11:11:11.165582 http.c:623              <=3D Recv header: traceparent:
00-8526084c5ce698fc4aaa4cd887c14e04-1ff731d1925ebf82-01
11:11:11.165591 http.c:611              <=3D Recv header, 0000000002
bytes (0x00000002)
11:11:11.165628 http.c:623              <=3D Recv header:
remote: Enumerating objects: 165, done.
remote: Counting objects: 100% (165/165), done.
remote: Compressing objects: 100% (162/162), done.
remote: Total 45555 (delta 77), reused 0 (delta 0), pack-reused 45390
11:11:17.236374 http.c:664              =3D=3D Info: Connection #1 to host
xxx.xxx left intact
Receiving objects: 100% (45555/45555), 29.04 MiB | 4.85 MiB/s, done.
Resolving deltas: 100% (35362/35362), done.

Look forward to your favourable reply=EF=BC=81
