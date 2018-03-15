Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F9AF1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 22:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932774AbeCOWss (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 18:48:48 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:54868 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932665AbeCOWsr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 18:48:47 -0400
Received: by mail-wm0-f48.google.com with SMTP id h76so13387174wme.4
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 15:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JhQGi01gcYBKx2pPCeCBgcAOmQX0ihHwGtuX1UNYFew=;
        b=n7wLHu77sgYOk7zZLzd33zhHlR5GBsT6qflZ5mlWlHv0UZc3PiGwsOm8J67MrDvaRl
         LpJULZ93Yx3C8PQOscK0eoXkwIoCcum7T3789DWCAZRVwIkqppQXJUC3zikzpAVUJgM3
         ErTmkROocjWTDYqgoTAUJhraRl2cFlIMLhmltsGs3LrFaAf42p+5D6LahTZg9xncgbzI
         K30Tpak0q1Hk+tYC0XmEmqTLZabvf85vJmcFaVsouXdMxpeRUvVRuY8Zy9pB3PexK8XE
         iCaKuW0jNp4uV/6DMOVOcuHy7y16iqVy8nxz/2+YvRW953n0TqV+2WbB0Bi/OTWFsMf7
         eDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JhQGi01gcYBKx2pPCeCBgcAOmQX0ihHwGtuX1UNYFew=;
        b=iLIpX5cy+PmkN6oSw4TLHxO9OcPYRJXWY2soZIrFVDj3YJ8ZHLWiDuYBCb06Xshm66
         JE/eoElWGwABWtTysAi0gvnvyzgjv+I/lPeyZjSSrXYvM1Ir30Shmu8D7FC6wI0Er/vU
         30lDackd7cuIHGkueqJHD9cKN37TBrSRKuK1U5V8nvg+p62sSoRseLKapg/8zAWdoDze
         xKfGrRB5oOYMGQfuvzFbkatJEz+AejpSkw4ELTLWz9qcvCtj/YV4cw7cZP9fKGNV6Ui5
         G4dDRYUS9Si0rw6g1ZR0EzjpCyFMJ0h0ua5fdqoyBRjJR4GURWfrX9cdPjlWRHxGtbqK
         MnYA==
X-Gm-Message-State: AElRT7HyMj7yQLmIm5gbuEdzNcJjZo12pvoospkYh/lZwdQdljGY/zC7
        jHGf5SM1iHCmtyu919+MDr7G64+rRjk=
X-Google-Smtp-Source: AG47ELvo+WHeMIztFTLzz3bC7MdyLnJ9+4GX+RAzW03ZdTUY2MI4RvwKN0+1TpDeotItcJecrRppnA==
X-Received: by 10.28.17.210 with SMTP id 201mr35272wmr.58.1521154125625;
        Thu, 15 Mar 2018 15:48:45 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 9sm7030256wml.22.2018.03.15.15.48.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Mar 2018 15:48:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/5] ref-filter: change parsing function error handling
References: <0102016225e61c34-50ab78f0-6fb6-4ece-acfe-da253bdce616-000000@eu-west-1.amazonses.com>
        <0102016225e61cb4-b59773de-d22e-42cd-909a-d7ce71646898-000000@eu-west-1.amazonses.com>
Date:   Thu, 15 Mar 2018 15:48:44 -0700
In-Reply-To: <0102016225e61cb4-b59773de-d22e-42cd-909a-d7ce71646898-000000@eu-west-1.amazonses.com>
        (Olga Telezhnaya's message of "Wed, 14 Mar 2018 19:04:20 +0000")
Message-ID: <xmqq8tat3qgj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

> Continue removing any printing from ref-filter formatting logic,
> so that it could be more general.

Hmm.

> Change the signature of parse_ref_filter_atom() by changing return value,
> adding previous return value to function parameter and also adding
> strbuf parameter for error message.

This says what the patch changes, but it does not explain why it is
a good idea to return something with different meaning to the
callers (which of course forces us to update all callers so that
they pass &result pointer and check the value returned in the
variable), or more importantly what meaning the return value has and
how the callers are expected to use it.  While at it, it probably is
a good idea to explain what the original return value means.

	The return value from parse_ref_filter_atom() used to be the
	position the atom is found in the used_atom[] array; that
	information is now returned in an integer pointed at by the
	*res parameter.  The function now returns 0 for success and
	-1 for failure.

or something like that.

Having said that, I wonder if a calling convention that does not
force callers to pass in a pointer-to-int may make more sense.
Because the original return value is an index into an array, we know
the normal return values are not negative.  An updated caller could
become like this instead:

	pos = parse_ref_filter_atom(format, atom, ep, &err);
	if (pos < 0)
		die("%s", err.buf);
	... original code that used 'pos' can stay as before ...

