Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 835B3202F2
	for <e@80x24.org>; Tue, 21 Nov 2017 02:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751957AbdKUCB4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 21:01:56 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:44536 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbdKUCBz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 21:01:55 -0500
Received: by mail-it0-f66.google.com with SMTP id b5so146530itc.3
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 18:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QEQ3BbgvH4YNINgtjXyov/idlcq7/60S5C0575ir2XI=;
        b=eMalfg/JLXTMupvl9R2EZv21bea/LErVzZkHlYJeV8m3aIFit/K4G7Ji045HWWB+/C
         AdktzeUOTeC9kkWTamyH50iyc/uC+TxjsB6sUwsHgb+Q9Q6smxg3NDDfcdmLWyHdcJAM
         8VGSfRIqmeS2JIWMU5SnVIYrjkG0RyQDsw4E7PT/Db6x8+0mB6UjLKUBtvN6VIgploGv
         H9ftEfL61A5+5JXNCuu/NnHsOH0u6p8YskmpHfXCLPTqoVtrOI+gkmdmOTiFb3jAo9tj
         Oag7N/yAVowEb745pecnrZ3a1bDS07jBd1vuVg/36wMkS53nbRedwd6iC3Cv7gZ12iWi
         nKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QEQ3BbgvH4YNINgtjXyov/idlcq7/60S5C0575ir2XI=;
        b=s0dWaRLp1PmWCkfcNYbwxmWMYf+TJh/7oPOhv/4cwn7zdH6mqZ4tppwlnQ8phl2QsJ
         LxAXWohIX85a9GVr8d8Y5QmKSnFMTz11rFqTgsOVmBhQNxsIqDorNnAvX3n8t3JY0WRV
         ARMJoMCPdCHzzQIPDwT0yVFXOmw6kqUJMYnzhCnNId4o+1iL1CWDfFbCLtr1dZjEzJgw
         rWZrPk+8ujE05t9A6Y0sngwv8kT/3IK8O4+vSanwqz5HCWEWUVbv4PJu7h0xhI4Ocaby
         QfThJE4zklkaTnYaLn8KKgNYAfyQqmRfh9TOxc9RqbenGtrmKQMycxm85KfLXbsI6aiB
         dENw==
X-Gm-Message-State: AJaThX4ZYAgeQ78Asz9RCXqz76UYmkWgrqawg6GE1Vp/8cos6E+RtzwL
        Z/hQDvsuR/1SQaTH6PeNQcU=
X-Google-Smtp-Source: AGs4zMbiH/QfOeTQKx82IutcDvYfBKCK6IWl5pM68EVrtSghgwOdyw5Wj8dJ0NKw0RmgFJZEyVVZjw==
X-Received: by 10.36.74.135 with SMTP id k129mr21849063itb.147.1511229714941;
        Mon, 20 Nov 2017 18:01:54 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id i33sm5112426ioo.64.2017.11.20.18.01.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Nov 2017 18:01:54 -0800 (PST)
Date:   Mon, 20 Nov 2017 18:01:52 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Segev Finer <segev208@gmail.com>
Subject: Re: [PATCH 6/8] ssh: 'auto' variant to select between 'ssh' and
 'simple'
Message-ID: <20171121020152.b35kxjyzdveclsu6@aiede.mtv.corp.google.com>
References: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
 <20171120213004.57552ja3nmxy6pmc@aiede.mtv.corp.google.com>
 <xmqqlgj0jtai.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlgj0jtai.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Android's "repo" tool is a tool for managing a large codebase
>> consisting of multiple smaller repositories, similar to Git's
>> submodule feature.  Starting with Git 94b8ae5a (ssh: introduce a
>> 'simple' ssh variant, 2017-10-16), users noticed that it stopped
>> handling the port in ssh:// URLs.
>>
>> ...
>> Reported-by: William Yan <wyan@google.com>
>> Improved-by: Jonathan Tan <jonathantanmy@google.com>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> ---
>
> Not a big issue, but the above made me wonder, due to lack of any
> signed-off-by before improved-by, what "base" was improved by JTan.
> If you were writing a change before formally passing it around with
> your sign-off and somebody had a valuable input to improve it, it
> seems that people say helped-by around here.

Yep, I should have put the Improved-by after my sign-off.

Jonathan Tan's contribution was at
https://public-inbox.org/git/20171023151929.67165aea67353e5c24a15229@google.com/

[...]
>> +The config variable `ssh.variant` can be set to override this detection.
>> +Valid values are `ssh` (to use OpenSSH options), `plink`, `putty`,
>> +`tortoiseplink`, `simple` (no options except the host and remote command).
>> +The default auto-detection can be explicitly requested using the value
>> +`auto`.  Any other value is treated as `ssh`.  This setting can also be
>> +overridden via the environment variable `GIT_SSH_VARIANT`.
>>  +
>
> Cleanly written and easily read.  Good.

i.e. that part is all thanks to him. :)

Jonathan
