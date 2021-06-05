Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFEFC47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 07:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEB0A611C2
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 07:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhFEHHJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 03:07:09 -0400
Received: from mout.web.de ([217.72.192.78]:44815 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbhFEHHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 03:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1622876697;
        bh=u3VwxTBT8C5X3mwcX9RJhQFvYBWyx0NR+d9pIjyOqMU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lm3D7Z9ewYsKyRkH4VIg1mtnOj4Uv7+bHzEBQNXFG0fkFBNyRr5SfIevO6OIZK0Rp
         IErD0RjThfltDQkU1vxmflJrdD2gEvYWhSYhk0LXVfUT8Il+wEnyBvp1cILtVL7Kdf
         boXdMUsX5kk1Xj+0krb6mWSFoNSDghDsUDmBS2ws=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MNtTz-1li1ZK1z0l-007Yix; Sat, 05 Jun 2021 09:04:57 +0200
Subject: Re: [ANNOUNCE] Git v2.32.0-rc3 - t5300 Still Broken on NonStop
 ia64/x86
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
References: <002701d757d8$1a8d9dc0$4fa8d940$@nexbridge.com>
 <YLfc2+Te7Y3UY+Sm@nand.local> <YLfgy94sbmStC0mR@coredump.intra.peff.net>
 <YLfl4jkuwSCiNrrS@nand.local> <YLfm8cqY6EjQuhcO@coredump.intra.peff.net>
 <xmqqk0na2yyc.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <9b663ba3-6680-0d9a-4910-502cb2abac6b@web.de>
Date:   Sat, 5 Jun 2021 09:04:49 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqk0na2yyc.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WWWg34nqtLrXi6tObmfFgl4Uc9Ek6xQNd9J1WMNlDF7j4lPtjI0
 BJVeTkmOIPUDmJo1pED5m9XbNS5OzRUPdz04hHXxgtP+IMTOhckJBlFlzJpOsFvAicOy7k0
 P7M4XXTX2D+u3guoE9GMH5Dqnh3aIXwgo+By685napmqmLFGoSxToC20mJGM4deCzlQAJz4
 qAIP7fU8cJGwq/6IcLy9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KcrlYzZgjzk=:6nI4kVAvxFvTQFDwme7h0a
 c9E+kI/xbJtRxdOSdZR7gNKPnGlw8pk+F3DjC2fS/IlHKvmEw659v3o4XlEm4C+BUCvO+OhVw
 9wZDIutwJ28+J3xRgBcMRuv5/SuXXzVrH5iRifYBVGLYiQQiq8ACbY9FaW3BsuyCAR0/v/iwE
 mMhRWIqSMSOendO7JrNOs9QHI6Ir9ThI4peWacXIbqZLPtCXz//ha8OHzSYNFdYhAsSHXfbLF
 /RUAJ+y3e/gql9NBoRTSxDH4AKvhX1iD4Lywpfvu3BjB+kFq43AryGSam9/+b38pHbjKUvruO
 qPrXsUGOfC6ttW3w+CSyxMieDtOwShnRkxEs3hmictcJfXEq0c4GTy3NSorVjqxempytWhbGO
 qwaPvJvay0NGzY0Wl+UzLykvfgTDBpUtLKwkp8XgbguAvXMH6Npu2yswdyo9y6AFRl1+h0heV
 Etm6HbfiT3AThNB19REJGMqkmma7nycWtMVi9w4+14WK8iNV8361rxCtgyf8oMB9JxALc/ayV
 yCmZIVhICu6osbwL2/R8NOIr2AGaMd68TDm4lHg1z9lKgy1DejRmCBQpTlfxG9MzHgdu+wrOk
 3ycrATMRtULbIhtNb17rNa8YOOTQkWYmNwxclmnUnzs5bxKF7Dgsnepm2kTdk9asAJ+KOF5lS
 otBkiaABWxiDTT8NMcJn5/7XtngAr5L7PHRKSNLVV67hwrZ1atdbz1iR3GqXYDkWhYeE/ahQY
 WU+qielVmxiziCRfrOQFMiBlik2ttgYN4kkMESSiXoBvbVBkpRlf/pQ6dXLV7UMKWlCS971Gv
 zc97JT+FAUn7fkh8Knu6MORNKnAqnLrUf83aHI4TOl1fQR/NPaQcUgJCxSUCWyfvy7VjnVhFS
 ni7pPAqT8cVKTNMEpYRyueZj+TvV3+F5PwOFiT8pO5X7Oe9H7i5EkLdjRWjHs5/z1h1aEFlbY
 upnK5z0/I34x5SYIl0tlRBXFFNPQwsjPDub4fBdF9A97C90fC5Q99r7q0N5zQsCGNbqoxUgz/
 n5o8Icu3okksID5DKjvXsxJnhF4cQia06WETnNbVwBfYKQKWA7+dPSXhrpV/TPNUkIzqQ7juD
 zI8OeNjFh0GZhbRz4rtn4SQL9P0xxg82V1/
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.06.21 um 03:36 schrieb Junio C Hamano:
> ---
>
>  write-or-die.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git i/write-or-die.c w/write-or-die.c
> index eab8c8d0b9..534b2f5cba 100644
> --- i/write-or-die.c
> +++ w/write-or-die.c
> @@ -57,7 +57,11 @@ void fprintf_or_die(FILE *f, const char *fmt, ...)
>
>  void fsync_or_die(int fd, const char *msg)
>  {
> -	if (fsync(fd) < 0) {
> +	int status;
> +
> +	while ((status =3D fsync(fd)) < 0 && errno =3D=3D EINTR)
> +		; /* try again */
> +	if (status < 0) {
>  		die_errno("fsync error on '%s'", msg);
>  	}
>  }

The function body can be written like this:

	while (fsync(fd) < 0) {
		if (errno !=3D EINTR)
			die_errno("fsync error on '%s'", msg);
	}

I find it easier to read because it has less syntax elements
and is shorter.  Bikeshedding, of course. :-/

Ren=C3=A9
