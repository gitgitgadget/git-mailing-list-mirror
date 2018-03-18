Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB4891F404
	for <e@80x24.org>; Sun, 18 Mar 2018 00:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752548AbeCRAYy (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 20:24:54 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42808 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751867AbeCRAYx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 20:24:53 -0400
Received: by mail-wr0-f193.google.com with SMTP id s18so15041298wrg.9
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 17:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DTDSbt0OYMvNZe8gy7LNTcLQ020kN69Bor+WH8SAygc=;
        b=NXVpe7iqXEXOEWvlzv0aFAITkTG2a0EvCbVxU7B7nBx0Eh8EET0tPAUkM7YWgkT2Nh
         dH88T1TW9Go5MzgdwNAV3m2kKpW/BLLjgDeAtyxZM8iG/0SJcx8arRm93FmDNrubi8hj
         rfJ7JS9mDb6ya6YhRZEKap7xgbGMIEuYtbYF0Kkl9/6hgGzSecSkPoBycE5fb/CNzd1P
         6gTVI+MMEeeIkEL71+MjrFBWB5j6O83X+/EniCxtnucf+h8NZs1vlwp0FjdkmkhbEoao
         u+PFkGExDscsBAOwqNcsByfbQzWxQEZe/Md9oS+TO8+AWCUHbe6nT2FsmodGhdyOJKSe
         MgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DTDSbt0OYMvNZe8gy7LNTcLQ020kN69Bor+WH8SAygc=;
        b=DmVvl8SWNzzSt2i8vVePmM73RsJksIpqLOpfrHkfZxHAetiVpzSkOtGsds21kcr5Gc
         JBb5/kyYiIMqBDMD/nOZpcdkWagSvCeteZ2mJiUjWsm8FO6/SBqXnd4DuYnet2PQo39H
         iZE2kN+a+gZFIerxEAIgBhzRFvpQ/tGNUaxkhimq6mCPLCVSTkfstMi/O1nUV0QSTlI5
         MSmSjsqJrAheEUahrzqCofGY7HOy6rQAGmY/aTEzbGdr/aiA7BHZk2J6Mh6wArMTT60T
         OACksiH/XFE027PMMJja2si3T1bhJYf9M/Xgg6vbUbhyBfTTeMLuyGgdrVWPp3xNNkmt
         y2eQ==
X-Gm-Message-State: AElRT7EOK4DIXVVvUPTrsy6VuLFMVc+URBs0tg26dXA+kS6z9ATGlQ9q
        DVYxkpTkh7z1FZDZ0jURTH8=
X-Google-Smtp-Source: AG47ELt4w70tCeCsfpWkQVQ3yLc/A3k7FhFSNZMPZCN2TdWl7unsqVirfiPQHe3/X6wvQsBF21MDmw==
X-Received: by 10.223.183.16 with SMTP id l16mr5818534wre.214.1521332692225;
        Sat, 17 Mar 2018 17:24:52 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l41sm17714903wrl.2.2018.03.17.17.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Mar 2018 17:24:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 0/4] worktree: teach "add" to check out existing branches
References: <20180204221305.28300-1-t.gummerer@gmail.com>
        <20180317220830.30963-1-t.gummerer@gmail.com>
Date:   Sat, 17 Mar 2018 17:24:50 -0700
In-Reply-To: <20180317220830.30963-1-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sat, 17 Mar 2018 22:08:26 +0000")
Message-ID: <xmqqfu4yxmb1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Previous rounds are at <20180121120208.12760-1-t.gummerer@gmail.com>
> and <20180204221305.28300-1-t.gummerer@gmail.com>.  Thanks Duy, Eric
> and Junio for the comments on the previous round.
>
> Junio: I know it is the rc period right now, but the topic is also
> already queued in 'pu', so I wasn't sure if you prefer me submitting
> this now, or after 2.17 is released.  I'm happy to resend this once
> 2.17 is out if that makes it easier for you.

Mail archives would not forget messages easily, so it is OK if you
sent early.  

You just need to set expectations low enough, though ;-) Topics that
are not in 'next' before -rc1 is tagged will not be in the upcoming
release unless there is an extraordinary reason, and reviews,
replacing in 'pu', and advancing topics to 'next' will all get lower
priority than keeping an eye on breakages in what is already in
'master' until the final.

