Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5298AC2BA19
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 06:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FEF02071E
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 06:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcUk4ty0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgDUGpp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 02:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725831AbgDUGpp (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 02:45:45 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FDEC061A0F
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 23:45:44 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id h69so6325888pgc.8
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 23:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jM+YXWP/LtcXxJ/CC6XPlE+nCvPwQRWU6Mw+4SXKVyM=;
        b=QcUk4ty0CWI0vdTD1cHsInmlTBJ6qOq+GydxEUYoUJGSqoIUDv1uIMKzbp4mueyhMo
         3AE6DFWWRtTAMO38m/zNxThlwNEnCrsE0kJvJdZv8zevmPstqDoB4Efe64NhsCEmwol+
         H8YrYboCUE3ubwhH5TmFNXAbEcDaJRvXKkC5jieydjIQiUBYUjdLytbC4a8IEWkPF6OU
         RU7LbjoFSOK++Nz7PcWI2Ck2ZqUixinh2Pg7FrULdC4CbmM0XpmK62327xvLdR3b0eXx
         HEiJrhmJD+zfxh2IKnopxjCDjyH+unq520a3khwiqg77bZkxdQGClmhxDa3CH1qUm819
         Gwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jM+YXWP/LtcXxJ/CC6XPlE+nCvPwQRWU6Mw+4SXKVyM=;
        b=QiumNcvWHtHud7mcLAbnX9IMQ0/MFIuE3cXRjfoCUA/tZ2OKsm6KxWy/Aasw2cJybT
         RMGcXuKFDPH60Gp++YA5tTCt9ueSVl6UM+oq8COZyWWsScQdVXupm4bbf0BWiwpt0OTb
         GsxFKiQ8R/iFZc96NcXOKoGOzm8ELOBWJBz+LWLkocSG3yhfYcIbw8cq5VrWOECN203+
         olh7jTsQY6CiRwckw0vq8BbHFetV7P4f9PcfcfZ4V6jnW+aLLBebv/7OX5SyqaS065mm
         cly2yagRB5U16ZFkekjvrxr/CWe/mgYzRLxP9tEA+/oy6uId7I0DqH3Nt2SFzBGt9Sd1
         aUpw==
X-Gm-Message-State: AGi0PuZe4IgzQJ+tIhN1bJyfUaYw8wAQI/9Fe66Jex6Spd9MEF9Y68X8
        z4zmPwalRYb9ibYtiAkI3rA=
X-Google-Smtp-Source: APiQypJ/bO4G4aGTp0pRbMv9telLQMvjhAcvb/AYnR3uK5bS/EGO/+nYKbEk8GbNn+iIyjrRNKsgmw==
X-Received: by 2002:aa7:9a4c:: with SMTP id x12mr20248689pfj.263.1587451544080;
        Mon, 20 Apr 2020 23:45:44 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id v1sm193896pjs.36.2020.04.20.23.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 23:45:43 -0700 (PDT)
Date:   Mon, 20 Apr 2020 23:45:41 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: Bug in 2.26: git-fetch fetching too many objects?
Message-ID: <20200421064541.GG96152@google.com>
References: <878siqxiu0.wl-ashutosh.dixit@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878siqxiu0.wl-ashutosh.dixit@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+cc: Jonathan Tan, fetch negotiation expert)
Hi,

Dixit, Ashutosh wrote:

> I am seeing a strange behavior in git-fetch in 2.26. I frequently fetch
> from a couple of linux kernel remotes (so you will have an idea how big the
> repo is). I have a different system with 2.20 on which I never see a
> problem.
>
> So let us say I fetch with 2.20 and it fetches say 20,000 objects. However
> with 2.26 it starts fetching millions of objects, objects which are already
> present locally. I don't know yet if this happens each time or only once in
> a while, I have seen it happen twice, will keep an eye out for this.
>
> If you open a bug please let me know and I can update it with my
> findings. Unless it is a known issue, perhaps already fixed?

Does "git config --global fetch.negotiationAlgorithm skipping" help?
It might be time for us to make that the default.

I suspect this is related to the change that protocol v2 does to use
stateless-rpc even in stateful protocols.  If my suspicion is correct,
then the same behavior would show up with protocol v0 over http and
https as well.

Thanks and hope that helps,
Jonathan
