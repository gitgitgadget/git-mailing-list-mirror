Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96786C352BE
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 20:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D2722076A
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 20:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586896524;
	bh=SOGUopQYrrlyTdXtEdkPpmeAYwIvMrPepzL37jkR3XI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f22VFzsNRbXfy3vjKOarnP6WUm5ItZS+UzTuR9kFBFWfkGp1SLTeiJoAPEkkht2uH
	 nskg8J1WitojZmh1+VEEexfEns1nMHnHuXyLk43SpkjLrmEPZMHPdCP+5/H8MDGpML
	 DaiJnv+krbMRrAUIdmaUqimZAmg3OPKGL6p8tvuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731386AbgDNUfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731686AbgDNUfV (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 16:35:21 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49CEC061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 13:35:20 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id l25so14926899qkk.3
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 13:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=rWocRvRylBPnk6ZPCwn4NYPa5CbAU6IMQfuaVE/FQns=;
        b=AwBNaWnowHa9Tr2Em2RUPArd8ab754OHsjChMyu4qp+aTBSbIJml/tiijZNB58f7PD
         AupnCSNS41crHotdCOK57XqSRJA4yw7KX1r+5xi9WUEbFYSaLygEAq2vqdPVbRCttAcr
         mdvaW+/hSWgcaFkDki77bYeGy/J6CtReqsfmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=rWocRvRylBPnk6ZPCwn4NYPa5CbAU6IMQfuaVE/FQns=;
        b=nYGK+oHzNRk2ywbq4LfTH5BCz1E6xb1iuRzJdCSLdvXF7me14hjIeeSTIPk3Svimmb
         pvE/Bn33cgGIs+DS4RH1HDcH58a8Ry+hJJOFyIPXjQE47BRDFgGzXzBba1Q2zXayk/YR
         BepyWbNMLYBbRwqzTzlF2tAEl+7i39Qfq50SSIZ8z2TzVDxl3KVmLSPHTfsP7Dglhcjk
         pIh1W7WDmSXjel5HhCfhNUKW5T/RMgbmch1x36atuGqYdP9i74mzZvAIvOULkgjpPEed
         m52ll6Ru3ptDOxzU2KTMg/X9rle7MptgSKGencT2idfaWe6LMinlUhqDaKby0d1ybzhC
         jESw==
X-Gm-Message-State: AGi0PuYdntM1/xDuVI3cRZyBjbrB/avTZUa/H3GcI5fXxXD7lHoL3NLB
        cU40ECvXCeSnaHJXi4Zfp3qySg==
X-Google-Smtp-Source: APiQypLshalnaRJctzuVC+qa8uzeiKzMAXiWLx7Pg3QGRilLy+uhNTSc6xjT2k9hVPSGWge634ZCrQ==
X-Received: by 2002:a37:7dc6:: with SMTP id y189mr24260311qkc.223.1586896519870;
        Tue, 14 Apr 2020 13:35:19 -0700 (PDT)
Received: from chatter.i7.local (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id n63sm11247144qka.80.2020.04.14.13.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:35:19 -0700 (PDT)
Date:   Tue, 14 Apr 2020 16:35:17 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: has anyone bothered to read this "Git is a security risk"?
Message-ID: <20200414203517.qm55zyu34b7nc75h@chatter.i7.local>
Mail-Followup-To: "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
References: <alpine.LFD.2.21.2004141612580.6138@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.2004141612580.6138@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 14, 2020 at 04:13:39PM -0400, Robert P. J. Day wrote:
> 
> https://twitter.com/blubracket/status/1250123442600513547

Summary:

  - Accidental data exfiltration is a problem.
  - So are supply chain attacks.
  - Both of the above can happen with git repos.
  - We sell a scanning tool that will help.

-K
