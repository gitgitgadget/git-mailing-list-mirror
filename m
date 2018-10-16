Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 818001F453
	for <e@80x24.org>; Tue, 16 Oct 2018 05:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeJPNpz (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 09:45:55 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:53928 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJPNpz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 09:45:55 -0400
Received: by mail-wm1-f44.google.com with SMTP id y11-v6so21008607wma.3
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 22:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tawIJ/RJcw7CyhTtXLju3/YwfE9r82UKMtaYyH4eIpM=;
        b=aKHzJOKHXAsudpqBo5xX4giPaFb64DgCFQyDpWhwigMwuLa0qAJgPoc7lhEn2cwgvp
         SN3RpOK4+S8BqWLSFSMS348tyPmFpFOkewWkKIfQDAIMpshHtT1/3gNI7yfjdFJ65F0q
         UGZiXTcFhKFd5aa81plJxCAUIopf3ujfmuYbwBQuw3jGzOLSzSBpNuIYHRM+NQIDOjYk
         Qt3oV7+2utd8CzMDiTK4EK+IAtFf9mXhg6IQFEFiP7vecfX7ecifcmRFUCGsfSR4/1S1
         +jJ6dofpxGtO28uNcObO+2+J+TLU86PHq4dG+MzPT5tdQxV0F9+CCsahOaSOYXQeM4wD
         v+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tawIJ/RJcw7CyhTtXLju3/YwfE9r82UKMtaYyH4eIpM=;
        b=XSxGmTDmIOeJ43Hrv+mr/RHs3MOihLn2jOvPD163f5lO99Rbkd7OOPC2Gw6OwaOjcH
         tygHRcZeAY75KrMOhfxUngUUNfmNvlBGNg6iO0YAgTvO+Sp/xFPQhpg61/Liz8RTcram
         ZcFl0y5r0/aLzP+Q1dm+1Kk7DbCq1T8RxfzU53mCDH3Qapajv1lqkZWcVq3s9+iE4zpP
         NYK7jKwkGFUxiodP98RvrqZO/Y4u5RaMfIXQdZnYnbaGYLPUTL0iCiX+ayXtkc7evFvw
         hr1NYVPXfvfW+HBqo6KDh9pSLdx3oxSTJ09WDD5FNEJZLPAbHsj29Ng4GGxMwNjzu3Sw
         aVQA==
X-Gm-Message-State: ABuFfojZdixYtpXgPqwALm8Ab7xj3a3/HPS1t0aTdutfF8Xdw+YvRedQ
        Qgk+ilmY71iON+0zXeqYVQc=
X-Google-Smtp-Source: ACcGV62nZGc2blGWpDRdgtvlxt3f6y0MP5xbEki+jS1M6uvhxD5tp3DceTV3tnhg3EQwezLHGB1MQA==
X-Received: by 2002:a1c:5d8c:: with SMTP id r134-v6mr14716047wmb.147.1539669426810;
        Mon, 15 Oct 2018 22:57:06 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n3-v6sm15735706wrr.62.2018.10.15.22.57.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 22:57:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     git@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH 3/3] send-email: also pick up cc addresses from -by trailers
References: <20181010111351.5045-1-rv@rasmusvillemoes.dk>
        <20181010111351.5045-4-rv@rasmusvillemoes.dk>
        <xmqqd0shgg66.fsf@gitster-ct.c.googlers.com>
        <5651069a-4879-096d-082d-58d8f0158958@rasmusvillemoes.dk>
Date:   Tue, 16 Oct 2018 14:57:04 +0900
In-Reply-To: <5651069a-4879-096d-082d-58d8f0158958@rasmusvillemoes.dk> (Rasmus
        Villemoes's message of "Thu, 11 Oct 2018 09:11:42 +0200")
Message-ID: <xmqqo9buzb67.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:

>> I wonder if it would make it easier to grok if we made the logic
>> inside out, i.e.
>> 
>> 	if ($sc eq $sender) {
>> 		...
>> 	} else {
>> 		if ($what =~ /^Signed-off-by$/i) {
>> 			next if $suppress_cc{'sob'};
>> 		} elsif ($what =~ /-by$/i) {
>> 			next if $suppress_cc{'misc'};
>> 		} elsif ($what =~ /^Cc$/i) {
>> 			next if $suppress_cc{'bodycc'};> 		}
>
> ...yes, that's probably more readable.

OK, unless there is more comments and suggestions for improvements,
can you send in a final version sometime not in so distant future so
that we won't forget?  It may be surprising to existing users that
the command now suddenly adds more addresses the user did not think
would be added, but it would probably be easy enough for them to
work around.  I'll need to prepare a note in the draft release notes
to describe backward (in)compatibility to warn users.
