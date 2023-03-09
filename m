Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61607C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 23:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjCIXlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 18:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjCIXlB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 18:41:01 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B37F9EC3
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 15:41:00 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id a2so3789395plm.4
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 15:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678405260;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUC4PVHhp49JwB8s9BaUUKB6gqAl0jtTqaL91BP3sak=;
        b=QVGnbqVQVaGPO8ntWfv9KiWRU89CSHW82SAv73UKd1lA5DFVA1SlJnmoJwjdP1TTm/
         zqFW73wWiIN6DjiaJoitEFVQblS4l78oK7nLojZbwTEStXwtANz50G65UukHFd7fPTcs
         /iFPcud0MrPfS+NAfhUsF6kznZcTQJ1Fv6VLj0mCW3IWvKyaTSoL/joy061uWfy3BL5Y
         AAth2/TYJzC4DTAcFyr3rlFniqR7Q1IJMfnm3j/3HEZ8SL8hOunKooFj7Dzte9ZHfRbm
         ytg6FafpuwQRrmj8v1LSibWIW3J5xx7IbyhSfmFSnVBBlr5HkwAlS4KhU7dhLhUb+mmZ
         15VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678405260;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nUC4PVHhp49JwB8s9BaUUKB6gqAl0jtTqaL91BP3sak=;
        b=s2x5VYSTHX0DgnmenYewMbvPVPQNTu2F/ogn8CkfcJt0DfQPrWf4vd3BU3q6v8KExd
         waKISDK0/tr5d91ydsUIc9GPlAUzgmeoUsyLGIXytwkWtSzEzbeHCnm6XxzLIKqTbnYg
         dfHpPaD0APzM17KfLSa8Wni2NbUKn+gLVmsYPqveIRBb7JgFv8sdDm3+c5IJOA7nC7Lq
         l7y3c5b/LyYPUq4xU7OVLFy5B+kLDmEyPIYvQE+V0Ch0fP8NqF74a9ZWxGKd6JyvL26a
         62edL6Wpwo9I2dqJJuT5H/TWucfOjX5Hit2Ja85ZQkqlZgd5MbQsnjk6NP7sEZunkaqG
         kNGA==
X-Gm-Message-State: AO0yUKXMuZRr12GZI38ydMjcGfQshkM6ss5Z1seGHS2Xxfo9cgFJy51L
        F3rQ8rQspEGet7yE7KIOL2Q=
X-Google-Smtp-Source: AK7set/BcQw0eg9b5EcQdqU1TKRgU1DBBO2mRjA8ZqequCjgoz/mv+QJGYurpf7moDtGCo1qvIsgtg==
X-Received: by 2002:a17:902:7841:b0:196:d05:bac7 with SMTP id e1-20020a170902784100b001960d05bac7mr18409129pln.58.1678405259678;
        Thu, 09 Mar 2023 15:40:59 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id ki3-20020a170903068300b0019adfb96084sm185064plb.36.2023.03.09.15.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 15:40:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, vdye@github.com,
        git@vger.kernel.org
Subject: Re: [PATCH v4 1/2] t1092: add tests for `git diff-files`
References: <20230309013314.119128-1-cheskaqiqi@gmail.com>
        <20230309063952.42362-1-cheskaqiqi@gmail.com>
        <20230309063952.42362-2-cheskaqiqi@gmail.com>
        <xmqqmt4lc03s.fsf@gitster.g>
        <CAMO4yUFs5zSafO1pGFZqBU9R58G8ENhfTh5qNayeFMRPrCa+Jg@mail.gmail.com>
Date:   Thu, 09 Mar 2023 15:40:59 -0800
In-Reply-To: <CAMO4yUFs5zSafO1pGFZqBU9R58G8ENhfTh5qNayeFMRPrCa+Jg@mail.gmail.com>
        (Shuqi Liang's message of "Thu, 9 Mar 2023 18:21:04 -0500")
Message-ID: <xmqq356d8pdg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

> I wonder if the method below is good  to test the actual output for '
> file present on-disk with modifications' :
>
>     cat >expect  <<-EOF &&
>     :100644 100644 8e27be7d6154a1f68ea9160ef0e18691d20560dc
> 0000000000000000000000000000000000000000 M newdirectory/testfile
>     EOF

Hardcoding 8e27be assumes we only support SHA-1 but there is a CI
test job that runs everything in SHA-256 mode, so it is likely
to break if you wrote it like so.  Something along the lines of ...

	FN=newdirectory/testfile &&
	OID=$(git hash-object $FN) &&
	ZERO=$(test_oid zero) &&
	echo ":100644 100644 $OID $ZERO M new $FN" >expect

... may have a better chance to be correct, but I didn't test ;-)
