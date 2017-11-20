Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C1BD202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 22:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbdKTWFC (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 17:05:02 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:36929 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbdKTWFB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 17:05:01 -0500
Received: by mail-it0-f68.google.com with SMTP id m191so13603666itg.2
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 14:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hh8MXlYyIhkrcrX+4Rknh0dFZNYYXIg9UNPS8ovb+bs=;
        b=nr/PBLgv7tRyNcQZddozf1ToSZNvZztgPPbIWAX0P5jRvwrT9MdejQgKqL0i2KcBd0
         hRzWqikvOP8AtJ0H7amcByMDTHqHRQCULw5BhmeZ7MXBgJjDHskrQXzPVnSdzoY7sZqe
         O5w/r5oTR1/SpkFTjRJHy9iEcrx/vK6C6HEwytKDV2m8uxFZQsWgS98znPkcASbxBrF1
         +NyR1+uciErHQjddqZX8bqJqHoJwmRDpS286OE/r98qkuBnXeweMSNLgCGRKLFhBbI72
         hpc1NnnFLhn1hEZcD/JPjrVofOBcyvQjzD2wv35yHac3si6no4g/6GcNZboHoEoR8/2T
         ehQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hh8MXlYyIhkrcrX+4Rknh0dFZNYYXIg9UNPS8ovb+bs=;
        b=sxsDh2DkVTgtFjkkK+MGWRr/51n8iIHtYZ5xMpRFVL+hybcnGcjMwcs9hcviHu0Qez
         1T9z578qilnNl1p97M5khdPAmAWPpkDiOUkioDT2mUAaTKxMUhwaYhpeZNqPDJzoVFer
         xPR+Nv9VFeb+oAIydGPp4Ogs9zy/W5GdsknQC+y7QvClxhJ0GKi0YeBjl1fndl2iBEN6
         olEHWd4kkHxdWuUNDWWudVGnLqCD1fKNGxu++qJS4tmNHQWFJPAq4u6qWD5hlCjRvhV4
         Hu9V1wiiTijBRtWI0d3ACJah42jX+GwSZOfHUHWF2DpZT4+ftXt6LTBdfvSrgIpiN+FD
         tfAQ==
X-Gm-Message-State: AJaThX5WQLdV+5ZjNsRtFsfi0lCJuojmPoxhIz81s72AKZzC7wNrABE2
        K/yADeI52vb2ORTAe7tuQ7w=
X-Google-Smtp-Source: AGs4zMaMDTycFOzZNiizlKnNEqFLgN4wgtif8jDDW1Qgv/xcxg/Wz+dsj0pffGF+qz2dXlmeR7c4Vw==
X-Received: by 10.36.240.78 with SMTP id p14mr1893752iti.28.1511215500900;
        Mon, 20 Nov 2017 14:05:00 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id v8sm5393894itc.5.2017.11.20.14.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Nov 2017 14:05:00 -0800 (PST)
Date:   Mon, 20 Nov 2017 14:04:58 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Segev Finer <segev208@gmail.com>
Subject: Re: [PATCH 3/8] connect: split git:// setup into a separate function
Message-ID: <20171120220458.sxltsyheixgkunyh@aiede.mtv.corp.google.com>
References: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
 <20171120212327.ssk6vmw2hd5jwbi5@aiede.mtv.corp.google.com>
 <20171120215218.GB92506@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120215218.GB92506@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:
> On 11/20, Jonathan Nieder wrote:

>> +	/* These underlying connection commands die() if they
>> +	 * cannot connect.
>> +	 */
>
> I know this is really just code motion but maybe we can fix the style of
> the comment here?

How about doing that as a separate commit?

-- >8 --
Subject: connect: correct style of C-style comment

Documentation/CodingGuidelines explains:

 - Multi-line comments include their delimiters on separate lines from
   the text.  E.g.

	/*
	 * A very long
	 * multi-line comment.
	 */

Reported-by: Brandon Williams <bmwill@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 connect.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git i/connect.c w/connect.c
index 20ed1d9574..e544a5e1dd 100644
--- i/connect.c
+++ w/connect.c
@@ -889,7 +889,8 @@ static struct child_process *git_connect_git(int fd[2], char *hostandport,
 
 	transport_check_allowed("git");
 
-	/* These underlying connection commands die() if they
+	/*
+	 * These underlying connection commands die() if they
 	 * cannot connect.
 	 */
 	if (git_use_proxy(hostandport))
