Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77FBF1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 01:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbeJVJPK (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 05:15:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42511 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbeJVJPK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 05:15:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id f8-v6so3493962wro.9
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 17:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=+76UFsMY/tzj+nV+3dSx7pL+Zbx9hoUT46kTUpRJFmQ=;
        b=MgV1tX5nwKxL3hnNpF/Rspr9rX35H+2QEH78v29tQrrr4EhxnRwM3JviyMxvvNokGP
         FgGY15SkTonkPTGNIHAGEJCm76JosWjBZBkeNHutIRn1mhNa1L9MFUH7webA+0KKJOVu
         RcIf1SFJyB/ENMzje6n2th7OnbS7hensOGYVjqBdfkPWfF9HLrKzV/UlS/gBtEDr6Lz3
         BVtV1LzoDVtAXBEsJIm+7IpjVsOYDWFXnpY5lZGeCIDU8Bg11x8CB+V5DDToHAceQ4tH
         YF0qV7hpZGGn/CZgDUJcioKUp5ufgBmUmmXVuYCMQcbKFw64dHytXqkqboNtw6i14WFQ
         kmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=+76UFsMY/tzj+nV+3dSx7pL+Zbx9hoUT46kTUpRJFmQ=;
        b=cc+eMP0DKoiFDpwMdkQkMXZx/tHH3u8ceF3tUfq/MIm/bVoppus9d6FoaHjfqQC0lB
         a2WGA3pg5O4h9pI3en32ok+1x9ly1VnzovHPrwHunRbJpthg1jxFZySrsR4Nm2sxUDO7
         UDb7r/ylSF8cb9dMrvgT/mbevZ3U8HIkSLtv/AfCFDupNyHVpGTwkNFEuFg8AtMcvDdm
         rvip5PWxMpX2FADTVdIX8qYhzrdfX9AHWkHHilyl2GL47GEzC+fvmUwfcawa4L4sDNcD
         fLAD+ZcVdkKppgtdHeguFFbdmNolmKJJKMcDNcFgBhwWUqmYV9BpXLpsQPmX75NCJ4fk
         gIYQ==
X-Gm-Message-State: ABuFfohOGxo2tpqTrVLFZbE3eZKi2Ev4eveVj8itxUX6MuSN2MJ9QTjv
        VpREZL4aQMTSg36m4jlJXHQAHk+o
X-Google-Smtp-Source: ACcGV63Eq2OJKNS3SGTGXiNA3aN05jklr7b98Ij7hF2yZ4BDVETS10bBfEpgopKiomlpEeKRpk7Fxw==
X-Received: by 2002:adf:8347:: with SMTP id 65-v6mr43122552wrd.264.1540169933075;
        Sun, 21 Oct 2018 17:58:53 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t77-v6sm15652984wme.18.2018.10.21.17.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 17:58:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4] gpg-interface.c: detect and reject multiple signatures on commits
References: <20181020193020.28517-1-mgorny@gentoo.org>
        <xmqqin1wyxvz.fsf@gitster-ct.c.googlers.com>
        <1540105841.1174.1.camel@gentoo.org>
Date:   Mon, 22 Oct 2018 09:58:50 +0900
In-Reply-To: <1540105841.1174.1.camel@gentoo.org> (=?utf-8?Q?=22Micha?=
 =?utf-8?Q?=C5=82_G=C3=B3rny=22's?= message of
        "Sun, 21 Oct 2018 09:10:41 +0200")
Message-ID: <xmqqefciztit.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michał Górny <mgorny@gentoo.org> writes:

>> Very minor point but by not using pre-increment, i.e.
>> 
>> 		if (seen_exclusive_status++)
>> 			goto found_duplicate_status;
>> 
>> you can use the expression as a "have we already seen?" boolean,
>> whic may probably be more idiomatic.
>> 
>> The patch is good in the way written as-is, and this is so minor
>> that it is not worth rerolling to only update this part.
>> 
>
> Sure, thanks.  For the record, I've been taught to use pre-increment
> whenever possible to avoid copying the variable but I suppose it doesn't
> really matter here.  Just a habit.

Yes, it's a habit many C++ trained people spread; it just looks
weird to see a pre-increment of a "have we done this once?" variable
and end up comparing to see if it is strictly greater than 1
(i.e. have we reached 2 or more?).
