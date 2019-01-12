Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 722EA211B4
	for <e@80x24.org>; Sat, 12 Jan 2019 03:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfALDIN (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 22:08:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51618 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfALDIN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 22:08:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so4105343wmj.1
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 19:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=whYQ7AJcnUNjzxXsvZBIE8+P3TS+jNp11wkVmhex9lM=;
        b=m+OOXzczQqAciusuiXwqjSPB3jsiT1Y6q/Pi/M9P0bTrpPFj8Albk4pqbK03nbRGW+
         2HZCILmZKhC/xYkd3QIit4AtEWqi+56i+AzwJ3O6Zh9Rjn7EEjiHvuZEa4kPkr600RTv
         n9ybMooawiHIoy6fLAXmIdLPsa/Cog+WBD6XHijR/oqgc+lxWdC9HeeDxlPQsuhxzEQ3
         YJFcUqm8/XPFwREYn+NxwLt434Zx/LPuBzx7pUy6SVjfrR4Rj828vNjURh7YbtXCB/ud
         nyFqro4yFs3B0LMiBQ+rDbIh4HpdaKmiXZyF86KwK5QN0QEAlzEsO4uxbXVAUynalaf3
         1Zaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=whYQ7AJcnUNjzxXsvZBIE8+P3TS+jNp11wkVmhex9lM=;
        b=YmKKbf/DNcfGimpkzUG1gMwfW3DEpCwSx7L9MDi+w3eQAkONA+G4kX+ZvtdS7XWOV6
         R5CGi5TFqXwCkzw3gJy4rJ4YwjxmYy0gw//S3chI4wQZCM2oLUXZz20TrGsplbm5IjoS
         UduOmXFA5GDkWDleGEuPWUeJpQQG4ggoYG5d57y9cl5rnMvCXZSYVJUb4QbKNoFYGBFN
         gA2BI6Rt0Se6zdH+F3woxiz7xYGNNBqkWya6nMtZa9lfc6S8+g/uVehqPd4qWI+iRUZm
         Ai8F3VczW9XGCkIIevWw49HssibNnujikW/Q/LEcG/TsKQ1bePDvuBhi73A8mVkbQ4F3
         qG9g==
X-Gm-Message-State: AJcUukctWckQYhB1JadISJvwketmzyqSQh1utVremF3FgZ33soFxmtqJ
        zU/O09e5bE1iJrTYqAReaArm3XpB
X-Google-Smtp-Source: ALg8bN5wLyYbG6oI2UyebV9brlDGeVNwiYadX2iuekr80GPjxShLV18UqZ9/FAUi/+FS9ZK1Ezm7aA==
X-Received: by 2002:a1c:a00f:: with SMTP id j15mr4111893wme.84.1547262491111;
        Fri, 11 Jan 2019 19:08:11 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s1sm95365885wro.9.2019.01.11.19.08.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 19:08:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] init: make a copy of $GIT_DIR string
References: <20190111221414.GA31335@sigill.intra.peff.net>
        <20190111221631.GD10188@sigill.intra.peff.net>
Date:   Fri, 11 Jan 2019 19:08:10 -0800
In-Reply-To: <20190111221631.GD10188@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 11 Jan 2019 17:16:31 -0500")
Message-ID: <xmqqo98mwp2d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We pass the result of getenv("GIT_DIR") to init_db() and assume that the
> string remains valid. But that's not guaranteed across calls to setenv()
> or even getenv(), although it often works in practice. Let's make a copy
> of the string so that we follow the rules.
>
> Note that we need to mark it with UNLEAK(), since the value persists
> until the end of program (but we have no opportunity to free it).

Makes sense.  Thanks.
