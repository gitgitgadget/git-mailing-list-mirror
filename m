Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE927201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 19:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbdBXTVJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 14:21:09 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33207 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbdBXTVG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 14:21:06 -0500
Received: by mail-pg0-f68.google.com with SMTP id 5so4073237pgj.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 11:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=b9VMAvr3NoyaF7phF8cGA3WNsBGxO+fVYq6SveGCAjE=;
        b=iCdu6a6Kxlz7+FAxSM+DhMY/vD5ML8JxEQTzFV7akLRb4FUZjfvlEUjCymcNCQc7gP
         DHd7HhllRl1XkbYqKXpC7Mz1++3Ma8viWOGeKuHU+mvGelRFpSghROUEhOn0x3X3OFsd
         p8jgzQhu32KHkRGK9FUAYHqia0p7FfS3WPeTZRMVrSPx29IVAF1hTdLHww5hyfoh8a2B
         Faq3YKSy3emj0aP7oD9LVb6jGqEJCAoZfPOVFN/T5ZDVJ0PYPFadJl7zbDW+LU7Ry2el
         K1ozDGb4MOr6SvVQ3PRrFiH0ZPDHAtYAxETSdDQfdglj/+g6iOaxV+W9Xy4QWHwyV8iI
         JeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=b9VMAvr3NoyaF7phF8cGA3WNsBGxO+fVYq6SveGCAjE=;
        b=ap02M02L1pelnOXLcZGtv4DfnGbDYgdmbKK6puBW1d06F1D0A7mlbgQr1xqDWJrYvn
         nU7ZhUsIJ1yZAlCB4XgazEACP8/OdubP46sPaQDC1c7j7//ussi0cE/qx/Ro9/m65e8F
         ROt34UuuaOSg1sOuNujiKPpg66Ryvi2IB1+v4Siaj8084sytbDHi5j/q6rwK/2hcYSrP
         CT5RktmRy/PBYb4O57SzaqUWmJACwFqENZeagWJvL3Pyt81LU0nELvwglrnAUSt5g41a
         el0D2sIaajl5bb1vDHXj6a9Xq/6OV3pqBVwNrcO5bOu/cRGizFsH37qG6UmsEaJNWOXe
         cPrA==
X-Gm-Message-State: AMke39kTDBDCZrGBMyUVX+ksSapu0ssbmwYBjIQMpECf6ZPwEdXyAAnIqSoxDBArkDHn/Q==
X-Received: by 10.98.39.195 with SMTP id n186mr5368089pfn.17.1487964041743;
        Fri, 24 Feb 2017 11:20:41 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f06c:2e0c:850d:31b4])
        by smtp.gmail.com with ESMTPSA id l12sm16520725pfj.37.2017.02.24.11.20.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 11:20:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     David Lang <david@lang.hm>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
        <22704.19873.860148.22472@chiark.greenend.org.uk>
        <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
        <nycvar.QRO.7.75.62.1702240943540.6590@qynat-yncgbc>
        <xmqqk28f4fti.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaZWe-8pMZnQv7uZtr8wXWawFeJjUa68-b0oa4yFo-HcA@mail.gmail.com>
Date:   Fri, 24 Feb 2017 11:20:39 -0800
In-Reply-To: <CAGZ79kaZWe-8pMZnQv7uZtr8wXWawFeJjUa68-b0oa4yFo-HcA@mail.gmail.com>
        (Stefan Beller's message of "Fri, 24 Feb 2017 10:58:28 -0800")
Message-ID: <xmqq7f4f4cqg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Fri, Feb 24, 2017 at 10:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> you are inviting people to start using
>>
>>     md5,54ddf8d47340e048166c45f439ce65fd
>>
>> as object names.
>
> which might even be okay for specific subsets of operations.
> (e.g. all local work including staging things, making local "fixup" commits)
>
> The addressing scheme should not be too hardcoded, we should rather
> treat it similar to the cipher schemes in pgp. The additional complexity that
> we have is the longevity of existence of things, though.

The not-so-well-hidden agenda was exactly that we _SHOULD_ not
mimick PGP.  They do not have a requirement to encourage everybody
to use the same thing because each message is encrypted/signed
independently, i.e. they do not have to chain things like we do.

