Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D47E120248
	for <e@80x24.org>; Mon, 25 Mar 2019 02:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbfCYC1J (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 22:27:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37797 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729255AbfCYC1J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 22:27:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so8295676wrm.4
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 19:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7Cv+xxH1jBPR7rNbFO9q8dJkHgm73ZnQSygfsQhoeHg=;
        b=GPmOShKbbHpXw3mr+MXWkL2Ld71OilegPictcrXWx3y6JeB6/2lTgR5HB3WLYcTaf4
         CqfZAZYxfUiuvCcQGlkm6m03Qsbyidu4Ckuwciz/b5x0TBUPtna8owTlkoaHyUe3uI2m
         dFCcw7xCc+gcjsiFkC87ctmCY5V7UIMcaa2e3ELykIe17wIHLMSxAM0zA3u6SnfIKuFY
         PS8BBqS0EWiyORkwjBapUK9S6LFWM11sJR6DFn9EHnMM/cz2VjUOit9eDem8nlNkCPsc
         zqk7HLA9Raa+/ikP9NybA0HTqyF4G8gvBIvzO1mC/NCUx+F9elakWwMAkJ2AnFAI39zi
         wYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7Cv+xxH1jBPR7rNbFO9q8dJkHgm73ZnQSygfsQhoeHg=;
        b=JpSBTbvnN2qKSAAcAM9aC4HHDLZ+rAYXtonLLhHMdX0G8++EuE/joswYGgVPLqjmFa
         c6zzszMvIIeg5od+Cq5sEaIyjE4VbVL7lt5+84l8ePdSh8Jgcd+X+33NN1tbVbNu/sDS
         H7C7st0hyORI2niW6nRWSvMCWHxWRGpmEpQXzwMG6Ovog/atKV2pNKtan+C7e29oD17e
         HqlWPE8PoftnOqPcj0HMLFuidZi1aMAVxUxY8Tgyixn4TlSnI3mlyIIzRyKmMvgTxZcP
         drsz2HX+nb/YRYSkS8AZbMxXuES50R4eh03RE4QYB7fgUNKPYKYsQhBsxiEMa4HP/adh
         PFOw==
X-Gm-Message-State: APjAAAVhCj6SNa0EdQBvBuGrNEiGoHfOH20a3MiJZWtnH/srCqacb3iU
        +jaL2CQeYOTNiQfFY2Hh+gmNnMGvFQA=
X-Google-Smtp-Source: APXvYqym4V8n8v/iIld+t3M4cfYdEdUvYRJNjQznWFg+8fH7pX4hEUCefptP8ucVYzegz8O2Bn5dbA==
X-Received: by 2002:a5d:6252:: with SMTP id m18mr13180314wrv.199.1553480827624;
        Sun, 24 Mar 2019 19:27:07 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id k14sm12016859wmj.26.2019.03.24.19.27.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 19:27:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Kahn Gillmor <dkg@fifthhorseman.net>
Cc:     git@vger.kernel.org
Subject: Re: git tag -v should verify that the tag signer intended the same tag name as the user is verifying
References: <875zsdu41d.fsf@fifthhorseman.net>
        <xmqq5zsduinf.fsf@gitster-ct.c.googlers.com>
        <xmqq1s31ui5s.fsf@gitster-ct.c.googlers.com>
        <87imwbmqpg.fsf@fifthhorseman.net>
        <xmqqpnqgpifu.fsf@gitster-ct.c.googlers.com>
        <87k1goia52.fsf@fifthhorseman.net>
Date:   Mon, 25 Mar 2019 11:27:06 +0900
In-Reply-To: <87k1goia52.fsf@fifthhorseman.net> (Daniel Kahn Gillmor's message
        of "Sun, 24 Mar 2019 16:07:21 +0100")
Message-ID: <xmqqh8brofid.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Kahn Gillmor <dkg@fifthhorseman.net> writes:


> What do you think of my updated proposal for tag.verifyNameMatch ?

Meh to slightly negative for hard-coding project-specific preference
to the core tools.  "We give you --format so go wild in your project
to do verification your project likes." I think was the conclusion of
the previous round of discussions, and I do not think we saw any new
arguments in this round to rethink it in a different way.


