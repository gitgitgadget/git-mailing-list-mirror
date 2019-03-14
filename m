Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B11F20248
	for <e@80x24.org>; Thu, 14 Mar 2019 03:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfCNDtp (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 23:49:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33918 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfCNDto (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 23:49:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id k1so3720349wre.1
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 20:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NTGPD5Gl65EdA5fnH97klGm8pFaxISsk/bflj7Qs+i4=;
        b=jYlcv7ThlqC/1ac9zTUl2mIQXEI+zXJUnuLV2rT00wChOP4nQqOP5I6+pzSmTVZ9W9
         plFQrl/bTqdi/027+dl5iMrJseWSVCz8gyLvAInxiHJQOPfooMtjKwlkM95haGHT+9FW
         zl3JOc8CWygVDj2zjyYwJYP8mBABUSdk+x6VAOfzfuExbZa0BEFNKcIrakvnLrSov6oy
         1evzAYWQtdHtr4mZV6Sth+NnGTLsAh4V1/B3Sz0lFRaMtqesqCNuvXhOzanwtqEIx4AV
         Q1/GFlBR/iO1X0rz8YI8V8nU+fMUkxqUzAK7uI8YuCFC2ImUYN0JQNE8h20vm9JY0YuV
         SRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NTGPD5Gl65EdA5fnH97klGm8pFaxISsk/bflj7Qs+i4=;
        b=fKnIqSRoOBR/yLcxPSh+Vt1/YLAwl/PLJxm1KRpQP06wiowzUmIBOxvmj3qHfhrmF9
         LIcK/nXfQsfzOn3eD1555eP/w4+pmclEIZ1FBuPZFurzPySuHTLsBKDLi/kMes+M/WGC
         HLNOH6hpOP+tgnnmrUInIhKdeebEHhgmjTB4gM3LjdTSLehJA+CloBwGFgh4QeCUURio
         DPNenYb51qX1cEriMAGpw+ar/J2mbKPTPYIY9mTQMGHkpXcS5bn9YSk7XKuk8FxwnvrA
         FkUYdZlflHgBa1qnipJxcODByuvVperVPOwmJp4hSYbxZUCyF3i8fzh3uHCmtoyPJOSw
         85Og==
X-Gm-Message-State: APjAAAU7f/h/RgYMt7yw8IgswgaRN1+ldf30kjkHBtdHzpWx1thMhSGu
        dMTTSiv2cgLGtDG21mN/Tbw=
X-Google-Smtp-Source: APXvYqwMK4tTBVfQq/nksOzKWShckWRFeXFy9mx4vUHB2o1wDEmolDXYOZH/jVkYmW1iFXXDkXS/8w==
X-Received: by 2002:a5d:428d:: with SMTP id k13mr20527787wrq.147.1552535382871;
        Wed, 13 Mar 2019 20:49:42 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id b18sm14039030wro.80.2019.03.13.20.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 20:49:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/4] get_oid(): when an object was not found, try harder
References: <pull.161.git.gitgitgadget@gmail.com>
        <994446236d05d9d014e12a5102bcf9be222e3b57.1552472189.git.gitgitgadget@gmail.com>
        <xmqqa7hyckfm.fsf@gitster-ct.c.googlers.com>
        <20190314022245.GA1414@sigill.intra.peff.net>
Date:   Thu, 14 Mar 2019 12:49:41 +0900
In-Reply-To: <20190314022245.GA1414@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 13 Mar 2019 22:22:46 -0400")
Message-ID: <xmqq8sxiaze2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>>  1. is reprepare_packed_git() a bit too heavy-weight, if the only
>>     thing we are addressing is the loose-object cache going stale?
>
> It's not the only thing we are addressing. :)
>
> Try this:

Yes, I knew about repacking.  I was alluding to the overly heavy
reference to loose-object-cache in the log message ;-).

>>  2. is there a way to cleanly avoid the three-line duplicate?
>
> Yeah, as you noted, I think the boilerplate is worse than the
> duplication. The most readable alternative to me is a separate function,
> like:
> ...
> But what I find particularly ugly is not just that it's more lines, but
> that the assumptions and outputs of do_get_short_oid() aren't
> particularly clear.

Yeah, exactly.
