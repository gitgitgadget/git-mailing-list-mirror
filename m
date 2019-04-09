Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0518920248
	for <e@80x24.org>; Tue,  9 Apr 2019 15:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfDIPY2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 11:24:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38543 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfDIPY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 11:24:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id k11so21480177wro.5
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 08:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=09DMnFVGHqkz+Xp+IyoGRbWblghRja+JlCo1aeOFDQY=;
        b=W7o2vIABkM7U34fgr9hZt/aKzU7C9qfpnc1hR6lSBQVk6tjyj/LOGoysmLebEqM0ww
         oUKwqWwNvQ8cILQOTRt9FUY+TEH6KCOM1G2NjDxx6RcinKXf8Ta2SI4JFpJ6AnAjr+6U
         AfcWG+OlRSB2NPy9Hr0jJt/rpLMpyVkvOvZJi/rSTEHQsStrokypWFY3Ey3VWXrdSaIP
         7N910BefUJAW9PQF7EHzwbZByPgtNORm26wIbFzgwc/cSbENsnSSoaE6VBdE7hszKc4h
         wwHeaDcOyaYpFjJzOBovVC2hYGwleXItRAJ2bTKSYWLdMIiw8iME57IrJ0v7P6FVBns1
         TAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=09DMnFVGHqkz+Xp+IyoGRbWblghRja+JlCo1aeOFDQY=;
        b=cEIfE/5CaoyK2aMiVMZvc1I2fP/UF5LLOWl9w34PCv9s3tgASmbl4Gg7L2cOvjlZmZ
         LtTBtnGpVLo+yK/vCR8kh5ikCpOgIEhLoJivdLgIuQewXa+on9UKUSMr+Eh1TfDlwC5F
         flkUteghk6ur8+lDLy5XxjF6pAm0T/Fr3IE7xcuIDXwDn7aTvsAyI4gKSaxV5u9xkiSt
         mydH6DR6iIuWZy6iIZv4/5cT2OUSL+MthdgNFQ9yJpK/b7QaZPmw9LO9dDcHdXjxCIfd
         +gdCtPXCbSvt3Sq7oOD0le7HZmSBI2VSOze6/ls7+hYkGbwPV41kYKcXaAjwsn/1mdYB
         F0tA==
X-Gm-Message-State: APjAAAUz8eMDlPM+HuMuTQ1GFa4YCdd6Xw0HVmLzdTsWstYv0e8/+dFd
        X8GolSFYMTRj8ErLEtjdUuU=
X-Google-Smtp-Source: APXvYqzLhMsv/QJKOiNM/SI4+z6gQwwYC4wM1bQgqlq/YVZ0eUxHmK+3SDv8IDmr7KizByzHmACeYg==
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr23864735wru.30.1554823466355;
        Tue, 09 Apr 2019 08:24:26 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id x21sm23078822wrd.45.2019.04.09.08.24.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 08:24:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     jrnieder@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] clone: send server options when using protocol v2
References: <20190406115728.GB219876@google.com>
        <20190408171149.125872-1-jonathantanmy@google.com>
Date:   Wed, 10 Apr 2019 00:24:25 +0900
In-Reply-To: <20190408171149.125872-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 8 Apr 2019 10:11:49 -0700")
Message-ID: <xmqqk1g342xi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> > Teach "clone" the same ability, except that because "clone" already
>> > has "-o" for another parameter, teach "clone" only to receive
>> > "--server-option".
>> 
>> Can you give an example of what this would be used for?  An example I
>> can think of might be
>> 
>> 	git clone --server-option=priority=batch <url>
>
> protocol-v2.txt says that it is server-specific, so I don't think I can
> give any meaningful examples here.

Does the code behave sensibly when the --server-option=... option is
given and

 (a) the given option is not understood by the other side that talks
     protocol v2?  Or

 (b) it turns out that the other side does not talk protocol v2?

In the former case, I would expect that there would be a way to
respond with a failure for the other side and "git clone" should
notice and respond by die()-ing at the end.

In the latter case, I would expect at least that a warning about
accepted but ignored server-option to be given, or "git clone" to
fail with an error "cannot honor the server-option".

If the code does not match the above expectations, at least that
should be documented, I think.  If "git fetch" shares the same
issue, this would be a good time to address it, too.

Thanks.

