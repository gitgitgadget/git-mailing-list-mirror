Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D65D1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 20:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751895AbeAZUrf (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 15:47:35 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41440 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751621AbeAZUrd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 15:47:33 -0500
Received: by mail-pf0-f194.google.com with SMTP id c6so1023403pfi.8
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 12:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=usDrxqiFUiTnwRRvGFFdg+rrQhZLt8Qtf2B9f+FhvTw=;
        b=dp9qK3ADtb3gG9nPYEerpnUfF0o1rwSPI8C8jFXxdjQarTn1gqdxExfpMUfbDjelWa
         wdoko6npCjRmJ3aPNXZRaNTXI14XNbt+erI72N5OndRKwzRxoipciZzKx1zbXfCrmnLl
         w6Cuaijs8KMYqzzGIKMX42anZY27NxT8CR1t2vOxE8YBbqT+Mxi5jBXoVdkQW3Gt1ukl
         cRluld3PHe6YKIqzjEmeW76QKgBXLhb4gTUCWmwujFko11UOBsyw4FU4dTPO1SxXLvG+
         O1ONSEsBaS8Yf4UFNhODJf6OJmRylRMFwaFgdi/ja9uNV2fk819EnT+YC9xSxzOZIfr/
         YRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=usDrxqiFUiTnwRRvGFFdg+rrQhZLt8Qtf2B9f+FhvTw=;
        b=hwX6CTH8tYd6axsTwuSqaXZiCjcNubcOO8Nc/2iug8PPqtMAlyM2AjB0Si73Pia/u8
         3y2iHfXxpANLvXnFeLh0s+Y0tfnRelPL3icWD+hoIl0EA5jV8WJekGPQaucoGRRj4OTE
         GCMxV2Sh0Q8xJZEZgKnKJr5vPS5axCN+o2mZCuqX1DLW6KrAZ5oXA9ZsthzCyO5SOew1
         5kGGqWJDwpZSrQQ/tnMVBnAM2GlKczcrwmO6/9b6dmjq0hr62yXzVRCfy2+w/c3GMT2a
         O8hzf3sg+68nA+d6CNeCY/mXaOOgCeAuN51oQfwQHcByBU/4kVT+u2bZupfM1nOrNBM9
         T/YA==
X-Gm-Message-State: AKwxytf0yVLvpfpyIoxbs56PmOuRcXrcL99XL0PUHC9qsPAcsEgRDWlD
        a+rmiCYDHu1RFUxLqFq09AA=
X-Google-Smtp-Source: AH8x22613oZwy03NrBH0H2UWQ7B9KzGvYApjWH7XEg53E5FD/kJZPdR87uzcmBzX4VApABxKKajtHQ==
X-Received: by 10.98.223.196 with SMTP id d65mr20506525pfl.176.1516999652970;
        Fri, 26 Jan 2018 12:47:32 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3d49:4bb2:1738:a537])
        by smtp.gmail.com with ESMTPSA id e189sm19133819pfa.4.2018.01.26.12.47.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 12:47:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 05/14] packed-graph: implement construct_graph()
References: <20180125140231.65604-1-dstolee@microsoft.com>
        <20180125140231.65604-6-dstolee@microsoft.com>
        <CAGZ79kaNj-+oBNmbTKtOE8P-ZFcBVZSaBtwzrB4RQTWnYXcoqA@mail.gmail.com>
Date:   Fri, 26 Jan 2018 12:47:31 -0800
In-Reply-To: <CAGZ79kaNj-+oBNmbTKtOE8P-ZFcBVZSaBtwzrB4RQTWnYXcoqA@mail.gmail.com>
        (Stefan Beller's message of "Thu, 25 Jan 2018 15:21:33 -0800")
Message-ID: <xmqqbmhg73fg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Thu, Jan 25, 2018 at 6:02 AM, Derrick Stolee <stolee@gmail.com> wrote:
>
>> +struct object_id *construct_graph(const char *pack_dir)
>> +{
>> +       // Find a list of oids, adding the pointer to a list.
>
> Comment style.
> Here is where the bike shedding begins. ;)

I also saw some violations of the usual formatting conventions, e.g.

	if (condition) {
		block

should not be

	if (condition)
	{
		block

