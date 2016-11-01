Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF3D920229
	for <e@80x24.org>; Tue,  1 Nov 2016 17:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753340AbcKARYr (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 13:24:47 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36013 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751613AbcKARYq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 13:24:46 -0400
Received: by mail-pf0-f175.google.com with SMTP id 189so44901034pfz.3
        for <git@vger.kernel.org>; Tue, 01 Nov 2016 10:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BGf+Oebw6/SaGIpfSFLOyX+/j0lzBB0NCb3AZgKIfDs=;
        b=i2rCnJwP7Gy1qEr/jXs6YNqAfXD0h88Srq/g5WTwNvC6rjw/j1Wwu11vNBWMdpgy4p
         sQH+yC6sGZWUn7ay6bobsvvP0wwVPDxAnEDs+r2meH1QhowONnscg/EXsrlG06MH7y54
         v3i5F3pFeChhiz173ZJTZyYp1S+J3ANOsIgDNd4Xv6Z/wePsQ5xkHJEjM/9WvGov5DwD
         YyOUVbbIf8xSRlrzf+W1Itel0HvNa819LSThvWPE/pE55ELIgmsgsBCZUrtfYxeoaCCo
         WqllwLnKhkbAAdQGH/w4E1BidrhDoGHt/9ZcnLDJZHYJjg/UmubhJYEc9djyYK4nNg8J
         C0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BGf+Oebw6/SaGIpfSFLOyX+/j0lzBB0NCb3AZgKIfDs=;
        b=JM5cKu3aKoO/zmgYqfaEaHKyJQOoYTuRY1RU5JFMgB32kQo9vKavrAf5QQoxi5MpSF
         oPMizWYqK+KS//ZJ72WSdVfIgSzl2JPXU8B1lch+9mZr6j6TXgIH+K9s8pqji+/9eQPc
         GnqLcliDR26NOQOTyL7LGpZNKdIQFzuSZGkG0msyl4y4DDi+5Nc+LZdMvO48mQbxQubF
         IQXpVCn70GXNKxd+SuLbIoNas7LSMsJerVfDmvHvpFjaV6SyhL4UfkjbijXaV3YVez9+
         5Dvwk+1NdnDSrbyEhi6lgiL/NmKXI0I1IQu/0Huz9BGThgUZyUAaPc5eyyr+t/LJp2fQ
         IjWA==
X-Gm-Message-State: ABUngvdFgievKCinhId/sCihPVXyw5IHt5R2dN81+NHUPVkmimS7FY6qVJNz6L5Aom9Keke/
X-Received: by 10.99.204.5 with SMTP id x5mr50178800pgf.96.1478021085301;
        Tue, 01 Nov 2016 10:24:45 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:3408:feb:5098:461b])
        by smtp.gmail.com with ESMTPSA id h187sm6617834pfe.64.2016.11.01.10.24.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 01 Nov 2016 10:24:44 -0700 (PDT)
Date:   Tue, 1 Nov 2016 10:24:43 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] submodules: add helper functions to determine
 presence of submodules
Message-ID: <20161101172443.GB13899@google.com>
References: <20161027223834.35312-1-bmwill@google.com>
 <1477953496-103596-1-git-send-email-bmwill@google.com>
 <1477953496-103596-2-git-send-email-bmwill@google.com>
 <CAGZ79kamzSPyM65k9ugS0dAJCfGnGvk3m2p+XtCEozCvoZ5+OA@mail.gmail.com>
 <xmqq7f8nqfqc.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7f8nqfqc.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/01, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
> 
> Overall the suggestions from you in this review is good and please
> consider anything I did not mention I agree with you.  Thanks.
> 
> >> +extern int is_submodule_initialized(const char *path);
> >> +extern int is_submodule_checked_out(const char *path);
> >
> > no need to put extern for function names. (no other functions in this
> > header are extern. so local consistency maybe? I'd also claim that
> > all other extern functions in headers ought to be declared without
> > being extern)
> 
> Maybe I am old fashioned, but I'd feel better to see these with
> explicit "extern" in front (check the older header files like
> cache.h when you are in doubt what the project convention has been).

I wouldn't consider that old fashion as I'm fairly new to all this and
I also prefer the explicit "extern" :P

-- 
Brandon Williams
