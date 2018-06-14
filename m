Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 582CB1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 16:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755295AbeFNQHc (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 12:07:32 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51160 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755069AbeFNQH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 12:07:29 -0400
Received: by mail-wm0-f68.google.com with SMTP id e16-v6so11486650wmd.0
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 09:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HceV3XgryDFM2GnBCIrS0PgZJkcJGb9TcIZ5w9bm+88=;
        b=Ht9NsbbzNsdXMc7MN0Vg4odgGPo6AV1y18eGVNvJumxHyqTV3W3fZg3pVulKd3z7m5
         FkpETI240/RFw7PkUMWqU/nguHSLKkDbOJruJos9akH+iYnEndclLxYZPLJKs5aSaaJl
         ILhZmhC0HUNct6Yp/qKEFGRHIn8LBTttD9zfiRhhHcXa5oJS3mO7febZUWtREjOpcVxa
         65hNOtrui+6BH4Qoisbm2znKlCaChX1KGAFTIb8e6VDCThb+b6f6FLQOxIGZWPxU03wj
         5huIqjQcec7q9tCYviEA7e7W0sr3O+eCYbZz1oUgVQmlrk3gNsYEh6czwxLLWK4aSw0I
         Us8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HceV3XgryDFM2GnBCIrS0PgZJkcJGb9TcIZ5w9bm+88=;
        b=twd6mP9K3MaQtin7JAVjcBd9xFSoFPZLS8MEiDI8Q2Wa3YOwM4E6eo9vummWwzVWku
         VOPEMqNBDXuKxImfyC5BbksOHvxtMElSgDJd+4lXC5AyS8BLOEeqoPNVNZ1h9y8rj33/
         LHG0PvmT5z7VHUpYSs5EciHLgKz2SqQ/+qI4+hhc5pjsagGfq9ltS2dQweg9O1MtSAfA
         JB/ymm9hfHgXCxLW3Cy3tPCmFomzaTuWh0UnJ68QTpisRnTB5b8+W2HPKblZheHBM4Y3
         ymLKtM42ewXl1dkw9RgAJ0WroVObAu/hgVMsP+6vb+52UzKmZaJR/4U7HWVESc68YCNY
         8waQ==
X-Gm-Message-State: APt69E1woetANl9vOAISi7qtfyTHZqh421aVRUMMspOtrcUmp67Gof9H
        DDn0LObwhvM5nSyEtez6MAo=
X-Google-Smtp-Source: ADUXVKLM2j4YCVKoSErQT2OyMHpZYY+lB5g4WvInoA6I6P+JZrw/nqF7S0255VV+FUUpLjDax6NYRg==
X-Received: by 2002:a1c:d650:: with SMTP id n77-v6mr2548573wmg.140.1528992447885;
        Thu, 14 Jun 2018 09:07:27 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d15-v6sm2066483wmb.0.2018.06.14.09.07.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 09:07:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Takuto Ikuta <tikuta@chromium.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        <git@vger.kernel.org>
Subject: Re: [PATCH] fetch-pack: test explicitly that --all can fetch tag references pointing to non-commits
References: <20180612185413.GA21856@deco.navytux.spb.ru>
        <20180613111840.1427-1-kirr@nexedi.com>
        <xmqqbmce7fcm.fsf@gitster-ct.c.googlers.com>
        <20180613184301.GB22854@deco.navytux.spb.ru>
        <20180613210509.GA15574@sigill.intra.peff.net>
        <20180613231147.GA21025@sigill.intra.peff.net>
        <20180614052455.GA2861@deco.navytux.spb.ru>
Date:   Thu, 14 Jun 2018 09:07:26 -0700
In-Reply-To: <20180614052455.GA2861@deco.navytux.spb.ru> (Kirill Smelkov's
        message of "Thu, 14 Jun 2018 05:25:02 +0000")
Message-ID: <xmqqzhzx4aip.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kirill Smelkov <kirr@nexedi.com> writes:

> Jeff, thanks for corrections. I originally tried to look into invoking
> "git tag" two times, but since git tag always creates a reference it
> would not be semantically the same as having one referenced tag object
> pointing to another tag object which does not have anything in refs/
> pointing to it directly.

Well, then you could remove it after you are done, no?  I.e.

	git tag -a -m "tag to commit" tag-to-commit HEAD
	git tag -a -m "tag to commit (1)" temp-tag HEAD~1
	git tag -a -m "tag to tag" tag-to-tag temp-tag
	git tag -d temp-tag

would make the temp-tag object reachable only via refs/tags/tag-to-tag
I think.

