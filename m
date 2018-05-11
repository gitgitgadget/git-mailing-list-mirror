Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFB241F406
	for <e@80x24.org>; Fri, 11 May 2018 06:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbeEKGA4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 02:00:56 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36435 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbeEKGA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 02:00:56 -0400
Received: by mail-wm0-f67.google.com with SMTP id n10-v6so1011684wmc.1
        for <git@vger.kernel.org>; Thu, 10 May 2018 23:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=nNqDHPnS8buwXX2Y7gVSJKzerPrHX/rdqLNiEWzDAMQ=;
        b=lc4EbMQMuIvLxpIis2pTNp+O8sP6OO18PzUXFMiwvU8huSfS16oKlwclxGXUiV9wFM
         SLt1NvkcJ/Z39lIOoAx4d6uxqP7U5IVnDbxVwkVFtnqj72qYDeH4CgnOfOhciY5zhss/
         F7OMFZY4Rw8hpQAmL5m03s3InDGvCxRl5i9eRn9CyynzJ4jdYutccfx4ykcxIqKO3vZf
         +xLyCAwfAi1ltXB65dkEPTKOLIF9bYbjaelIYB3By7ytie3i6zhT8vAFDSbk/h6xIebT
         svxa/GkbYQIkKoAorcM5xahb+ZgcKBEcMdwHjvkw8F1TbwGk5gTgPSECzGprEzopN6wE
         5SMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=nNqDHPnS8buwXX2Y7gVSJKzerPrHX/rdqLNiEWzDAMQ=;
        b=WIskwo6iy+fr+KNjGpPMWCQG0MZaE2l3LEMafhrYd+hWHkET+WbUnp6+HE+C/2H/vX
         O5ZzEi0AugxWYrrVYGeohKppqY1cYq38DYeO72vGrLIMy0TYZBlOacYmrUCLMcSKW4hB
         TJoF/F5KadcK9PWyXDc51Pg1/5+AdWaB5c3A1w2/DYGF6k9hwIqN4h3blDU1UKyowAop
         gOFbayVXdJDCFAC4rLoJe7UvfXqNpe3NWMm42trEwWENTnyzrA4HVCHtVyfk9dLYMcH2
         f2QyxNueJeEjIvWSYtXKP7Gez9dCrGOw9mLITTl/ZbW+bgwLECeqSeJGRVV4LjhquKCK
         kewg==
X-Gm-Message-State: ALKqPwcpeFFclzSI937S+TlHnrBrlO91bVMHDPRjALAUGONVpkjiaFlN
        2C6eN5i6NU1etObz6ij1g1s=
X-Google-Smtp-Source: AB8JxZpq5YlFcyVGwCeXfw+DnbLrAZS/aHiEIaXC4QIDqgjP+XKPRlulmWgk4nCVq2nsFBbRIT4j4g==
X-Received: by 2002:a1c:fc3:: with SMTP id 186-v6mr1027833wmp.113.1526018454696;
        Thu, 10 May 2018 23:00:54 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u69-v6sm356051wma.37.2018.05.10.23.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 23:00:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/9] completion: avoid hard coding config var list
References: <20180510141927.23590-1-pclouds@gmail.com>
Date:   Fri, 11 May 2018 15:00:51 +0900
In-Reply-To: <20180510141927.23590-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 10 May 2018 16:19:18 +0200")
Message-ID: <xmqqvabug298.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> While at there, this config list is also available to the user via
> `git help --config` if you can't remember the exact config name you
> want and don't want to go through that big git-config man page.

Makes a reader anticipate a new user of levenshtein code, perhaps
;-)


