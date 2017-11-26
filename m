Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AADC20954
	for <e@80x24.org>; Sun, 26 Nov 2017 00:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbdKZAif (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 19:38:35 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:45006 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751415AbdKZAie (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 19:38:34 -0500
Received: by mail-qt0-f172.google.com with SMTP id h42so35165733qtk.11
        for <git@vger.kernel.org>; Sat, 25 Nov 2017 16:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=j7+953OZVJ5E8EDicFD0q8Q8n9vrSjojdsu3Am5fXzk=;
        b=iwSbp99hX77NSHFX1SMOcGp62YjNV7imvXxitdDojPLZdLO4VLNaq6RwAhjoE/I1V4
         +ogtXeC5Yg4IQcdAAEsiP0rMpBQenfO1tOVHzJSWUWJOR099ejNye/f/wqOxEkrEep0R
         nAxX8SB2rQUjWkalfoHqdq2GkIYYK/ylAlaA1YWw2avZCeFKuRWdiu3id4wmwVLJpD9w
         Ml7aJR4DC5lazDF7ZK+Z5UIWvtzHrUUjA+6OpOU+y9xte1l4Igx4e6XAksRZI1v/+vF4
         l0IqcD5/Qypr5Neb8coChXPjHSz8XFYGn126qXo3G4Nr7wYvJhGNENYaPiYSbZG0Aur+
         u4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=j7+953OZVJ5E8EDicFD0q8Q8n9vrSjojdsu3Am5fXzk=;
        b=jERNJm3PccKeK/NcVdSI2jTx8BkDYGo/kC9kGXUgC74j2Wj23nmN25iKtLQ+hKA2j3
         pW8Gl0wZBwB5SIwpUzHmKhsJ4c7T5JLtwEQOWYm0oXZW1nCpr7KrUX3qrrbu/Q9anejK
         RKf/ZShaUWtnHKJ0ZvdG453oDR5i0Py+FTrzL34tYC8RPGkCRSODB2ckjHGnlrh2R8Ft
         dDPpPsarZELGM3Aq7b863XLL04oU3lJ5xfW8EIUm7+tSVsbV0PTHfZ6goxgJtfqy1No/
         E+x9aTJwaVStmLYyhC0kENFu0OUOgcN1IIRzBQHwfrvGsFPw/6kA99HgzKrBOZ2Srxi1
         3QBg==
X-Gm-Message-State: AJaThX71cBrMxQ3yJR5GF+YADYYXEx5yu+NY01C8antPoiCv5Oa7LoCy
        yorUrfT2TYA6by8ONqR1Kvkz1PqrOneqIOpYK5Q=
X-Google-Smtp-Source: AGs4zMbwTDhKFc/U0UHWT14LDErSDBl9Ulx+N7nK+XYF36hm6sDwKytcTSNUdy9QjA/+VV//iF75ZbX0nnyh+bwbOcE=
X-Received: by 10.237.37.162 with SMTP id x31mr53541167qtc.58.1511656713899;
 Sat, 25 Nov 2017 16:38:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Sat, 25 Nov 2017 16:38:33 -0800 (PST)
In-Reply-To: <20171125214721.GA26158@jessie.local>
References: <20160401235532.GA27941@sigill.intra.peff.net> <20171123234511.574-1-max@max630.net>
 <CAPig+cQEaqaOTcC=5pZZmZNs_QQQ0vBRbzczyM3ZXXi+ZHW4XA@mail.gmail.com> <20171125214721.GA26158@jessie.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 25 Nov 2017 19:38:33 -0500
X-Google-Sender-Auth: Yn7YQ4-eG65HCOpk9T_wKRPy1lU
Message-ID: <CAPig+cRRHepuNNva_cq2YPEDSBCO25y1mihuC52RntpJ+a+YMg@mail.gmail.com>
Subject: Re: [PATCH] http-backend: respect CONTENT_LENGTH as specified by rfc3875
To:     Max Kirillov <max@max630.net>
Cc:     Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 25, 2017 at 4:47 PM, Max Kirillov <max@max630.net> wrote:
> Thanks for the review. I saw only reaction of the Jeff in
> the original thread and though that it is ok otherwise. I'm
> fixing the things you mentioned.

The commentary (in which you talked about restoring the patch and
squashing) seemed to imply that this had been posted somewhere before,
but it wasn't marked as "v2" (or whatever attempt) and lacked a URL
pointing at the previous attempt, so it was difficult to judge.

> On Thu, Nov 23, 2017 at 08:30:39PM -0500, Eric Sunshine wrote:
>>> +static ssize_t read_request_fix_len(int fd, size_t req_len, unsigned char **out)
>>
>> Wrong data type: s/size_t req_len/ssize_t req_len/
>
> Passing negative value to the function makes no sense. I
> could add explicit type cast to make it clear. It should be
> safe as site_t's range is bigger, and overflown
> CONTENT_LENGTH results in die() at parsing (I have a test
> which verifies it)

A concern with requesting size_t bytes is that, if it does read all
bytes, that value can't necessarily be represented by the ssize_t
returned from the function. Where would the cast be placed that you
suggest? How do other git functions deal with this sort of situation?
