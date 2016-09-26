Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E7F9207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 18:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161652AbcIZSxZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 14:53:25 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36264 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161518AbcIZSxY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 14:53:24 -0400
Received: by mail-lf0-f67.google.com with SMTP id s29so10380739lfg.3
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 11:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ivuGCJ0R++xOKqDVT3lA8DBvTxmz84aO9QXAaLKNECs=;
        b=lfDH3rImJANLEHmRZzvPlfHLGIPgZdYc8TUKvqLrtts2l6wD+0isDq+Qxibyy4ThVC
         eBpt/WvfqX+1WU5cxkXrbudJko45IZHoqqD18qaPORdj0225SnvLvDmv76Pz/64HZbvM
         3KefJGH2JaLH1KsnoHTgkgZIaiOob0cJC+CY2pwQJeYa/5/nG5JiX6xwBh7VE1BzzO8n
         lsfFY8BgXC3HQ6y80d/ISNrA1jtqewK64z1ArLqytv8MpQ6PU/rqMkjVyuHmvGcTdXNk
         gsQdz4hIa5wcurmWWaFZNagXdqkT7n4JHdI8K69cRVNHuVcADa3/sMn/Hjy8SOQVyyCz
         vaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ivuGCJ0R++xOKqDVT3lA8DBvTxmz84aO9QXAaLKNECs=;
        b=XtehI3HKG5Ayse12kMa9pAuN3ra03B27j6dzGo8xuAGIow9xywzg5pwM+MLUKnDxZj
         HYqlIBN5b5juq0HI/BLuhPoIsFYdaJLqRfG/0anqjp7hOeIWDzNYNkCLx8rTC6xKcWiF
         6PjiM1dCcIvMEKOPC+4z22rG1jHf+JYHBeEEaqcncZx9WG/saVEN0Dif0xepUrlPfONa
         4mzqX1iUejRHpPOvmkwHovuaCeWbfLc61v3t85P3Lm/iBnD+na/+Mn48Kf23JBEHoLix
         G+zPna8Ll4DsIv8vzc4S/zfOSFCpoyPCBEz62aCqADY3Ngcsn6JG9wIl8mXtc8gjhA50
         VLZw==
X-Gm-Message-State: AA6/9RlBTICZ3AzIsnR+PnXSbEpiuasCFH/+4rzhdYBIBRmAAU+3Y3qwoOCDgBkCirb7gQ==
X-Received: by 10.28.135.71 with SMTP id j68mr14736229wmd.130.1474916003021;
        Mon, 26 Sep 2016 11:53:23 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB4342.dip0.t-ipconnect.de. [93.219.67.66])
        by smtp.gmail.com with ESMTPSA id ce6sm23709156wjc.27.2016.09.26.11.53.21
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Sep 2016 11:53:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v8 02/11] pkt-line: extract set_packet_header()
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <a5b9a46d-592e-089d-d156-36c4d61902c9@gmail.com>
Date:   Mon, 26 Sep 2016 20:53:20 +0200
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C797715E-97C3-4EEA-AD9F-C22FA27F0421@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com> <20160920190247.82189-3-larsxschneider@gmail.com> <a5b9a46d-592e-089d-d156-36c4d61902c9@gmail.com>
To:     =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 24 Sep 2016, at 23:22, Jakub Nar=C4=99bski <jnareb@gmail.com> wrote:

> W dniu 20.09.2016 o 21:02, larsxschneider@gmail.com pisze:
>=20
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> Subject: [PATCH v8 02/11] pkt-line: extract set_packet_header()
>>=20
>> set_packet_header() converts an integer to a 4 byte hex string. Make
>> this function locally available so that other pkt-line functions can
>> use it.
>=20
> Ah. I have trouble understanding this commit message, as the
> set_packet_header() was not available before this patch, but it
> is good if one reads it together with commit summary / title.
>=20
> Writing
>=20
>  Extracted set_packet_header() function converts...
>=20
> or
>=20
>  New set_packet_header() function converts...=20
>=20
> would make it more clear, but it is all right as it is now.
> Perhaps also
>=20
>  ... could use it.
>=20
> as currently no other pkt-line function but the one =
set_packet_header()
> was extracted from, namely format_packet(), uses it.
>=20
> But that is just nitpicking; no need to change on that account.

Changed it:

Extracted set_packet_header() function converts an integer to a 4 byte=20=

hex string. Make this function locally available so that other pkt-line=20=

functions could use it.

Thanks,
Lars=
