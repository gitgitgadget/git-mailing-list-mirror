Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D18FB1FCA5
	for <e@80x24.org>; Fri, 30 Dec 2016 00:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbcL3Ahc (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 19:37:32 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:34434 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbcL3Ahc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 19:37:32 -0500
Received: by mail-qt0-f170.google.com with SMTP id d45so162680962qta.1
        for <git@vger.kernel.org>; Thu, 29 Dec 2016 16:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1tJq9tqCCQ6hq4xX2OFjR/bAx+R/CisySf0I+R3CFkg=;
        b=RZdovvz9qp9+k4bTWOLrcZkt6QGHLf3BibQ7g4z2AaJbipO7etFUDpaBHTW6MMERB1
         8zIRSl/FiH31XI5MEuRPYFplZ32rRHuvPsnui/1k87W+3UmgzwdC0wjYdHPkPaCiWJ/Q
         VOeUmVb2orTAJhKk8GIK3ZqZAwS24/xMpsdk3WP5R51WD0PLU0M7w7kiJ3Spzn/EBUNk
         9FWFl5qpvtrVNnpxeq+orsnCVh3msrKSihST4w3iCDVLHWdfTItBKdG2EBLUGbo9/Qz4
         dPguqPcrneI13no1r9K0TPWafVAeURm/Dxh5DseYr1KtPY0B/n2uXJVmbGYNe6cVCNJ/
         4frg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1tJq9tqCCQ6hq4xX2OFjR/bAx+R/CisySf0I+R3CFkg=;
        b=UbPdgcghn9smE/Tc3oRprEk/SC3KEnubyJB4cc5Yem89lQIpK6qkt93IrNFp3JNLzY
         DcB57SE7i6AyzGIHx0CBKTLo2/8AcwI3jofE2QdmXRIDoqI0CePskFFhKFAiUPyFtYwk
         +c0AE+qjJ5jr3iPxJzIUCYIwB5WvygxwK7YjsQ4npokD9sLVWARqdS7+S3LMHVq2XzhW
         C4H+vcIIXiSNGUCVlCSNxqIAVCCDPCtVcxNCXc97TFDtkiDV+MepASx00ABFtqv+Uf6B
         3IVnPvwxl4sYgxne45L5ErP69il6mFtItLY/xtmX6KuH0O7xbQ2DOegKRnYJzibEJhCg
         nT/g==
X-Gm-Message-State: AIkVDXJ5VEXIM7Ivtg6QLRpVHIff6S+b7AsYL0KU7AL80YA5FbBKXR/dAPiej4qPDvk0Nlpw4SnsiIOCRCZOuVlK
X-Received: by 10.200.58.65 with SMTP id w59mr38980105qte.54.1483058251174;
 Thu, 29 Dec 2016 16:37:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Thu, 29 Dec 2016 16:37:30 -0800 (PST)
In-Reply-To: <20161230001114.GB7883@aiede.mtv.corp.google.com>
References: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
 <20161020062430.rxupwheaeydtcvf3@sigill.intra.peff.net> <20161122004421.GA12263@google.com>
 <20161122024102.otlnl6jcrb3pejux@sigill.intra.peff.net> <20161230001114.GB7883@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 29 Dec 2016 16:37:30 -0800
Message-ID: <CAGZ79kZiR7grGeMrMFRuQQ0kW6eQ4m=ZizGHDbT-s14iAj8hWQ@mail.gmail.com>
Subject: Re: [PATCH v2] remote helpers: avoid blind fall-back to ".git" when
 setting GIT_DIR
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +       mkdir lsremote-root &&
> +       (
> +               GIT_CEILING_DIRECTORIES=$(pwd) &&
> +               export GIT_CEILING_DIRECTORIES &&
> +               cd lsremote-root &&
> +               git ls-remote "$HTTPD_URL/smart/repo.git" >../actual
> +       ) &&

We could avoid the subshell via

GIT_CEILING_DIRECTORIES=$(pwd) \
    git -C lsremote-root lsremote ... >actual

Not sure if it is worth to trade off a block of code (and an extra shell
at run time) for an overly long line.

The rest looks good to me.

Thanks,
Stefan
