Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28379207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 22:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759957AbcIPWgO (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 18:36:14 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35790 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757939AbcIPWgI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 18:36:08 -0400
Received: by mail-pf0-f174.google.com with SMTP id z123so31216887pfz.2
        for <git@vger.kernel.org>; Fri, 16 Sep 2016 15:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Y4ZcZeeweA2oPDDrtdN9BiVS52X1Amo5FkID/7eznlY=;
        b=EakrX3wzpmBZNuBaKG7soAeUEee58z1SyKguwWzyExWfwnuFXZmnVaassEj3hJza1i
         BifMvpF5duZvxe+L71iiKEQAB09Bqr4+u9ZWd+QGr3EDbsP/pgjGeUv5C+i6qeqzZUwd
         OAR/FX5mOUWgp//Kz8DV5imuSPHE98uBEb05OmE3v5DZJi7GKNSYThfB9NPgg5IFoEwy
         +Wou2oZGTBOJve4h1v2XpmzO7ZpJ5b/9H1kwemcQyM/qYjQnIJA7cqZj51luroYMVMAd
         4oXQJX+tJIcIZdnrkvFQkXIU5GfsUDmx6RBwJ5rTXB5YWONvo4wkSRW/O4mApvopktPD
         BL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Y4ZcZeeweA2oPDDrtdN9BiVS52X1Amo5FkID/7eznlY=;
        b=QF99lx5sf+D7WN8nQOpPNIOotjZHlYP59iHhBNRIsfIp77EhXylrgwOJfEmsvb1Zcl
         pB0GpTLxqkHDrDoLJ5+1wBFWjNitgq4dJML08MiVFIiFdBtoK0zsAf6+Mx3MwfR3vwHO
         f8TbiPcrXGYFOJ9XYooGTIqkdcEFSWwOXuV2QQJcNTC27CQqPY5KsxdDUh2eibnI4tSG
         OsHvb7C7xpKAKjEMp+d2W4An+UUPOTZI/HiAITWZi0kDLJppEWDMcRrzFVC9nYzJJVaQ
         EPbHSEK6yoMmiGpQTk1Ra5K7s4+lmYqC4aZAhr9QTFYY+OGFIkU5MNjKeVz5phjETZuE
         DcQw==
X-Gm-Message-State: AE9vXwPoeAlHS5yG8GrDFQbWVf+gVHLZaWtRvjgKTXseCNM997BKz5eAmjBbR/5kz02ULctg
X-Received: by 10.98.30.133 with SMTP id e127mr26698942pfe.104.1474065367672;
        Fri, 16 Sep 2016 15:36:07 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:c82e:43dd:7495:3b10])
        by smtp.gmail.com with ESMTPSA id c64sm54436419pfa.51.2016.09.16.15.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Sep 2016 15:36:06 -0700 (PDT)
Subject: Re: [RFC/PATCH 3/3] mailinfo: handle in-body header continuations
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1474047135.git.jonathantanmy@google.com>
 <20160907063819.dd7aulnlsytcuyqj@sigill.intra.peff.net>
 <cover.1474047135.git.jonathantanmy@google.com>
 <0152df30db0972d61ff45b2b099ad1242aacd431.1474047135.git.jonathantanmy@google.com>
 <xmqq8turk3aw.fsf@gitster.mtv.corp.google.com>
 <1b392241-461e-3b87-400d-70d66903e3d7@google.com>
 <xmqqshszimrh.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, peff@peff.net
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <128036e3-47b4-b7ae-034f-8d227a62729f@google.com>
Date:   Fri, 16 Sep 2016 15:36:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqshszimrh.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/16/2016 01:59 PM, Junio C Hamano wrote:
>         if (mi->in_line_header->len) {
>                 /* we have read the beginning of one in-line header */
>                 if (line->len && isspace(*line->buf) &&
>                     !(mi->use_scissors && is_scissors_line(line))) {

Minor note: this means that the scissors check appears twice in the 
code, once here and once below (for the non-header case).

>                         append to mi->in_line_header strbuf;
>                         return 0;
>                 }
>                 /* otherwise we know mi->in_line_header is now complete */
>                 check_header(mi, mi->in_line_header, ...);

(Sorry - should have also noticed this in your original e-mail.)

I'm concerned about what happens if check_header fails - we would then 
have some lines which need to be treated as log messages. (At least, 
they are currently treated that way.)

To treat them as log messages, we would need to convert them into UTF-8, 
which may possibly fail, so we would have to figure out how to clean up 
(we have to clean up because we cannot `die` immediately, at least to 
preserve the current behavior). Also, we are likely to detect such a 
failure only while processing a subsequent line - this non-"fail fast" 
currently is fine, but I'm concerned that it will hinder future 
development (especially when debugging).

Minor note: the buffer would also need to be more complicated (instead 
of the current single buffer), either:

o store newlines in that buffer (and we would need to remove all
   newlines before passing to check_header), or
o 2 buffers: one with newlines (for log messages) and one without (for
   check_header).

In light of the above (multiple scissors checks, late detection of 
failure, more complicated buffer), it seems clearer to me to just change 
the order of the checks (as in RFC/PATCH 1/3). This necessitates holding 
on to the old un-decoded buf and len, but this seems easier to me than 
the above.

>                 strbuf_reset(&mi->in_line_header);
>         }
> 	...
