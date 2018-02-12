Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62E041F404
	for <e@80x24.org>; Mon, 12 Feb 2018 20:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753260AbeBLUhW (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 15:37:22 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51660 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753011AbeBLUhV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 15:37:21 -0500
Received: by mail-wm0-f67.google.com with SMTP id r71so11993935wmd.1
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 12:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5XhfJkT4iyL0fgJYqhcAa82qMDyGmCgJV8QLGvzNbhM=;
        b=ZxxKgKYMEFZm68BpPoh7DIR65YdYc+9eOdckSHguE++yN0WtJ8fTI4yQSPhxBYBY+k
         hJBJWOKnpGmkcdPfpZ6nIgzh2fs3VOYvNM4azpIsiP5Isa6ocU6fu4zFGijbIhJras5B
         X0uq6y+xnqJ0b3FY9sMzW14ySyBnT7WEhH5zkwgZk5ufn/Exb+C1UcybzHbNkQWMwuqU
         dF9oFQQCXtDP0Yuns9hrTXztpTXSCAwC+i1cb/coH7tTeTdcA+ce7OUEZ322I6EmOO4m
         DLcx+9lM8DFhzJwS+KZpHLXq1sIYLVXZmiE6pQdRyj5F9lEV/FG/g7b0bTIY4ynZMN5t
         e8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5XhfJkT4iyL0fgJYqhcAa82qMDyGmCgJV8QLGvzNbhM=;
        b=Rps8FGqhbmtpoibX9FZJauYWgPYZOZnHwCf3T7tE8iPnQs3/jhhdxLZubC/j9yDaA+
         yhwHnz4L277p81vi8Fct3pvYZSLOFPFA9ce/nXknNh7FO98f88ICsqpv8Qgs1PMizRvv
         FsgwRUZnbuWcnPe+j/7uchEV7kd47G+Gl102GbD9WalCCUsQ7qmu1aVLyPpTBny5QP/w
         4evt7fpse8pFBwqyLf2mpgqlCywbWdOqVtTj8/nkuYn4TbTsLEErC2SfDgV7ju5GhS+F
         tHjz3/4gx+d/wLhZkxsSCXCTSH8KD8vFUm2kl5+YfpGAZFVuC2nfk3Oaapgzz1JjHb5D
         g60w==
X-Gm-Message-State: APf1xPArN44yt0FPBmOPUt8fqIZP7/9mL5+0h6mctdnP3CDu+5RW07rp
        FfqSSDhkl0Mg6kUPpZBBxl4=
X-Google-Smtp-Source: AH8x224YXXvCzMzC+21qvESgZhVAzUMpijoVIpGgvsaDwGCuWDPAR7YSrdMwE27Ns5lAKqxDzbxIAg==
X-Received: by 10.28.38.133 with SMTP id m127mr4306513wmm.40.1518467839629;
        Mon, 12 Feb 2018 12:37:19 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p5sm8349862wmf.13.2018.02.12.12.37.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 12:37:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 07/14] commit-graph: update graph-head during write
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-8-git-send-email-dstolee@microsoft.com>
        <xmqqeflqt4st.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 12 Feb 2018 12:37:17 -0800
In-Reply-To: <xmqqeflqt4st.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 12 Feb 2018 10:56:50 -0800")
Message-ID: <xmqqwozirlky.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Derrick Stolee <stolee@gmail.com> writes:
>
>> It is possible to have multiple commit graph files in a pack directory,
>> but only one is important at a time. Use a 'graph_head' file to point
>> to the important file. Teach git-commit-graph to write 'graph_head' upon
>> writing a new commit graph file.
>
> Why this design, instead of what "repack -a" would do, iow, if there
> always is a singleton that is the only one that matters, shouldn't
> the creation of that latest singleton just clear the older ones
> before it returns control?

Note that I am not complaining---I am just curious why we want to
expose this "there is one relevant one but we keep irrelevant ones
we usually do not look at and need to be garbage collected" to end
users, and also expect readers of the series, resulting code and
docs would have the same puzzled feeling.


