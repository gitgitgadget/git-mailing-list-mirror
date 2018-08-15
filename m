Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 567781F404
	for <e@80x24.org>; Wed, 15 Aug 2018 17:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbeHOUbI (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 16:31:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35256 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbeHOUbI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 16:31:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id g1-v6so1801035wru.2
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 10:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=N6Zo5Ictk9Rh8W0jLEmUwcyqWtsmR4gIzfa+HyQ6Jvs=;
        b=QWvMCoczPWcP+HobH9ZQDHOWlP0cxiMoKeArDhGUquP+nD8mxFAn/ihndpqdsXJLW3
         eMQnp8huFxfINMGqx1r/zCA3AYQrEBJtlNctQ04oJQi60SmTOexTbraO7i0/mTNKilid
         TpI/MUklucm8viqp3RTBqm8IighnDTwoOMNEezXL5v1Ov7yEJHlTdYMRukA8eIffLsSJ
         IJvafB4Q9xFnDJ7TU7CX/VTrVjumroD5y7LjRDLFe0VAKRySepdJ/f8gwml8vynaiqP0
         1ED5CNoZcNC7rTyxpgJxeJq06c5YYHhVcFGcRQdIuWPqYBIPg/dM87mI6W7Hu81RVhM4
         Is0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=N6Zo5Ictk9Rh8W0jLEmUwcyqWtsmR4gIzfa+HyQ6Jvs=;
        b=UxQPsTLXInPX6KfyMhoF0wj4XbfRzPiP4bZMMh9IyNrxDFOyLL4VVBRvzxGKOwShGC
         VB4x6UwCD6+rTB4o1dgSzOdW3EBca8v7MrsRO8j39rIxkFChN31REExsRCgbfDEJFQnr
         fQ1u39BWCQ34SmnmhKm7OfJ1ubtGuYmpLCxh83FVjgajrlE2ndtp2UT5r5NcsP0O2GSl
         q+hKBWTbT/wMIbCgl+OeODm36JDLLtvZ2IDb2vUgKyiynqEEtZf88aTqb1sHPra0IkgL
         SSOMFIDauX/utHGgoubTn1ujT0ZXwqKBqSBnfaJFo5h2QzxO2C2t9LOVjQ75dX1HcGc5
         Vezg==
X-Gm-Message-State: AOUpUlEMOwQLj5JRgijpbiGLIZMAaCc3DIZ4eZFOb6+eCv4guq2i9BI6
        pNGUhn+rBcgLMR2vOi1HLixt3KWr
X-Google-Smtp-Source: AA+uWPyfUsxF9JGwAiRoaHbLvNEBmmnkQfpvz1RbOF9m8VDT+crEiNFVuTMA252kwJyjsLCUssCczA==
X-Received: by 2002:adf:eb4c:: with SMTP id u12-v6mr17102194wrn.174.1534354681744;
        Wed, 15 Aug 2018 10:38:01 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d123-v6sm3595100wmd.9.2018.08.15.10.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 10:38:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] branch.c: remove explicit reference to the_repository
References: <20180815162308.17747-1-pclouds@gmail.com>
        <CABPp-BEC45snMzGeCre-dD1rtqGok-RKuLGbMaV=VJhwx1ceew@mail.gmail.com>
        <CACsJy8B3ip+_sDrpvaZ32a35-6hWkY=eE6g4RObWgbHnf6g8uw@mail.gmail.com>
        <CAGZ79kbSa2chcUj_2=v7iE59R6_0m==ecYkB86+-4Fd_Zgd5_g@mail.gmail.com>
        <CACsJy8ASVqV9mmokTMmap9q7o--3nk1rRyFuuYrrNRO9mnrUvQ@mail.gmail.com>
Date:   Wed, 15 Aug 2018 10:38:00 -0700
In-Reply-To: <CACsJy8ASVqV9mmokTMmap9q7o--3nk1rRyFuuYrrNRO9mnrUvQ@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 15 Aug 2018 19:11:32 +0200")
Message-ID: <xmqqh8jvil8n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> 4) eventually (in the very long run), we'd change the signature of
>>   all commands from cmd_foo(int argc, char argv, char *prefix)
>>   to cmd_foo(int argc, char argv, struct repository *repo)
>>
>> you seem to be interested in removing the_repository from branch.c,
>> but not as much from bultin/ for now, which is roughly step 2 in that plan?
>
> Yes. Though I think step 4 is to make setup_git_directory() and
> enter_repo() return a 'struct repository *'. This means if you have
> not called either function and not take the repo as an argument, you
> do not have access to any repository.

That part is understandable if somewhat hand-wavy, but it is not
clear how you can lose the prefix and still keep things like
OPT_FILENAME() working correctly.
