Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4A6C47259
	for <git@archiver.kernel.org>; Mon,  4 May 2020 17:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BECC8206A4
	for <git@archiver.kernel.org>; Mon,  4 May 2020 17:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588614353;
	bh=bGJcpowU2SnWf3n/KqlzA4VheRrPKg20XgF9oL3W5is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tH+AxNSxnlULBKx24pWfAQFY2JbOjqoma3oBxYib26gz9ip6wGL7T1xMSS6ptrM0i
	 57LodQUmHVHRpcOBItdB2GCP+04wY2nWUZewCw9QJpGLwNQhTR9a1+QuBEp91qMMfj
	 rICnNwp2bHYp117d2TFQ/dpsl5D5iV/X1qcRrswQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgEDRpx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 13:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730328AbgEDRpv (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 13:45:51 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B52C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 10:45:51 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id f13so437491qkh.2
        for <git@vger.kernel.org>; Mon, 04 May 2020 10:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=yXCyBw9R7ktGqSsJDJfY2KUeDDnUd/O7Cp2bw2C/lQI=;
        b=eyXp9L1gb0sGxNYyyijQDs14kVSN4aJt1wV7O2sBdCE2nc9H68Hwry5nNqaLF1GOQw
         NNKTP0z94Aa5IE+tOWDef99y0Zqt3sfohOsnMEgoRuXjfaTw0Zk4ry7YmtYvtvsiPaeA
         Kacu7ptHXJMvBzJ2j4kusMYlyBstIQeiL9WYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=yXCyBw9R7ktGqSsJDJfY2KUeDDnUd/O7Cp2bw2C/lQI=;
        b=X/j1KWAdK6t0TRosmzAqUcg4bUA7zGNGE1n2kRZ+A+QjEn5Jfo+SWV4tPtlSz3EDpe
         HWSjvLOZ4ELU3E9CRiA+cdTwvm0lZ0exv/NiCYB1yRNdBmr9FroCeox/FFrzBrm0mb13
         g1B6G43M37IiYJGxsdy3jq8q5CgENsxJZHPQiAo/nwubm07wo6W8AmRHuu2ud4G8+pot
         S4XgrBnfiWQkPNMrL45gvb51p3I94WRhOCw7aLmtqCK58SXUKpgdA5LUB+n3rYEm8ImE
         WWi04zq8UnNhJBrLTQg7hhL2yaghKRA9EV65gtONTXR0YEkoYAvvDWTLzaWNWt1z8qK6
         aXeQ==
X-Gm-Message-State: AGi0PubRzEYDYo8X/i1rCvXMzaly0kZyPVw69/lODf3cNpteEHo2D+sR
        ock7Yhdpa9KYDZJXVhaHpXaSqyqvq0U=
X-Google-Smtp-Source: APiQypLxjAL+oOUWYGLxgvFU7x3Af6962t0iYC+tY4Bgrxu/YhwpitPOuvGDQA5v0KTr9BWBH9txfg==
X-Received: by 2002:a37:809:: with SMTP id 9mr361159qki.93.1588614350830;
        Mon, 04 May 2020 10:45:50 -0700 (PDT)
Received: from i7.mricon.com (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id d196sm9146216qkg.16.2020.05.04.10.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 10:45:50 -0700 (PDT)
Received: by i7.mricon.com (sSMTP sendmail emulation); Mon, 04 May 2020 13:45:48 -0400
Date:   Mon, 4 May 2020 13:45:48 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Simon Pieters <simon@bocoup.com>
Cc:     git@vger.kernel.org
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200504174548.r3zaftqcq52yhd2u@chatter.i7.local>
Mail-Followup-To: Simon Pieters <simon@bocoup.com>, git@vger.kernel.org
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 07:20:33PM +0200, Simon Pieters wrote:
> "master" is an offensive term, as it can be interpreted as being
> slavery-origin terminology. See
> https://en.wikipedia.org/wiki/Master/slave_(technology)#Terminology_concerns

Git doesn't use "master-slave" terminology -- the "master" comes from 
the concept of having a "master" from which copies (branches) are made:

https://simple.wikipedia.org/wiki/Master_recording

The concept predates the music business and goes back to middle ages 
when a guild master would create a "master work" or "master piece" that 
the apprentices could use for study or for imitation.

https://en.wikipedia.org/wiki/Master_craftsman

So, while I wholeheartedly support using inclusive language, I think git 
is in the clear here.

-K
