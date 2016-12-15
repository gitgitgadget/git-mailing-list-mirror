Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42DDB1FF6D
	for <e@80x24.org>; Thu, 15 Dec 2016 19:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753784AbcLOT1E (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 14:27:04 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:35670 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753733AbcLOT1C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 14:27:02 -0500
Received: by mail-qt0-f179.google.com with SMTP id c47so66820264qtc.2
        for <git@vger.kernel.org>; Thu, 15 Dec 2016 11:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=66OkkHWHoM5RDGtQNGs3CQ2a42RSSFePT2PvU9CmGss=;
        b=QJP1mgkczQauAs4rbdMo6ttKzYA0WXEsrZiPgRnI6C+CLJTXCf6cdmHQ3XASDT6RCr
         zuEc9SN0nwLxaCAAcM/77gJl0EhtqrQDhwkfZnG8XbD053o7ePjLgtEPSai+/+k6UzE1
         wNfqdD+aR0l0hh4kcTAYeLAyt2+L+rjd+CetKMVa60VXyjBVoN9jmf2v75/AeKwy9Vn5
         y2iQpjya9qJYUchbKLKgW8JTvYLn2QHVUNojqr5FG4kzb0ovnooXbraDnms+NuPscfhe
         CJfODFJZstc9qh6MfbnjwFH1pfPUCoYmbU27jc+fUO+RW4gqHpI08jePsEdQVmzeWElY
         Ulcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=66OkkHWHoM5RDGtQNGs3CQ2a42RSSFePT2PvU9CmGss=;
        b=nx5v5RJA9zTDYzmE7kv4p3itGYUbOx0cxarCwpVp2FjWDmik2kaGlnqkZhMQ7/vOh/
         zQDdhu3ViU6kA/7JUs3uY4hcd+B3Sse42yCdPnw2IntTAfms4B0uxswkDn9Wg2CUcbeg
         6W1EttHTSKq5ZiDJekbiI0ToxJ+141YJNezgchXOlccbVIW5/cfksjPEMyPr0ROgPWEb
         wUs6VN3WucOPbLapXC5BJd2pKnms44LLPjcBsLud6aVGOWvvLYqMIwC9fGq/3MFwS6Qf
         T9mH+dAubtfvn6cEEp+qu/ed/PycKWA4SHPyFjpIdE9daWOk/eHmw6gHr+gsSxDUOo9k
         WBIA==
X-Gm-Message-State: AIkVDXJblmoW4oXYMqP6CwqM9FViT8sgZhkC0gMj+jOXp6c4KlwGmnW6FJtWS40osbToxrmW8ojlWBGnHvdJR/tg
X-Received: by 10.200.42.232 with SMTP id c37mr2107518qta.145.1481830021702;
 Thu, 15 Dec 2016 11:27:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Thu, 15 Dec 2016 11:27:01 -0800 (PST)
In-Reply-To: <20161215192016.qhbcyo7vb7petuwp@sigill.intra.peff.net>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
 <cover.1481642927.git.johannes.schindelin@gmx.de> <ae521f75a105c6b9e54595d68bda3c5b62f313b6.1481642927.git.johannes.schindelin@gmx.de>
 <20161215190351.as76panrcz5rgibj@sigill.intra.peff.net> <CAGZ79kZ3i-eoxMsVMsb+VBtEVQf2-Fovh_YM5NBN2pSOBHajBg@mail.gmail.com>
 <20161215192016.qhbcyo7vb7petuwp@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 15 Dec 2016 11:27:01 -0800
Message-ID: <CAGZ79kbebNRJq11sv9O9+dmRsFKF=70skd=zdgL5jkqD_1b3Zg@mail.gmail.com>
Subject: Re: [PATCH v2 07/34] sequencer (rebase -i): add support for the
 'fixup' and 'squash' commands
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 15, 2016 at 11:20 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Dec 15, 2016 at 11:07:34AM -0800, Stefan Beller wrote:
>
>> On Thu, Dec 15, 2016 at 11:03 AM, Jeff King <peff@peff.net> wrote:
>> > wonder if it would be helpful to send that output to the list.
>>
>> Sure we can try.
>>
>> Another project I used to run through coverity (Gerrit), shows
>> similar characteristics w.r.t. false positives, so people complained
>> when I was force feeding them the niceties of static analysis.
>>
>> I'll just try to set it up and see how the mailing list reacts.
>> (Not sure if you can just add emails there or if the email has
>> to be verified or such.)
>
> I see you added it, but I don't see the confirmation email on the list.
> I wonder if it was HTML mail and vger ate it.
>
> -Peff

I think I'll setup a dummy gmail account to use for subscription
and then I'll configure that to forward all email from coverity to the list.
(the actual complaints about memleaks etc are plain text, so that
forwarding then should work)
