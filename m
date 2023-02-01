Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E716C05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 23:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjBAXz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 18:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAXzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 18:55:25 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E0437B75
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 15:55:24 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b18-20020a253412000000b0085747dc8317so111178yba.15
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 15:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OE3XhKdr3/v1xENjNAtRcXLJnjxN3b/Zu3tT1FZ1pjQ=;
        b=HsrVDbj4ysEIHiIORFEw8XiQ+MbxDLFEMp1bdQo/n2ZzOE1ODAHxIubx0hgkCH8RXN
         VvOqAh5Y+PEx7N5WDeTL/uUORzbXJq947h8ny2pdYDqn89QgkaMjeKoX4z+tpdePjPHJ
         kT06JubAcQbCdMudb/MbiYhYgHkKjVN4nn7Ol0n0bi3ZU/T8YmH3P7N2If7+l02HGB+K
         KLJhdUf1sD7XgmB/sdPuA9EbKUuOLl1ILcz9nJ/CynAsOf4yMdbyq2rzfW86Z8jgusOE
         80ZQOFxfB59zEkSbGXsKa6CBn+Qby+tDj7APZ6mvR2gFLwnNS9HQDTfgjDzPyJfvosoE
         RM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OE3XhKdr3/v1xENjNAtRcXLJnjxN3b/Zu3tT1FZ1pjQ=;
        b=yQal63P0s0b4u06X8zpE8ZD8yj+FQGkiwMJPioY+pkm+tyq5FnxMmvWCwqBdPJnKyQ
         NTVDFCWDwCAilHGirzCaWkRVu/PULRa5AOtp+LCfK2KZ2HRFK8dlLBMr1hQYbZRqf/Al
         DTz98iBSEsPee6KpBxKQ5iuyTlucNV3yz1OvVFiKUA9VSVyZw0hiVMJXl/CTefxl+ZKE
         GEKY5m+3D1dkE3dWpfaOFEJnEQpUc8Qav5esmSrfmxcL1ozetipdDRf2DWtYd3IjKQd4
         qxAs++eWoIG7T5vXWVpcaM5MdASiHCJkZAqTFUttJBs7zhwg8jdztX8JG5p5Pve2Um1t
         ftxg==
X-Gm-Message-State: AO0yUKX9Dvdd9gBmU/SgpasJh96PluBEdgifkb1bbOa7vb8Ma32FgEzk
        e/FX7ZZCDjYfACFF8VccWF29reO/KQBuEac=
X-Google-Smtp-Source: AK7set8Ko6y+P27XvQtfJuhkmbUSvOJGy/tjgbXOL565DQ47+62WG3lYpAkSR6qe/Cn3rIBBGGwC71H0IcxhYLc=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a81:ae17:0:b0:521:da86:a57 with SMTP id
 m23-20020a81ae17000000b00521da860a57mr0ywh.7.1675295723396; Wed, 01 Feb 2023
 15:55:23 -0800 (PST)
Date:   Wed,  1 Feb 2023 23:52:50 +0000
In-Reply-To: <20230119223858.29262-2-zev@bewilderbeest.net>
Mime-Version: 1.0
References: <20230201235253.1891546-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230201235253.1891546-2-calvinwan@google.com>
Subject: Re: [PATCH 1/5] t4014: Add test checking cover-letter To header
From:   Calvin Wan <calvinwan@google.com>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +test_expect_success 'cover-letter gets To: header' '
> +	rm -fr patches &&
> +	git config --unset-all format.to &&
> +	git format-patch -o patches --cover-letter --to "R E Cipient <rcipient@example.com>" main..side >list &&
> +	grep "^To: R E Cipient <rcipient@example.com>\$" patches/0000-cover-letter.patch
> +'
> +
>  test_done

'>list' is unnecessary. The test can also be moved closer to other
cover-letter or header tests.
