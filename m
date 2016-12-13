Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3DEB203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 19:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932741AbcLMTOq (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 14:14:46 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:36136 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752409AbcLMTNi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 14:13:38 -0500
Received: by mail-qt0-f175.google.com with SMTP id w33so116312139qtc.3
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 11:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8Mrh3hwnUSOOllD9mC5d1qQEZWT89JaczMQo5a5wFbM=;
        b=JUv4SDdrnQfDglVQAEz8E1dypjXqLSHSl+BZ6/38yguK/X6o061TxERFBRT7sPYF6Q
         Pxr9HRicLUpM2AdkL88p7l3agbUpd0F+c8FNAugqmR36oDPIII2g57A7fRqFR8gqQreZ
         Q9Ut4uFekfgikKEZhD+Ol2asp60/tp7nZIblEmgpCWBNO56F2EZZ+i6k1ulIcaGQZS4o
         DlUNYoOQMwLpL0LNOD584gnAA3mHtOKnFZ3Q/wrSWHcG8MuAHhcGGGcqnpc6Ocl+f+er
         C7KQKm9HqQVk9H0xNXPkViUFIhx6Dwpb4pgy2fi5vbEUEQsQVAKzU5asXib96VhCJ0+9
         y5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8Mrh3hwnUSOOllD9mC5d1qQEZWT89JaczMQo5a5wFbM=;
        b=T9hk89tNUI6ZWcddjxezRNAC+Fw0wlvnOWb4bu3GmAyQlkLha8VblwsVNng9XVOKCo
         ffEnZIWvadTCqX49SnISgAJSbWiL2LShTdaLl41EeXNX0CYcfoauQESL+NMKYO81ER5F
         viRGSiIjeOd/rhRM6ZzGQmNtZJ6+BhCPByUuNgaU49vufYoATkzuU6g7eu7GQDDlnZPN
         V0Cfj/3LcY+HVcrvLdT4ja/+gGF8SSn/7vFpHPjRrhyJFKgjfhy1oIiKjwTp8AXegTRF
         w0gDS+Dp6Wy8I07GMAtffbcj1JVvXXX70zC+8wu9xlw1WUJrl1iWLSWQHRRVeSLBzQNB
         2pCA==
X-Gm-Message-State: AKaTC01VaHV4Ld+s4yDIK33LjdjCpzDZNOPelK5Q4lVNAgcGiHd44l+ieryLEc5YTb9rxpbpsFa6ZxIds8AKHFQk
X-Received: by 10.200.49.235 with SMTP id i40mr96010555qte.170.1481656416599;
 Tue, 13 Dec 2016 11:13:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Tue, 13 Dec 2016 11:13:36 -0800 (PST)
In-Reply-To: <xmqqtwa73ara.fsf@gitster.mtv.corp.google.com>
References: <20161213014055.14268-1-sbeller@google.com> <xmqqr35c5luq.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbmtYzFmEKrxHKx-_WY=0NDJM=QZYJziim-eh-w4WzDKw@mail.gmail.com>
 <xmqq37hr4q5t.fsf@gitster.mtv.corp.google.com> <CAGZ79kY_E8xnOpCAFQo_91FeQCs9X3fkassFYunG=adx81AcBg@mail.gmail.com>
 <xmqqtwa73ara.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Dec 2016 11:13:36 -0800
Message-ID: <CAGZ79kZCza=cwtzQ7raU3ch_Z_5TDqt0AGN2fPHiRSTDu66Fag@mail.gmail.com>
Subject: Re: [PATCH 0/6] git-rm absorbs submodule git directory before deletion
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <David.Turner@twosigma.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2016 at 11:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> I do not think there is no dispute about what embedding means.
>>
>> double negative: You think we have a slight dispute here.
>
> Sorry, I do not think there is any dispute on that.
>
>>>  A
>>> submodule whose .git is inside its working tree has its repository
>>> embedded.
>>>
>>> What we had trouble settling on was what to call the operation to
>>> undo the embedding, unentangling its repository out of the working
>>> tree.  I'd still vote for unembed if you want a name to be nominated.
>>
>> So I can redo the series with two commands "git submodule [un]embed".
>>
>> For me "unembed" == "absorb", such that we could also go with
>> absorb into superproject <-> embed into worktree
>
> With us agreeing that "embed" is about something is _IN_ submodule
> working tree, unembed would naturally be something becomes OUTSIDE
> the same thing (i.e. "submodule working tree").  However, if you
> introduce "absorb", we suddenly need to talk about a different
> thing, i.e. "superproject's .git/modules", that is doing the
> absorption.  That is why I suggest "unembed" over "absorb".

ok, I will take unembed then.  We could also go with more command line options
such as "embed --reverse" or such, but that is not as nice I'd think.
