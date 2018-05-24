Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 472981F42D
	for <e@80x24.org>; Thu, 24 May 2018 18:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032954AbeEXSx6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 14:53:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33526 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032744AbeEXSx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 14:53:57 -0400
Received: by mail-wm0-f66.google.com with SMTP id x12-v6so28643163wmc.0
        for <git@vger.kernel.org>; Thu, 24 May 2018 11:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0neKVuE7qL8FMzY3tZVJo3c087eNQaCjw8UTvydvrJk=;
        b=s0NBu6Bp4uyLORQaxYlK6tMFzW8vJsFZE269nl8NlNWaTUnH+SES2z57Fgupo8EFcW
         9r+0CcG574krni9uL1/OGDciAn3/uCeTQIpelzz3BkXO3JNgjERlxAuwsSilkevtwopE
         AuODkqQ5sGXohXu0xGG/Pb2ebzPRHUsncn5J9jVYW3lgvXYOXTIfDQSe1GnV0zzMC+D3
         bmbQrAiO29qqjSeT+YdFMtPkc4MA6mT+FhOuPTDAn4T6cnLs9/0y3fQH3J45wdkVxWBy
         fXKI7xPQ7O5l5ic4tW8gY5lUCdMPe3De+Em9jhr7/ickize+52mgqEGo5Rhw1ysvjELR
         vSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0neKVuE7qL8FMzY3tZVJo3c087eNQaCjw8UTvydvrJk=;
        b=AbRUGDQnsc1pSZ4Yve8LvFiJm5VDq1IcJnN1t6dKSkLV2NfhZ3C9cEwX5cSjxDVpA2
         iw9nREEv0lGlb17SgH9FTNK6uN+YVNbITciJbf8M6wdcBWc1Cc9T2fpzDbpL93qW8fuA
         +6Bu04yOpYDvuiDFNo8SokvaQ1xI0AJn89UmGrwP8BaVcog7By5D/rzNgY6124eHXaSJ
         DWtsJA/r1wSg3vHoeWFpQL3u04ru12iuqs7xNew+GiqdwGEar0QSDFJBOI5mWnpdVWcW
         ZVxG9F+DUuey9Pt5p52HpyLgTGAv7xBfo4rDqyToUBilAKg8RDEPsDdwvN/GjBSzPTzj
         Ax8w==
X-Gm-Message-State: ALKqPwfkrlAuiq9+SJ496EMukR6uzBJcCF+ow8HPQVKdCP5LtLDQUkjB
        3beWDzg6Yj1ZvleIGWkzC5g=
X-Google-Smtp-Source: AB8JxZqL+EOXWEn8+a1Oat3Rl6hU7ZAAlt2k8JUa6o3Ij8MorgE0L0Wr8PwPUCM17iMpa9WLgMbhyg==
X-Received: by 2002:a1c:e60b:: with SMTP id d11-v6mr9551461wmh.128.1527188036122;
        Thu, 24 May 2018 11:53:56 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id b11-v6sm27075578wrf.50.2018.05.24.11.53.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 11:53:55 -0700 (PDT)
Date:   Thu, 24 May 2018 19:54:25 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH 4/7] rerere: fix crash when conflict goes unresolved
Message-ID: <20180524185425.GB18193@hank.intra.tgummerer.com>
References: <20180520211210.1248-1-t.gummerer@gmail.com>
 <20180520211210.1248-5-t.gummerer@gmail.com>
 <xmqqmuwpqt9s.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmuwpqt9s.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/24, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > To fix this, remove the rerere ID from the MERGE_RR file in case we
> > can't handle it, and remove the folder for the ID.  Removing it
> > unconditionally is fine here, because if the user would have resolved
> > the conflict and ran rerere, the entry would no longer be in the
> > MERGE_RR file, so we wouldn't have this problem in the first place,
> 
> I do not think removing the directory and losing _other_ conflicts
> and their resolutions, if they exist, is fine in the modern world
> order post rerere-multi update in 2016.  Well, it is just as safe as
> "rm -rf .git/rr-cache/" in the sense that it won't make Git start
> segfaulting, but it is not fine as it is discarding information of
> conflicts that has nothing to do with the current one that is
> problematic.

Sorry I botched the description here, and failed to describe what the
code is actually doing.  We're actually only removing the variant in
the MERGE_RR file, whose path we are now no longer able to handle.
And I think that's fine to do, because if it is still in the MERGE_RR
file the conflict hasn't been resolved yet, afaiu.

Will update the commit message.
