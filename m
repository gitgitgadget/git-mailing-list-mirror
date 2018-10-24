Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0A801F453
	for <e@80x24.org>; Wed, 24 Oct 2018 07:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbeJXPpQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 11:45:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43963 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbeJXPpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 11:45:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id t10-v6so4305190wrn.10
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 00:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=hEQH7/rtF3vpSSpCtTSLFys713DW/p5/c/J+dmPsdl8=;
        b=ZrwvrIODixY1yQKdeO3IERZ2JRKANz/gJKlyMMOOcwaHk59ANoh8NijTSKF6p3VgWk
         ShAt0ikJA065U72zO801EdOJJkcl1LsIcMdHh47DmM02D3aGi77YIWjuugrK081I2bF5
         qbsVpwCtsExWY/ROFEzxknBJvJLX0VGuIr1YEDaF076QXMN2qmsjMVztPWZD+VmDxmUJ
         Gc3Xoc82Lv5mb28m8B73rpXZ15K98awhdvf4G9qq+THWRYMi1lf8h7gdY4uKWqaIZ9UI
         fslGVw8HLi21He6TuCx/3HbtjmUyIud+pvuUGpInuSjikvYxYXBQstirzttifcTXXKIT
         B4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=hEQH7/rtF3vpSSpCtTSLFys713DW/p5/c/J+dmPsdl8=;
        b=QRSIwTWGC7lvJezGGglhwjF2piRNDiCPkaI3SHmT1ss4FzDBywfvxsVdNhPCCYqPrH
         q3yEzCEw2YfzqP2BMWIW3Gd4AkAJ5bnX5dip34WLVW0xWHoFAssW6GdDdGOO3li+jrOp
         cymGiYxbSVAWCCJ2JqrSvFgEeV32SQgDdnQUim9im0y5vfIR3s5qz9q9COz5Vklz2tLr
         uNcNCLFaTGOFyMSm5M7RH8A8JS43JTHzBsbRSa/i7NGnFzY1dbBrMEDE9bsNLZnUgvDw
         9a9XYqc+tmiFqDXLvsOPE6GvW02p0qIllsXW3WGQ4IacxBHtkshItb59HzGKX+3EPV+9
         FpGg==
X-Gm-Message-State: AGRZ1gJFO32rZhBWmAsoLSC+eI8QbZyjbm+r55gIs1PtVuFq6M5R1oBw
        fyE85qkor0svPXXQVtLNRtE=
X-Google-Smtp-Source: AJdET5f2uIdNe7ZmLKpL0DkVBu6d/Oeh62eYB2w8bnZQmIBaVtd7qy7HPeyklpAndQ27yMCHgbhPBA==
X-Received: by 2002:a5d:6045:: with SMTP id j5-v6mr1501599wrt.21.1540365506540;
        Wed, 24 Oct 2018 00:18:26 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m2-v6sm3910360wrj.80.2018.10.24.00.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 00:18:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, juergen.vogl@jku.at
Subject: Re: Bug with "git mv" and submodules, and with "git submodule add something --force"
References: <xmqqd0s2y9o9.fsf@gitster-ct.c.googlers.com>
        <20181022215236.72238-1-sbeller@google.com>
Date:   Wed, 24 Oct 2018 16:18:24 +0900
Message-ID: <xmqq36svolrz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> You would want to be able to remove a submodule and replace it with
>> a directory, but you can probably do it in two steps, i.e.
>>
>>         git reset --hard
>>         git rm --cached sha1collisiondetection
>>         echo Now a regular dir >sha1collisiondetection/READ.ME
>>         find sha1collisiondetection ! -type d -print0 |
>>         git update-index --add --stdin -z
>
>     "Ignoring path sha1collisiondetection/.git"
>
> Nice!

There actually is another possible outcome that anybody following
along must be aware of and be careful about: not even .git directory
exist there, i.e. it is possible that the submodule has never been
init'ed.

So, it is not that nice X-<.
