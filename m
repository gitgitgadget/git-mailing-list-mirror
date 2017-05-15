Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99ED8201A7
	for <e@80x24.org>; Mon, 15 May 2017 12:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753501AbdEOMn2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 08:43:28 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35979 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbdEOMn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 08:43:26 -0400
Received: by mail-pf0-f195.google.com with SMTP id n23so14577214pfb.3
        for <git@vger.kernel.org>; Mon, 15 May 2017 05:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=k07CRnRgHQnTmcKgw9iN13bRpQM+zn79P9RHwLNZHGU=;
        b=dXUPw3azLJqFR/ptwGUa8WXlNw1SVN1N6+e6IgiXB3M0bkG8Ygxnl2X9HBkq9saA5T
         oNMWVw4SQydZ4RIVm2+uLDNdOHUiQ9SaGZ5k0i+wLkLpxFpagZ9cNYk8pB2bHj6038sr
         15hvRcBpYEIu1EabSq3nTA/jdBqn54w8GJ9Xm1f7tkYcXbG0QRm+x34JVzpwGZsPDu+4
         txUPT/QWJKCaSVCWS1i9hcLtU4sJJWJfkbcaJHOjoBa4I2rFFttDfQl3xIHvWkM70ply
         1/Z8V0e7wOxjSIHYvz3m41vLGBAOcMaGRH7dCIpRj8TzG0oaD8n7ausYtfTLkvuA0u3W
         koqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=k07CRnRgHQnTmcKgw9iN13bRpQM+zn79P9RHwLNZHGU=;
        b=JKcoU/sBvAfPTgOhMLdcTuByVlewX7Xe5tJia5I5wCYJtBkeg1B4WgJ9csQ3DIjv2v
         GA1aQ7yzzu9eAzVaX4M7dWmI0vuKx3LrjqcDyHu/NVBcftFiaFr2eMrean761Jw9gRX0
         q6wyVBBBXRwlDkjg3HM+AIGjdskXQOCA9q8G+/ULbg4Q/DRH4geyiVpkft8nQNb2FyOR
         nw1ArEA9Mg4Wy0I3TlSk5Ld/bH4qiO/y9HQWzBZpy7e3HhcQxCo7cwaOzcqOh1bCg5Ko
         wDPok/Co2CClKLmwX6GN9YCkmSUU27CUH1hz08u3iCS06yjDL+QNlBMVCuUHKm/ICzZx
         2azg==
X-Gm-Message-State: AODbwcDK025bOvZqUVsac9GhkA7+j+gTzJwdbdjXkYWW5MmiXJnvtnws
        cz2sAUNpj0KwAw==
X-Received: by 10.84.171.195 with SMTP id l61mr8226841plb.147.1494852206101;
        Mon, 15 May 2017 05:43:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b170:f9ed:5f25:7ab5])
        by smtp.gmail.com with ESMTPSA id e5sm26248755pga.13.2017.05.15.05.43.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 05:43:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, peff@peff.net,
        mhagger@alum.mit.edu, jrnieder@gmail.com, bmwill@google.com
Subject: Re: [RFC PATCH 00/19] Diff machine: highlight moved lines.
References: <20170514040117.25865-1-sbeller@google.com>
Date:   Mon, 15 May 2017 21:43:24 +0900
In-Reply-To: <20170514040117.25865-1-sbeller@google.com> (Stefan Beller's
        message of "Sat, 13 May 2017 21:00:58 -0700")
Message-ID: <xmqq37c6uw7n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> For details on *why* see the commit message of the last commit.

Luckily, we have a good test case to see how effective this approach
is in the flight.  Running

  $ git diff master...'pu^{/Merge branch .js/blame-lib}'^2

with your new feature should tell us that bulk of blame.[ch] that
are new files came from builtin/blame.c with some symbols renamed.

;-)
