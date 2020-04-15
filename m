Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6704CC2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 10:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A6A720737
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 10:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="O44o2Udp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896472AbgDOKrI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:47:08 -0400
Received: from mout.web.de ([212.227.17.11]:42649 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896439AbgDOKSf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 06:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586945868;
        bh=PEmqEfHXGIY9ZT8xA0BaCuFn5wHycHlUzWvc/Bez+pI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=O44o2Udp0LvPLfEgsNIohAVvrUv6Qgg22J21mOhUfRYF2pC5dbwxW5L8cu56/C/mX
         ke9/nGPZlKWBeQqQpa7/o0SycIS6yvMYJbAKMxaEf/9zu8GbeaJGVLtxCaGd9HzWOi
         tDVxSytUdjULIYKVAhk7cOagsMia877MvmbbHzYI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LbrQm-1ix3bU2Atw-00jKr3; Wed, 15
 Apr 2020 12:17:48 +0200
Date:   Wed, 15 Apr 2020 12:17:48 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 1/2] date.c: skip fractional second part of ISO-8601
Message-ID: <20200415101747.ua22fjadmfxzri5n@tb-raspi4>
References: <cover.1586856398.git.congdanhqx@gmail.com>
 <cover.1586921235.git.congdanhqx@gmail.com>
 <03f3e9968bc29b758f2dd32434c9e8d19f624fdd.1586921235.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <03f3e9968bc29b758f2dd32434c9e8d19f624fdd.1586921235.git.congdanhqx@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:QF+5GyR0wXFtVsfO5WWPgKXM5wmK+WiHHu3tZROX3MFvc5bHMkj
 p6iSVVVBU370xIQ7eINf82wQPta39HolP/HrMvw1x8uiZvTp/yLm0APwJUY/qFSH4Gneq6l
 tM8XJlcISP7hbRQvHUzwjKhw5UAfOAm8XOj8F3fyt1hK0DjPybUMTVMpxGsLct1UWvV+77o
 e85h3MnkQKk17QUel5XWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1OQmHd7EHhc=:ZJKX8OIYoPzq/PNqJXpKxj
 MuUA110yMGNB3BnBFHB1hKe6bXx20/2mcdhGZuaU5PX4NXKqpkDJM5+q/bi36NrE/YvdyzNzZ
 uu/ZvJOOMTHXZFsO3JssYlGMQpX1EQVeaNJZpxo3U6v/bbHTPduEONWGNwbGYYSptjBIqUosQ
 siKuHMjU9InbKmbkQ1IvO2TqWVMNynBGXlDOH0WG2YLWs/YoIA54iFpE4uBEQcmt6m82i7mW/
 3lFn166G6hBiGgGrgRKXobmbwl29r28Shf0Qnqb2i68GS1G0hEJQO+IdCppDkeq6MnyJnlN25
 EfBeKpdtMKotVrYjYP0Sz9OhtvW9BXCV18ASjPA8q43udGh0UOnZQ1B/wjrrKddO4zTZNcjOW
 FQ8ksfN+iRQ5CbEpLWKF3rdeGrUgGQGwQdHZsw6bf3MRK+6j2Ytklf8ZZevgPC8rkw7YMigYV
 Gqz0wCgk0PQv/ONQ2CvFuPpjuVHRNN6ph7XRB5YKWTHRQc4vCno7Y1HKdvrJHXB7SBzCuJZPl
 UHnbacSUdqVVJIzL/fPaSXcF/nGEorX5P1llTcvUftculoVib3vaz0ogBFyVN6T2xm4Y/wths
 LtZ49cugAR4AnLCSGFtYXkcg6T7NNa1OdJnllH7gYLuG0oyjoYGp/LlhFyMUj2vqUNOyjQgqA
 v6YwQiitItyUo5kMXpi1EtZaHi4DKxZ+lHpUKjzqZ1sxg0FcgpVUeli5Rez+f0lI5ySwMZmId
 398yvrFDOYGlwCYr5qHJp/z6V+AREZCtalsuMJMwgxFHnqYlK/42XKkQEaQOJW/9qF2s/stde
 TLANukIAbEVWCnCXvCiPVr6/YEzZqRiGa6o7MAPDqv2jhdUPMtBbLa5LBuALqEf4uS9bOWVsp
 YEgCcI7kDQG/2I1bIC6z8jbflEbRiUHgIFxGLknkvCEUIkfqn4olXJFcwNy6A/kQrDLBvFHTy
 6Lum6O5LGx+gllhMzNka32f58mHQDUifjepljayIxVxRxmIykX0SEQWB/xk5E9HbLoFIHa4Gi
 iranKvSj7XjzXcKwWt6tyFEM58olqIbFVv2PPcUvtKTppqq/qY9l4NQf7XWXe+mkZ2al3BAcd
 jiGS5xiTgAKO9aH2e5dILNgtcQtbDFqjSAatPf1Vpb3fGwqwbzuaaCv9+X+sN+dgubnoumz1v
 LNgOM9Jyo/fX49oTSHeME6cNFgjpi40NitOtCBXKVh5piZHz+TX7PeE9aYP1mMMQdFB7hAP9i
 mEvzHe03yYBf0jYLa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 10:31:27AM +0700, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=
