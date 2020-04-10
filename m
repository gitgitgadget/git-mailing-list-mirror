Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A127C2BA19
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 01:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C4F20768
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 01:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKsClDjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgDJBmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 21:42:44 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:38933 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDJBmo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 21:42:44 -0400
Received: by mail-pf1-f171.google.com with SMTP id k15so412837pfh.6
        for <git@vger.kernel.org>; Thu, 09 Apr 2020 18:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KYmKxyr1TvuXFWiFeGYZxdPfgGMmcvPYDMUeSlXDRsk=;
        b=gKsClDjfjK8WGmVrI6ZReuv4e0EwJH1mTL6/ZzAD2pPXsoTFjfJmkvGd4ADd+eFYao
         qWYSfXSJnFCldUzIyYx5QwdYGV/dcS/pSliubZ1yPtN1C9c8ywVVm96mrA6FS0Km6wza
         q2kcP7jlW2eMX5LgiUgYzDHbzX6MKSjVJSvZg3GQgQbd4lHvdJ8L1EYhHC/UtHR9i3JK
         oRhfcpFOeVKvJrACpmi1mKhuD9lUbRpRuCCSGJseP799/AQM8ynPCwG3epBh+IrRZzi3
         YUpw0tPnsG5hOGJDx8J/WCBiR8fx7M5LMWUTsC0MFlNn+vRRMdHuHz4yLqzhe+S3AgUF
         0YRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KYmKxyr1TvuXFWiFeGYZxdPfgGMmcvPYDMUeSlXDRsk=;
        b=sluHBcYLXNf7Xd6IUQ5Grw5WR6bEZAMCvtQbvr+PrPzi1aQxVoDINLWIZ+5L1CL5q0
         Sk6UP5iLPGpqGH+44xE0Luyj1CAlcTPoQoefe+Uh3C20V6baqvwg4SYtHkWmhp3vgMS6
         w4QeZzSt/t8r8rHlcHpjNllMYGEt6lLhRkWn2Sksp1vcDP+85WGE7vcsjhjRp2hioxWZ
         ESD6n5OM+TLijtQtL0LMP01TvNdFgUEWYXgocKL2BnhM/egJwv0zF56GpBTsKzZm+SAh
         O1PbHniMQ43MaEOgO2Wv94VxF7RsWF2PFGRgPtoG5HONSrVVLJbP5kDXT2GMPKUUI7kC
         4Q3w==
X-Gm-Message-State: AGi0PubqqfLIOA7QfIcmJ5unNvIApGFcCxpRTJHhwXelxNV3VrJvSh7Y
        NWhHEqxwyltgqS+Np7Rle8E79uvUuhKsGuiYKBk=
X-Google-Smtp-Source: APiQypKsQF0rxkIqOusgxqKbV8wNLq9OtsedAMiLNWPKmH8H7Ffplmwcy9fi4utVFkxVKWSH9kda0aN4R1lTiR+FsPE=
X-Received: by 2002:aa7:969b:: with SMTP id f27mr2590391pfk.116.1586482963796;
 Thu, 09 Apr 2020 18:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAFDeuWO+2JEGudtnHZvSsSUOVRR83U9ziLEjSoDyMWxYhvDMKg@mail.gmail.com>
 <xmqqh7xsmg7j.fsf@gitster.c.googlers.com> <xmqqd08gmg3s.fsf@gitster.c.googlers.com>
 <xmqq4ktsmfnn.fsf@gitster.c.googlers.com> <20200409234152.GA42330@coredump.intra.peff.net>
 <xmqqv9m8kxzy.fsf_-_@gitster.c.googlers.com>
In-Reply-To: <xmqqv9m8kxzy.fsf_-_@gitster.c.googlers.com>
From:   =?UTF-8?B?w4lyaWNvIFJvbGlt?= <erico.erc@gmail.com>
Date:   Thu, 9 Apr 2020 22:42:32 -0300
Message-ID: <CAFDeuWMpsZe-qUZD4=f0SLqfuPUhdER57WOhnpDH-TP-h2jArA@mail.gmail.com>
Subject: Re: Re* [BUG] segmentation fault in git-diff
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You guys sure are fast! Happy it could be solved somewhat easily.

Thanks!
