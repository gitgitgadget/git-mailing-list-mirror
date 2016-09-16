Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6584207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 20:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965082AbcIPUtW (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 16:49:22 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36750 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965467AbcIPUtV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 16:49:21 -0400
Received: by mail-pf0-f173.google.com with SMTP id q2so10505446pfj.3
        for <git@vger.kernel.org>; Fri, 16 Sep 2016 13:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=+LixrSYHz+8mtXmqXnarerMQ/SfWvCNUkWZ1B8NpI/E=;
        b=aPdLzP74o3ABjWKPQLyDRIql9G0jzcC7Q7ykX0/WHVRcvOFzdtg3a1dnx2ETgr21Qw
         WIeigxPKop+OdYfSe3FlBErcLofq7KYNghef0sAgjACFZKwM2zL6TXGnli0ek4ICuEPM
         kWbMxntUYxgpDv3yARHTs6U2AG4knIzGwhNEMhRA7aydUTh3UsKnzEc67I2XSfKOP05R
         QeLtWcoaMRf3EJqijhMEZqjIx/0UuKiwvfavVOLmdZoUoAnOt4+22BFMUnnaYvFoj0tP
         A/cGTVN1f0CqjRvV39j2l5ljHY66bIIJKc7wPlS8oTqG3uES3EMvq0G2+9sNX9nzIwQ/
         TrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=+LixrSYHz+8mtXmqXnarerMQ/SfWvCNUkWZ1B8NpI/E=;
        b=lsqYvM970sy9fLGMBL2hmPMj2jY5WjJTi+eLCrlL5NWNgKTzLTT6BXUf2ieXGaZc+A
         ZN1IsyJN0XmyXF1m3oWBgVi+UvFQyo7yJruvkVV7r+xylg6kiQxNQ7kU2M2HM4Gec7b1
         /FJ9kCgcWnruGNGW/8TQY4ym81NWMhVXFMzNPNYlA9OQt7Y1QoMirCC6PMDSpeM8QaTH
         E4GI2HhgCxkkvOVAUYsHCw8Gp3q2rYYIksgxPsifOAHWoZUH1DT9mzL86yVyydJQ00wX
         7RR9RgPcMDos1nzbsejM1vpa4vryXP1qePKGbS3dgMMivIMoni/lVYCmgTXgveRjYHW7
         8B7w==
X-Gm-Message-State: AE9vXwN3tH6eaMnAZLEGz9XkAchUaN91yURN28ulnMC71Kbn2bxvpQdHdL3Y+VOWyriiwc4z
X-Received: by 10.98.37.130 with SMTP id l124mr25872708pfl.60.1474058960229;
        Fri, 16 Sep 2016 13:49:20 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:c82e:43dd:7495:3b10])
        by smtp.gmail.com with ESMTPSA id q25sm20268023pfj.48.2016.09.16.13.49.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Sep 2016 13:49:19 -0700 (PDT)
Subject: Re: [RFC/PATCH 3/3] mailinfo: handle in-body header continuations
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1474047135.git.jonathantanmy@google.com>
 <20160907063819.dd7aulnlsytcuyqj@sigill.intra.peff.net>
 <cover.1474047135.git.jonathantanmy@google.com>
 <0152df30db0972d61ff45b2b099ad1242aacd431.1474047135.git.jonathantanmy@google.com>
 <xmqq8turk3aw.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, peff@peff.net
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <1b392241-461e-3b87-400d-70d66903e3d7@google.com>
Date:   Fri, 16 Sep 2016 13:49:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqq8turk3aw.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/16/2016 01:17 PM, Junio C Hamano wrote:
> In other words, wouldn't something like the illustration at the end
> of this message sufficient?  If the body consists solely of in-body
> header without any patch or patchbreak, we may reach EOF with
> something in mi->in_line_header buffer and nothing in
> mi->log_message and without this function getting any chance to
> return 1, so a careful caller may want to flush in_line_header, but
> the overall result of the mailinfo subsystem in such a case would be
> an error ("you didn't have any patch or a message?"), so it may not
> matter too much.

Noted. (This was one of my concerns - that the caller should, but did 
not, flush.)

> What am I missing?
>
> handle_commit_msg(...)
> {
> 	if (mi->in_line_header->len) {
> 		/* we have read the beginning of one in-line header */
> 		if (line->len && isspace(*line->buf))

This would mean that a message like the following:

   From: Me <me@example.com>
     -- 8< -- this scissors line will be treated as part of "From"

would have its scissors line treated as a header.

The main reason why I reordered the checks (in RFC/PATCH 1/3) is to 
avoid this (treating a scissors line with an initial space immediately 
following an in-body header as part of a header).

(If this is not a concern then yes, I agree that the way you described 
is simpler and better.)

> 			append to mi->in_line_header strbuf;
>                         return 0;
> 		/* otherwise we know mi->in_line_header is now complete */
> 		check_header(mi, mi->in_line_header, ...);
> 		strbuf_reset(&mi->in_line_header);
> 	}
>
> 	if (mi->header_stage && (it is a blank line))
> 		return 0;
>
> 	if (mi->use_inbody_headers && mi->header_stage &&
> 	    (the line looks like beginning of 2822 header)) {
> 		strbuf_addbuf(&mi->in_line_header, line);
> 		return 0;
> 	}
>         /* otherwise we are no longer looking at headers */
>         mi->header_stage = 0;
>
> 	/* normalize the log message to UTF-8. */
> 	if (convert_to_utf8(mi, line, mi->charset.buf))
> 		return 0; /* mi->input_error already set */
>
> 	if (mi->use_scissors && is_scissors_line(line)) {
> 		int i;
>
> 		strbuf_setlen(&mi->log_message, 0);
> 		mi->header_stage = 1;
>
> 		/*
> 		 * We may have already read "secondary headers"; purge
> 		 * them to give ourselves a clean restart.
> 		 */
> 		for (i = 0; header[i]; i++) {
> 			if (mi->s_hdr_data[i])
> 				strbuf_release(mi->s_hdr_data[i]);
> 			mi->s_hdr_data[i] = NULL;
> 		}
> 		return 0;
> 	}
>
> 	if (patchbreak(line)) {
> 		if (mi->message_id)
> 			strbuf_addf(&mi->log_message,
> 				    "Message-Id: %s\n", mi->message_id);
> 		return 1;
> 	}
>
> 	strbuf_addbuf(&mi->log_message, line);
> 	return 0;
> }
>
>
