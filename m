Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAEBA200E0
	for <e@80x24.org>; Mon, 26 Dec 2016 08:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755334AbcLZIU2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 03:20:28 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34601 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755322AbcLZIU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 03:20:28 -0500
Received: by mail-lf0-f67.google.com with SMTP id d16so12483887lfb.1
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 00:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GaMmij6dZ9/GMeGRGS8lCUfFXXiaO2bxipBSDlaXrzk=;
        b=KiR7/enAtpytmJfhXMITZFsDT1z353JXKQOKoLSW0oFX6b5ULnpGdBeGpA3cqVnO/8
         fv2hNUp0XQJ3KbLvKN/7LONje050r5roexxEJNDHR6VmnzHwA4iRQ6uc+hJfvVzscXYN
         DhArnhYhMexsnlwmDbxU75iIdv3zgI+O4djz9ReRkck2QutFxhhcTes1nlHWVKAlRJzG
         ELuVtAsqzNjyR6blzRWGGEF5nBslSTOyH35qFCBrgESUfXXLsYE7z4YPFLfCT9HjTG7O
         81xjNnjrMEEe331Sgu1ttFC2m2xsJearJbu61UTaDcKM4VumA/3TreBpEBEQLW3oKQ0B
         GKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GaMmij6dZ9/GMeGRGS8lCUfFXXiaO2bxipBSDlaXrzk=;
        b=blwExxGJn7OLC+c1uPSxGfLZQWPvG92OQyBsujHnjfOpbsP3CjaeyVttpl/H0n5kou
         /zDE6tYWHvdX2Lj7X9oUGXurOueTFFa+i6MC/gJidh22bD82uAajoAjG/NsmmvD0FXsS
         BwgqVpguyoGBg935cnyAzGw0g06SSgZNIawepZUU7yLYglw1pLb8eqLIV4dE1Xrrvb62
         I9On3FqJaQuMdKRoGLVLsnF850+iSzbkk4M0gKI1OXtugRQ60GsM5mSp/NinlWBGGxff
         vFsARWXVtGRA3+QLGUZG1ENuLOMPDBGvw4DQ6GNc6T2n9rAJVkywfzXjGOyX5DSVr57u
         SGRg==
X-Gm-Message-State: AIkVDXJPZa2+27ERSe2X1B+FlUBulxZI2EKsCIJmi9kV9wYSspbbwl6mecX/ax3Qjyzz6Y1j7CWlArpK0YuFhQ==
X-Received: by 10.46.69.11 with SMTP id s11mr11039909lja.44.1482740426208;
 Mon, 26 Dec 2016 00:20:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.152.13 with HTTP; Mon, 26 Dec 2016 00:20:25 -0800 (PST)
In-Reply-To: <20161219111843.GB24125@ash>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
 <20161217145547.11748-5-chriscool@tuxfamily.org> <20161219111843.GB24125@ash>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 26 Dec 2016 09:20:25 +0100
Message-ID: <CAP8UFD0KwbQo4QgC9cevcdHWBwedy-qCUXcDqaeissv4U=5RyQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/21] read-cache: add and then use tweak_split_index()
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 19, 2016 at 12:18 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Dec 17, 2016 at 03:55:30PM +0100, Christian Couder wrote:
>> +static void tweak_split_index(struct index_state *istate)
>> +{
>> +     switch (git_config_get_split_index()) {
>> +     case -1: /* unset: do nothing */
>> +             break;
>> +     case 0: /* false */
>> +             remove_split_index(istate);
>> +             break;
>> +     case 1: /* true */
>> +             add_split_index(istate);
>> +             break;
>> +     default: /* unknown value: do nothing */
>
> Probably should die("BUG:") here since it looks to me like
> git_config_maybe_bool() (inside git_config_get_split_index) in this
> case has been updated to return more values than we can handle. And we
> need to know about that so we can handle it properly.

If we later add another value to the possible ones, like for example
"auto", we might not want old versions of Git to fail with a "BUG:..."
message when they read config files tweaked for newer Git versions, so
I don't think we should die() here.

A warning would be ok, but given that in tweak_untracked_cache() we
decided to do nothing, I am thinking that it would be more consistent
to just do nothing here too.
