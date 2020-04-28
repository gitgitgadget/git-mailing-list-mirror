Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9525BC83001
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 14:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A734206D7
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 14:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tb4mrh4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgD1ORF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727881AbgD1ORF (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 10:17:05 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D617FC03C1A9
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 07:17:04 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u127so3057732wmg.1
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 07:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fWVLuv4kSjrQpR9GSgJLpVoVeXUbdKGCfJVybNHgvo4=;
        b=tb4mrh4Ornz8K7my6SvnEQXfto9hzimb+mJAekNIlNlmfG8crtWjD9WKWWtoefqzrp
         HeapsHDzNH24m0dFU0i+uG1752D7iVntK24+THaZX8pthTEdFtyL3yehpqVblv2uw7p5
         VUTBEtHwgfVQKFYHybqaJdArefPJve0bkuVhUL1+yVSNzhFsMLJ3ppVkn/ljOyNVXKUX
         VTBrzA6GQNlz086cTahGKzNgG1ThIgSNJIb5gzcwTjkOJooJVsDNfwEjK50w+aMSndRt
         OGCkJXMLNBw5XwsHhuDBYAp/VVjkhRTkFjQ1gFlHy6UIYWcuvtvYLyNidEBckHWydpvh
         JHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fWVLuv4kSjrQpR9GSgJLpVoVeXUbdKGCfJVybNHgvo4=;
        b=G2bsfwMXQHf2O7qKRBiBGrBOt/chB/wT+b8oaYDcSNQMAR2vFeIHAp+7ExMRcVlMsP
         nNkskzA2yVeFc7GG834bkj7gcrYkDXQ1y05q81wc4laDRR/pnDr6vJbsZwdzhmEasWlf
         0HR0CUuIOIZhhn8tqn9SaqaUtxuYPnsLY1MdBnPHgQFwjoFhG4AIgzlvgQpAFL72orHp
         F49O2N75L7wcxsO6559bmgwwVmbIiyfU16NXVn1XqJUtN7bJE20Prm4QyiUva6tyY2Bl
         m66xidA+2lcarhUA0VXhtNdqDpzJCkH1XcWeKRlD4TcZuJiuSeXIoKsUJFdMhasMmqz8
         PBkw==
X-Gm-Message-State: AGi0PuYJjcbq59wRD5Hm/hdwLMgj7Qe/U58D+A7s4U7jKa+qorszIgDl
        mGYZMgOwigVo5JysKcyt2pM=
X-Google-Smtp-Source: APiQypLME5oDWF9ioOGQDXPHIYoKyoxqsPTnjfPpovt8jAZRe95JU+EYdTc2sr/CBmxpEEq6Vw2TUg==
X-Received: by 2002:a1c:1bcb:: with SMTP id b194mr5047100wmb.4.1588083423561;
        Tue, 28 Apr 2020 07:17:03 -0700 (PDT)
Received: from ?IPv6:2a02:a210:ca2:9c00:74c6:846b:f036:3655? ([2a02:a210:ca2:9c00:74c6:846b:f036:3655])
        by smtp.gmail.com with ESMTPSA id d5sm25792139wrp.44.2020.04.28.07.17.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 07:17:03 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Git Stash brake splitIndex
From:   Son Luong Ngoc <sluongng@gmail.com>
In-Reply-To: <CAP8UFD32D4WnSbpB1erMTidFpinCNwzqHG_fsyHqRmWgZpsSjA@mail.gmail.com>
Date:   Tue, 28 Apr 2020 16:17:02 +0200
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B48606E4-1ACB-45AE-9C24-4C285C989736@gmail.com>
References: <EED2CFF1-5BEF-429D-AB99-AD148A867614@gmail.com>
 <CAP8UFD32D4WnSbpB1erMTidFpinCNwzqHG_fsyHqRmWgZpsSjA@mail.gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

> On Apr 28, 2020, at 15:57, Christian Couder =
<christian.couder@gmail.com> wrote:
>=20
> It looks like it should be `git commit -a -m 'add a'`
I tried to reproduce with `splitIndex.sharedIndexExpire=3D1.day.ago` and =
everything works.

It seems like the config `splitIndex.sharedIndexExpire=3Dnow` cause the =
sharedindex to be deleted too early?

Cheers,
Son Luong.

