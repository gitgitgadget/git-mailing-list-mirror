Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E8201FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 20:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751004AbdLHUTf (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 15:19:35 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:42939 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbdLHUTe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 15:19:34 -0500
Received: by mail-it0-f49.google.com with SMTP id p139so7225792itb.1
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 12:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GgsOWhoIoUvix1MZq5iBjuLwD5qA/4OCxgAQPd0q3GY=;
        b=pQrUKHJfd2Ko4wMpILG0MtlCRPJZCyrdDjc4oDcUa51+ZFu5E1lFaaS9xuYbCa68mg
         wseoxt1EJeao6r8f1ah7X85eQf5vDHgIqFy3CkrQ35evesAWpHEBP1C7hurzp568FvDW
         cXmVJmyhZJAFJL/rnIbcu7XKAgGklZZjC0yqInvsZmTmza1E9nTS8TAAj+3cv7Vuz3o4
         Om/LTekGp2PJNVqNzIJtKM0J6CJeanaYrQoGMkzWwsAW6Pj5AeX663kX0H9r78m1qB50
         admhcIG4whYIj8FKR2kA6G+yDkoIe6zOMDSLQbfcCXATR3r6vvD1r/d6J9kMoAVsJk3U
         Z5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GgsOWhoIoUvix1MZq5iBjuLwD5qA/4OCxgAQPd0q3GY=;
        b=YdKlgC7wN+1SxhOdCnTJGUy+A8upu7f17uzOYu+cshM7rdzPvnTc0sro2/8oOFhrtJ
         SwNmh7jx7oyfiN0aKs+IfRzgnI4AU0VaKFprdsRiQBdI6sBv/VMneu7kCUMBvNMvKyNN
         YeM8KDAJOn1CtJIObwmGqqPxE+yAwu8U1/zJtwLUwXDl3Th7mDGwiG3pGRccUGdK9/7A
         sA8AStYaXyyhR0trnT6CNJsNPnR0nH3r81HHAYL2MWvL7C/lku2ZqzUbHtpiZPJ0nZcF
         zfbf2q7Lmj92Mcve4H3GoFzJ1e6QQRlhvCzBKxXEieDDW1Ui84vjYCTGL95cLa9xws3e
         pNQA==
X-Gm-Message-State: AKGB3mKleh4WGl8/k2uamt5CbjOM6vzSZwVTZrNHc3DRUsat2g7Na8FW
        i/96y1OYCRt/4sCh2WHey1ZWXKPn6fM=
X-Google-Smtp-Source: AGs4zMYq6pRRtdzu4Ml+tj7dfL+2vKB72deuJx5iaucDjdkN8M0hVMQ0+uE5Ji1M6pTIbBLrvli7Uw==
X-Received: by 10.36.60.77 with SMTP id m74mr8062914ita.117.1512764373352;
        Fri, 08 Dec 2017 12:19:33 -0800 (PST)
Received: from google.com ([2620:0:100e:422:e4f1:b67a:70f2:4fbe])
        by smtp.gmail.com with ESMTPSA id d14sm1092523itj.11.2017.12.08.12.19.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 08 Dec 2017 12:19:32 -0800 (PST)
Date:   Fri, 8 Dec 2017 12:19:30 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [WIP 07/15] connect: convert get_remote_heads to use struct
 packet_reader
Message-ID: <20171208201930.GD140529@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
 <20171204235823.63299-1-bmwill@google.com>
 <20171204235823.63299-8-bmwill@google.com>
 <xmqqh8t3fpm7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh8t3fpm7.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/06, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> 
> EXPECTING_DONE sounded like we are expecting to see 'done' packet
> sent from the other side, but I was mistaken.  It is the state
> where we are "done" expecting anything ;-).
> 
> Having an (unconditional) assignment to 'state' in the above switch
> makes me feel somewhat uneasy, as the next "switch (state)" is what
> is meant as the state machine that would allow us to say things like
> "from this state, transition to that state is impossible".  When we
> get a flush while we are expecting the first ref, for example, we'd
> just go into the "done" state.  There is no provision for a future
> update to say "no, getting a flush in this state is an error".

I believe this is accepted behavior, receiving a flush in that state.
And I don't think there is ever an instance during the ref advertisement
where a flush would be an error.  It just indicates that the
advertisement is finished.

> 
> That is no different from the current code; when read_remote_ref()
> notices that it got a flush, it just leaves the loop without even
> touching 'state' variable.  But at least, I find that the current
> code is more honest---it does not even touch 'state' and allows the
> code after the loop to inspect it, if needed.  From that point of
> vhew, the way the new code uses 'state' to leave the loop upon
> seeing a flush is a regression---it makes it harder to notice and
> report when we got a flush in a wrong state.
> 
> Perhaps getting rid of "EXPECTING_DONE" from the enum and then:
> 
> 	int got_flush = 0;
> 	while (1) {
> 		switch (reader_read()) {
> 		case PACKET_READ_FLUSH:
> 			got_flush = 1;
> 			break;
> 		... other cases ...
> 		}
> 
> 		if (got_flush)
> 			break;
> 
> 		switch (state) {
> 		... current code ...
> 		}
> 	}
> 
> would be an improvement; we can later extend "if (got_flush)" part
> to check what state we are in if we wanted to notice and report an
> error there before breaking out of the loop.
> 

I don't really see how this is any clearer from what this patch does
though.  I thought it made it easier to read as you no longer have an
infinite loop, but rather know when it will end (when you move to the
done state).

-- 
Brandon Williams
