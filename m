Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E23F20984
	for <e@80x24.org>; Tue, 13 Sep 2016 23:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759131AbcIMX2I (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 19:28:08 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:36005 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755700AbcIMX2I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 19:28:08 -0400
Received: by mail-it0-f54.google.com with SMTP id o3so19997500ita.1
        for <git@vger.kernel.org>; Tue, 13 Sep 2016 16:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y0RpY2jgJaZiArjnEfeDdk94QiEgNMoWMiX8pczzwEk=;
        b=VM0m8yzV/YthzkQu58di18GBmvdWqrcxLXFGiguctIq4n3hT0rMW4W7HoYq4+toYB0
         Y+dqdECrvsIT4VPbrCde/eTGNp2dFo5g1ELqDftTizCNgKUYQr6XhhI1ueKVLA4L7Y0M
         Kte6oSjbMS8gI2cxnGVYbxB0yVd7R/04bvxyIIiQRWb5tTrOMY4+c9uQTdMP5sJ+y+5N
         x0pQCYGROlyPgwEJzw7DA4k/YzMmTXSdgAEabZaOnOeF3d2DVi4ZOLRMRJ4S2kjBD0VV
         bokNy2X4uZi2YrAyxdaNuH1g65MjZLeny1ZwiI4c1KOm8qaJY8b8TdpcK0vkbN7aFGDY
         dPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y0RpY2jgJaZiArjnEfeDdk94QiEgNMoWMiX8pczzwEk=;
        b=frjpxnjbWmdTU35Up2zWIY7g5PIu8/L7jSPERt+N1e0kAmtUkXQLfW2lL9mpHuCiLO
         /aX+mHXIKh95JGmDC6TfL9hFQq5fI55MWMFkb8viLhxVsWs3yNdhUEids8YV9QRL3Tf1
         rlGZvuNVM2jE5V9+v5tspK5pRy2EwQ8nvxPtGHo2zSlDP6bitn3onPYVAd9uKaQQQRbV
         NaaPLwag+vqqrh7wPjDaLqFvO/TF+clDXVgJQwbDUZK6d5v1U+njw/eThtsNydm4nSxB
         Pu5Q9p+jAPaqruDXFm5ujLKIpbn5vWJTGncSF+5wjgHd4qfGaHTO9CA/J+W3y489WSIL
         j5hw==
X-Gm-Message-State: AE9vXwNnzCBwwSCKWZ7lOQ7JAPGLy8fzj8zudpVvhGkLhW863CVHBbUFNuobpLKFeNdjIr5v87aFURIwEufrqTEl
X-Received: by 10.107.131.8 with SMTP id f8mr46685iod.91.1473809286713; Tue,
 13 Sep 2016 16:28:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Tue, 13 Sep 2016 16:28:06 -0700 (PDT)
In-Reply-To: <xmqqlgyvtn6l.fsf@gitster.mtv.corp.google.com>
References: <20160913044613.1037-1-sbeller@google.com> <20160913044613.1037-17-sbeller@google.com>
 <xmqqlgyvtn6l.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Sep 2016 16:28:06 -0700
Message-ID: <CAGZ79kb4Rm=AT-hFutXW5jhZRL0ThDFr789=AbxKC-o+jQ341g@mail.gmail.com>
Subject: Re: [RFC/PATCH 16/17] diff: buffer output in emit_line_0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 13, 2016 at 4:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +struct line_emission {
>> +     const char *set;
>> +     const char *line;
>> +     const char *ws;
>> +     const char *reset;
>> +     int first;
>> +     int len;
>> +     int whitespace_check;
>> +     unsigned ws_rule;
>> +     int has_trailing_carriage_return;
>> +     int has_trailing_newline;
>> +};
>
> It is somewhat strange to see whitespace things are per-line here.
> I'd understand it if it were per-path, though.

Yeah we have to have it at least per path as that is the granularity
the user can configure it.

So would we rather want to keep the ecbdata around for each file pair and
just reference that? I thought we deliberately want to avoid ecbdata, so maybe
we rather want to have another struct that keeps path related information
around (pointer to the blob and white space information).

Thanks,
Stefan
