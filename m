Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96215208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 23:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752243AbdHOXbH (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 19:31:07 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:34682 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751565AbdHOXbH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 19:31:07 -0400
Received: by mail-yw0-f182.google.com with SMTP id s143so13527545ywg.1
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 16:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y65pSHQd0TikLicd94TpBrlov15Z2/rqjy8v4PY1V74=;
        b=ERggjLYTd9EJoLifeW5xQX5hroZwPvaFd6dZtqQ8Hz9KWe5cL9GNIITCyrUVowBfKg
         +rcnavHM9sMLIdXygYNiF76MAXiG3135IELkEsIzqkD56jr4lpPK9CXobyrB3ziLf3Tx
         +6ZRO/lbjg6OJ5lKpe4HM89wpYJwameH7DmZDuTiuJNbbBMdJ4GjBVl6A60iQcbMs5mw
         PE3oxMcYWuM0fSlEd6UP3UJJDWkFqOZgmFbOfMukNV0eeNceRym3MUyPkzuReh/t/wZm
         Qot3HkF8Ve9uBv6XSzd9q1ufZOKwWgPX+3meDPq6vG31EOLhBr5ghf31OQxuR+R0qFGS
         ZdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y65pSHQd0TikLicd94TpBrlov15Z2/rqjy8v4PY1V74=;
        b=mJXKtT1Kl70TzWv7N0faUB54U7MUhVLCXxj0UFDEIyNzAqbifolnZuA3DbIpQMXxlu
         kpnpvuDP2/Fug2ANiIzYF4feuQvp5rS7eQGZ54WFjDmu7fClagPBWPrSzjCNX7Fhfm++
         CkV/wuZAGuJN81fE8HrJzQR6e4dtnV+nWQ61yG8qVNxxyCBx45Np2swB0fFtn/DocIUr
         VKTz3T8xjLj87mRPRdI9tr5pqvJbUiFCsiCPQEqM2SNmtJ6HHlYgGFmbjVawmw59aEaW
         hWbq6/sjUQm4ELqn3aFSwXA202QgRapvlnm9hkUoU3R7+LckwOHmD2QFot8OX+rCgS1O
         WWwg==
X-Gm-Message-State: AHYfb5hSlSgjkS2dIXv6J1gUcknD39Vf/FKfNL+KX9uC+5fE+Ys5kBsn
        ijnDjGkyQ9mXtIC621mzx52X1a4d+vaO
X-Received: by 10.13.218.129 with SMTP id c123mr23344866ywe.175.1502839866320;
 Tue, 15 Aug 2017 16:31:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Tue, 15 Aug 2017 16:31:05 -0700 (PDT)
In-Reply-To: <xmqqh8x8pg8p.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kZouNBxOKr7X8j6wqebp3Wh3cDqhYR-t_PxaF7AwQ0Wzg@mail.gmail.com>
 <20170815224332.22730-1-sbeller@google.com> <xmqqh8x8pg8p.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Aug 2017 16:31:05 -0700
Message-ID: <CAGZ79kag+U94tzJ14mB4VZjSZ2MtUJ4vu4MXKLKkpkLw=2K_NA@mail.gmail.com>
Subject: Re: [PATCH] push: do not add submodule odb as an alternate when
 recursing on demand
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 4:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> "git push --recurse-submodules=on-demand" adds each submodule as an
>> alternate with add_submodule_odb before checking whether the
>> submodule has anything to push and pushing it if so.
>>
>> However, it never accesses any objects from the submodule.
>> ...
>> Use is_submodule_populated_gently instead, which is simpler and
>> cheaper.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>>  Originally I intended to send this out as part of a larger series,
>>  but the series is getting too large series, sending all things in smaller
>>  units!
>
> This vaguely reminds me that you sent something imilar perhaps for a
> different codepath.

https://public-inbox.org/git/xmqqh8xzq6td.fsf@gitster.mtv.corp.google.com/

> Is "is it populated" a good thing to check here, though?  IIRC,
> add-submodule-odb allows you to add the object database of an
> inactivated submodule, so this seems to change the behaviour.  I do
> not know if the behaviour change is a good thing (i.e. bugfix) or
> not (i.e. regression) offhand, though.

Good point, we should be able to push non-populated, even inactive(?)
submodules. For that we strictly need add_submodule_odb here
(or the repo object of the submodule, eventually).

So let's retract this patch for now.

Thanks.
