Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDFA11F406
	for <e@80x24.org>; Sun, 17 Dec 2017 00:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756929AbdLQAGm (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 19:06:42 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36410 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbdLQAGm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 19:06:42 -0500
Received: by mail-qk0-f195.google.com with SMTP id 8so14528600qkj.3
        for <git@vger.kernel.org>; Sat, 16 Dec 2017 16:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=hBChpgQAsMkF+WjiByrzqVdHB3+wiTSF8BHIjxslyrU=;
        b=q4Dxabj/lD0i+/0nhJsQMh1XaEFUd5kFkAY81faPeCpu4YgV3TF8pycedEm8JW+gfs
         1mc7RpfHIxF5E4ZZu9HuCeHsArSVFAZV8YziCYEf8XUGkNFI0UZpZOxVR74gFN5H3HzI
         kr3k7hTymFPOyCl/lX+SvnHosUCUUGgLt1jeOc5/QmXy8phuL5aQUvk9WsqMyJu3pCNs
         5dpR+0lF6l9kZAciLDypTDF4kvHbefsX0yUAnqsmzHueBMhaC9mNluv9+R6en+aU7pLM
         HpVIJn7UBGY9YIk5hprZ+6jgzW/58XmRtQM4d/i5oJ+ETs9sBd/LTul1a9L1UXHADz7W
         flww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=hBChpgQAsMkF+WjiByrzqVdHB3+wiTSF8BHIjxslyrU=;
        b=FhqZ6kJT5hDBxhk1c7BjJiLfDPa97RfLcTHo2Vseduoj02KcoMPWcD7HtGVWWwM8tR
         tccjtikAzRv/+NGuAejIYYD/7Eg9Ifte8bOL3iKent1oYYRzablJ6oYRIwS/tmBUgBPf
         NnSOfCU3l3gKY3ivceOdBTPEu1p1oy6clzuYu+SBJRtk2YwYNXW5aT0SMEUgtAS8DMeo
         LUZCtdvtkafDXrq6d5m2w0iKZSvvwAMdjapzKw860mtNNHav7p2EzpcT/jZQqsc5YEmY
         zIyX8DEXumkRp1Yh7CfYxh9fDFzWNzflf25c7dJfhR24dUvM0pJPqXV6VrgZYaBWw7+q
         yBCA==
X-Gm-Message-State: AKGB3mLyl+y6QAZgT85NLzo+0Zm/Qwh3Of37aAdXfmAo+fO9hEWl+gdX
        9a3If/KhpZA3jREWHMJbciHxIGy7kWY0woh4k8U=
X-Google-Smtp-Source: ACJfBostMFjeC1KC6INEkAbOKMgI59ua/Z1hyzEM4/+MqX5pWXngNj0IuwMS9Pt8o1e0gOd21BryxXA8eckSKDfKrB0=
X-Received: by 10.55.130.194 with SMTP id e185mr27041100qkd.357.1513469201352;
 Sat, 16 Dec 2017 16:06:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Sat, 16 Dec 2017 16:06:40 -0800 (PST)
In-Reply-To: <20171216195246.10445-1-tboegi@web.de>
References: <xmqqh8t2ckgw.fsf@gitster.mtv.corp.google.com> <20171216195246.10445-1-tboegi@web.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 16 Dec 2017 19:06:40 -0500
X-Google-Sender-Auth: xpy9eD-4Hmq-L6kNWx-ioEjk3gM
Message-ID: <CAPig+cQtcNhz3Z+iZRWx1PjnJwWeeo19gUNQRHOcJyxEgfUDsQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] check-non-portable-shell.pl: Quoted `wc -l` is not portable
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 16, 2017 at 2:52 PM,  <tboegi@web.de> wrote:
> [...]
> Add a check in check-non-portable-shell.pl to find '"' between
> `wc -l` and '=3D' and hint the user about test_line_count().
>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.p=
l
> index 03dc9d2852..fadbb1e5a7 100755
> --- a/t/check-non-portable-shell.pl
> +++ b/t/check-non-portable-shell.pl
> @@ -21,6 +21,7 @@ while (<>) {
>         /^\s*declare\s+/ and err 'arrays/declare not portable';
>         /^\s*[^#]\s*which\s/ and err 'which is not portable (please use t=
ype)';
>         /\btest\s+[^=3D]*=3D=3D/ and err '"test a =3D=3D b" is not portab=
le (please use =3D)';
> +       /\bwc -l.*"\s*=3D/ and err '`"$(wc -l)"` is not portable, please =
use test_line_count';

Nit: Every other "please use" suggestion is parenthesized; for
consistency, this probably ought to be, as well.

>         /\bexport\s+[A-Za-z0-9_]*=3D/ and err '"export FOO=3Dbar" is not =
portable (please use FOO=3Dbar && export FOO)';
