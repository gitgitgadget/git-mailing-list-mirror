Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 428A120248
	for <e@80x24.org>; Thu, 21 Mar 2019 01:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfCUBcD (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 21:32:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51484 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfCUBcC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 21:32:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id 4so586801wmf.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 18:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8ECjNWwW2yITEq1r/r3bhHLhGHOt3LFlWsS3gYe2GfA=;
        b=kQSXP6U8vy3vUuEVGv8KN7i3KpbpJKHPrpbuayOzLm2VScseyCZK+TGmbR9VTCL/yX
         8mjmjhIhJaqs4ngoCYmAtT9EKw4XLUKD7pyKflLSZ13HgzXDeEYc99/o/SP7mSF1ZwPg
         V+svKhgUKBP8O+HiB74K3CQ9fA3vCOtkwUWzYNmHp5TlbIX9zA9ddIifAfgaP8u3wUOz
         AKCZfRFOxdjbuxVUPP4d9AfrMKebL92XNiQq6l94sSD59NUCiX55+AhjqclQY1Kj8ABD
         Hbo2DO2WXofKKZha2Izp7KUhEqah6lvYELPsyzIscnOReHa9DfENvErH9jhgwipi51B1
         Zqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8ECjNWwW2yITEq1r/r3bhHLhGHOt3LFlWsS3gYe2GfA=;
        b=bFkxpj77Xg1tagSUySqvLUtD2yLOXP/vqpZds225NdfhKoifI3/RDCTBmp3xSX9HJ9
         qC/fsm4RCTyp8+/pn2gNDg66nx82Ld0VnZLZAEx7FLkWRzSFd+WqiSa/voj7nCPo2+lO
         2vWRw7R8ytbQnZbBVk42Meg9TJDPBB31VhGud7hLWg0YPHJTmkGIp5UlbipAaIg5DBBD
         6gBpukbyiuMdA8BnOH1c5btXZJPfEgatgSDypi5miOqZlt0RvHOZ1frvBcIdk1g+c50b
         2lHn2T3pVc+bV7Vo1XzSWpi2wC3klxX9D3ifl5fI5tZZz6iexrwNHO6W+hi7ql0zLRjF
         Z+nQ==
X-Gm-Message-State: APjAAAVs5ZxHGmSSOuwF/R82j5POnL7gTidLkbMPok/LIMdnOhYIjKwn
        AY/IHL/2pV4x+1Afi6SshEY=
X-Google-Smtp-Source: APXvYqykA2paIi5gui6RaS71WbgWGglLNtywVkv9eMEEw+2nlWrWaakiIJAv5u1rrhtL3oNBZlwphg==
X-Received: by 2002:a1c:7dcc:: with SMTP id y195mr647271wmc.13.1553131920810;
        Wed, 20 Mar 2019 18:32:00 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id l26sm2756647wmj.41.2019.03.20.18.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 18:32:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Kahn Gillmor <dkg@fifthhorseman.net>
Cc:     git@vger.kernel.org
Subject: Re: git tag -v should verify that the tag signer intended the same tag name as the user is verifying
References: <875zsdu41d.fsf@fifthhorseman.net>
        <xmqq5zsduinf.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 21 Mar 2019 10:31:59 +0900
In-Reply-To: <xmqq5zsduinf.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 21 Mar 2019 10:21:24 +0900")
Message-ID: <xmqq1s31ui5s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>  * "git tag -v $(git rev-parse v1.0.0)" should work, but the command

Sorry, forget about this part of my message.  I completely forgot the
discussion we had a few years ago:

https://public-inbox.org/git/CAPc5daV9ZvHqFtdzr565vp6Mv7O66ySr-p5Vi8o6bd6=GyVELg@mail.gmail.com/

In short, "git tag -v TAGNAME" does not take an arbitrary object
name, TAGNAME does not go through the usual ref dwimming rules
(i.e. checking for .git/%s, .git/tag/%s, .git/heads/%s, ... to find
one) but only looks at refs/tags/TAGNAME alone.  So we always have
the refname it came from when inspecting tag contents that tells
what tagname the tag has.

The other point still stands; there are legitimate reasons people
would want to have a tag with v1.0.0 tagname in somewhere that is
not refs/tags/v1.0.0 and an extra validation must need to make sure
it won't error out, even though warning is probably acceptable.
