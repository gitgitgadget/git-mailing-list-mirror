Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13CDC54FC9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 19:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 804A5206D9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 19:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkczTkYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgDUTgP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 15:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726361AbgDUTgO (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 15:36:14 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95430C0610D5
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 12:36:14 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o10so4013773pgb.6
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 12:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KyAjaxkSZB7kREo77AA3/idHwsTbYQV4wwIl/iZutlQ=;
        b=OkczTkYjo8w7uMtXvcxin6fac2zIR4IFyz/q64t7v2DfgiXx0KIvkbbcQHQOHSIMgv
         VKl+1dXIPe6W4N1p74RDOt9ggYh96827WTjsZBGIEiegXEQND522XUNGGDRJ7TU0P6UM
         eXVN4xJ10egKTqSlW+13C8PmCD3v2Ai66MF51VwA107jvbFOJA4Lag0dqOC9ZQ5+pU0L
         i8tYAv03b/PPjK6hv4SXDAQQpHh9LNj4LFOHIXFOKWUHsw7FA7qmK4bAdYQPK7tcptye
         1CSlH5UhJ7RhLdhyt9Zzd8C+xJ90ehCVOZTWB6A9DpVqj7z1p6KDWvB6uN1gYTuy9Nv2
         vLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KyAjaxkSZB7kREo77AA3/idHwsTbYQV4wwIl/iZutlQ=;
        b=j/RtbFiJJI+D5rxir/D8iB61gGDqKFLqu87GT8U2JvqHrThx62VJMa1EA1SoZU5SfJ
         RfXOZ4QmyQYc16YUp+K8G375SYxrUYN1jaX2CEKx3IO+NcdPRdBYfPpid/bKpAkYxOF/
         diTfsIG7SH4iIidWPhU/qybK6ospzG7zVNf7GZhSVQLCpWtDU+ZLhbxTyBtMzDqWNaCP
         faeTXaBvrTcDMUUw00GrRnSyTVRIZotVsNFchw6QID7jnWl35/Ikhw6BDV9dLNmlC1Sn
         9Fz+TDOyjhYRojR0Hpx8j4Z8USRP0G7QwDzsw+55r9Uq/PiQZTo8KfFra0oih1dTCCEB
         jgwA==
X-Gm-Message-State: AGi0PuZPQqEKhLGiEdWERhKzgltZkw2bmsj4yMVTBt88baTRO4vI1X55
        Cp87WtDOuvdQzFRJ/dEQExE=
X-Google-Smtp-Source: APiQypITlGgyEdK2cW1G7AXQpHn1Bqvv46UvAnznPfahij2wcWyEKrUpwKx675B7QXY+KwPDBMMWPQ==
X-Received: by 2002:a63:3d01:: with SMTP id k1mr23568448pga.85.1587497774041;
        Tue, 21 Apr 2020 12:36:14 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id 14sm271094pfj.90.2020.04.21.12.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 12:36:13 -0700 (PDT)
Date:   Tue, 21 Apr 2020 12:36:11 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Dixit, Ashutosh" <ashutosh.dixit@intel.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: Bug in 2.26: git-fetch fetching too many objects?
Message-ID: <20200421193611.GA103469@google.com>
References: <878siqxiu0.wl-ashutosh.dixit@intel.com>
 <20200421064541.GG96152@google.com>
 <xmqqblnkodi4.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqblnkodi4.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Dixit, Ashutosh wrote:

>>> I am seeing a strange behavior in git-fetch in 2.26. I frequently fetch
>>> from a couple of linux kernel remotes (so you will have an idea how big the
>>> repo is). I have a different system with 2.20 on which I never see a
>>> problem.
>> ...
>> I suspect this is related to the change that protocol v2 does to use
>> stateless-rpc even in stateful protocols.  If my suspicion is correct,
>> then the same behavior would show up with protocol v0 over http and
>> https as well.
[...]
> This is at least the fourth time we hear that v2 may not be ready
> for the real-world use.  Perhaps we should revert the default flip
> on the maintenance track while we hunt for bugs and improve the
> protocol support?

That feels to me like an overreaction, since these are all reports of
the same issue that we have a fix to.  Shouldn't we just flip the
default for fetch.negotiationAlgorithm to skipping?  If we revert to
buy time, what would we do with that time?

In other words, if I understand correctly, it's describing an issue
that also exists in protocol v0 for https.  I would be *very*
interested in any evidence one way or another about whether I am
understanding correctly.  If we flip the default, I don't see how
we'll get that evidence, since we've been using protocol v2 as the
default at $DAYJOB for quite a long time now.

Thanks,
Jonathan
