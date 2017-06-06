Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A9C520D0C
	for <e@80x24.org>; Tue,  6 Jun 2017 01:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbdFFBUt (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 21:20:49 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36582 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbdFFBUs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 21:20:48 -0400
Received: by mail-pg0-f51.google.com with SMTP id a70so20699316pge.3
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 18:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=YViSdz18A2Gpe4gmoKoZR+Zr6Agq2tlLEXRfKxcH9to=;
        b=H5d6N4J+h8NpEIpEQ37zVw9kADmjLypTHYqxdxfCiOJl1UhmAMtIEi52yKvN/SDe85
         kvlzJnj9iHgK4bNg0zUptFLN4Bq5n9Bm0Gb0mKV3w+epG3E2Fo+8l5nZfVe/ZupitsMB
         33z4wfECgVpOjSEbPFc/WA+KGF3cWfpm4/WwFZDrmjlkSTD6DAqpuX752l452F5szD4v
         RrtB003MShgmAUYCopx+ooXhvOCTolbPQPqoGDJDzVcZJ9zMR/IDOoB4iOwRNjquMe1H
         /A4N+P2jhRpcOb8jhguioSieZyTdOxpueAXqvWxo8lO7e67PsguxwKDK4fOkOeKmFYx+
         ig9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=YViSdz18A2Gpe4gmoKoZR+Zr6Agq2tlLEXRfKxcH9to=;
        b=eqkRIqegl7wHQnS7nTgR9oO45A1SgaeXT7tqMolR43cnqveltkEuWWlG3v+2ZNAhU0
         EAecjOIq8CmI36EN+6lhkXA8Rcf6mLJRRMZkT70He5H7yi/raM1QzFr0luOgxc4g88ZB
         Ql3sUL0Ck3MzgWRBh/W5sCV7Zo/Q7iEgm8NOx7Otrmy75FVX2/LvfMZYFt48X1TKy3Ro
         viH/1L873C0M+iQKHHovqgBSkjAhoR0gz8seTnOdspVfi9/rUfdvZKjjkKD8NAvYtxdm
         pEOWbS/aYBI2EX6mRnmM0zyfvt+9p9o9ptKsyThoyboNwgqIgSqx7ziqveuacGXwAsyX
         Ziiw==
X-Gm-Message-State: AODbwcDS1Pe6zetfK+CVc9QIG2vJnRcXYgbmgXtLtqVcF1tYq0zaVBe/
        w9L30/pi6x4Fjw==
X-Received: by 10.84.135.1 with SMTP id 1mr7780570pli.185.1496712047551;
        Mon, 05 Jun 2017 18:20:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:5d03:f5d1:882a:10e])
        by smtp.gmail.com with ESMTPSA id v3sm31583381pgn.56.2017.06.05.18.20.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 05 Jun 2017 18:20:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git v2.13.1 SHA1 very broken
References: <20170605203409.GB25777@dinwoodie.org>
        <CACBZZX6vOr+ZjUaAf8i1xdjEFfY_Exj+_Xn2-1u0RcWoLy+X1g@mail.gmail.com>
Date:   Tue, 06 Jun 2017 10:20:45 +0900
In-Reply-To: <CACBZZX6vOr+ZjUaAf8i1xdjEFfY_Exj+_Xn2-1u0RcWoLy+X1g@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 5 Jun
 2017 23:05:24
        +0200")
Message-ID: <xmqq4lvtap3m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> That looks scary, can you please comment out this:
>
>     #define SHA1DC_ALLOW_UNALIGNED_ACCESS
>
> In sha1dc/sha1.c and see if that helps, alternatively comment out the
> ifdefs guarded by "#ifdef _MSC_VER" calls in sha1dc/sha1.c

That is merely a performance (and theoretical correctness) thing,
no?

> The functional differences between 2.13.0 and 2.13.1 on that platform
> should be none aside from possibly those changes, unless I've missed
> something.

If it does not hash correctly, the cause is more likely that the
endianness detection is going haywire.

    make CFLAGS="-DSHA1DC_FORCE_LITTLEENDIAN -g -O2 -Wall"

or something like that, perhaps?

