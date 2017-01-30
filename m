Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AD9C1FF1E
	for <e@80x24.org>; Mon, 30 Jan 2017 22:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753050AbdA3WwW (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 17:52:22 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33390 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752802AbdA3WwT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 17:52:19 -0500
Received: by mail-pf0-f195.google.com with SMTP id e4so24437317pfg.0
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 14:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zqyFEZQ/wtj1vpGrr99oE036+MhbSzFrPfMVcwCeiuA=;
        b=pz93OxSGxkA0aB3FT+letCq6yq+5Sstzvwkg/UBII8/1fKqUEgW3J0qinpeZsed8CQ
         Dv82MeIEFHRoIfiy8jUHWDPHJBod68/j1Azix7q7zH7fNRsVZsbxdrfD7GVX4hLk7EMn
         ze2T5N6mMpoizH7RRc5l6HVXX+6uzdMzWMVm1KoxAY0isyqTh+CkBme0HlwspRsKf+Eg
         w0JHUbUB08NxlS5PvkXc5yNQz0ytrWDwFnIUntH4Nx+mMtSlInAca51IIvFQLuqW70CV
         BLxVJ7brPt/4Q0uVGAj3DCOH/k2M+wg6If/PkoXrrkyfVOpeQhqUXhUCou8DtJZfL2/F
         ra7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zqyFEZQ/wtj1vpGrr99oE036+MhbSzFrPfMVcwCeiuA=;
        b=tjae3drhp1PYP8gF9fVKEMNp8MJ0aEpsOPFmv+0aVtIc+y4F5p/TJS53vdGcWB43/G
         HTplsjvqbxTlFavYCVsq4FsnVAmR5wRpVJVEn8Cm7PCa46/LYmrDypE0oSywhghHNSJq
         mRzI06LYyljMMy4rJrzzyZbrrF9yTcT8q7mHW0HKWym8h2Xk2Ytj7Z19HwQaWKXnJbWG
         WzP08POzSoes5/2o6K2ZzoEQ3jSurJEXUr+knCe0CxhZmRAT8BN88VbQrMbGCKsfr7mz
         /bIfmwMYAr++j7xeD3Y9TuE5Lq4DVvtSpJznVeR9AhB2Mj1gc9fb9+5lEZyrq8D9DIyZ
         FT/A==
X-Gm-Message-State: AIkVDXI64Z1lUVguJOEgv4wc8YQ5JuniadLG8wV41J5waDvNZ5XTa3XB3bkcr3FMIC8kWA==
X-Received: by 10.99.37.135 with SMTP id l129mr26659566pgl.206.1485816721648;
        Mon, 30 Jan 2017 14:52:01 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a9ce:56f8:45fd:fc63])
        by smtp.gmail.com with ESMTPSA id a8sm35141343pfa.19.2017.01.30.14.52.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Jan 2017 14:52:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <patrick.steinhardt@elego.de>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v4 0/5] urlmatch: allow wildcard-based matches
References: <20170123130635.29577-1-patrick.steinhardt@elego.de>
        <cover.1485512626.git.patrick.steinhardt@elego.de>
        <xmqqy3xstdh9.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 30 Jan 2017 14:52:00 -0800
In-Reply-To: <xmqqy3xstdh9.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 30 Jan 2017 14:00:34 -0800")
Message-ID: <xmqqfuk0tb3j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <patrick.steinhardt@elego.de> writes:
>
>>  - I realized that with my patches, "ranking" of URLs was broken.
>>    Previously, we've always taken the longest matching URL. As
>>    previously, only the user and path could actually differ, only
>>    these two components were used for the comparison. I've
>>    changed this now to also include the host part so that URLs
>>    with a longer host will take precedence. This resulted in a
>>    the patch 4.
>
> Good thinking.  I was wondering about this, too.
>
> Thanks.  Will read it through and replace.

Ugh.  When applied on top of 4e59582ff7 ("Seventh batch for 2.12",
2017-01-23), Git fails its self-test in t5551 #31 (I do not run with
EXPENSIVE so some tests liks #30 are skipped, if it matters).

