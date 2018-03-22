Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F33D21F404
	for <e@80x24.org>; Thu, 22 Mar 2018 19:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbeCVTfc (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 15:35:32 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34130 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbeCVTfc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 15:35:32 -0400
Received: by mail-wr0-f194.google.com with SMTP id o8so9887473wra.1
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 12:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ioAnztegpSgUxZepVfo3GT5hG5R9jmsYaW9m0UObIaQ=;
        b=YmBFJ5jO9XjlYGEcgiTvZTmp4cfa9w59zIQ4GFus2UX3dZvz1xZ+eov/6OfM0cYQbQ
         4VDf0ce5GxPiJbNjcslW9tq9TX72sXjoMMgdfYb+0ePoLdyxgJWvs1A5cJWZs11NroVw
         eQ5CACWf+22WoSFDGopLZrh0k6/nFtahr8076BMcefXQB/jV9mOTKbPtjGWGyhf/+3rw
         6RmCUTPOo6Ey6EzW9hGUeV+zu1R3DtCT4gCnmbdx7Igbl1n8ps4NrQ4BX4q+4UO0I3j/
         aXyZ1IjaHr4OYTU/EI5ZayNAl8UkORk0I9c0PcxGD/k8uo1l9eZoBqfTOz2WCjA+WcxB
         JWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ioAnztegpSgUxZepVfo3GT5hG5R9jmsYaW9m0UObIaQ=;
        b=rECbeReo1JJo2XLUGQx1bylT8ys/KXdKbFoIaRjr+bd4RyLZWpn6HLswq5BduJmrIM
         4Vk9kl/DGdEk0gHN5XhSMXNDM9sqiwea1/1ooIMu1PosZ6cR500FZMoUYQumtSd9o/Gi
         3mLzZZpkPUgKMm0qLKvn6WQNLndTD4eFxG4hjYnNAVf7zzJ0Nsg4MjT+M5lQwkkNRvtl
         rh2lYW9zUhff0ss8rZI6VtqfZq00mrdrBpFQOg/9nysezcVo4pMl8rGbCA5bOcLaYmir
         R3mP7hWoB1lXYS7dC9k0Mh0VyTbaXy34UO02MXxakOmliYJkfM4SCOx1pB4KJp/CYDh5
         e+iQ==
X-Gm-Message-State: AElRT7HWp1YIPv+uV3vJ4/vprxoKADlkAIo2a4Yyi+kGKQxzG1TtaCRt
        22HtUCACWrhZnKxhnZAX+gk=
X-Google-Smtp-Source: AG47ELuwcDZXSXAN4Guh/2SaAQkhPLzsqwxKMix02xDU9Zau8H9TwCS1armG9z39G2PiW8GxO/VGpg==
X-Received: by 10.223.184.234 with SMTP id c39mr19898767wrg.67.1521747330530;
        Thu, 22 Mar 2018 12:35:30 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t132sm8822380wme.8.2018.03.22.12.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Mar 2018 12:35:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git@vger.kernel.org
Subject: Re: The most efficient way to test if repositories share the same objects
References: <14d0937f-0e39-7af7-a395-3046ec5d5c16@linuxfoundation.org>
        <87o9jfyl0y.fsf@evledraar.gmail.com>
Date:   Thu, 22 Mar 2018 12:35:29 -0700
In-Reply-To: <87o9jfyl0y.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 22 Mar 2018 20:20:45 +0100")
Message-ID: <xmqqlgejlx8e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> But of course that'll just give you the tips. You could then use `git
> cat-file --batch-check` on both ends to see what commits from the other
> they report knowing about, in case they have branches that are
> ahead/behind the other.

I am not sure how you are envisioning to use "cat-file
--batch-check" here.  Do you mean to take "rev-list --all" output
from both and compare, or something?

I am not sure how Konstantin defines "the most efficient", but if it
is "with the smallest number of bits exchanged between the
repositories", then the answer would probably be to find the root
commit(s) in each repository and if they share any common root(s).
If there isn't then there is no hope to share objects between them,
of course.
