Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B140A1F404
	for <e@80x24.org>; Thu,  1 Mar 2018 19:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034109AbeCATYJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 14:24:09 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46768 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033435AbeCATYI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 14:24:08 -0500
Received: by mail-wr0-f195.google.com with SMTP id m12so7736915wrm.13
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 11:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QNdiJoBg/fwX8y82mCiM8XdmqUlduUMaIxGI3rA/FtM=;
        b=pk6LYQemFVYRLjHyOQjSgv0XOyNY7biN1cp5NVWF8mRt4Qd8Y+Xwp0OLYhgxUjSb7B
         HVT34VcVvijVLHjf8hDOhSSSMcQn2lV6/ZwszMktAhF/96MujDn0VNSSq7V43DvEzvSf
         I+x6+0HQAozKZbYF9vhtY6A2HMaBokcfe7tvtcv15mPjw+YGVumZIZanHurzvfy2GD9o
         YPqn6ZFaGrpTSwI3hkmPQPekbR96kgR9/Iq+0KqWkUjoPiYqJuueYYzzDAFejK0SZGOl
         L3AFUn07TRo8/q9JK8dkR+G6y+v4V0IyJRGuwMdzQG71Vmg91d7iS/BqvNBrOes01pS8
         VWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QNdiJoBg/fwX8y82mCiM8XdmqUlduUMaIxGI3rA/FtM=;
        b=eGOdlL0700vcUG5vy/T29LesLXJ9WfusxwLDrP1EKzCsTghV3qbbmsUOMqtT2aw5/j
         sCaAKx8/XsHsNqxqARrVqJFhlq2MY56rl5hfi8wu+dvl5uUXIR1sE9eSeo7aC4D6kJsW
         1BNQkTqUsO7AjVhgQG6xtaLS7qBOOb2uRXToKgwRgjhBBvM2UyqzNQItmnvUetFK050y
         qR+MG/7hvqK1jQV6C24H/J/5IOiKkfQzgbESwLCd2Q8DrC0OtCpoGx+6nInSTGYBrO5z
         gIMX6VqOroC3/l55mLafEt9b3XIZg8P1mbFo4E2cBf10ksvP5rZLP3VfSAO25mMnXLHA
         /i0g==
X-Gm-Message-State: APf1xPDClrcjl8VkXdV1a5SDXnHWuUhj8WwEv8LQbnIaTlrBtVNeywg0
        PW3mVf9suVwy9pfhxlkS1uA0DCAY
X-Google-Smtp-Source: AG47ELslrYtHEf6ytx38LKZJtQW/m7EuXNAN7iDD+LKvJ2gxQcGTz7bmSMXlySkttE/73m/ienED8Q==
X-Received: by 10.223.187.68 with SMTP id x4mr2631957wrg.80.1519932246891;
        Thu, 01 Mar 2018 11:24:06 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d63sm5712506wmh.16.2018.03.01.11.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 11:24:06 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/5] roll back locks in various code paths
References: <cover.1519843916.git.martin.agren@gmail.com>
        <20180228195809.9145-1-martin.agren@gmail.com>
        <20180301074129.GE31079@sigill.intra.peff.net>
Date:   Thu, 01 Mar 2018 11:24:05 -0800
In-Reply-To: <20180301074129.GE31079@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 1 Mar 2018 02:41:29 -0500")
Message-ID: <xmqq4llzha5m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> IMHO the result is easier to follow. Except for one case:
>
>> -	if (active_cache_changed || force_write) {
>> -		if (newfd < 0) {
>> -			if (refresh_args.flags & REFRESH_QUIET)
>> -				exit(128);
>> -			unable_to_lock_die(get_index_file(), lock_error);
>> -		}
>> -		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
>> -			die("Unable to write new index file");
>> +	if (newfd < 0 && (active_cache_changed || force_write)) {
>> +		if (refresh_args.flags & REFRESH_QUIET)
>> +			exit(128);
>> +		unable_to_lock_die(get_index_file(), lock_error);
>>  	}
>>  
>> -	rollback_lock_file(&lock_file);
>> +	if (write_locked_index(&the_index, &lock_file,
>> +			       COMMIT_LOCK | (force_write ? 0 : SKIP_IF_UNCHANGED)))
>> +		die("Unable to write new index file");
>
> where I think the logic just ends up repeating itself.

Yup, this one I also had a bit of trouble with.
