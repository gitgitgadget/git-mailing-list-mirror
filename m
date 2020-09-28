Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B319C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 19:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFEDB2071E
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 19:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPI8E1Sc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgI1T3U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 15:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgI1T3T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 15:29:19 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B586DC061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 12:29:19 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fa1so1269036pjb.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 12:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:to:cc:subject:from:date
         :message-id:in-reply-to;
        bh=/hekCusqkbDalNIv9BGZc07Iln3CVRGHaRE8f/gjzA0=;
        b=nPI8E1Scm+6yF5gfEYtjEwArZiFRO5zPPfbRXEqTcIQMoxqhzeXxc8WXcI3C+nKzXT
         I1CFvLps+GSnACga7FwrMp3WCxequmTqnlykv3mjOd7oGSUEVIiKQGou2Ju/T9TBGT0V
         WY/1WxXHoyMBpSUYlJvs+jL4hFiHNP2UimWnXKQkO5P8v5p6y33Cs/mCQqlrNTvEyldM
         2Zr8+efT7WsxHeFQhyLNQqzWAfJRpxYBo2Sj2ZjOiGUXh2iGHWhtcTVQ8Rfq/EvkU+e+
         i/2TPgzIZ2rZK5NDdJK5iBijQdrctHYyzNcNAulZMxUZ6p/A3v//exwMVA2XsIcOr5lN
         9c5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:cc
         :subject:from:date:message-id:in-reply-to;
        bh=/hekCusqkbDalNIv9BGZc07Iln3CVRGHaRE8f/gjzA0=;
        b=XojbEUSSkzQHtFlBhRvcbSYQnqCUhRF1Uk91uZIn0Mu5kjl7V7YSLElKWfjeFq7YC9
         7DmmkJrsvNVWSHq3dSTz2WepedCJMz0bcERW0j0cO2Z7mTt7CyDJFEfk4l/MLLwxyJNB
         7Td2XRFJXo0P8rOsUQxJ3O7cQH4ZLCPkJmSsHP1ELIWBDHi38RGJzO+9URCBfI4w3KIe
         wMUJOJ5Wz44Q/IpVHvyIVOKPKPNz0UEj/tBSH+xFBNakEIfYr+WZL6CRF26DqTEAsmtV
         DlomCL0AR/5M5z1S6p4Q2jaL0RNFnhp9RVRt8d9gKHTfO7s0gB3fTeLo3GttdeXpF5NZ
         Qcqg==
X-Gm-Message-State: AOAM530oS272GtmGHSLiUAJGhkllEcoCvMlzYpSltdO32bR4+vdZ+F+F
        eS0FI6O2jtwYRxfOQnc35jLhigy/gy50nA==
X-Google-Smtp-Source: ABdhPJzzT2AXYvPBRzjsiYdVQLIRrwO/n4VY9UNutTlQUgKIRenMPhppC2U7Djf/vct92ldggb9HEg==
X-Received: by 2002:a17:90a:7bcf:: with SMTP id d15mr668305pjl.230.1601321358812;
        Mon, 28 Sep 2020 12:29:18 -0700 (PDT)
Received: from localhost (cpe-70-93-247-186.natsow.res.rr.com. [70.93.247.186])
        by smtp.gmail.com with ESMTPSA id k3sm2614045pfp.41.2020.09.28.12.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 12:29:18 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
To:     "Jonathan Nieder" <jrnieder@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH] Doc: note minimum scissors line length for mailinfo
From:   "Evan Gates" <evan.gates@gmail.com>
Date:   Mon, 28 Sep 2020 12:20:31 -0700
Message-Id: <C5Z8UYJS02RM.2UD0R6DCK0KX5@emg-xps>
In-Reply-To: <20200928190029.GB2285677@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon Sep 28, 2020 at 12:00 PM PDT, Jonathan Nieder wrote:
> Junio C Hamano wrote:
>
> > It certainly was fun to declare that users can use anything that
> > look like perforation drawn on paper, and to pile more and more
> > heuristics to detect such a line.  But I think, instead of
> > describing all these details in the manual, telling the users to
> > always write "-- >8 --" and nothing else would be a better approach.
> >
> > It would save them time.
>
> Agreed, I think this is a much better direction.
>
> Another advantage is that it makes us easier to change the heuristics,
> confident that we are training users to aim for the simple and
> reliable case instead of the edge cases that may need to be tweaked
> over time.

Sounds good to me.  How about:

Remove everything in body before a scissors line ("-- >8 --"). The line
represents scissors and perforation marks, and is used to request the
reader to cut the message at that line.  If that line appears in the
body of the message before the patch, everything before it (including
the scissors line itself) is ignored when this option is used.

Etiquette question: Should a v2 patch be a new thread or reply to
this one?
