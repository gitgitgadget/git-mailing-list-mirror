Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C9D91FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 17:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbdBHRo2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 12:44:28 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34042 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbdBHRo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 12:44:26 -0500
Received: by mail-pg0-f65.google.com with SMTP id v184so15739921pgv.1
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 09:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OOQIAAcuYGBVP07eWLR6nm5C6UIUE4fMVH13fRa9qrA=;
        b=Wy2pPdtj/YEcY+d2lYB88oVuzsssO0GEBjQn6LSH8tUshLAt8sX/CThBuwQ1H7mMzq
         N/YJkgqqDPqMqShd0tIf09utfMdl6ir1WCgkfSPPN5a40zeJfAayNWfVVBvxUHiNjp7W
         4h0ku1w2CTv175CjfJRB9uYYnazpXAbaG02pLwt/kQWzFmz1NJrt6y0XyBy2sqbIUgoB
         tfPKrVC28h8Pl1OJWF+lWtanUHmM1sryBi0yrFP/9VxIpqEywHm+JTKwVXDOsSqs5TBt
         Jdu0SVCa3Q6JPFAsX4vEz8GWgUJmJPOdaIqKZGIWFHG5n5CCqNOJukmBUG1LHxOJOsX7
         hUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OOQIAAcuYGBVP07eWLR6nm5C6UIUE4fMVH13fRa9qrA=;
        b=nhQ1Xe3R8tCY/FvUXyBI2sbSz1IjHW4mTA9HRuJPn6MLXxKxy8aFd6+dnhbMpwVrCh
         xDOdm0CainpotpXnwkZo9I3oeaIiqAtSLOidqx1LrHu5OiQCrtRbs/Sl4hb4DkT6QR+H
         fhCmHx//hB5UR+0OivN/eaPjw95LP+ytklg3mTmuacCzv61CvxmFwR5fvv3Ytx2qc9vh
         vJ76GI947z5M0qhBAIc8tRstOsgAEPDV3zLPuX45NuaMilqpshGcFm65JqsAR62zd84d
         vv8W2CTpBTDggGjwDQGfC4gr3xe7G+7qOOx+5UskQ7AhQkUOvCp0kjpEn7RSyDwnMRy4
         3ngA==
X-Gm-Message-State: AIkVDXLkIZ1agPuL1Yr/i2blO1LuZo7NwMabYsu5Phb6SgUPsSyshHvxMzm5SZgPqFf7YA==
X-Received: by 10.98.166.131 with SMTP id r3mr27567350pfl.143.1486575865634;
        Wed, 08 Feb 2017 09:44:25 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:7c20:fa7c:46cb:2209])
        by smtp.gmail.com with ESMTPSA id j78sm22002636pfk.39.2017.02.08.09.44.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 09:44:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     David Turner <novalis@novalis.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: "disabling bitmap writing, as some objects are not being packed"?
References: <1481922331.28176.11.camel@frank>
        <xmqqpokrr2cf.fsf@gitster.mtv.corp.google.com>
        <CACsJy8ACy+Hv1Z3FgG-WFBozwWqmMuN-JnMWF-+rdpF0knFjqg@mail.gmail.com>
        <1486515795.1938.45.camel@novalis.org>
        <CACsJy8C81+D=UG4pZ4e+URQqKRCPG=5bLiCHbGCQamvE-2y2MQ@mail.gmail.com>
        <1486542299.1938.47.camel@novalis.org>
        <CACsJy8C4DO-GYREUhED3YU_WetoTZaB3MUq1kGfRjA3e-FOLYQ@mail.gmail.com>
Date:   Wed, 08 Feb 2017 09:44:23 -0800
In-Reply-To: <CACsJy8C4DO-GYREUhED3YU_WetoTZaB3MUq1kGfRjA3e-FOLYQ@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 8 Feb 2017 15:37:24 +0700")
Message-ID: <xmqqtw84wpag.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On second thought, perhaps gc.autoDetach should default to false if
> there's no tty, since its main point it to stop breaking interactive
> usage. That would make the server side happy (no tty there).

Sounds like an idea, but wouldn't that keep the end-user coming over
the network waiting after accepting a push until the GC completes, I
wonder.  If an impatient user disconnects, would that end up killing
an ongoing GC?  etc.

