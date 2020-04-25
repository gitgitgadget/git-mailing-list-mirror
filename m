Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE67C54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 22:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1F8220706
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 22:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiOyp8My"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgDYWOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 18:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726220AbgDYWOO (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Apr 2020 18:14:14 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799FFC09B04F
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 15:14:14 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id u203so3768715vkb.11
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 15:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RO9rgJLnsYdJ6XF9B6ukaBnryF9ArFspXAANivwSUiI=;
        b=ZiOyp8MyOYin1akesatOCP77LRT085yKR+owiyG2PZrOZS39PZpADfcQqmQEhxawEQ
         jLsIJ04cv1EvxyO0XgYVLZEgQ2ukvNeUFWZhJvLTneC4aY1zGWjsQGtpd1Po4O+Mdqd1
         dQqKhBsBZNimqh3hOk7nwSb3K6J1Am4RqzqElH0ck7H9dw6i1xGrYs2RXxLTfqWzJl0a
         8Xx1/oN5W+3mAzivkTWNHspJelYDM9qu1P3JhOSUSRgD8u0j8yAMlFbPTmI2GoVNoaqE
         DHuBbbNLPQhDN2f1TwpCX6hl4/00UFtr80RxC7JDGWNu8urZBTJdec/+4sdYD/OWdEjX
         6dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RO9rgJLnsYdJ6XF9B6ukaBnryF9ArFspXAANivwSUiI=;
        b=uXkoqjy+HqefTEHXADoGksFi0+8g60yBMsHoZD/hWMEGkqf5b/dRPS6C8GaSATuuWv
         uPU9gPMGzT06Leui6a5ZRb2e92Iq+HQj32fmsZg1NBOB1ERrUxy/bdqBNYiIyGBN762X
         Ds7l6/1WRyzT9UyfjBO+8WUqXC7nTMuq/Ur4R3vY0r2DZekviJlK8g39/3Af3+iOHYr8
         D6SwJSkx0zIBnaCikVhdCtF3ptsOsYtAkzg+9DWGl4HA7JRlznRBj9yjlg860XDHPBtt
         6lrK5rk9Mwe7O9SoYLiEAzl0LaE2vFlblOKIYNPucWKBYHzJdAcUiMZAJFAIwm+Xs8lE
         biUg==
X-Gm-Message-State: AGi0PuaEoOmhZUGdlHnNij5fv0jqscdCzfcEvSnms3dNKw/AE2HsNpQg
        wo4jZpVrOhrkXkv8qX930KuHGRbCeVERc3RmikqMPCGq
X-Google-Smtp-Source: APiQypIuVB7UruxQeozTVHcvH310C89F2G2Ll7x+2KvMudx2JVR36xijVA07v1QzzooKU7FoHM2AajZ7WC8uRGv1gFY=
X-Received: by 2002:a1f:16d5:: with SMTP id 204mr9685218vkw.20.1587852853416;
 Sat, 25 Apr 2020 15:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200425022045.1089291-1-jacob.e.keller@intel.com>
In-Reply-To: <20200425022045.1089291-1-jacob.e.keller@intel.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 25 Apr 2020 15:14:03 -0700
Message-ID: <CA+P7+xp8RzrpErc0bu2MxozyA0sAM-4W0C94wZWgwGOzzTYx7w@mail.gmail.com>
Subject: Re: [PATCH 00/11] refactor git switch completion
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 24, 2020 at 7:20 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
> Following this are some patches to extract displaying DWIM remote branch
> names from __git_refs() and refactoring __git_complete_refs to take a mode
> argument that switches between calling __git_heads, __git_refs, and a new
> __git_remotes.

This should read __git_remote_heads, since I changed the name to be
more descriptive to avoid thinking it prints the remote names on their
own.

Thanks,
Jake
