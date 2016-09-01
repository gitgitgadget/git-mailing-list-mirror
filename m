Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 056A620193
	for <e@80x24.org>; Thu,  1 Sep 2016 22:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752909AbcIAWxG (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 18:53:06 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33056 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752521AbcIAWxE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 18:53:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id w207so550509wmw.0
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 15:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=yNk1eWtqTqt0KhM/2b4S7VE6UQkACog1g1Ciysjpf98=;
        b=GV1FaKb1JhGOLoGhjD40OMs0pIDL6k7DrNm+n0C/DXLonFJmGgY1lkvDiOaGQG2toK
         cGD8WnJTF2bLTDawuqKm3FJQkIxZuwzLKPnwr6z82Zpz/o92i3ZPYhlGvexMQ9qAsCmM
         E+v6BuaAeZj4xyrRY/kQMtTqh0hBf3bcuCqe+5ekpmgcyVjk+jLHaIl5V60T2wjjRt2Z
         sR7Oy/i6Y25XvsAQOVY6bpzlJOH1SHV3O7B5zG37pWV7as08/UsHRLHvrdtqVBams11j
         B954ja0uPkgJH6xDqAHm8WWNXk62VBF2z0VIHfqFp+WHanV9OVOfL8NoaI0No+oncBNS
         /H9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=yNk1eWtqTqt0KhM/2b4S7VE6UQkACog1g1Ciysjpf98=;
        b=iMWmgb0vshatvOd5jHkToymlFpHkZOJaLwmx88y8VInHRoWfYO/BxWtBXuSNh9LFQe
         CUgPq2tpna64tEtvuVrvroyfokEeBND/gSwE4PiO7xjMT8QqW2rCt4+b35/TdFnNU8CI
         f+r8uNzV76VxNTJ9+ZomAvHwr7tesQsZ7sP4vi/Ud+0WlYZC6wtiAd92e0c6T3lCH1Ma
         jSexMqr04cacel36Zt02XpFpMEcsgvNjXx0/w0xbvp99lMRznnmeRS4z1D0g3uowZCdo
         +m0wYba7LLtL2qcARobZwFqvM/p4rG7KF5Ekxl+T90B58Jhn0iWpm2PDTDzKxNdIOZOP
         gv+g==
X-Gm-Message-State: AE9vXwOFWsbfz52askPNxG8YCf+H8CCgyYHcQ11LtcH8KlyyhriOwObnzuV8753N/yAJTg==
X-Received: by 10.28.158.1 with SMTP id h1mr108354wme.94.1472770382396;
        Thu, 01 Sep 2016 15:53:02 -0700 (PDT)
Received: from [192.168.1.26] (abrf30.neoplus.adsl.tpnet.pl. [83.8.99.30])
        by smtp.googlemail.com with ESMTPSA id e5sm570471wma.13.2016.09.01.15.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2016 15:53:01 -0700 (PDT)
Subject: Re: [PATCH 13/22] sequencer: remember the onelines when parsing the
 todo file
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <12bffd6ca4eb7acc00a102d13348bb96ad08371d.1472457609.git.johannes.schindelin@gmx.de>
 <52d61bef-668b-fdc4-30b3-a34c11b39f81@gmail.com>
 <xmqq8tvc21re.fsf@gitster.mtv.corp.google.com>
 <a9831d93-f5b4-d729-eae0-1f7c1123a6a6@gmail.com>
 <alpine.DEB.2.20.1609011507130.129229@virtualbox>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Newsgroups: gmane.comp.version-control.git
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <58587e4a-a326-2676-6d32-4a570b27dbf8@gmail.com>
Date:   Fri, 2 Sep 2016 00:52:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1609011507130.129229@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

W dniu 01.09.2016 o 15:12, Johannes Schindelin pisze:
> On Wed, 31 Aug 2016, Jakub Narębski wrote:
>> W dniu 31.08.2016 o 21:10, Junio C Hamano pisze:

>>> So I am not sure if we want a parsed commit there (I would not
>>> object if we kept the texual object name read from the file,
>>> though).  The "one sequencer to rule them all" may even have to say
>>> "now give name ':1' to the result of the previous operation" in one
>>> step and in another later step have an instruction "merge ':1'".
>>> When that happens, you cannot even pre-populate the commit object
>>> when the sequencer reads the file, as the commit has not yet been
>>> created at that point.
>>
>> True, --preserve-merges rebase is well, different.
> 
> It is mis-designed. And I can be that harsh because it was my design.
> 
> In the meantime I came up with a much better design, and implemented it as
> a shell script on top of rebase -i. Since shell scripts run like slow
> molasses, even more so on Windows, I have a loose plan to implement its
> functionality as a new --recreate-merges option, and to deprecate
> --preserve-merges when that new option works.
> 
> It needs to be a new option (not a --preserve-merges=v2) because it is a
> totally different beast. For starters, it does not need its own code path
> that overrides pick_one, as --preserve-merges does.

Better preserving for merges (with cleanly defined sematics)
would be certainly nice to have.

> But I get way ahead of myself. First we need to get these last few bits
> and pieces in place to accelerate (non --preserve-merges) rebase -i.

But it can wait, right.

-- 
Jakub Narębski

