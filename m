Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C48D1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 19:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965623AbeBMTq1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 14:46:27 -0500
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35734 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965313AbeBMTqY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 14:46:24 -0500
Received: by mail-yw0-f181.google.com with SMTP id d77so1011861ywb.2
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 11:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oq0uE1F8SMeziCgbsjRBxc4eWF4S18E+EGjFQPi3ti4=;
        b=I5a7PWeOv5aNMxCT6rhRtXKDhbId36Py7xHIJo8Y3cl41z4BsxsQvx/43UW6bO+Vi5
         ah36ENdfGeaL6gIid6jMWILf95ElvYBHK29wkbT92rC/295BDrQkQ9e5AvVDJQDKUHqV
         VEqVj7GakghiEz5SsYrVmptW66rporCdOSmXFbFsqbg4q9/2jRLVjnVahnY+1tX7LwYu
         Tols7ph6WMI2lpglQNbYjCynESAo60SxacIxfc/M3g+JInjNilF/z7WhirwRNvRS5Lhg
         dSGbmmF0RLEd3LAzYkZxHLY2QYai8RC1X/tY0tJwNLMbUeF5CaNb5iTeiN9Sg/cYptwS
         tUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oq0uE1F8SMeziCgbsjRBxc4eWF4S18E+EGjFQPi3ti4=;
        b=hoi2mLvKGJ2k4GhQ4cEFd2oVOME5h6WQsn2ndq2okKPYPjUjC47lgzlAqNkARRtfuQ
         u+2Wn2/ZDRCAp7QVOkotPdxheFFs2KIoLIAHPvs/0442XMsvCyS3cUC6bYY/kUQGbzwb
         N32EKyZ3DEGyWb3bg4ynRGSntMdjpZGW3Ut5o62v1ZUbB996MTYK/7IRvkJBQQdIBp44
         EJUKRlAPD7pcPDuX4N0cXqOgRuUv7ks9CoN8XMoTlvyNNp987f8qqbrIh7NmkyXDOCWm
         I6Gx+Se8DRSIK0s/ruBpbT3//K0nPOQV8Gpi+UD4KBUI6t0cgjS417Uca4Cngfk6IOAk
         gsBw==
X-Gm-Message-State: APf1xPCsPWDXlIEtzV7EEijo3SiblzjLG8NEgXDGmz61wmUFSvIlbrrf
        UXscy50k/aV0oW1pH40clswnW4JPMkt39BFICPhd3A==
X-Google-Smtp-Source: AH8x2254RzOAfzA6dbnNIF9pORkMffiADnTlPuuBGTXpNM2Nf4f66re1wKhrBfsNwDa6Ul1dmjNVDzSNUr3gxH8x5yg=
X-Received: by 10.129.86.139 with SMTP id k133mr1512355ywb.253.1518551183368;
 Tue, 13 Feb 2018 11:46:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.203 with HTTP; Tue, 13 Feb 2018 11:46:22 -0800 (PST)
In-Reply-To: <20180213185120.GA108526@google.com>
References: <20180213012241.187007-1-sbeller@google.com> <20180213012241.187007-3-sbeller@google.com>
 <20180213185120.GA108526@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Feb 2018 11:46:22 -0800
Message-ID: <CAGZ79kZQGbf-0n6vfnF9=tneaKnt_X6odc5OUJbD9X5z8JTcoA@mail.gmail.com>
Subject: Re: [PATCH 02/26] object-store: move alt_odb_list and alt_odb_tail to
 object store
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 13, 2018 at 10:51 AM, Brandon Williams <bmwill@google.com> wrote:

>> +#include "cache.h"
>> +
>
> Maybe we would want to move the definition of the alternate store to
> this header file?  That way we don't need to include cache.h here.
>

Sounds good. I'll take a look at that.

Stefan