=B4ng Danh wrote:
> git-commit(1) says ISO-8601 is one of our supported date format.
>
> ISO-8601 allows timestamps to have a fractional number of seconds.
> We represent time only in terms of whole seconds, so we never bothered
> parsing fractional seconds. However, it's better for us to parse and
> throw away the fractional part than to refuse to parse the timestamp
> at all.
>
> And refusing parsing fractional second part may confuse the parse to
> think fractional and timezone as day and month in this example:
>
> 	2008-02-14 20:30:45.019-04:00
>
> Reported-by: Brian M. Carlson <sandals@crustytoothpaste.net>
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gm=
ail.com>
> ---
>  Documentation/date-formats.txt | 2 +-
>  date.c                         | 2 ++
>  t/t0006-date.sh                | 2 ++
>  3 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/date-formats.txt b/Documentation/date-formats=
.txt
> index 6926e0a4c8..6f69ba2ddd 100644
> --- a/Documentation/date-formats.txt
> +++ b/Documentation/date-formats.txt
> @@ -20,7 +20,7 @@ RFC 2822::
>  ISO 8601::
>  	Time and date specified by the ISO 8601 standard, for example
>  	`2005-04-07T22:13:13`. The parser accepts a space instead of the
> -	`T` character as well.
> +	`T` character as well. The fractional part will be ignored.

When somebody has read the whole patch series, it is clear what
"fractional part" means. Otherwise it is not clear, what fractional part
means. The following may be easier to understand ?

  ISO 8601::
  	Time and date specified by the ISO 8601 standard, for example
  	`2005-04-07T22:13:13`. The parser accepts a space instead of the
  	`T` character as well.
  	Fractional parts of a second like `2005-04-07T22:13:13.091`
  	will be ignored and treated as `2005-04-07T22:13:13`

>  +
>  NOTE: In addition, the date part is accepted in the following formats:
>  `YYYY.MM.DD`, `MM/DD/YYYY` and `DD.MM.YYYY`.
> diff --git a/date.c b/date.c
> index b0d9a8421d..2f37397beb 100644
> --- a/date.c
> +++ b/date.c
> @@ -556,6 +556,8 @@ static int match_multi_number(timestamp_t num, char =
c, const char *date,
>  	case ':':
>  		if (num3 < 0)
>  			num3 =3D 0;
> +		else if (*end =3D=3D '.' && isdigit(end[1]))
> +			strtol(end + 1, &end, 10);
>  		if (num < 25 && num2 >=3D 0 && num2 < 60 && num3 >=3D 0 && num3 <=3D =
60) {
>  			tm->tm_hour =3D num;
>  			tm->tm_min =3D num2;
> diff --git a/t/t0006-date.sh b/t/t0006-date.sh
> index d9fcc829a9..d582dea5c5 100755
> --- a/t/t0006-date.sh
> +++ b/t/t0006-date.sh
> @@ -81,6 +81,8 @@ check_parse 2008-02 bad
>  check_parse 2008-02-14 bad
>  check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 +0000'
>  check_parse '2008-02-14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
> +check_parse '2008.02.14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
> +check_parse '2008-02-14 20:30:45.019-04:00' '2008-02-14 20:30:45 -0400'
>  check_parse '2008-02-14 20:30:45 -0015' '2008-02-14 20:30:45 -0015'
>  check_parse '2008-02-14 20:30:45 -5' '2008-02-14 20:30:45 +0000'
>  check_parse '2008-02-14 20:30:45 -5:' '2008-02-14 20:30:45 +0000'
> --
> 2.26.0.485.g42af89717d
>
