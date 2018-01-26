Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD0291F404
	for <e@80x24.org>; Fri, 26 Jan 2018 21:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751404AbeAZVqF (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 16:46:05 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34770 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbeAZVqE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 16:46:04 -0500
Received: by mail-pf0-f194.google.com with SMTP id e76so1123887pfk.1
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 13:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YPy+mcAeV4KgrljBGyP3LF9VL4LgorcCcEWPq5/JlW0=;
        b=cYDI+z1rihQp6XP+ii23GaHXtCusM87xwbolGUsE2nSvzL+0YO+H/ka734D/HdaWIw
         ZVV+UmlXi/xNrUn/yUZyo7VUmyoKQwxpLTByyiXuB3FJ16xixI4/Ec92OzX7gAnzt7Qu
         ImNPQOQdA1FyEl3/JetxyFCorfabtXddVQ4T+EWA6kSDtswMtXQD8mwUo24TRbJA5uOX
         n9FIEDh1JNe95CRMgEjFwWzucnBsa5TZIIvmZlDShJSCHAyB5Guwy0X4c2PAHEnKRc5V
         xXa8+Q8bj2hGQibPMnXT5v5wairIljWyTVDdFV80P8Qh7XttitleRGP4Kq7X5TsROhPu
         rSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YPy+mcAeV4KgrljBGyP3LF9VL4LgorcCcEWPq5/JlW0=;
        b=D8xIb7KqTq2xfR8Q7kDSQaxTt07cQ/2awlrulGc5H2RPITVV0gow/Fyx+847mANgO6
         +JosZ6866XpMHwei7Ms7bBbzLu0oLu2GnhvzbE93+/A2lAjV75LGwThRyzR0iQnvIPm0
         PFsrUXv6Kj1iAm9T6/iZpT7hIP/FuCEj69fDF80WT8dTvRTbLqeVZbSOYph6wg1M2Bs1
         iJLIIpm0IbiXbjdZBgfQx8kxxdoZzUArfTbaRerNKUdgULVWYWUcs3zutXVeZ4WnBVKw
         eRLtnP097Ops3Q/uRANbo9yiWh1nCfBKSrpXl9FmVg0NfbJypaOUq8tJ18B3uM/uA4An
         nBVw==
X-Gm-Message-State: AKwxytfp/AHX+kE7JAIGp2t4j548pYx2rC5cnpV4e+M9Uj4QcnYBFsQ1
        UQzn8kSunx07kTlsADTu7vW/Lq+O
X-Google-Smtp-Source: AH8x224AdwArGo+iktaPRGiHVcEVz7BdodR//mFvKSwnUCafexI4jJolPLz1q9Vgh2FjBIhcgiHjlg==
X-Received: by 2002:a17:902:59c2:: with SMTP id d2-v6mr15786487plj.306.1517003163740;
        Fri, 26 Jan 2018 13:46:03 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3d49:4bb2:1738:a537])
        by smtp.gmail.com with ESMTPSA id a15sm20322515pfl.98.2018.01.26.13.46.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 13:46:03 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH RFC 03/24] cat-file: split expand_atom into 2 functions
References: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
        <0102016133ff3afb-6bab2c11-e0f3-4bef-9626-fbcc826bcb15-000000@eu-west-1.amazonses.com>
Date:   Fri, 26 Jan 2018 13:46:02 -0800
In-Reply-To: <0102016133ff3afb-6bab2c11-e0f3-4bef-9626-fbcc826bcb15-000000@eu-west-1.amazonses.com>
        (Olga Telezhnaya's message of "Fri, 26 Jan 2018 19:43:40 +0000")
Message-ID: <xmqqvafo5m5h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

> Split expand_atom function into 2 different functions,
> expand_atom_into_fields prepares variable for further filling,
> (new) expand_atom creates resulting string.
> Need that for further reusing of formatting logic from ref-filter.
>
> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored by: Jeff King <peff@peff.net>
> ---
>  builtin/cat-file.c | 73 +++++++++++++++++++++++++++++-------------------------
>  1 file changed, 39 insertions(+), 34 deletions(-)

As expand_atom() is file-scope static and its callers are well
isolated, it is OK to change its meaning while restructuring the
code like this patch does (as opposed to a public function to which
new callers may be added on other topics in flight).

The split itself looks sensible, but expand_atom_into_fields() is a
questionable name.  expand_atom() does fill the data in sb, but
calling expand_atom_into_fields() does not fill any data into
separated fields---it merely prepares somebody else to do so.

Helped by this comment:

	/*
	 * If mark_query is true, we do not expand anything, but rather
	 * just mark the object_info with items we wish to query.
	 */
	int mark_query;

we can guess that a better name would mention or hint "object_info",
"query" and probably "prepare" (because we would do so before
actually querying).

I am not sure if separating the logic into these two functions is a
good way to organize things.  When a new %(atom) is introduced, it
is more likely that a programmer adds it to one but forgets to make
a matching change to the other, no?  (here, "I am not sure" is just
that.  It is very different from "I am sure this is wrong").

Thanks.
