Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE15E20A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 07:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbeLLH2n (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 02:28:43 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50816 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbeLLH2n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 02:28:43 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so4672592wmd.0
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 23:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yDH6F9Ym08uTn+Iw+rkn2GZvBlAI7gqFxUR6A8cBMJA=;
        b=rDgBD9+wz6uLLkUhcxl/BFx5W7n+qB7DKmEhAuMbLtisHXQ7GrreeVmJ8Z5oBM5OM8
         tZ5uSCGvFTjRBY9Gq8UVeNiNzkOA2JOOzwmKxEiKJzzwsM6xwn5BF6xlnX+5D58d2D6L
         z5df4FK/nMeiPBNzX8NZhrGd69OUpxjetMU0wQteKFxG0zLbKjOTOEjRCGZYkmv/+rS2
         WxzcZ3OsFNWohpDmB9A6/UAMWBltMJpjIktl/CM1VKpZ+m8bQN8fb4d/F5/ASJqEcCcE
         dT841Nl7pddn5DVF4ZHK8lRXSEJywMemAvHedSc36IOf0TeovQyDbObwkcvv5P7Kv+N1
         dTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=yDH6F9Ym08uTn+Iw+rkn2GZvBlAI7gqFxUR6A8cBMJA=;
        b=W61iTNNAhotLuNlnKgFaOHvVfbKrlmkCysMlTKmToSVKq7CpxAZiR32zrTFZugc+65
         +k9a48wmVi8myCxqK+bNLvERjlTmYzPkhGOv6lf4XRCRCpEBDddRl0EPNHDBmNxCw1zZ
         VWX+1OuWdXSoHMScsXDrdQMvYjalFKHV4hf0/brYqK0HMPcLktMg8H6BPieK/j4qdWbL
         zdcVKcKOrp3bshUQxvR6Y1PplhcHa+bdvTtmfPJIoI3ng9uSC8GpgexmiCJN7ZR5+AY4
         vK4MwHFYEAc65UkE0g4+CH3wyvnpgw/UGv4gOGyT2o89huKdg1Nyt6ODLqWAwBw8CRyZ
         2E8Q==
X-Gm-Message-State: AA+aEWaBCLhUBrVshYGTdx0Q49WAAheWnG3MkHsQPHZq8snNwXH8ZrSD
        3gjm0i/nxhbFCBmAdA2KODZoKqlQMbA=
X-Google-Smtp-Source: AFSGD/X9KZFSjrGEnJ0iT4OwQepAV0lPoBqJlZAfHN59CWTW/YgLDuokh78FJNi87GsY+Yz0pSG5Sg==
X-Received: by 2002:a1c:b14:: with SMTP id 20mr5387150wml.103.1544599721371;
        Tue, 11 Dec 2018 23:28:41 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j202sm3557645wmf.15.2018.12.11.23.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 23:28:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Subject: Re: [PATCH 0/8] introduce no-overlay and cached mode in git checkout
References: <20181209200449.16342-1-t.gummerer@gmail.com>
        <CABPp-BFaWtDiBPuGQVU_+VGQtDkemDKnvjHhz+h1sbUGssffmQ@mail.gmail.com>
        <20181211225241.GW4883@hank.intra.tgummerer.com>
Date:   Wed, 12 Dec 2018 16:28:40 +0900
In-Reply-To: <20181211225241.GW4883@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Tue, 11 Dec 2018 22:52:41 +0000")
Message-ID: <xmqqk1kfjj9z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> I think I got the right solution for that in patch 5, with deleting
> the file if it's deleted in "their" version and we pass --theirs to
> 'git checkout', and analogous for --ours.  I was just wondering if
> there were any further edge cases that I can't think of right no.

That sounds quite sensible.
