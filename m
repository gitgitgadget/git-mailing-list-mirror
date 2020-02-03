Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D86C3524D
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 08:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABF720661
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 08:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQOgvW0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgBCI7c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 03:59:32 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:40377 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbgBCI7c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 03:59:32 -0500
Received: by mail-il1-f194.google.com with SMTP id i7so11934488ilr.7
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 00:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=rdCSGp4gYpPmoEsosi+/qjUkxMmkkJXhzuIoCTWt7CI=;
        b=FQOgvW0cbdi6hqk8FzJm7fV6Qy1z5Sz1gly0tqoo5tDTeFqyDeTJkldcbw01BZxLK2
         M7Fr6CGmlrABPl5MykRlDNYS8xWrfeUQZRKcxaBcM+Ba2QpycJbg6Q/WBhLOeoAKcUoO
         Qd+4mbN3MQZQQ/5rJAAyRwPEoH20rZhDBRIIyXc0b0zGUjTaGJ0KJulnc1ml2cIRxlVg
         +Xd2zF/Sd4qJeI0fYrQZ0NpsYr2wD7EmUxUNer3y/X/FBZV/VWvCphjN78wmyASfs9PO
         +REVh98BrMaWa8We3zkXpWWCB7BnhD4tCrmAUVw82mYki+5UbGxVG5mrpldgKfGDOdn3
         caUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=rdCSGp4gYpPmoEsosi+/qjUkxMmkkJXhzuIoCTWt7CI=;
        b=RVNJ23NXm51ujqx8VnmFFndAloSgyX7Tx5+fmkingpfDd7PNyCxLgg6qyXShbFfVvl
         Rk5N/FHXY/tPcWvQvG39a81553LGeJUmRdjreIIbcHqV2k9f2IFDXQPQ+EoM77DOUw9x
         p31Oi+n4/bMklkNm3njNe3ZaXqeoeS+DNQ1rpah4kveRJ+UowDjX9bkTv4ry0HZGtxiW
         +bvILJHnySe9S9/Tz67fU1IJ3vPeAq4sbNFjSf6VairmzIfcHEaUKnWUnmU5p1F5h6CR
         2AyhG7n+vsH/n83mNSbnc5aNBERFYpJ0F+Wm5B1PhMpVYvbJBL0S1Ls8ii5RHVypH9/D
         R44w==
X-Gm-Message-State: APjAAAXzCYUAFeHK1+/99xt+rmXnwc4v9BXraJ7GH3aaU8D47x4h3sRr
        pDfIiSibHHBQjVneLACZBQnInkeBO7DtvHllu1o/LA==
X-Google-Smtp-Source: APXvYqyjw2fbQjWkAfpDqFH3hDOW8oaSdJ6fEFNO5lkRKdQDlCEySbvHMinojXKtZCnha4h1r8wy8WceQTsEQV3ekwE=
X-Received: by 2002:a92:8847:: with SMTP id h68mr20556313ild.212.1580720371664;
 Mon, 03 Feb 2020 00:59:31 -0800 (PST)
MIME-Version: 1.0
References: <CAH8yC8m3JFvEcfFF3z1rrRnEPK-adHGObmkOhNZiph7QJKUWqA@mail.gmail.com>
 <CAH8yC8mh0gysNz3Dbrph0f8KZ8DEWaH-6rWg6fSOD-_aGh3=3A@mail.gmail.com> <20200203085405.GC2164@coredump.intra.peff.net>
In-Reply-To: <20200203085405.GC2164@coredump.intra.peff.net>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 3 Feb 2020 03:59:19 -0500
Message-ID: <CAH8yC8=_9OtBJ2dMJPSGb3bYf-b+C6GYXx+NP4Dy_LDCoiks+A@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IGdpdC1jb21wYXQtdXRpbC5oOjc5ODoxMzogZXJyb3I6IGNvbmZsaWN0aW5nIHR5cA==?=
        =?UTF-8?B?ZXMgZm9yIOKAmGluZXRfbnRvcOKAmQ==?=
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 3, 2020 at 3:54 AM Jeff King <peff@peff.net> wrote:
>
> On Sat, Feb 01, 2020 at 07:12:21AM -0500, Jeffrey Walton wrote:
>
> > Maybe the include should be <arpa/inet.h> on Sun systems?
> ...
> This also seems eerily familiar:
>
>   https://lore.kernel.org/git/CAH8yC8kOj5a5PN4V7mj7xZPoNDr-MH-CkirxRKyfx1-qAvfpqQ@mail.gmail.com/
>
> :) I second Junio's notion there that you may be better off skipping
> ./configure entirely.Thanks Jeff.

I run 'make configure' and configure because that's what the INSTALL
tells me to do.

Forgive my ignorance... If I don't run configure, then how do I
configure things?

Jeff
