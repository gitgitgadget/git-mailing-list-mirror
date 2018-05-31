Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CFBF1F42D
	for <e@80x24.org>; Thu, 31 May 2018 18:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756002AbeEaSwz (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 14:52:55 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:41168 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755877AbeEaSwy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 14:52:54 -0400
Received: by mail-yb0-f193.google.com with SMTP id l2-v6so7925072ybp.8
        for <git@vger.kernel.org>; Thu, 31 May 2018 11:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WTXDe6E5xUztxZK9w7YRJvmU03RrMRzqrDYaGzsLC6A=;
        b=uMrB12YQTGgEMKeBOsu5MpznQSXIxqxVYRKbiKsjC3rbzAxsJyyGQxq7xl/F/l8Udt
         /qExSx48KCzaVBWB1/Fl6FLDb0ceBfUi45um8VX+lAVVRPBgwITc5O6PoSA8VN8gADCg
         23QOj6thDAkUqweoeJVAGVxZgOhO5X/dLZ0njSMjnbQsTTtPXQ2QjTAmDsqLuojbroZk
         I9T6T4m63D4J5sJ4obhcuU8JWH1AEsiUAhFuJ0WcGzKs28HATA7qwfEHjaphyI8P/nqu
         i/2i7tXFAyBptVoP/STb+kUr12Pq/eSAJG1EFUmlvycc+WyowO81xVKkGhs3nmR299fw
         Fu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WTXDe6E5xUztxZK9w7YRJvmU03RrMRzqrDYaGzsLC6A=;
        b=rAsCYPHvYuQWce3rDJLfQmNFrCdFrbEEcj8xGJSlKxkPyTK0GLcI2D+4oM8Qg9zmwH
         HRrBUJ6iXDzcBa3cBvI+/8zFUPQfS2PnjSRdTfONTgwj1rciR8BpcsUYT4dy8R2pMomx
         mbAJQuQPNYgFz3uQJyeqbvbewguTjbUuDyTbSSHuvUihP/Gniy5FiWVQTgimUxRewiaY
         mAN71kRTPaeh1/xvuUOiJHnVRA3mwXYVM0DLeGxCui6dAkgF3ZMGNtxeG+hb48aSK/uY
         ORXImO63F/xZofgFwtsqjNVkui2KfEz5V+wdlIPGgRcYzWW+ANMgHW7DB+4lNqUmB/8K
         vSgg==
X-Gm-Message-State: ALKqPwd0IB4S+Bom9JYEtH2mx8HraiCOdINaDFJjy5hULNdqotlw48bj
        aDJalS/ETZ+lh+PTcNYY/ukivLg5/7o2efJUjEtnwA==
X-Google-Smtp-Source: ADUXVKLWSupAdzde5NCaKXkAc3Ahp7coLWw+eaafvGgi3CDBU+qb55ZfdIOqKBA7V5clcxP80ePChfjnGfJh8xm0sN0=
X-Received: by 2002:a25:6cc2:: with SMTP id h185-v6mr4622147ybc.307.1527792773198;
 Thu, 31 May 2018 11:52:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Thu, 31 May 2018 11:52:52 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1805311402210.82@tvgsbejvaqbjf.bet>
References: <20180530170302.191176-1-sbeller@google.com> <20180530170302.191176-2-sbeller@google.com>
 <nycvar.QRO.7.76.6.1805311402210.82@tvgsbejvaqbjf.bet>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 31 May 2018 11:52:52 -0700
Message-ID: <CAGZ79kbhYSuBEEgALAmFT6Cf4+wmqFO_cMScBDs8CcgFwckXQg@mail.gmail.com>
Subject: Re: [PATCH 2/3] sequencer.c: free author variable when merging fails
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 31, 2018 at 5:04 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Stefan,
>
> On Wed, 30 May 2018, Stefan Beller wrote:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>> This was a deliberate oversight in f241ff0d0a9 (prepare the builtins for a
>> libified merge_recursive(), 2016-07-26)
>
> No, it was not deliberate. It was inadvertent, most likely ;-)

ok, I am not just bad at writing commit messages, but
also bad at reading other peoples commit messages. ;)

"As this patch is already complex enough, we
leave that change for a later patch." is what lead me to
believe it was deliberate.

>> -             if (res < 0)
>> +             if (res < 0) {
>> +                     free(author);
>>                       return res;
>
> Why not `goto leave;` instead? I wonder what is happening to the commit
> message: can we be certain at this point that it was not set yet? And
> also: should we call `update_abort_safety_file()`?

I think so, but wasn't sure. I wrote these patches before
my usual morning routine. I'll change that.

Thanks,
Stefan
