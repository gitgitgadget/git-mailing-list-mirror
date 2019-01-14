Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49FCD1F62E
	for <e@80x24.org>; Mon, 14 Jan 2019 22:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfANWL3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 17:11:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32953 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfANWL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 17:11:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so759741wrr.0
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 14:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7J0ksq09tm6+gqLDccxA3ZYnBGrzxtVx5cmzKvP7dkI=;
        b=hXMDFCu5idpRs1NqJmFITZOMD0/exHYQgmZGN9l+90fNh2d1q2GWD2pmR0gqKwlR+n
         nCR+Qh8j5woHTqUvL+QcJCHhlCZunZrVbhl8B1R+IHR46VbGbsUDfsmpHiSBw9HlHAPN
         2k8R/VsJKvBxOU+U4QEGWYlAPPthuEx7iJb1UADREsXJYDS7lseqIFgMQhwKqXY+WT6U
         Rb59Suc+Ex/SPfCTZC7zGCke2xIkagEeN/ofTFTFDBWnX4pKmAfPTRC4sRV7ybc+3ibs
         1plPhQ7coBB8eI2Ueqbh8FBKh3xpqRDamW+RdHiHSDPu4tVCC+SJoVErSr2TA3Kjg060
         Wf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7J0ksq09tm6+gqLDccxA3ZYnBGrzxtVx5cmzKvP7dkI=;
        b=hQu+/tsO9UW0p/96SkGqRV31b0niu1VRLzApJ1LlRbwR7vRf/jeS6L6E8628QjMLHy
         DxUS8Vaa9MublohwEBHJ+W7x/MXa8ACgo9T8twnDkj7Ouk6Ytq3JdwWGIAnio3hbh0bo
         Up59+O99EHn/uuRCz1ScuHY6Z/wbr3NZ4SVIU0zGI/5xxTgAML3Z7cHvp5RIE45WOWpE
         J4n3G9tk5Uj5WFURRz6Hmcw25P3Rt4Nbj0Y+E4o7/TEtR1Zsgwftct962UDIh0dv3YqQ
         a1JQu+Q//AbZBDihL+L1nJ6AbmfNPVuI6X26lolunbC7MdP+5tjB05yZmln40noSXpNS
         e63Q==
X-Gm-Message-State: AJcUukcIdxrLBvwIEt3dRW1ESvxa2ZNm4gwyBV1cvdqwxli9OlUWD1HJ
        DA7sTZJnI+oxhKN9kFHudTA=
X-Google-Smtp-Source: ALg8bN5xbfFTOu6LI+IBwhRtg9LM+LtrppUQNrGW4Ng6pvXlt5CrCWwRpZTag0F+AKDYQuksN4WEkg==
X-Received: by 2002:adf:b243:: with SMTP id y3mr489397wra.184.1547503887440;
        Mon, 14 Jan 2019 14:11:27 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h2sm73334250wrv.87.2019.01.14.14.11.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 14:11:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] sideband: reverse its dependency on pkt-line
References: <cover.1547244620.git.jonathantanmy@google.com>
        <4079a1f110086bd412fb4f56bc8b7f8a6a7a8f9f.1547244620.git.jonathantanmy@google.com>
        <xmqq4labuho5.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 14 Jan 2019 14:11:26 -0800
In-Reply-To: <xmqq4labuho5.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 14 Jan 2019 12:07:38 -0800")
Message-ID: <xmqqlg3mubxt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Lack of corresponding comment bothers readers.  In all of
> REMOTE_ERROR, PROGRESS and PROTOCOL_ERROR cases, the other helper
> stuffs the message in outbuf in "switch (band) { ... }" and writes
> it out with xwrite(2, outbuf.buf, outbuf.len) [*1*], so I can see
> there is no need for us to write anything out here.  Perhaps
>
> 		case SIDEBAND_FLUSH:
> 		default: /* errors: message already written */
> 			return retval;
>
> or something to clarify?

Forgot a footnote for *1* above.  I was wondering if xwrite is what
we really want, rather than write_in_full().
