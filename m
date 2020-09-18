Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A78C43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 22:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40FF72100A
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 22:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTFOrpV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIRWVH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 18:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgIRWVH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 18:21:07 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC428C0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 15:21:06 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id n14so4327021pff.6
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 15:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=VSyePbhm/lGRUMFqgpf1QRG8nc1C3UB5yf7pFgmihnE=;
        b=mTFOrpV8Jar0QG0lZM3AWicqa0/ljSFZJGhLcPT5UoYq7TgPuukbRg7uoJl8OavV0N
         6Obtv1XuRulq7Cuiyx6wb7zG4N6DVtLx5+b5YV/PBOF+HK3oBMzy73BjPl+HNGuebXmh
         gwvlRTzntjtbBnbgXuIrCnRjMEa0skDTFzOPnBpqCv0Y9esXB2KoDUJwWIX4pq69oe0I
         fHI+i0ewg8PLqYy2cCkAjkJzsVQ2kgDihBUEZ3rE8DXShy7jvd4I1A2eEn/c3zCho1i0
         DmLEkCTGnedFQKvUZIpud7sYwzft6U2Xj4Xruf0RQ+LCsiiNFjOisz3QRWiL6Xbu6gl9
         3gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=VSyePbhm/lGRUMFqgpf1QRG8nc1C3UB5yf7pFgmihnE=;
        b=tFjYD3hJTNpElVpYW2Z0r5OKzy4TyXRgR757VRT74h/qji5hCJP8/f0pn/hDO/USSU
         UtC/tAu2tVeMrgH1daMre9cX5HxFSaTLPmYFOKqd58jwT2UQ/8lZTcOx5RHi8Pt/ipmo
         gRSPxi1UQMi3da72/kf8Epql4e1me81YSsJnkfEyyktAUYC3ShNrWs15qMhT6zhz67vf
         eCQn3daACR/2xrWYpIazLD3NhH3CJDQv+730TKK/Nc6UiFNFG42mbroNRUo0uMzu/hw1
         xSxEBrCA++PNWOWKeFpZoeqOBG+MBWnx+qigKGKOpV8Pjx0t1ayXmvzr2koFa3+2a8j0
         0lkg==
X-Gm-Message-State: AOAM533aY3TFlwGbulpvdzM4kBV+6ne9uz0vVbs7CjzQ+6/7VhoUmbFb
        8TkSdRLk9H3AoA2Tq35WmSE=
X-Google-Smtp-Source: ABdhPJzqfNkcECh/QQ2s/jOhOP9d5jo87p/ChIHfIKmM/5OPwFx68GevwjmPBu7ArXn7ErVGUrh6Jw==
X-Received: by 2002:a63:fe57:: with SMTP id x23mr27854958pgj.309.1600467666393;
        Fri, 18 Sep 2020 15:21:06 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id u27sm4110766pgm.60.2020.09.18.15.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 15:21:05 -0700 (PDT)
Date:   Fri, 18 Sep 2020 15:21:03 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     wireshark-dev@wireshark.org
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: Joint project with Git for outreachy
Message-ID: <20200918222103.GA3352870@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi wiresharkers,

Outreachy <https://www.outreachy.org/> is a program similar to the
Google Summer of Code, providing internships to work on open source
projects.

Emily (cc-ed) and I would be interested in mentoring an outreachy
intern on adding support for the Git protocol to wireshark.  We think
this would be helpful for documenting the spec better, for making
debugging easier for future Git developers, and for helping people
working on systems involving Git (e.g. CI systems) to understand the
behavior of the systems they oversee.  We think that a co-mentor
within wireshark would be helpful for making sure an intern is set up
for success (helping them find pointers, making sure their approach is
on the right track, etc).

This would be a project under the Git umbrella
<https://www.outreachy.org/communities/cfp/git/>.

What do you think?  Does this sound interesting to you?

Thanks,
Jonathan
