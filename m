Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76A161F404
	for <e@80x24.org>; Wed,  7 Mar 2018 22:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934258AbeCGW5G (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 17:57:06 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:45279 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933858AbeCGW5F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 17:57:05 -0500
Received: by mail-wr0-f181.google.com with SMTP id p104so3797578wrc.12
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 14:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MUZ8nGG45NwsmjBW+rPkf2OY6s1FXlSsuvHNmWfv/Ag=;
        b=J2CfoFHT/HW4yqnNoy3sI40ShfsW8PHdhLaWmctr2FSb3YS87OXu4Ok4RHJhljV2Lf
         ByltIdpwziXRgtLGMnLNo7/Blb/AuOdQhxhEHSZKgsAyjAO/dj1zi4xMOp27TGKolhWF
         rTMCnoGj/XHEpZbaI4+wcEOaajGCkn9cKnf7RZFQXh6/z7vuzENLjuGGwR9wl0r3RJR7
         D4+e3uDJL/ivD+CFjw56a37D5lmoBCzafQLTbUeb6UqPgvxObWE0Iih60Ljse+Ey7oOs
         WzvdAWSTJhoiU8pDHYi9WzWWiPQFeJgMJCJ8+8lT8L1Zci5HlJ4+ztnZVEOF+OpQ1HzE
         pFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MUZ8nGG45NwsmjBW+rPkf2OY6s1FXlSsuvHNmWfv/Ag=;
        b=D85bid0pW/ID12SkTYXpJCmoWXQbytQfuF78XWQMRyik0yLOaAQXv9hFi4ZClPUjR6
         u5xa1818u+kqlh12UtsLotzxofTheLsv9pj86re5joBDo6AT4hQpt7+FfNUXiZg3ca9Q
         zJy+xWAa0Oc9lv7YJ9RABkaLJf1wCpkLXu4iypgMl0XQEJZeXoc3cHxuTImijVUn1gu9
         5iUPVCiiPjiGIKHcIYCOGambCKucmyY5hx/Kipt9myIlysTCTBA9uF3cNgnhHFGPBDhV
         CILleO+XFD2E6DgswWbC67NXZ2P/f+tFgUxIoGFz7NekMrL1TX5+l8b1G/ueqrn2e1eA
         +h6g==
X-Gm-Message-State: APf1xPBCdxGKwOco4wezr6V6/JHu8xp30y+kWxafOpRUiAnjCkChtYVQ
        tgws7G/3CEcFwFsb5qDEL2A=
X-Google-Smtp-Source: AG47ELufMpLjjan5WfWSCCtA0f4piuWy7P2aQTXsHYmM8Q4U/iq2uI1145CP4x2pyVWIRBHHXBkKyw==
X-Received: by 10.223.164.221 with SMTP id h29mr22177563wrb.259.1520463424130;
        Wed, 07 Mar 2018 14:57:04 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g52sm36922474wra.20.2018.03.07.14.57.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Mar 2018 14:57:03 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        git <git@vger.kernel.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, sunshine@sunshineco.com,
        peff@peff.net, ramsay@ramsayjones.plus.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v10 7/9] convert: check for detectable errors in UTF encodings
References: <20180307173026.30058-1-lars.schneider@autodesk.com>
        <20180307173026.30058-8-lars.schneider@autodesk.com>
        <xmqqr2ovzmwo.fsf@gitster-ct.c.googlers.com>
        <B001E8E2-9C98-4136-87A3-4425C50E90DB@gmail.com>
        <xmqqa7vjzfcp.fsf@gitster-ct.c.googlers.com>
        <766B302C-446B-4730-A5D9-909C6FCF6A84@gmail.com>
Date:   Wed, 07 Mar 2018 14:57:03 -0800
In-Reply-To: <766B302C-446B-4730-A5D9-909C6FCF6A84@gmail.com> (Lars
        Schneider's message of "Wed, 7 Mar 2018 23:49:08 +0100")
Message-ID: <xmqqvae7xznk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> In the case of has_prohibited_utf_bom() you are right as we are 
> dropping the BE/LE suffix in the advise. However, look at the 
> is_missing_required_utf_bom() advise. Here we *add* BE/LE.

So?  Then add BE/LE like "Utf-16BE" or "utf16BE".  You do not have
enough information to decide what is best for the user anyway (which
is why I am not convinced that it is even a good idea to always
upcase in the first place).

> At this point I thought it would make sense to make the advised
> encoding name uppercase in both situations. OK with you?

In the endgame, if upcased and properly dashed form is always used,
that would be good (if we are enforcing the policy, which I am not
onboard 100% but it's your code and I do not care too strongly about
it).  I do not see much point in an interim step that only upcases
without doing the dash insertion.


