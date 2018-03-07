Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B525B1F404
	for <e@80x24.org>; Wed,  7 Mar 2018 22:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933736AbeCGWcm (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 17:32:42 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54669 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933415AbeCGWcl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 17:32:41 -0500
Received: by mail-wm0-f66.google.com with SMTP id z81so7721448wmb.4
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 14:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ibi1RkMnyzXYPMS4F0bSBfY6EJdWgq1ieFMLDm4Fwq4=;
        b=d0WAaLTUemrxsOu+uGwPd4Z/7bT3XeyOHA2hUE+gUb/wniBwtpqPT1S+ZaPcc7caWY
         eUmGqMiWCmwqjdVwL2v6VkYFDbIpMcCJSDvZuJxkOb/ZGo1WRgf4kGxou5Bb+S/s1D4N
         2gWwyKwkQEm4SAHoby9bDurWCrW9Bigo1wOwORlqOu0nMmuY/luu51QmeAwggdL6JrQg
         9NGocc6m9TelA6TMfOtrDpbyRJfobMCFIEAsWzLMDrSduSEME+8PAg99lcaG1ld2Mhrn
         vrskqKvPAoKw7J3s6pU57oBywqiqfGiRXpHssqAaLrMmHqgPSs4FmVbYDNXc0U9xv95V
         Ebwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ibi1RkMnyzXYPMS4F0bSBfY6EJdWgq1ieFMLDm4Fwq4=;
        b=s/iGS14b8zl6ur56QaBkiikXtLwJKno7LUecznpHj5DaevuQNouOhf3q7ZMc6UxYst
         Pdyg0BFJSGxhqRvWlZFaAFNuUnaHRWrDsejHr8rcAkqIFK2ncayF/7CYDD8/0tp6focR
         /iXTEEV0zmjJctls+ToylKv0J+nViGW87pTxUZ4f4vOi4efXJsFyFhWnwFeF3gvR1tnw
         Eyo426/aKil1O9o0ynBQInCnKkIL4HLF8fRGW8FkXiAQQuUPwV5tTeeNFQPRpkbpBw+d
         Zdgl5tqdYP0WiGFjmX5HMrUjufJLlRouEwLVW6yUWZ6oAn7l/U+4yKOIbTuyl9OyzELy
         6o2w==
X-Gm-Message-State: AElRT7EUiO2FWbjUrdaz/sOtMcDIwkK4K2nVPRd0VcaU1TtoBzP8lz0n
        8uKZMInWiZIogml6Me4pdt0=
X-Google-Smtp-Source: AG47ELtz1axMLPtMa2Z0a1R2FkE5oA6oVi+DMfsFSDuplVl8+Js9AdDgCzdBmd57q6NPEWP2dSsijg==
X-Received: by 10.28.20.84 with SMTP id 81mr16776752wmu.70.1520461960100;
        Wed, 07 Mar 2018 14:32:40 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h1sm14931580wre.16.2018.03.07.14.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Mar 2018 14:32:39 -0800 (PST)
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
Date:   Wed, 07 Mar 2018 14:32:38 -0800
In-Reply-To: <B001E8E2-9C98-4136-87A3-4425C50E90DB@gmail.com> (Lars
        Schneider's message of "Wed, 7 Mar 2018 23:12:38 +0100")
Message-ID: <xmqqa7vjzfcp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> I also would have liked to advise "UTF-16" instead of "UTF16" as
> you suggested. However, that required a few more lines and I wanted
> to keep the change to a minimum. I feel this could be added in a
> follow up patch.

I'd say the whole upcase thing belongs to such a follow-up patch if
that is the case.

>> On the other hand, if we are not enforcing such a policy decision
>> but merely explaining a way to work around this check, then it may
>> be better to give a variant with the smaller difference from the
>> original (i.e. without up-casing).
>
> See example mentioned above: "Utf-16". How would you handle that?

Dropping LE suffix from "Utf-16LE" or "Utf16LE" would yield "Utf-16"
or "Utf16" if the advise message does not force policy, or "UTF-16"
in the canoical form if it does.  Is there a problem?
