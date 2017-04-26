Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A2AC207E4
	for <e@80x24.org>; Wed, 26 Apr 2017 01:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1434527AbdDZBw1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 21:52:27 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35801 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1434524AbdDZBwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 21:52:25 -0400
Received: by mail-pg0-f52.google.com with SMTP id 72so36381865pge.2
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 18:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=7K2xXV/7JNBAND3kSczUWAVWPKhaespamDqIl2VutnY=;
        b=UeWZr21zpXrpVAl7oNL+1fbVKI4fuRv4SOIK/ecPEzEo1yHgRGJx8lxKgRu62tGPx6
         glvcT0Z5dDxlGdh6OI/NvMc4mOBgH5WEurSuKfQneLREA+KbqHm1olYQESmGU+cZrfNH
         HlCBjV6zxMEqlqONi9w72EQvLbxZPzxaa93jPpJRlW20ZXRZOpa1WoSi3v/2mpnGkm3j
         Ig8VB4AAWWHQaJynyEJKKFmx9NUeyrW0kSKnPQGu+QRr3YLRIcfRXOd7UlUBkaX5nAtB
         n8Prp1posVROIfN4Zsg6owJROPRpjrHRFcj9ZKANWKDk2mpzJSrRBh+4cG1PxxL5N5/G
         velg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=7K2xXV/7JNBAND3kSczUWAVWPKhaespamDqIl2VutnY=;
        b=nusxvRhCDi+Gj4QY/hu1lHQsCE1M3z264iZVt+MDAFht8C87BUCdZdOGi83yyPV3tg
         1nKuZEsYtA0HLLduWf8EwHl3wFBOndcUaJR3ZryyZXhJqvK4+AeB5wZQrMNloG608Ngs
         e2+l5cnvIKUm98atUMowUWPcfGfK1niNBzIUqWRTKHPYU9RdgKYtZozkTC5OeKeJrs4Y
         0Insmo1oS/M5g6sVv1+010ZNecwcKn+WcMrLxlflBIuZllEjo1sodyiyBY9SffCMS1tH
         raXxeT6kPFo1ssmwYqhtrecTeOO+gshs9vLFgF2QvKEMLioEE5Na6YydGBfkXBa72A1O
         F2Yw==
X-Gm-Message-State: AN3rC/5cQwjNlja1Xq6TezTKFZDPhzn7p3HT2hUIRW36rAHPQnCmAriT
        c9QNIk7S3xAjsQ==
X-Received: by 10.98.29.86 with SMTP id d83mr30861035pfd.68.1493171544632;
        Tue, 25 Apr 2017 18:52:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3179:d004:20b:b383])
        by smtp.gmail.com with ESMTPSA id 3sm38352362pge.12.2017.04.25.18.52.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 18:52:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 8/9] Use uintmax_t for timestamps
References: <cover.1492721487.git.johannes.schindelin@gmx.de>
        <cover.1492771484.git.johannes.schindelin@gmx.de>
        <b59a414793492786937e910f6cd588b8e1751b4b.1492771484.git.johannes.schindelin@gmx.de>
        <xmqqinlu1o8u.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1704241226440.3480@virtualbox>
        <xmqqr30hw31s.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1704252208520.3480@virtualbox>
Date:   Tue, 25 Apr 2017 18:52:23 -0700
In-Reply-To: <alpine.DEB.2.20.1704252208520.3480@virtualbox> (Johannes
        Schindelin's message of "Tue, 25 Apr 2017 22:10:50 +0200 (CEST)")
Message-ID: <xmqqvapsszoo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In any case, it is a question unrelated to the work I performed in this
> patch series: the raison d'être of these patches is to allow timestamps to
> refer to dates that are currently insanely far in the future.

Yes, but the job of the maintainer is to prevent narrow-focused
individual contributors from throwing us into a hole we cannot dig
out of by closing the door for plausible future enhancements.

