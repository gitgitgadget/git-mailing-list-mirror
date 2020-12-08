Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCAAC433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 21:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BE31239FD
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 21:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbgLHVEI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 16:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729458AbgLHVEI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 16:04:08 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B908AC0613D6
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 13:03:27 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id f16so66902otl.11
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 13:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e+pVKYuZPwsRJvOEBmH9H1GYXmAc7Y8nZls4rYhUuls=;
        b=La5oKKC/rkHLo1J7wX9yt0dSXpDDCRVdJBuoBK5aV1HNTxp0cSZXopr/eBoP7koYfm
         yu1R4p4KypW9x/h2P39VqN+HX85neEwzR18b8+4zHa5PH8Mcq3SCbdLY961rEiRBkNQS
         hR+lXrFz7Sd5UUgQGxwNSg+Gp9C7B6oIdlaGum0vzAek20Yv6kFr88iqbUteRBMFO6GB
         hw1DFqwgswtvjUdJIpBkiSi0R9Aa4ZCAbHQeWJl7RfGtXylJxiyQGbPV8CjIqR8duvLg
         LPQofQyXI+9deNVv5f31ZCS9kunyaD6CGGRNlHE1TRVu90q27OtP1Lc12AezjJNlQ0PH
         SPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e+pVKYuZPwsRJvOEBmH9H1GYXmAc7Y8nZls4rYhUuls=;
        b=LJ9dOWRGihWDQbyijTo2p2KXGsYk+SqS64yqbiDSTAfN7V+iXC42b/tFELHdBZWUCe
         EbXo4x3H54yBarN3Wdjzym+4FIcb1PUuQ8+L8o3qw2Zlcr6tWwU1/dAm5usbTmSxPTuf
         +UHXD6vGRNWaDsF7HPAMtvc+QNXXFekdGGTwqoie8ksIJAu/JXsp6qdYqpw+dRu4eTSP
         /6GpS86oPnHVq44NYkK6j9myCShjRnWtZ3e4krdYEIJRpcb5Y/IQFl+r4nRpKiYrqxXk
         iCMnd8Q+uiJIQkuYaulS+qjGAhIuH1jkmgLgfuYBuktZtRJe+RilOYvDx2io96aARK+E
         wykg==
X-Gm-Message-State: AOAM5325luaBm3wjz39V/Wmvj4ZvgZOBJr/474+hdFSBqLv02Uz1UVYD
        XtQ+FDPFg0ZwXDBhVJq1tPrsLA==
X-Google-Smtp-Source: ABdhPJyKBzya43hnw8FV8F97/rp65xfVHAPMKnnmo24O4dZpF3zZVgyopZemy3XmMu4uAz8+NPONkQ==
X-Received: by 2002:a9d:64c9:: with SMTP id n9mr12242251otl.282.1607461407050;
        Tue, 08 Dec 2020 13:03:27 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id t19sm1777201otp.36.2020.12.08.13.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 13:03:26 -0800 (PST)
Date:   Tue, 8 Dec 2020 16:03:23 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        jonathantanmy@google.com, dstolee@microsoft.com
Subject: Re: [PATCH v3 00/24] pack-bitmap: bitmap generation improvements
Message-ID: <X8/qG70Wgd7xInq+@nand.local>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607385833.git.me@ttaylorr.com>
 <xmqqmtyo6mqi.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmtyo6mqi.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 08, 2020 at 12:56:05PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Here's an updated v3 of mine, Stolee, and Peff's series to improve the
> > CPU performance of generating reachability bitmaps.
>
> Has the "avoid having to assume the default branch name is 'master',
> by naming the initial branch we create our history to use in testing
> 'second'" fix-up by Dscho, which has been queued in 'seen' on top of
> the previous round of this topic, incorporated to this round?

Unfortunately, no. I wrote you an email a little earlier today, but it's
possible that our emails may have crossed (vger seems to be rather slow
today...).

> I think [4/24] and [15/24] can be adjusted by adding this piece from
> Dscho to the set-up procedure and ...
>
> @@ -64,6 +64,7 @@ has_any () {
>
>  test_expect_success 'setup repo with moderate-sized history' '
>  	test_commit_bulk --id=file 10 &&
> +	git branch -M second &&
>  	git checkout -b other HEAD~5 &&
>  	test_commit_bulk --id=side 10 &&
>
> ... fixing the remainder of the test script by adjusting for the
> fallout from the 'master' that is now called 'second'.

That seems reasonable. Another approach would be to leave these patches
untouched and apply Dscho's fixup on the end, but I'm not sure which
you'd prefer.

If the latter, then I think you have everything you need. If the former,
would you like a re-submission of this series? Either is fine with me.

> Thanks.

Thanks,
Taylor
