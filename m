Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63BE81F4F8
	for <e@80x24.org>; Tue, 27 Sep 2016 08:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755001AbcI0IOY (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 04:14:24 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34873 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753643AbcI0IOU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 04:14:20 -0400
Received: by mail-lf0-f67.google.com with SMTP id s64so1308900lfs.2
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 01:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qM+YUUJFtQQ/jcx+KclkmufK3l+rQVdTDMRd/gC51bI=;
        b=YIkTciaDZVGyZcut9p16DFUBLX9UXkU0OeYjAZNEyhNqrXTnRh3qRQPbHeMxBBBpKI
         WkFbUmf201nHbXCDk5YX1FEhyR4NHho7KIwDhzc5SWsv/jPbu2uosTWzC+Ah9HNmHfBv
         AV0mi4QS9X9bQ5Ex7UU2XEmmFEscWuP2lqbUTSmjTC09dZDcwuqYSI8TBKEufrQazwuk
         01dc8Jb9mJ2ht3EdUImC4wu/jOIQSk0ClxuSLimYtbE2yH6rykVZO1FYElNxea+f7z2C
         VqmO0eCgiDkqVrV/c8nTTvtCGVbZ7LdnNkv2nyEAbXRn4JIEl1BeO+uTKwwl/78MJus/
         ApEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qM+YUUJFtQQ/jcx+KclkmufK3l+rQVdTDMRd/gC51bI=;
        b=hG+i4ZpckebIv8127bayc4pUkpZIPtSExXms8JQTWVPjbGy93gS4Dlxn6/9a9v8GeN
         Qwdu0sqCc0VCH9HxXswgmejrN9jdkHXo5ir7vLdynMGbqJb7FLsREJZjz1cM4aCwfBBF
         pOY2HQ6EGRsYNDhSBslxEO9ioFFvvFUsqw2JgUO1R7y3gFjzRdoqyZrOaZGUJF5U2zN6
         nHMIac9k65/KWhFVzM0Vux182EWIlJScN96ci1J+n6GafTDD1VJtu7VqxSTuaKqqPhM5
         K42vU9qr4MFQMBxeReRSW1R8PRxeecPHgrqYM7+lshFR7LZYgej5hkJmcl0sY0iTgYGb
         JoTA==
X-Gm-Message-State: AE9vXwMf8ziUe7UMwLngXFj3XUvM9KuhR5n9vNxeZlGdIvAHwsYuTz/5Z3cuj7AsrL33rQ==
X-Received: by 10.194.93.198 with SMTP id cw6mr21457537wjb.212.1474964058690;
        Tue, 27 Sep 2016 01:14:18 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB40BF.dip0.t-ipconnect.de. [93.219.64.191])
        by smtp.gmail.com with ESMTPSA id a84sm15494037wme.6.2016.09.27.01.14.16
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Sep 2016 01:14:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v8 07/11] pkt-line: add functions to read/write flush terminated packet streams
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <77315FC2-47F3-433A-8D70-5497FB04CBBE@gmail.com>
Date:   Tue, 27 Sep 2016 10:14:16 +0200
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6D8B988C-8E54-4AA6-980C-A6BA40983D88@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com> <20160920190247.82189-8-larsxschneider@gmail.com> <507a29a1-99ff-c13e-cf1f-76631345a822@gmail.com> <77315FC2-47F3-433A-8D70-5497FB04CBBE@gmail.com>
To:     =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 26 Sep 2016, at 22:23, Lars Schneider <larsxschneider@gmail.com> =
wrote:

>=20
> On 25 Sep 2016, at 15:46, Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:
>=20
>> W dniu 20.09.2016 o 21:02, larsxschneider@gmail.com pisze:
>>> From: Lars Schneider <larsxschneider@gmail.com>
>=20
>=20
>>> +		strbuf_grow(sb_out, PKTLINE_DATA_MAXLEN+1);
>>> +		paket_len =3D packet_read(fd_in, NULL, NULL,
>>> +			sb_out->buf + sb_out->len, =
PKTLINE_DATA_MAXLEN+1, options);
>>=20
>> A question (which perhaps was answered during the development of this
>> patch series): why is this +1 in PKTLINE_DATA_MAXLEN+1 here?
>=20
> Nice catch. I think this is wrong:
> =
https://github.com/git/git/blob/6fe1b1407ed91823daa5d487abe457ff37463349/p=
kt-line.c#L196
>=20
> It should be "if (len > size)" ... then we don't need the "+1" here.
> (but I need to think a bit more about this)

After looking at it with fresh eyes I think the existing code is =
probably correct,
but maybe a bit confusing.

packet_read() adds a '\0' at the end of the destination buffer:
=
https://github.com/git/git/blob/21f862b498925194f8f1ebe8203b7a7df756555b/p=
kt-line.c#L206

That is why the destination buffer needs to be one byte larger than the =
expected content.

However, in this particular case that wouldn't be necessary because the =
destination
buffer is a 'strbuf' that allocates an extra byte for '\0' at the end. =
But we are not
supposed to write to this extra byte:
=
https://github.com/git/git/blob/21f862b498925194f8f1ebe8203b7a7df756555b/s=
trbuf.h#L25-L31


I see two options:


(1) I leave the +1 as is and add a comment why the extra byte is =
necessary.

    Pro: No change in existing code necessary
    Con: The destination buffer has two '\0' at the end.


(2) I add an option PACKET_READ_DISABLE_NUL_TERMINATION. If the option =
is
    set then no '\0' byte is added to the end.

    Pro: Correct solution, no byte wasted.
    Con: Change in existing code required.


Any preference?


Thanks,
Lars=
