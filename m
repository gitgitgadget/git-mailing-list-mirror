Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5275A1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 22:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932736AbcHJWTc (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 18:19:32 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33036 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932427AbcHJWTb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 18:19:31 -0400
Received: by mail-yw0-f193.google.com with SMTP id z8so2584654ywa.0
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 15:19:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=p83OcyQmU7Zjf2WNpFiIjZpZIq6goOzc9b8Eo0W2K7c=;
        b=GFSXyKviVxvBz1iAGC5YhdUtVeuJxXn9WX/HG1lMfJw5GJP0l04OwBq7o71tVidZmE
         n9Borgmar8qqbm/GZ2kNHQRJSEMbJwrBWDGXJnrI9Km/n4dF5keUV6POiUfvEkEu5YOB
         WH9itAcMRxzavSthJnzv0/qEuQehvMIM8Y/FOicu9WLxYkLi9LNY8cGBxYCJubSqcTfN
         AeS9XWUu1UxJ/YE3o9fGf9RH5PqGTpl70080BrJt+AdpVgBpUFZDsTWK4bXa5ZDkDE/o
         O/f+0fQOTp3UiEVtz1+ags0Qebo/LPtG2b1v0T/vMVKSnx+E/GvsuqeRpoDAuTHL3QWi
         RXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p83OcyQmU7Zjf2WNpFiIjZpZIq6goOzc9b8Eo0W2K7c=;
        b=i2oUpY806hc49+tf0mXK2n0Ap9sNNPhI6h6Xbo4aIdO42/7x3fjuWidNCnGdiIj4cB
         LKnJhC45jZl9sgDzfoQA2eEXXLdOk39LPHbyDc/TW49VDsuJdPK5/N2zQU4bPEhgX/u2
         OXby9brZNLdAftXUskpv/VJwLbxvjYBzOgvRe9ftdxdRj/tbJ23sTm0u4jeGKiInxCug
         bhMxhrLR2Z+GwQaeVsq6GDJPIAyWI9JxID+CpBhhMNK2S95hiBt7cCrqkC3p8U5qeeEf
         cO9rqZd3PG3m6qZURbQZxq/hmqvdnDYFttCPX/suFtWzt7i7LU6tH4X+NjdS5CAukkx0
         FUeQ==
X-Gm-Message-State: AEkoouukTDybq7qZXdC3QyFB74kdkI4eKkvuTbWWQNJOZV0kXCjEVQKP96HQvht3x8qGX52+bx0t+Vtimilq5g==
X-Received: by 10.129.152.88 with SMTP id p85mr4184404ywg.261.1470867570914;
 Wed, 10 Aug 2016 15:19:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Wed, 10 Aug 2016 15:19:30 -0700 (PDT)
In-Reply-To: <010201567675adc1-17e27495-6b36-40d1-836d-814da029fcc4-000000@eu-west-1.amazonses.com>
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
 <010201567675adc1-17e27495-6b36-40d1-836d-814da029fcc4-000000@eu-west-1.amazonses.com>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Thu, 11 Aug 2016 03:49:30 +0530
Message-ID: <CAFZEwPNMOE4yBu8mRfYNW=w2FbkC03=C2W44TxUC0TF9sSx46g@mail.gmail.com>
Subject: Re: [PATCH v12 01/13] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
To:	Git List <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Here[1] is the link for interdiff. Sorry could not send a cover patch
or put it in here. I am under a proxy which blocks IMAP/SMTP
connections and gmail wraps the lines.

[1]: http://paste.ubuntu.com/22794990/

Regards,
Pranit Bauva
