Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 620BC207E3
	for <e@80x24.org>; Tue,  2 May 2017 00:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751016AbdEBA75 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 20:59:57 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34279 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbdEBA74 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 20:59:56 -0400
Received: by mail-pf0-f196.google.com with SMTP id g23so29868193pfj.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 17:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fen+AbQx47befWVxlCaxTYrdxi391q/M1xf+8BIjuVw=;
        b=LwsYECjShKwulBdqpMXvCS+MSJMD+vwfxEmNV89Qnmrq1SkkCdYFIuogSwF0kaAB+p
         FVRp45MXp1v8+O0QB1Uadoi10B6tC4Jsc7XDktGp5V/XZd/D1j3HjNhH9nluF3d6fAms
         glULnfKIuumzl+/DgZ5kLFzxqKLEobVJ+yD/ApTLG/V1fw/emQq8dEZgOIYN57qnRme1
         sVp+u1u0853miAhJ/nCyCmBBxMkmDmndL7NOaZ/9gGl7FIl3+MqTaArWkCwTkAhvVDT4
         lLIqrgmvppKkfJbGs2CZ2/u28rblz9I1lThPOqH0bSJ3+fjvFC09KoawKvrvzTOceEln
         cVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fen+AbQx47befWVxlCaxTYrdxi391q/M1xf+8BIjuVw=;
        b=a47TCcYxXwUaC0LRrb/nhr2s6opWkN6FkNYyEt1yq/O/U2KFw5etCBpzw9FTzq92lb
         Kc+a6ByEsIQiOYwmXTPtMCTWYXzN1Zte6939aGtWrNlUy2S/1htk193T2xpBZP+H0OTj
         Vj3VwE4cFjQsXhr8CeDHJzr1qiYKAhTYgcwbZcxKONvY+R7ZMFq+nhDk9SDMRTKj7AoQ
         JuXTjoI9XBx4vdGFQ/KRtC3JcvIVlP293bQwd4b/mI4EDYQ+15iaTjeCBzdzxQxmp+K/
         0hc3A4JI9ijRi+tvINZrV915ztoeGqQCu8gYZ5EyA9FfIC+c6nmg+0LBUXI5nO5mJZoP
         SFpQ==
X-Gm-Message-State: AN3rC/7D4OZfJNtISKptHYZeY68nJ6fmCyC7AOaGnvcIqrjeafOTO8ex
        v623Ih/iqKg8NA==
X-Received: by 10.99.181.25 with SMTP id y25mr6740710pge.192.1493686795725;
        Mon, 01 May 2017 17:59:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3c5e:d1c1:579c:ef99])
        by smtp.gmail.com with ESMTPSA id s68sm3629705pgc.5.2017.05.01.17.59.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 17:59:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Terrible bad performance for it blame --date=iso -C -C master -- <file>
References: <58DE0598020000A1000256CE@gwsmtp1.uni-regensburg.de>
        <xmqq60ip1m0f.fsf@gitster.mtv.corp.google.com>
        <CAJZjrdUt+=oLt0cDcs2+bJMCFR4h8UUSFmZkx6-1menz4haPig@mail.gmail.com>
Date:   Mon, 01 May 2017 17:59:52 -0700
In-Reply-To: <CAJZjrdUt+=oLt0cDcs2+bJMCFR4h8UUSFmZkx6-1menz4haPig@mail.gmail.com>
        (Samuel Lijin's message of "Mon, 1 May 2017 12:58:42 -0500")
Message-ID: <xmqqfugof4zb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

> On Fri, Mar 31, 2017 at 10:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> It might not be a bad idea to teach "blame" not to pay attention to
>> any path that is marked as "-diff" (e.g. binary files) when trying
>> to see if remaining contents appeared by borrowing from them.  We do
>> not have that heuristics (yet).
>
> Could you elaborate on this? Do you mean to tell diffcore-rename to
> ignore diff_filespec objects if they're binary?

No and yes ;-).  I do not think it is a good idea to unconditionally
ignore binary in diffcore-rename.

But when we know that the rename detection is called from inside
blame.c, where by definition we would be digging line-oriented
contents, there is no point checking if the contents we are looking
for came from an existing binary file.
