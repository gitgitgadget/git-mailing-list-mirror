Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1046207EC
	for <e@80x24.org>; Wed, 28 Sep 2016 06:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750781AbcI1GmB (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 02:42:01 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36017 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750719AbcI1Gl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 02:41:59 -0400
Received: by mail-qk0-f195.google.com with SMTP id m184so2233326qkb.3
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 23:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DO4zSdEI4uFXOTcgtZQPWB0p7wlozOKfP9J+3Nsh960=;
        b=Eln1vONwwuYE9Yy4lxmnbKuTFgZJi8bB0FBX6YRqewe3urTv556dnAMWNGbFJraYTw
         VMc6+pD1qwW5VaBmrI3T5j+iH0t9XKB/BGAWK11MjnFlE/xAkQxEoFA6kvDlPR1UTC1b
         XJ5p2riDe6a+VcSIhM8ruxqrPkigBaPqaAgCDvrEg6ScYAN5TPgbcrlVM0w0gyR7mCJd
         yG4eqkejC0kekeY7Wy9MAc6XCnoNBAln8jZzcGsLPxZzGMMiH7PHwAEBMq0Yr9DXOxQO
         gYVvj2bl39HZl4vEeppUwyyTJDegCAbAnYwYlor/6YRoVrXF8tLWK4Tnzd5XsB0U5eA8
         bSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DO4zSdEI4uFXOTcgtZQPWB0p7wlozOKfP9J+3Nsh960=;
        b=VK5BMRLktDjt2QbeHmhfgeIpsLoTWF64dcDdukwcQsdvKyi43SqGbakfO9hIpr2iGK
         L6VU+gGCJa78BVu+tUJ3z5n15DJmdG3HLSmvfnvjRM4lEumtU0PcH0QAMY3w7+TcW2UF
         edg5tpMuRLLAZ86rsavGw2X2Ef1CeTVx4mfhn9bgQAZdRe4AtmwxqHIHlNSjaGa3LnZe
         g31C61zJPkiVOT5rXrxzciFKNjizb4StT/KT/IFOJvq7npRWMXEagOUfDdmps2Ycr9FM
         LmKfyhl6DhTAaMw7DouUncwCa6J5KhgaUucZTnsGH5usWYSYsR0ALLY34kkGwPQ3FHBP
         u+ZA==
X-Gm-Message-State: AA6/9RnNFcHUma5Qr6JYsMji/LzEEWKEwmYU3AhRIc5DeKUXG0gtH0ep23m6rU0icWkS1Q==
X-Received: by 10.55.169.65 with SMTP id s62mr53958qke.105.1475044918791;
        Tue, 27 Sep 2016 23:41:58 -0700 (PDT)
Received: from kwern-HP-Pavilion-dv5-Notebook-PC (ool-457850cc.dyn.optonline.net. [69.120.80.204])
        by smtp.gmail.com with ESMTPSA id w35sm3217035qtc.24.2016.09.27.23.41.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2016 23:41:58 -0700 (PDT)
From:   Kevin Wern <kevin.m.wern@gmail.com>
X-Google-Original-From: Kevin Wern <kwern@kwern-HP-Pavilion-dv5-Notebook-PC>
Date:   Wed, 28 Sep 2016 02:41:56 -0400
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kevin Wern <kevin.m.wern@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 07/11] Resumable clone: add resumable download to
 http/curl
Message-ID: <20160928064156.GG3762@kwern-HP-Pavilion-dv5-Notebook-PC>
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
 <1473984742-12516-8-git-send-email-kevin.m.wern@gmail.com>
 <xmqqfuozihuv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfuozihuv.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 16, 2016 at 03:45:44PM -0700, Junio C Hamano wrote:
> > @@ -1136,7 +1138,10 @@ static int handle_curl_result(struct slot_results *results)
> >  				curl_easy_strerror(results->curl_result),
> >  				sizeof(curl_errorstr));
> >  #endif
> > -		return HTTP_ERROR;
> > +		if (results->http_code >= 400)
> > +			return HTTP_ERROR;
> > +		else
> > +			return HTTP_ERROR_RESUMABLE;
> >  	}
> >  }
> 
> Hmm, is "anything below 400" a good definition of resumable errors?

Definitely a rough definition, but I think it covers the majority of cases. I
based this on the fact that my example resumable errors (disconnections during
download) either had results->http_code set to 206 or 0, and that http errors
generally indicate some underlying issue that can't be solved with a repeat
request (there are plenty of exceptions, such as 503 or 504 errors that happen
intermittently). I thought that was enough to be a placeholder in the model. I
did consider something like "has (the file changed size or http_code been
206, some indication of success happened) in the last [x] attempts," but I
question the precision of something like that, especially before exploring
other tried-and-true solutions.

This patch is definitely the sketchiest part of my series, IMO. The concept
isn't fleshed out enough, even theoretically--containing only the element of
retrying with some very basic components to those decisions. I think that this
will ultimately require fishing through other examples of resumable downloads
(which was very painful to read when I tried). I know curl has a --retry option,
but doesn't include it in libcurl...harumph. I'll probably try to read that
implementation and chromium's resumable download code again.

I'll get back to you with a better plan here once I read through a few
examples.

- Kevin
