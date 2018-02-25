Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7C811F404
	for <e@80x24.org>; Sun, 25 Feb 2018 20:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbeBYUDU (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 15:03:20 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34462 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751762AbeBYUDT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 15:03:19 -0500
Received: by mail-qk0-f176.google.com with SMTP id l206so16764510qke.1
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 12:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=yh0pZkPjDd0sWcoMWgpyXh2gOsqc0XR2tE1HgtkR7as=;
        b=kalWwT8J6yGR6WH8jz7puqSZhPhBQOOe7GUvrTCjs3Bgtc5RF+9wdgGkiY4QWBvZUX
         7D7LQdjMb5MFqJpHGpEAGGI0f0nOPgTZDMP04QrpTkZxZnYtE5LlMTFh3yp+X0VLmP/W
         NX/NfrOwtPgGXBLdgFXZO8yMElLJxweY1Mv/x827t+VaZwLrjpXRda8w34TMyaFG0tdB
         TwMB7grHbNsD3gQiN0SycsWt1aGhIXITozOhC38MyuivQcrrnHWlcEMFLPA/zrr3Ntn1
         WdHe2sb08u34VT4PMLZZSJUFG5N5HIABXzw/ft678V//X01ypb9bKod4+V9f+FNwX4RH
         HD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=yh0pZkPjDd0sWcoMWgpyXh2gOsqc0XR2tE1HgtkR7as=;
        b=GQd8HpISQujtqQYzU7rFukEoUMZujfp1Hi2/b59kxfx62D0k124uvoGfdUJrXKsaG8
         F+q84SeIBu4z9lwcqAA2dkjA0mwacGOsJPEJVq/Brne+wNWa3DYVT+EeoQbZLTbVh2jr
         tkT7ik9nXGPfmaG5Cw1NLq7w/25OqXARvY3zQ7REbYZFohP4WTFCbkqaXpLld5p0lyo3
         4df4e3CLB5HHxNl83CqHcHQKMOQuLLahRyjHhld7y2hf/Fspye7ACj/H1YxzEbByXgBg
         v9ytWL/R/w/uyH1SuMekAa41ndGGBbTWV9kcz2+gLv+Jo76nSuHuuw7vve6Svsi6m/jT
         53VA==
X-Gm-Message-State: APf1xPA4NiXGQBqBo1d6eEVwUt8wrUvC6wZXcxME9UMayubdngd4odG3
        V9sV7DsPTRa7CEpi2tre4PTi3x2nSTIG7pzrto0=
X-Google-Smtp-Source: AG47ELt5H76Q4Bwy9/kqLxwN1z+m3rWDghvv9OFZKrZCxdfPMMoI9TqnVl3zWOYD4+JeXze3agncaEK2E/UzNGHgcjE=
X-Received: by 10.55.134.133 with SMTP id i127mr13707898qkd.275.1519588998552;
 Sun, 25 Feb 2018 12:03:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Sun, 25 Feb 2018 12:03:18 -0800 (PST)
In-Reply-To: <20180225194637.18630-7-avarab@gmail.com>
References: <20180214222146.10655-1-avarab@gmail.com> <20180225194637.18630-1-avarab@gmail.com>
 <20180225194637.18630-7-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 25 Feb 2018 15:03:18 -0500
X-Google-Sender-Auth: 2Iz4fFW9TCStQT88D35EldZfbcg
Message-ID: <CAPig+cSy5-4ErsiftU95Mihw5BqKjf95=iiw_0FBDJtTY0YOXA@mail.gmail.com>
Subject: Re: [PATCH v2 06/13] git-send-email: unconditionally use Net::{SMTP,Domain}
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@slb.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 25, 2018 at 2:46 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> The Net::SMTP and Net::Domain were both first released with perl
> v5.7.3[1], since my d48b284183 ("perl: bump the required Perl version
> to 5.8 from 5.6.[21]", 2010-09-24) we've depended on 5.8, so there's
> no reason to conditionally require this anymore.

s/this/them/ or s/this/these/

> This conditional loading was initially added in
> 87840620fd ("send-email: only 'require' instead of 'use' Net::SMTP",
> 2006-06-01) for Net::SMTP and 134550fe21 ("git-send-email.perl - try
> to give real name of the calling host to HELO/EHLO", 2010-03-14) for
> Net::Domain, both of which predate the hard dependency on 5.8.
>
> Since they're guaranteed to be installed now let's "use" them
> instead. The cost of loading them both is trivial given what
> git-send-email does (~15ms on my system), and it's better to not defer
> any potential loading errors until runtime.
>
> This patch is better viewed with -w, which shows that the only change
> in the last two hunks is removing the "if eval" wrapper block.
>
> 1. $ parallel 'corelist {}' ::: Net::{SMTP,Domain}
>    Data for 2015-02-14
>    Net::SMTP was first released with perl v5.7.3
>
>    Data for 2015-02-14
>    Net::Domain was first released with perl v5.7.3
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
