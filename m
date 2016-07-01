Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88CE82018A
	for <e@80x24.org>; Fri,  1 Jul 2016 18:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbcGASD1 (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 14:03:27 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:34017 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbcGASD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 14:03:26 -0400
Received: by mail-qk0-f169.google.com with SMTP id t127so214936401qkf.1
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 11:03:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=m7heY53X2igBveLKurtb84hGU/Pkx5yh+1W/sTmumBQ=;
        b=m8zM9r7528kXrt/EYCr0DcAkndkCvaZ5+rfp4ZGWYld3skQ8NCUOLaJxfiKtm99gFs
         pL5ZgnUP7l1RNrt016EQdI6aNDZJ04PM/ld3GNsuIYqh9JxZ6EwdrpIxN8WCMU9MvuXK
         KTbwmFteM6QCGs5e0qUpU7w+hfup/vDcAPckt6F1TwHDCvnnjOJmMuM9BP4SZxwGIgSz
         Ay3vHrRahpt8Ee18TTGPvT5ZMnnWgcFKXUz0cC1WWXZnbMt9ntXBEOeDR2zQJw7Yt71t
         36rplME/rJ52NfHJ166lNjmlfxkxJQh/f1zKBDTrWY99shd2b9yuMcQosJKS1/JqEG0T
         TutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=m7heY53X2igBveLKurtb84hGU/Pkx5yh+1W/sTmumBQ=;
        b=Fmk9i1wnG3IC3ozE5RRi+anf3Qj0St5meAELLxt0LBqK67azBu5Qs1B5s678zdtCf4
         e1pllM7SDdOkdjOWKPBy9INfTi4eSWKtQkRlMoMUTsOXQaDb549/LymgVAT2X1g9v42E
         qb+FDZg0L8txYuIpglsbDzJUudlaODD0TeOlha22Bw/vXy1bo+96uGMH8HGM7EHqbC7T
         eyxLPPdjleSM6zY046WHBS7DB0/bG0lU1BgGFAAX5+PH9mX5kSHHhOg/TTJndvHjaoxA
         hUq+eKul9p/LI7Gc3ubmHXDyaB6LOspNFNUNi3YWE/oVJGWZFHf/y1Cyx6BybeGAWq6P
         oIlA==
X-Gm-Message-State: ALyK8tLAOL5n3nN5h+RccWGvXHgR36DVgRO4jZWarN74GmprRAxcu7YCkLNMNZLLuMVk+xDPVkxc3TNn618edA==
X-Received: by 10.13.215.6 with SMTP id z6mr2166820ywd.275.1467396205386; Fri,
 01 Jul 2016 11:03:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.251.71 with HTTP; Fri, 1 Jul 2016 11:03:06 -0700 (PDT)
In-Reply-To: <20160701175950.GB16235@sigill.intra.peff.net>
References: <20160630005951.7408-1-sbeller@google.com> <20160630005951.7408-2-sbeller@google.com>
 <20160701071410.GG5358@sigill.intra.peff.net> <CAGZ79kaDCLm3BBURJKfkYWKKvozkFTGCn0wGiQCtspUvtQBd+g@mail.gmail.com>
 <20160701175950.GB16235@sigill.intra.peff.net>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Fri, 1 Jul 2016 11:03:06 -0700
X-Google-Sender-Auth: SZHwA2tEtBR63U92K-Sojv3RZgs
Message-ID: <CAPc5daWjSW5KM4uUyEBbb+765t50+dUsewF52uPrCiT1HW=NAQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] push options: {pre,post}-receive hook learns about
 push options
To:	Jeff King <peff@peff.net>
Cc:	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Dan Wang <dwwang@google.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 1, 2016 at 10:59 AM, Jeff King <peff@peff.net> wrote:
> If you give up on having multiple incarnations of each variable, then I
> think:
>
>   GIT_PUSH_VAR_foo=value_for_foo
>   GIT_PUSH_VAR_bar=value_for_bar
>
> is quite elegant, and easy to use from hooks. It just cannot represent
> multiple such "foo" variables.
>
>> If we did not have a GIT_PUSH_OPTIONS_COUNT and GIT_PUSH_OPTION_<N>
>> but rather GIT_PUSH_OPTIONS_VARIABLES that contains the other variables,
>> it may be easier to handle, but whether you read from a file or evaluate the
>> environment variable is only a minor step, the indirection is there anyway
>> and this would be very close to what we have above.
>
> It makes the server implementation a bit uglier. You have to create the
> temporary file, and you have to clean it up. What process is responsible
> for cleaning up stale files? Obviously receive-pack would try to clean
> up after itself, but what happens when it is "kill -9"'d, or the system
> goes down, etc? We clean up stale tmp files like tmp_obj_* in git-gc; I
> think we'd want something like that here.

It still is not clear to me why the option to pass _COUNT and _VAR_<N> is
rejected.
