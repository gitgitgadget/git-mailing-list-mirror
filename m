Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1289E1F597
	for <e@80x24.org>; Tue, 26 Jun 2018 20:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932159AbeFZUPH (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 16:15:07 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:55166 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752472AbeFZUPG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 16:15:06 -0400
Received: by mail-wm0-f53.google.com with SMTP id i139-v6so3294479wmf.4
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 13:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=On1RsvqvAje6B5P9eUOIh1RBkpmVQviBNBwOmBIfYtI=;
        b=VCQdxNgVc4zqT7nVKsOS6nTxf92NLM/9WiJSLboTmJJ4hQci6NqTgbFV7Y2ZpD7iyk
         kQGlvC67Xk9Ca+UEsFYoCkH6Y/1LknBkfHS2Czf39LKzfH5z4CEEcef1skBYsfEpAZQp
         jXMVhOuuZfKEmnejZTc6S+xT77bT1GilibKHyh+uc6ogp/79o8lF10UQM2QtwAv5eGoe
         4Ri9LLWeFj26EnuWxwvZsps0dqYuziUboVBzjSKgQm+AjHgcG2HfulSHPXpRXpARo7uR
         /o/XkezzlypjSs/QB6J1BavztrUbQJVdODhGDKY2iq5Nu39Bepergp6xmhtsoJZ0HZo7
         UK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=On1RsvqvAje6B5P9eUOIh1RBkpmVQviBNBwOmBIfYtI=;
        b=NlGaE6ydHHkwVjHlWT4FYkGFLRykBHK6Bk3PBuEjhXfngSkfHl9S4W+HJRN+ZKJrnR
         cC7hc5CVLEvKlN4V0hFHUXWp2h3zKn7enqI0gOCsDQrRLWkFjotcXOiMC8k151PVG39T
         vW7NWsDDtAF0Pi66GPYTj05VxJvRngm63nF8hsnAcCLgeiIorhJW5A2kgYLZ/IP41zGK
         HUnZ27suOUIO4Kg4NphAeBhz3dYf8+zSsXo9FBMyzpaCR/U6yZUT2i1h6IJaITVvHxiQ
         TybcWpmOrNMr0CGygYgLexAq0bKsz4jhAfI+YkS0maOcMqVP7AO33Xois6+v4QW7ePP+
         3N6Q==
X-Gm-Message-State: APt69E3hzbb3H0oid63cpttuBqXsH9tRBWGpUV4r3XMrubNS5lvm1yC+
        JOW+73qIdNMoz9sqELdenjE=
X-Google-Smtp-Source: AAOMgpdTlNbj9sx4pZXOoaR4DFuuqipeRHw0y5Pw7cFf/t9yot9foRbzCf6ymZDrhryPFsc8qpjh2Q==
X-Received: by 2002:a1c:9bd0:: with SMTP id d199-v6mr2771765wme.16.1530044104903;
        Tue, 26 Jun 2018 13:15:04 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g88-v6sm4563848wmc.27.2018.06.26.13.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 13:15:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/6] submodule-config: make 'config_from_gitmodules' private
References: <20180626104710.9859-1-ao2@ao2.it>
        <20180626104710.9859-5-ao2@ao2.it>
Date:   Tue, 26 Jun 2018 13:15:03 -0700
In-Reply-To: <20180626104710.9859-5-ao2@ao2.it> (Antonio Ospite's message of
        "Tue, 26 Jun 2018 12:47:08 +0200")
Message-ID: <xmqqbmbxjoe0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antonio Ospite <ao2@ao2.it> writes:

> Now that 'config_from_gitmodules' is not used in the open, it can be
> marked as private.

Nice ;-)
