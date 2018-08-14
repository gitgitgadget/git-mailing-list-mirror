Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35ACE1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 19:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbeHNWmx (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 18:42:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36576 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbeHNWmx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 18:42:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9-v6so18233456wro.3
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 12:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FTLa308uqVAkeO9J7f/hdiNockxceFSuDMlUyKANBU8=;
        b=U5vBdtPDSWIWG54EOIRrqQSGLntffIg61R/+eX9QPvYDawBvgXlC98G0SXQ/L7fExk
         7PPNNhfvA/Z1p0lClQFHuXhY0zM6ZrXZVD+f2x34i2ELuxjVNYcw571rOniwVQT0k99t
         hTQoT2IryAUL69JRH3ffzfePaO0Kzyazel0JTVgNlufSH5raA/sPDEIeY6In2MB1qyjz
         ezjhgRhR/3yeL9EdpBGAE13ssetoJ80/sdkugzSUSsjatJ+6dGkjIqlfeUMgf7mnDuxV
         dX9fogdPeG5j/pxbVzNDjByXObdLjXk+fFm5jSVm+frH9QZgwdRueYOXBPNHULLgsPxm
         6Hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FTLa308uqVAkeO9J7f/hdiNockxceFSuDMlUyKANBU8=;
        b=Kd9k4n33QK0KjrZJxZxvcEkwZNgxux/oBOVogDRTYS3W1obiJCVU2ubp9De3igudXi
         WKeIuecTWGoDhCUESnQNWmgIrNecrYdkZrHYz8GX9lMiCl7i6ULEtT+AWCNkR9AZ/ba3
         oUVX3US6PAnNQz6TYvsIw9VtQfTq3RJtEDh/QuQK1Q/WuLycaI6dDvrjhMoQr6U/y00d
         GuAU2l6n+6uVPIhDGmiUZwnyMhQ/xnPY75+2eVqpL0GR7bCi12npHvjaGFi5YUdZ6trV
         QtXUJlvyBYSQ3qlmL7gU62MOvjDvhZnz/8LlDdRYIgfNPRpFhBtc3MhOrCSj3wuq+3gs
         qpXA==
X-Gm-Message-State: AOUpUlGhJiq5A/Scd8ebZ1GhytO1fJjuirAPbJkvJ6bYI4dZ2lRGKcJk
        EdrJ3xOkQY3FGv0gtpnJBYY=
X-Google-Smtp-Source: AA+uWPwCkJVghp9dWd3xzKndnODWZnDFmUMJhflHBHvr/LcORhLQBEaurMI9ggGqFiljD/lcIhkTiQ==
X-Received: by 2002:adf:c891:: with SMTP id k17-v6mr14620184wrh.6.1534276445728;
        Tue, 14 Aug 2018 12:54:05 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e133-v6sm31270657wma.33.2018.08.14.12.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 12:54:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH] submodule: add more exhaustive up-path testing
References: <20180814185906.2680-1-avarab@gmail.com>
        <CAGZ79kaK8Wt0TGvo-PyDZRLWr9PU0BRo4=DiYUXvv8c8nZ+M8A@mail.gmail.com>
Date:   Tue, 14 Aug 2018 12:54:04 -0700
In-Reply-To: <CAGZ79kaK8Wt0TGvo-PyDZRLWr9PU0BRo4=DiYUXvv8c8nZ+M8A@mail.gmail.com>
        (Stefan Beller's message of "Tue, 14 Aug 2018 12:10:41 -0700")
Message-ID: <xmqqbma42083.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Thanks for this patch!
> Stefan

Thanks, I'd take it as your Acked-by: (please holler if it isn't
before the patch hits 'next').
