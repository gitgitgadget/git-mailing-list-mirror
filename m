Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEB801FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 18:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752987AbdBNS6t (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 13:58:49 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:36773 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752967AbdBNS6r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 13:58:47 -0500
Received: by mail-ot0-f193.google.com with SMTP id l26so4811839ota.3
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 10:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SJGlQpmyDvpCvgEfG1aGNbUoqNdPOeuu8khfrJc3Qtk=;
        b=MjLb6gRhDp5dhFIMqx+JQ8Z8HhHCskcNp8U369np2sYBHCkWMDKuiQe55Z4yJVUCxu
         U0A5HF0HQhT3g4Az/8TsJgxCVjPcvw/Bofxz83vn3w6HPZ0E3cogFgkplh0K+RUNDuRY
         DzENfwOts/XwbgZ+taAd9prSgxfZSDeOsEW/BVpQU024jkJowRBgxz6MnJCGbBgloZNV
         oIexBtZMVyChnfvz3m5ggHnhG3G7Am61vSfxHDswmqkvGIsBBPcVAnqBrnkUVU/+i0CC
         nWSSgkCrC1azqf6CjaKeG0WH/cMKtWOy/BCwXKigI+KEh8Ai4HO2vGS/1IfKCooC6Kdn
         PFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SJGlQpmyDvpCvgEfG1aGNbUoqNdPOeuu8khfrJc3Qtk=;
        b=dKxn685Wr9iPQydmZSQjrnCIBEk5w8tt0fpl/pV1Ofufqf5fKTFFbRrkIg5A5/OeCT
         DnGAP9rUHyyG1nlvLlJ3F9rhyjiDki9tbuKu0wvuKKxOC9g+yJqkA5GIYEEAfpbAgDUh
         ipScH4wKP48mgeT2psggIwvbxK1b0Ebg1u4UX2PFbFl+/mrFn76ypL0V1RFfY+VjH8e0
         h8Zi0vogSQ1MoPxikOk+zlnkuPUXPP5S0v3nojHd4Cgn58oAZVyOOIfhNe0tWj5YLbjv
         xu72MM4Qp5xOAK+OujG8V78zvnSFlYLjqfeU8dnhBEbNP15KsWEP401WhFFoD7fwGx7m
         al5w==
X-Gm-Message-State: AMke39m/spE7Cq+UiwcHhs9A1FkMLI8xxIbDhDPyP2bfbx+pXg5FV1Fr98wOMoj53VKMTQ==
X-Received: by 10.99.8.4 with SMTP id 4mr33895307pgi.204.1487098726921;
        Tue, 14 Feb 2017 10:58:46 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:2447:f72c:8fdf:75c6])
        by smtp.gmail.com with ESMTPSA id q7sm2669977pfb.98.2017.02.14.10.58.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 10:58:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] mingw: make stderr unbuffered again
References: <c88612da0a62bfcbc3e278296f9d3eb010057071.1487025228.git.johannes.schindelin@gmx.de>
        <xmqqlgt9btrv.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702141545380.3496@virtualbox>
        <ef8549ea-7222-fdd0-739d-855ad428e39c@kdbg.org>
Date:   Tue, 14 Feb 2017 10:58:45 -0800
In-Reply-To: <ef8549ea-7222-fdd0-739d-855ad428e39c@kdbg.org> (Johannes Sixt's
        message of "Tue, 14 Feb 2017 19:45:28 +0100")
Message-ID: <xmqqy3x88uqi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 14.02.2017 um 15:47 schrieb Johannes Schindelin:
>
>>>From my point of view, it is not crucial. The next Git for Windows version
>> will have it, of course, and Hannes is always running with his set of
>> patches, he can easily cherry-pick this one, too.
>
> The patch fixes the problem for me here.
>
> I am a bit hesitant to call it "not crucial": The symptom I observed
> is certainly not a show stopper; but who knows where else it is
> important that stderr goes to the terminal earlier than other
> output. As it is a new regression, it should be included in the next
> release.

I tend to agree with you on the "not crucial" bit.

I applied the patch with "Tested-by: Johannes Sixt <j6t@kdbg.org>"
on top of 1d3f065e0e ("mingw: follow-up to "replace isatty() hack"",
2017-01-18), which was the tip of js/mingw-isatty topic that was
merged to both master and maint during this cycle.  Unless I hear
the "fix" turns out to be undesirable in the coming few days, let's
plan to merge it to 'master' by the final.

Thanks.

