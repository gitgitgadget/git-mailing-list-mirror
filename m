Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAAB01F453
	for <e@80x24.org>; Fri,  1 Feb 2019 21:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfBAVDb (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 16:03:31 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37823 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfBAVDb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 16:03:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so7540044wmd.2
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 13:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jL+aCqpKUJCN9UCEgGrlI8E9Vb9bqtw1cks33ggR4AU=;
        b=WqPzBcN9dC0q8M5NgzahzsE+P7dSJEKseqMsJo1UDPkCVbY+AfT5nxp7v6eaFFsozO
         nl5U8kwBUNo9i6BxQWyDKYu83uivNhEDFxGjoNHwVzXyArW3cgCp9M+x5LcNlb5Pm0KW
         b8SbecrJWK+qHnjaqSbBNlJiqgAeD7JnlLoozeEtzBiW3aD7aAyzc9zMBrzwhsmIJXKH
         1la5tPsPb8xeSFIed23VAZWQCU63g0RodGOKUVR8x06ygOFhsw7xpwCDWpw+lr4T5rcJ
         jDAh0KYiZNI73vncJAsl2XG5UOuDLy7Kp1M9MDixSA5DfRqaV47K8e97Xt4YceePVVdi
         i3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jL+aCqpKUJCN9UCEgGrlI8E9Vb9bqtw1cks33ggR4AU=;
        b=EqlWWjjJUB1Q9jcAFAL5U+k/wZHxNqi1nmPnv+KF4njuMfs4GyoshS8djtz1m3FROK
         If6Mb4QseY06rIhqMDGdpEQPypq/Qr1KDnWGLKIMszvhSyMP/IJnQ/GPnFLSlPzr31DG
         nezy6+6iMBJ3nrEHpLnaP7X6yWoaC7lIgh1K/0Azr+tvgcTxkuQWxWhzeFbb+VKM543f
         ZZat8Cr+K1zK03EKJ2lYdela+nIYhbZEBB/CpwnOIlX5aVOiz7Fp13w3aN5q/B0QH8cL
         k+AZ0fV50hHcN0eZa/eEbCjQAwiw00zWu6H0LpFWLh7RhKabphu1MhCu6rxpJtJ5pkL5
         QawA==
X-Gm-Message-State: AHQUAuayFs34ONc6OVbMRzJRgWaW9HRy0XF7T8hh3vHGWMT66aIkcwPm
        I65KqbFOT9FlMm871cOo3VE=
X-Google-Smtp-Source: AHgI3IaXeyupXi0QlONsVY+p4OCm4ISb+gBKlpNJnoUBrnMIEAhP2AOqY7/h9Vop2h2Mgzz03mWP/w==
X-Received: by 2002:a1c:7ec4:: with SMTP id z187mr3849385wmc.43.1549055009192;
        Fri, 01 Feb 2019 13:03:29 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v6sm5348889wro.57.2019.02.01.13.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 13:03:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>, Sun Chao <sunchao9@huawei.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v9 1/6] t5323: test cases for git-pack-redundant
References: <20190130114736.30357-1-worldhello.net@gmail.com>
        <20190201162152.31136-2-worldhello.net@gmail.com>
        <CAPig+cRX=ttHWe1C6m1u9-02oT-TpBtHWb48N=-wX4jSYaFuew@mail.gmail.com>
Date:   Fri, 01 Feb 2019 13:03:28 -0800
In-Reply-To: <CAPig+cRX=ttHWe1C6m1u9-02oT-TpBtHWb48N=-wX4jSYaFuew@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 1 Feb 2019 14:42:53 -0500")
Message-ID: <xmqqva23xlun.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Feb 1, 2019 at 11:22 AM Jiang Xin <worldhello.net@gmail.com> wrote:
>> Add test cases for git pack-redundant to validate new algorithm for git
>> pack-redundant.
>>
>> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>> ---
>> diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
>> @@ -0,0 +1,510 @@
>> +# Note: DO NOT run it in a subshell, otherwise the variables will not be set
>
> Which variables won't be set? It's not clear what this restriction is about.

>> +       git -C "$repo" update-ref refs/heads/master $oid
>> +}
>> +
>> +# Note: DO NOT run it in a subshell, otherwise the variables will not be set
>> +create_pack_1 () {
>> +       P1=$(git -C "$master_repo/objects/pack" pack-objects -q pack <<-EOF
>
> Which variables? Note that you can capture output of a subshell into a
> variable, if necessary.

These helper functions set a bunch of variables $P1, $P2, etc. as
well as variables whose name begin with P and followed by 40-hex.
The script wants to use them later when preparing expected output,
and with the most natural way to organize the code, that "later"
happens in the process that would have spawned a subshell to run
this function.

It would have been easier for you to grok if the note instead said
"this function sets two global shell variables" or something,
perhaps?  Such a variable would certainly not be visible if this
function is called inside a subshell to the main process.
