Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 897CA1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 21:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfA2Vxg (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 16:53:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46091 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbfA2Vxc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 16:53:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so23750384wrt.13
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 13:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UCbBy1hF0q16bZ3+/hPngikjZSeqDpA2+s/eoM2R3x0=;
        b=Rwl2Sb2JdyCy8nNyemkkcqrhRy9J3x8ADvDQVyVeh/+lEAJYlD53W6v/ispGrDoNe7
         xnV44jdZWRrt45T8QsXA/2maU4mkiQdb+4Nrz4o0lEce8CCm/ihZfCPLL2/AC9AZKPdL
         wxwvFjoyn+H1w7zRfa1RVEd2z78L65ht/5OFUTst/BmIonKBhoQCAXnZGpblN3D7T4+f
         E40KAjiqCibfqbhzOcqDLBdWK/UQ/d3wZzAHsXyg15H7Q7hwgowl/I267YgdwsF15vHp
         Hm6sfIGAfloap8/T67moFh4hfIUhgbLB1ASkIc3oCNgKWDb6640+E7EZKGHHD9K6opWG
         byfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UCbBy1hF0q16bZ3+/hPngikjZSeqDpA2+s/eoM2R3x0=;
        b=IJmpEK30ZUSOoawZYvelRTUyo6mwEOgh9auved0WwFfDCeYUHoWXFQIg1AZm49fE4/
         Y+8YzKptr8DW47TiD0FIpLECRIIF+irvy4ntBqWnacufpYuutX7qCjCMkd2KTQPRJb1A
         BrH69KG3RR+dYalkKYXhSmLSz6oA45t3pvZUHeBPGJWrFlDgyQjzALZmzl7pMnwBb0Zm
         aKvUxoKbj+tnKkzfCCCrllhKdmLOu2Bxhi17o106w1TkkiwruLP8mO2ezL8axmwE4Fhr
         b4IVRPbVFzdjAHIXKfFN2AXyvB6tbbU5FmMBAMarUsuFBSBGTkl88VKvsci5LmKBsvJs
         LBuA==
X-Gm-Message-State: AJcUukePrHLPjPNIuKVwmo0zWgUmhcW8V+kOGSUH/hiagNnYYrNcgWZy
        xCRmGHWlrhR4gGDWyPqJezs=
X-Google-Smtp-Source: ALg8bN4gKnXT/LT36amI/fLaH/8ciulTJm1SglEIxbIQ/iuqKTa3+QkDxDqCUA+A5cEY+fWR9DKcaA==
X-Received: by 2002:adf:e34b:: with SMTP id n11mr26135774wrj.91.1548798810141;
        Tue, 29 Jan 2019 13:53:30 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o81sm88265wmd.10.2019.01.29.13.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 13:53:29 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] rebase -x: sanity check command
References: <nycvar.QRO.7.76.6.1901291632070.41@tvgsbejvaqbjf.bet>
        <20190129184327.30391-1-phillip.wood@talktalk.net>
Date:   Tue, 29 Jan 2019 13:53:28 -0800
In-Reply-To: <20190129184327.30391-1-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Tue, 29 Jan 2019 18:43:27 +0000")
Message-ID: <xmqqk1in6sh3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> Thanks for the comments. I've updated the code as suggested by Dscho
> and tried to make it clearer in the commit message that this is fixing
> git creating a todo-list that it cannot parse.

Will queue.  Thanks.
