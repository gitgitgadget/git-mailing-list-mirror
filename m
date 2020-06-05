Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9358C433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 19:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 825382077D
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 19:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591386283;
	bh=VHWh4EUQm/1NttCYVTFZYbN1EVvNKaOGP4nsVzEWNQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C254I72Yy+pptCQg5jiw1IovOBOqeW9Kq/qx62ToK8nLhT2w48tu+x/JlD9hA+oAd
	 EOacA+RiJdEVF2b9FsoX6Sukgywu6z8CE1X4IUgwdPzq4q7gkTCrtMqPPIG1B4q+zN
	 xB/EtUYwuy7inK+Wg7m0w11Hx5fVPhfVQVz+C5hs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgFETom (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 15:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbgFETom (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 15:44:42 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4811DC08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 12:44:42 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id w90so9498585qtd.8
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 12:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ocILR4yjyGl2fxf7KUY6hRIUfGNRxA8n9O6A+XV5bTA=;
        b=SRq9YNMUcwKpQO58I4i2CIgFMjJLQH2JiNu82qJ5YB3rGdwQTh99m+a7EjaHj03WBv
         C1rOD1YMjMFxIhQIeCufVQ7IT9Hd+BAvo+xKTLBCCrsrvfXwFf0hgTlDnvnG4dJLnJyo
         TLloVoSFgFnf9wpDAlI5L7yWtB+qL5f9wowyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ocILR4yjyGl2fxf7KUY6hRIUfGNRxA8n9O6A+XV5bTA=;
        b=MVUzGOyVmo7kK/iu3b32j6ZqOhCiggOlXsde+flJ8ER6tb1hRf/xR6HM18iCd5f/Fa
         51I7VCenIJnvjb/+t9N7kG+ql5bDBWA++m/bSwSSAB2HqRDHy7VdhafGvgJbd3ae3u+Y
         uaKrBqDKYoHytoVzXboYFFs0qTAKJOzboBXIyX/S4Nc0w9jJhwnsxYUoIdQo5F7yB0yz
         i0itaBPyTNyowv4O3W5F8BOAjtdPSq7K5AgVmydH4Lb77ZqO9c+AYHYvTiB7vn0J7iX3
         C8dpNvGjw6OqIRlTFLNqaViE+LitJl76uSBQgE0sTA1amKOJ1BeuB52Kz6DJr8xToxEk
         JZjg==
X-Gm-Message-State: AOAM532laU0IyVQRLSUjB7ZkH8FEzwM2bZdwr8KnuABUahaz8dcA5Ays
        hHI+FVixI9DW9LxMKXRbVif6Ow==
X-Google-Smtp-Source: ABdhPJytZ5qwh9p7Jkhc1luQy9phj+qaR7/CLcDIKR0ZSPf3YDLHNRBM//rShbpXr7yUfPcc+0/KQA==
X-Received: by 2002:ac8:4f46:: with SMTP id i6mr11571245qtw.317.1591386280108;
        Fri, 05 Jun 2020 12:44:40 -0700 (PDT)
Received: from i7.mricon.com (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id x205sm650667qka.12.2020.06.05.12.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 12:44:39 -0700 (PDT)
Received: by i7.mricon.com (sSMTP sendmail emulation); Fri, 05 Jun 2020 15:44:37 -0400
Date:   Fri, 5 Jun 2020 15:44:37 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Varun Varada <varuncvarada@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Standardizing on Oxford English
Message-ID: <20200605194437.au5vcy2wpcwi65md@chatter.i7.local>
Mail-Followup-To: Varun Varada <varuncvarada@gmail.com>,
        git@vger.kernel.org
References: <CAD2i4DCyovfV78rXwH+B+tNOeDM7rJCHWSCPFOiCv7mVR+56ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD2i4DCyovfV78rXwH+B+tNOeDM7rJCHWSCPFOiCv7mVR+56ew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 05, 2020 at 12:34:21AM -0500, Varun Varada wrote:
> Hello,
> 
> I noticed the Documentation/SubmittingPatches file reads:
> 
> > We prefer to gradually reconcile the inconsistencies in favor of US English
> 
> May I ask why? 

Traditionally, the "GNU C" locale expects that the character set used 
for all output should be in "us-ascii" -- a choice dictated by 
historical encoding standards. The most logical language to use when 
writing in something called "us-ascii" is "US English." :)

This has little current day relevance, but projects with code histories 
spanning decades tend to stick with whatever the expectation is for the 
"C" locale as their default language.

> US English is highly idiosyncratic, illogical, and used
> by a minority of the English-speaking population of the world (see
> https://en.wikipedia.org/wiki/American_and_British_English_spelling_differences).

You could try being Canadian and sit on both of those chairs at the same 
time. Then you can use both "colour" and "authorization" in the same 
text. :)

I think that since git was "born" in the US (courtesy of a 
Swedish-speaking Finnish immigrant), it makes sense for it to continue 
to use US-English as the internal default. There's already a way to 
cause it to output your preferred version of English by setting your 
locale appropriately.

-K
