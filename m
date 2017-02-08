Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A645B1FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 22:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751376AbdBHWY0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 17:24:26 -0500
Received: from mail-ot0-f181.google.com ([74.125.82.181]:34545 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbdBHWYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 17:24:25 -0500
Received: by mail-ot0-f181.google.com with SMTP id f9so124288643otd.1
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 14:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pkmt4GF1Wbssl0sueb33I4ZGbLS5O4a4msxVVTJybuc=;
        b=e7iyp/QmIr8sDAUyQq7JI/6lAHGEtxT0UGxQDX4q9McMVsA93EbVw94VQ6tVuBbG/E
         EJ05ogg1FoYXYozQ4/B9NpMViveJ5s6aTEjYrDP2lD1K7WHEK9rWe9rfEbogLBcOQhSZ
         YE0JmCExEj3K6UfTcu08X6fsoGP5/immsjup2uTb6bjTPKUOKNKujADQyWOKOvZ3GNS3
         /Bx559ld4kAbBq2hML3g1tidzz9aivUX3CCngAP4kkGt+QX+NGAUuu1NN6VZa2+L07zS
         5x0L8zYlEFCmaPOA3Erf4CCbe14wL+Hm1eHjburKB6xWTE7s6njiR38Dnjw5NnBq9imf
         VMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=pkmt4GF1Wbssl0sueb33I4ZGbLS5O4a4msxVVTJybuc=;
        b=eE3nBq2rMCO+eBuYok6It3f6M5eGXv7SbMMoGzlBSQ6IhDR2enBNOXbf2vJxmBBb6H
         ahdDMJOuzSvWHtv1MPrx/2Z9ebsN4G5pfDojWjMkc6YtOehkEfw8bEABov5LgJbhtBYp
         uJt6uH5xiNpYjp5pNRdKY7JRR74B/fVRyBZvl3mbH5Olpbx3y974dkpMgeKwTKzL46CQ
         b2/midLFPrMb3BQ7Ck/x0Xqk95HNCNg5U2WwK3/p4SQ48O/U7hGAiGH1E5dhMXaQ7ACZ
         V5xRUHt2JbA/umAfGTDu9sPCfdLSSVQ/zq+r9q3gLgtXmA6XUO8gHN5Sc7OsLTzMUSHA
         RVrQ==
X-Gm-Message-State: AMke39lqG1KtzbxakHs9D0AwmCZrOSgosBQQvIYM+s9xxq5Vjd8p0rY6GtQn+rY+nH7ewKOEE03MHTZrsNDpDA==
X-Received: by 10.157.4.141 with SMTP id 13mr13953094otm.243.1486592211167;
 Wed, 08 Feb 2017 14:16:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.63.13 with HTTP; Wed, 8 Feb 2017 14:16:50 -0800 (PST)
In-Reply-To: <xmqqk290uywp.fsf@gitster.mtv.corp.google.com>
References: <alpine.LFD.2.20.1702072113380.25002@i7.lan> <xmqqk290uywp.fsf@gitster.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Feb 2017 14:16:50 -0800
X-Google-Sender-Auth: kjYujy0MOWEr7jy-cq-D0HrEVvw
Message-ID: <CA+55aFycVda9LYtLuG-oBci1Q2-7TVx3jv0HRZzSP0gQsWvXjw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pathspec: don't error out on all-exclusionary
 pathspec patterns
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 8, 2017 at 1:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Thanks.  Even though the current code does not refer to the original
> prefixlen after the added hunk, I'd prefer not to destroy it to
> avoid future troubles, so I'll queue with a bit of tweak there,
> perhaps like the attached.

Yeah, I considered that. Along with just passing in a NULL prefix
string too for that case. Not that it matters.

So ack on that change,

             Linus
