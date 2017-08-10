Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAE0D208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 18:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753332AbdHJS2z (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 14:28:55 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:37810 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753133AbdHJS2y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 14:28:54 -0400
Received: by mail-lf0-f44.google.com with SMTP id m86so7090907lfi.4
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 11:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vfg+bW16PbvyEI+2jV+RAHk9AtObTPsM07SeKnrIUlE=;
        b=JFYWwXweotoDp9B6JLXGVW1Tmxz0j8BBv4X2u8kgYmPObzycDnF0ycTLIvYGkcUAqR
         P2aDQxuY0/fRtIdeo4/Wy+f6/qHBvPBATTj8Rn6st69ssds5YPe2VHPj4tHWAyupej/D
         uoB4xYO5/6AuhUSlwY3hAO3AmCoGN4LKP2WUCq7rj8rUhbqldOQg6EMsfUUfCOPgzfhQ
         DY0Mc7Rrzhgwl4+Y/nYowoPKGdK7ib8XjKvAWVXz7sXegSV8Z+hvdgm++zRELthvVbFT
         6Kwk06WqdrFdhsc6iL5mg/vGLMnosT6lvD0xQ0EOnQn9f1TC1J3iWWzoFlU+FrBZT6h5
         vrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vfg+bW16PbvyEI+2jV+RAHk9AtObTPsM07SeKnrIUlE=;
        b=uW12IF8RijutApQTq8pv9OBPhvEDuEZTuWoAohFdZM5Z63uGrjUSid0gSE1dJCbgxx
         nir369oYUgptVNXQcM8pKyUxkZNNzgudtPadm6RynmpUnp1LFnK22L0IAKqcJ/a2bx1j
         GFsV7utOTmXClPL8v5hmCjXvfLP5WlDsGyDWxvX/iEucHXJrlge28d2M37iVQ+zmL1Gk
         hzfdIMDBI553QbKccXDY4JOzL4ifp9VYFiE0wNcHWjj1mjQuKQNlDI7GTB0QrwsBxZSj
         lzYbrGVmkXEUFkUsBTauy1VWDb6cDEK//N5MDynHmW9bLGcRNTMlfHyg4EoLov9dX1SI
         ysog==
X-Gm-Message-State: AHYfb5gExBauLn7LWBHEsU+OvifkyHMzrM6SlnXceAxJI8nsjqNJW0rr
        2nImxq1k5vhukFj89Gm8hsnv1nN4Q1xY
X-Received: by 10.25.20.68 with SMTP id k65mr5741978lfi.260.1502389732885;
 Thu, 10 Aug 2017 11:28:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Thu, 10 Aug 2017 11:28:52 -0700 (PDT)
In-Reply-To: <20170810180404.yg3jdzhquregh4ta@sigill.intra.peff.net>
References: <20170810180326.4kkmawywvdbuzwnp@sigill.intra.peff.net> <20170810180404.yg3jdzhquregh4ta@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 10 Aug 2017 11:28:52 -0700
Message-ID: <CAGZ79kZY1ifks_TAniR+diHOKWVQpRVFeS=XEBGW+7LT=Js5RQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] interpret-trailers: add an option to show only the trailers
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 11:04 AM, Jeff King <peff@peff.net> wrote:
> In theory it's easy for any reader who wants to parse
> trailers to do so. But there are a lot of subtle corner
> cases around what counts as a trailer, when the trailer
> block begins and ends, etc. Since interpret-trailers already
> has our parsing logic, let's let callers ask it to just
> output the trailers.
>
> They still have to parse the "key: value" lines, but at
> least they can ignore all of the other corner cases.
>
> Signed-off-by: Jeff King <peff@peff.net>

Sorry for a sloppy review last round, upon reviewing
I found another nit.

>
> +test_expect_success 'only trailers' '
> +       git config trailer.sign.command "echo config-value" &&

You may want to use 'test_config' here, which keeps the config
only for one test. The subsequent tests seem to overwrite the
config, so this is not wrong, just not the best style.
