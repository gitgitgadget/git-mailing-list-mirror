Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48B25201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 18:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752307AbdF3Srp (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 14:47:45 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35460 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751666AbdF3Sro (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 14:47:44 -0400
Received: by mail-pf0-f193.google.com with SMTP id s66so17921945pfs.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 11:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bNTMsz+wiC7qntPX+JD0ME1JBrWu6pZdzfqnrtyfrwQ=;
        b=nAuW82Z55EmYdtjDHMbwn7JgYg7soDIqA72/o5xT0R2WrNkxky8q8HrelBfMXCdFcI
         07qS9ipguI0Cb329KDnSNuiCrzmV4cAhPBIvfUrcgPAlrswIKlqy4HDn/r63DmdNV1pY
         aYMB4ykH8kfYnBCit7YanqgB1doYR+42PqzaGyTt/+l3zVTS/PTvGvQc5123r+NMgla0
         p5txsRdh2/Js+xZBvCWBOHnI/wSTj7sjg2wtA8KDXppGmR0GBrcvFZm18DYHiULm8Ut3
         x8eIaQjBmMrXMiibhQ2RxX5rm4C8aks8Lrp2eLAaB8VyX+SkjuTEAI29JXwL0ir0DH5H
         nybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bNTMsz+wiC7qntPX+JD0ME1JBrWu6pZdzfqnrtyfrwQ=;
        b=IlXf6eB4btWKOz61DbF2LzR4rVKnApq4THw+KEY5CjOEmm2myhbiEbim3gRhccaFdA
         PCEMFul75L+zriqTtJy5KKex5LEDcOFzXed+jDZuwamL9akCdJ+8Gm0FZkpSoP98LjZj
         W2xULolaLEyUv0Dh7BnXfUn4PK4Sv0P0ucFsFT2es+Q+iy/8xHES3rLPY4tjfMUwR3Bb
         ah6Tg8t/uQko7s/ASGjr0AAHKk0AFpkarXMHATSgUVtqM0/lFK53S+c/A3bb1bIx1oaV
         tJUmNZAt1WJSt+3VODoBt/MZwB7SxJxTn6CFMx1+Yt4QaFYCHsp9sBVCDPT+vMN2hcta
         h0Xg==
X-Gm-Message-State: AKS2vOwulnGH4BjgspvJW9F+PHGE/uaIC0HJATIamHjaihNYTX7UCtFf
        sYrwPDFQn9ejrg==
X-Received: by 10.98.15.67 with SMTP id x64mr24055715pfi.216.1498848463293;
        Fri, 30 Jun 2017 11:47:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:54f:b41d:dd9d:3de0])
        by smtp.gmail.com with ESMTPSA id w123sm17044076pfb.101.2017.06.30.11.47.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 11:47:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCHv2 1/2] hashmap.h: compare function has access to a data field
References: <20170629011334.11173-1-sbeller@google.com>
        <20170629235336.28460-1-sbeller@google.com>
        <20170629235336.28460-2-sbeller@google.com>
        <xmqqlgo9s7li.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbu2hqc41eBk_AtoeTviJGT4TTV7M6cYp0h4q=gJs2wRg@mail.gmail.com>
Date:   Fri, 30 Jun 2017 11:47:41 -0700
In-Reply-To: <CAGZ79kbu2hqc41eBk_AtoeTviJGT4TTV7M6cYp0h4q=gJs2wRg@mail.gmail.com>
        (Stefan Beller's message of "Fri, 30 Jun 2017 10:41:40 -0700")
Message-ID: <xmqqo9t5qpma.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Ok, let me redo the patch to have fndata at the front.
>
> Looking at other places (that have a similar mechanism mechanically,
> but are semantically different), such as the callback functions for
> the diff machinery, we have the user provided pointer at the end
> of the list. But that is because the diff_options are the objects that
> should be in front row (they are bound to the callback more than
> some caller needed data).

Quite honestly, I do not care too deeply about an API specific to a
particular area like "diff" that passes its "configuration" data
that everybody in the API knows, i.e. diff_options.  If the
convention for ordinary functions in the API is to pass that in a
particular location in the parameter list, I would think it is good
for a application-supplied callback function to follow that pattern.
After all, it is to configure the behaviour of the "diff" and the
caller-supplied callback could have been part of a (hypothetically
richer) API implementation.

But I view a comparison function that is given to hashmap that is
supplied by the caller a bit differently.  It is not about
"hashing", so the reason to have the data close to function pointer
is stronger there.
