Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E921BC32771
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 01:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7EE021569
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 01:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHOe744/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgAWBal (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 20:30:41 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36749 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAWBal (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 20:30:41 -0500
Received: by mail-ua1-f66.google.com with SMTP id y3so446635uae.3
        for <git@vger.kernel.org>; Wed, 22 Jan 2020 17:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eJRJZ/NmVGirVpgDk2gJJ+d5wJ3mDJPZud4L2epVMrE=;
        b=YHOe744/nw7kU7LgkDSG8n6Kgk47p/Pg282dpY4nGXNGgzpeulSzz2iRz+LIEpPL23
         sAS0Lr2YnVTP8Lyu8Gvgc5RIAz8Ma/esdjzdyanPhv34mGYL9yQAO2jzHmhwdRCNyK5N
         bf3V2lS3ZrztrZOoL8Wqfd7qDYV/KTZrm4LtKkneePjOvJd5jxvrZyTnswnyS3pmHzlT
         z+niGlu5PNDdJIqeFXJPgQe9r6s3Qf+FtXuyVZvm+94l0k51lmJwlEBe8NkpkKH1ShV5
         YyhOeijyA2S1MY9TomkGeheI9WpbqToyaVmiLtQ0DksAnPK+UuHw25yp63mQEhar4/hD
         uzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJRJZ/NmVGirVpgDk2gJJ+d5wJ3mDJPZud4L2epVMrE=;
        b=VH7iTHeUUbOzs2x7l9q7nH+WiIKKfEeodgHhHu5DTgpNnERn3ID/HPsWWbwczlEjHl
         z3DbMgHOkmFnLeiTlnYqCRhuWTMdnVYDN15EgdV88fTUjyhn0NHt9xhWE2oVcSSnZs5d
         ghV9HqsDkXl6u5BmVtxm0gB1klNOBEyKKTT9wawT7RSXnvIq91gPB/pqdM4p+/2xyHMk
         TEKYeCaa/oOM1Slh0FDy98vIaVSZl3t2u4nqAOhz9CPdNgsqJM+KDhTBHd65a4KaJSpz
         zYTXVHrpBE8nzBKepEEdsC9fZhpRYi8qpCgreh/Hxg2/yWo52F/NLVqL65Tw0PtVQZMt
         XPUQ==
X-Gm-Message-State: APjAAAWA4OAzyE1rJIlI1YySEXOG4Gdpw9DXA6rZiPE1l3Kp/o+Nh4Xk
        5/fW9QR6SCAPIIKH+cNzKxJNPIJqcHA5l4+Ambs=
X-Google-Smtp-Source: APXvYqzmpqAcXAYBQ2WD5DOrhUSUT5YUt+ufxCwjIsBa4/382vJmljbP6Mr++TQ/1/MK3mGmGAmlF7n22IyIv2PSRsg=
X-Received: by 2002:ab0:4931:: with SMTP id z46mr8405124uac.119.1579743040253;
 Wed, 22 Jan 2020 17:30:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1579598053.git.bert.wesarg@googlemail.com>
 <04eb98389880c96e1dc18131031e9d6ad5830a40.1579598053.git.bert.wesarg@googlemail.com>
 <CAOjrSZsuPUc7kDPh6wTDMq10b2QM0R2Uq7-0TQ=W76yjk-eoJA@mail.gmail.com> <CAKPyHN0=jBc1PYC2jSp0SV7EuMwmRb_RRifmK66KTqVtP5oFRQ@mail.gmail.com>
In-Reply-To: <CAKPyHN0=jBc1PYC2jSp0SV7EuMwmRb_RRifmK66KTqVtP5oFRQ@mail.gmail.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Wed, 22 Jan 2020 20:30:29 -0500
Message-ID: <CAOjrSZsn1KArNp0Dj-VtiEq9yVdxuc+MJHa_k0uo10cgn=PWOA@mail.gmail.com>
Subject: Re: [PATCH 5/7] [RFC] config: make `scope_name` global as `config_scope_name`
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'll just put it into my local changes, and then reroll.  I should
have it up within a couple of days at the latest.
