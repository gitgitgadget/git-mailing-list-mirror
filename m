Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D7441F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 20:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732710AbeGLVFs (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 17:05:48 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36104 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732612AbeGLVFs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 17:05:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id s14-v6so7403374wmc.1
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 13:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Mxlkx9SvfRytN3gdeFnkFmP6D/7NFQxyYXQHGeVJVHA=;
        b=qfrKyTokU1uvaskjM6+1IEuuxtj8XzVNonAyPHcn3GG1LEJpYjq+NrK4DwcctKjrE4
         FxDhA2++S+GZLhFSNIXmQIChewVxi+4sN4TKgdd9m1L3z2m0MMkrd3U/jmc22m7en9Li
         pv7zJ3N1QSYa1MG+JJmKFcvL9dx4wcwXapK35arvDxeVEovMoA56X/t4OxN8o5Lu2vDg
         mQgnr7I7f0ugOueYCpyagFnN9pBhO1Mw5dVmewsxHvtiaVmztgDibHJVm2GFjTT6gBdX
         rQsR33d1JkOZXL/vb2jTYPrO1Xb8h38nB03Jp62xRTzLVsAzsjKEDfUCwpwH83cFKYAy
         5tOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Mxlkx9SvfRytN3gdeFnkFmP6D/7NFQxyYXQHGeVJVHA=;
        b=mfCUUXxumW8iwlBf36T0ZqQ6Uwv3rmyKu3p2MRne1SRioUMJrQMyR3AarT6EM97KcW
         U89eawiDUgc7qP3YrhNq5om9PlWUeDQPmNDNXWrkOga1DT+E2EbaGh4DKCIcIFlEvyab
         3iGWhbhLp/IEtj8LV5cG+7AFuE3Gq0VdJ4iq9zjLYj9/QCq1d2lHwxbf0KGD0exdb555
         8om4VdiS/LyXEqC6rJUvdoeE+TBkjuidqbNpnHeVXXri7ii7EHNQ3hueUdTZd2I6yj6Y
         MX1ZvlODKQMs06BtCtnerO6q/J629QSNOXPfxIn4Y/aEMQ8+LSu4ezDn0jrHpI2fZEFZ
         EAlg==
X-Gm-Message-State: AOUpUlFVr86c9F4mf4OBvnIgQxEBpJOu7f6GfceqhjtgsPRCgSdnf4n+
        OyU5o2DK3KJRq9povrqT43I=
X-Google-Smtp-Source: AAOMgpcOZGDAji6/7/jCZsuhUxRjk5+sngSAbQNYt2vp0XLwu0fNQis907OWxv6F+ZcyfBFmYRH6NA==
X-Received: by 2002:a1c:3e92:: with SMTP id l140-v6mr2205603wma.134.1531428869981;
        Thu, 12 Jul 2018 13:54:29 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w4-v6sm7280420wrt.40.2018.07.12.13.54.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 13:54:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, ao2@ao2.it, hvoigt@hvoigt.net,
        git@vger.kernel.org
Subject: Re: [PATCH] RFC: submodule-config: introduce trust level
References: <20180712190456.29337-1-sbeller@google.com>
Date:   Thu, 12 Jul 2018 13:54:28 -0700
In-Reply-To: <20180712190456.29337-1-sbeller@google.com> (Stefan Beller's
        message of "Thu, 12 Jul 2018 12:04:56 -0700")
Message-ID: <xmqqmuuwuqd7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> In practice we always want to stack the settings starting with the
> .gitmodules file as a base and then put the config on top of it.

Could you substantiate this claim with justification?  Thanks.
