Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA02C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 835742076E
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qjEsctG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgHUVIj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgHUVIi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:08:38 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727E8C061573
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:08:38 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id ba3so1802031plb.7
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ylk2k9UVQxiu3aXWPzWsmvoDIe6XABxGFmjviQvO8p0=;
        b=qjEsctG8KgJ3Kkfd/xhKaiBXjll+rSYukYemuAHU28f9Sv0t2lzHpqC4Ok4iByvCBn
         4DBgai6W8qHAH62ZZJL1khUlz7gaE9ta87+xjiJo+ObyPC2gSzxyebB2RYk2EibDkHMU
         lQW+zKZOCLZ5NqtEPgEt30+YBxtOqwl+IxJgrpjXWxrdI/fZQ4Jv0qFr2Vtlf7AcAAHh
         lMrf2/mXtDYJHWKQ6wfl/vCNBtiX+ojjpaeEyg9CfCiciz0h2C7Oiw7eAD2txAaKXHjo
         e27IPGioEZaeOj0L8L1CGis97JN+rIOadiH42KiLwGF7WVz6WyUqk1J9xZwAQepnMDKD
         PoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ylk2k9UVQxiu3aXWPzWsmvoDIe6XABxGFmjviQvO8p0=;
        b=TJz9vQCfdt7LDzJGgbDUKiNfEfwsKi9K4Mk+PCMF2zZiOC+PIzQ1bqGNM3cs++MNOP
         i6se8ZsaIHei30CMlWcX/EcxBNBl0KApzkhvhVLxdzxTMVm1+6P2AdzrByxbb4F791pH
         KuTraKTFNUZRi90lH6di5/QkUXgd2uVuvADCl9eyVR8qKhw5k4g8N5Ce2w+XDwKA7RMh
         o3KzGGg+KceSfHntIdAq6g18/RNRGMcAeFKIVjNZFGNEoVElnzkOExilp923M8Ck/6SA
         OPfDGnpnOxPTC3NtXZwkVipFVikkRnKqjCncOufrEbJ6Lv7BpwzezLa702qfS+gWectb
         Hu0w==
X-Gm-Message-State: AOAM532qj7KUA01NoFvVr2emY6vliEaiV5S0vAwP9YvgBKOLr3dHEsmZ
        20OQWww1VosxAacU/LUlOVjTZY3JSwjY74HnxOSN
X-Google-Smtp-Source: ABdhPJxWBg8HUVbLii2Zb6L9VEBxDXmLypDLTF6Dq70XZwfvpOkYJlUEogEAWEH6OzLuBkHQ/SmQ/+J0zOVEPOnpHbhm
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:ed4a:: with SMTP id
 y10mr3946095plb.106.1598044117873; Fri, 21 Aug 2020 14:08:37 -0700 (PDT)
Date:   Fri, 21 Aug 2020 14:08:27 -0700
In-Reply-To: <xmqqimddaxhz.fsf@gitster.c.googlers.com>
Message-Id: <20200821210827.1203531-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqimddaxhz.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: Re: [PATCH] fetch-pack: in partial clone, pass --promisor
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > When fetching a pack from a promisor remote, the corresponding .promisor
> > file needs to be created. "fetch-pack" originally did this by passing
> > "--promisor" to "index-pack", but in 5374a290aa ("fetch-pack: write
> > fetched refs to .promisor", 2019-10-16), "fetch-pack" was taught to do
> > this itself instead, because it needed to store ref information in the
> > .promisor file.
> 
> So is this patch a fix for a regression in v2.25?

Yes. (Just checked with "git merge-base" that 5374a290aa is in v2.25.0
but not v2.24.0.)
