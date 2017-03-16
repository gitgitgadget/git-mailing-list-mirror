Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB94B20323
	for <e@80x24.org>; Thu, 16 Mar 2017 23:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752582AbdCPX1S (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 19:27:18 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33555 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbdCPX1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 19:27:16 -0400
Received: by mail-pf0-f179.google.com with SMTP id w189so31132523pfb.0
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 16:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UprulK5B/uTZRoDiDoO6C9JVPhRNAzFW6u/Xt8UH1YI=;
        b=ueahHuX03TWpCauEGzFQRYMupvBeH9TI0guo3wIiqJaqP7ORhUKrtWj2C6VyWJG27c
         UlrybYrI9FvDu1sNfWb+3iqN6y53kdwGitdFGWud8iz9+ypEYbBPfZS9O6ysn97qZ61H
         reXGpgjdEkFQgmTVLkUmr+lHFGbrLVJoAJ+AM5wdCd9Z7sqlOUOtYyanTuPY11kkAnYa
         911CQGcS37dObdc6Se8C16ocMv7vmHjBTDt19pMvhPKSA7C0lUt01WrZPh8RSKV/OndZ
         6geAEwBf09wmQbef4XFlLvEJV9FyfdIYJAMWkOOjlgJD6uZJtldvULFpiC2ZtndFgD16
         oL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UprulK5B/uTZRoDiDoO6C9JVPhRNAzFW6u/Xt8UH1YI=;
        b=L5w3Ag7ypk1YmMx5B+o5HnyzC3y8Ja4C5SwVMkRSDaHmzTL6S33aCIUnNKXVP8rX27
         oLTAyJd9DQkjxSdWihbqsOF8BFHy3TTwPFgqJeDuhH7AWykfwkPXNxKsB5ur67LwJhBy
         Z4V/nXr8MXIJnbqMsl/NhfYaAdyRAVGpstDjMNtJo4kUB9YgDKYYGB5FdE261u+vIVzE
         htXcUHqVZNtuYBB0gtH9/lSn47d8tguLXJVKHkYaBa3l39k7MUSJQq95t6615qU6bfzb
         kJg5jGcnSqmTxOOd1vD8vywqrlWxtg17Byuil/YtowJ7I2X3/I4oL0SoagjuGBne0k3y
         QY1Q==
X-Gm-Message-State: AFeK/H2/SCoWFqMijQYLWd+LOVpdbNkRzSudcfJvxGbaPXxyz7x60Ev/1NQgJ1tAGPqddMcpBVgwtRs1cEHelPEN
X-Received: by 10.98.48.66 with SMTP id w63mr13462959pfw.179.1489706742237;
 Thu, 16 Mar 2017 16:25:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Thu, 16 Mar 2017 16:25:41 -0700 (PDT)
In-Reply-To: <CAGZ79kaP9ob+qvso=pV=PPaB5guaW18w297xA+bfDFASV0zibg@mail.gmail.com>
References: <20170313214341.172676-1-bmwill@google.com> <20170316222952.53801-1-bmwill@google.com>
 <20170316222952.53801-4-bmwill@google.com> <CAGZ79kaP9ob+qvso=pV=PPaB5guaW18w297xA+bfDFASV0zibg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 16 Mar 2017 16:25:41 -0700
Message-ID: <CAGZ79kaqeR3aNT5qVh0Zz1MmCJ-+WpRMLZAt23DMxU53kpr_Ew@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] submodule sync: skip work for inactive submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2017 at 4:24 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Mar 16, 2017 at 3:29 PM, Brandon Williams <bmwill@google.com> wrote:
>> Sync does some work determining what URLs should be used for a submodule
>> but then throws this work away if the submodule isn't active.  Instead
>> perform the activity check earlier and skip inactive submodule in order
>> to avoid doing unnecessary work.
>>
>> Signed-off-by: Brandon Williams <bmwill@google.com>
>> ---
>
>> +               # skip inactive submodules
>> +               if ! git config "submodule.$name.url" >/dev/null 2>/dev/null
>
> As a stand alone patch, this would look good to me.
> But with the goal of this patch series in mind (which is to add
> more options to enable a submodules "active" state), this
> should rather be "submodule--helper is-active" here?
>

I spoke too early. this happens in the next patch.

ok, thanks!
Stefan
