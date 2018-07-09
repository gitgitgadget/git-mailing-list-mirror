Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 887EB1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 17:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934124AbeGIRpi (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 13:45:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37047 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934100AbeGIRpg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 13:45:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id n17-v6so21642897wmh.2
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 10:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gQd7awpctrtepj2ukzRpVor6jgOqx8OBVgfUgpaUBaE=;
        b=Oc9a13eHrGMV1QgV0lAQ4cyoojdJ1MMmUm4WQK5TLkOtEDF92ppkz1lwnS62eL1AIQ
         jfew/LmmKemK+1JNIhA7ZPGwZ9UAINMQXh6hqq1O8Fs6A/axGANcrEY3c6mjB8KiymbM
         qYc0dVX/Cc7uTwYSiSobkLArmGNJlVkxMlulNDST6Mi7SNV2JneTWXpaW8wkHstUMcMc
         sUh8+RaVlQwGmdAzusG/OdG/Sc9X+NdirJzjDZI6usTZBBqwfHvBYspNgHQu//8kQYg5
         ItdWRTZXWYlN2i3x0OzNKFy1ooOwXJzVScbNe8Dv6dT8HmoCO2jI2UQZpFuZh6q4wUJ4
         x4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gQd7awpctrtepj2ukzRpVor6jgOqx8OBVgfUgpaUBaE=;
        b=b0k7odb3cOSpEyTajx8YqGb55KuPIpkNgCRlu/eoJBBCEqLI58gDbG51ch2DY9nEq6
         JhRFleILgNjMy4wpWgFto25rUmySZQCiiONkjGO0s0d9KuJ3kwTViJXq11Q0/7shT7uo
         HIdUWz9kGj9Vd/aH8xfCAuAOAGArgdiNaMQefZKJ3IgcK0O8G3cqrtspg3UGrXFwQG4z
         4KkdihzTjbMSEFbJXKFUYMu5hgNCvwsWogpIt2e6ayV9mf3SIGOUO4Ep+BPj14YdMqjz
         pWdfBfSyQjP7gxij4xkZELfgc7HVopvrZoZLWulo2VOB61w9KK2I5KyQZ5myR7FumBbf
         gglA==
X-Gm-Message-State: APt69E276vUm0h/iTILFphFFwo5ZG/NvHBFxDlZbvSSNRB39+Vqn02j2
        PbRSWrWyuudTc7xcCpdOf08=
X-Google-Smtp-Source: AAOMgpf0nVz/pmYfe4u5T5kY2CxrPPIthaRi9+c8SmxAKlHc3feKleXWfQJAb6mNk02FUT/HOEWUIQ==
X-Received: by 2002:a1c:8952:: with SMTP id l79-v6mr12138001wmd.7.1531158335087;
        Mon, 09 Jul 2018 10:45:35 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g10-v6sm5120290wru.43.2018.07.09.10.45.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 10:45:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 07/17] commit: increase commit message buffer size
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
        <20180708233638.520172-8-sandals@crustytoothpaste.net>
        <4eb44f33-ac9c-7ce2-0e53-ec6fcb4560fd@gmail.com>
Date:   Mon, 09 Jul 2018 10:45:33 -0700
In-Reply-To: <4eb44f33-ac9c-7ce2-0e53-ec6fcb4560fd@gmail.com> (Derrick
        Stolee's message of "Mon, 9 Jul 2018 09:09:00 -0400")
Message-ID: <xmqqva9oe20y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 7/8/2018 7:36 PM, brian m. carlson wrote:
>> 100 bytes is not sufficient to ensure we can write a commit message
>> buffer when using a 32-byte hash algorithm.  Increase the buffer size to
>> ensure we have sufficient space.
>>
>> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
>> ---
>>   refs/files-backend.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index a9a066dcfb..252f835bae 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -1587,7 +1587,7 @@ static int log_ref_write_fd(int fd, const struct object_id *old_oid,
>>   	char *logrec;
>>     	msglen = msg ? strlen(msg) : 0;
>> -	maxlen = strlen(committer) + msglen + 100;
>> +	maxlen = strlen(committer) + msglen + 200;
>>   	logrec = xmalloc(maxlen);
>>   	len = xsnprintf(logrec, maxlen, "%s %s %s\n",
>>   			oid_to_hex(old_oid),
>
> nit: 100 is not enough anymore, but wasn't a very descriptive
> value. 200 may be enough now, but I'm not sure why.

As Brandon alludes to downthread, we probably should use strbuf for
things like this these days, so a preliminary clean-up to do so is
probably a welcome change to sneak in and rebase this series on top
of.

"%s %s %s\n" with old and new commit object name and the message
will be "2 * len(hash_in_hex) + 4" bytes long (counting the three
whitespaces and the terminating NUL), and Shawn's original in
6de08ae6 ("Log ref updates to logs/refs/<ref>", 2006-05-17) actually
computed this one as "strlen(...) + 2*40+4".

100 was merely me being sloppier than Shawn at 8ac65937 ("Make sure
we do not write bogus reflog entries.", 2007-01-26), preferring
being sufficient over not wasting even a single byte.
