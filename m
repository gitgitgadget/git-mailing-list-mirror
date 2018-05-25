Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFE901F42D
	for <e@80x24.org>; Fri, 25 May 2018 04:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbeEYEJe (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 00:09:34 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38744 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751794AbeEYEJd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 00:09:33 -0400
Received: by mail-wm0-f67.google.com with SMTP id m129-v6so10762414wmb.3
        for <git@vger.kernel.org>; Thu, 24 May 2018 21:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=JXwkk4q1Yc8YAVbK+TF6MDL0+sFCtp2GqnKbQnrK0xY=;
        b=ECUsbO1je9ape3PxgMzRIEKfb/M3fD3d0AUe4J92eTNKXrUkEjIOzo1ogAaxym4lb0
         DuENB8HVcHIGPqLL8opom0Y96+cK2AlotSdUzn+ZqxJkf7+AzU1ojey+LmE9BHZXFQPf
         ijYMLvdib8t2fDhOipopBEtzpHkYejtSOzD3BNe9oRWYxRIglDlKAukmTndzk6mDTvhJ
         gge3bEnH4cFrbZ0QVn6ny2+FuCDH8mBlCBhKjOYXHS0Wwz3PpbCWuqY0j8FNAPjyyyx0
         q/K/PvqjHBOnA99xgwQkOJk0BeuKgiOG256KvOwclBYU7+DAAkM70IR1cvFrRdJC6yE5
         Z4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=JXwkk4q1Yc8YAVbK+TF6MDL0+sFCtp2GqnKbQnrK0xY=;
        b=RUMj5iWgeg1nxly18EWAGufVrTwa+RWVzNIdCmmmxOvkcpwtaTLDuS5Ab4Rh4hkLIj
         DymHUG2GSlM5V4VOVwDvF9RL5qB6YPQmUgfYz030P1LMdQgFMda36WqHIswjJXqiHpAU
         CkIvjVmiZgoufeEV2v7V8NC8FeHn7LxAZqgmeXU4j7tc2adc7G9X2IDThRGv+uMPAlqM
         Y/smFYAeIpu+ilUvreMe22lt5RQ7tsBlP1ygCaChwN06l5Q8PrSrLNzosixP1+rgbiFW
         qmxVfPuRoGhlhp66OLHSIqcXZshJ43V7BfSfyfm4SnIXd8BPH5tlPkuCfge+IpIUvDIM
         fC/w==
X-Gm-Message-State: ALKqPwceqv4pYqiatWCzErPKafDgQ/hm1fu5ccOPg1K7LxRleg7riLZb
        OmDUwzp/QKabKUn7qijXR7I=
X-Google-Smtp-Source: ADUXVKKT5LW5HMHpBXN0RUSQXzNwQse7myGx4yoHKEbIZ+H9iI2fX60nMUOxoEMtXyFqmYiSOu3NEQ==
X-Received: by 2002:a1c:96d3:: with SMTP id y202-v6mr367781wmd.106.1527221372010;
        Thu, 24 May 2018 21:09:32 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h8-v6sm4818652wmc.16.2018.05.24.21.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 21:09:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/4] fetch: implement fetch.fsck.*
References: <20180524193516.28713-1-avarab@gmail.com>
        <20180524190214.GA21354@sigill.intra.peff.net>
        <20180524193516.28713-5-avarab@gmail.com>
Date:   Fri, 25 May 2018 13:09:30 +0900
In-Reply-To: <20180524193516.28713-5-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 24 May 2018 19:35:16 +0000")
Message-ID: <xmqqy3g8nzph.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

>  fsck.skipList::
> -	Like `fsck.<msg-id>` this variable has a corresponding
> -	`receive.fsck.skipList` variant.
> +	Like `fsck.<msg-id>` this variable has corresponding
> +	`receive.fsck.skipList` and `fetch.fsck.skipList` variants.
>  +
>  The path to a sorted list of object names (i.e. one SHA-1 per line)
>  that are known to be broken in a non-fatal way and should be

I think I've said this already, but I tend to agree with Eric that
this is the other way around.  Perhaps that is because I consider
fsck.<var> the most basic one people would want to understand first,
and then corresponding <command>.fsck.<var> a mere specialization of
it.  So "Here is what fsck.skipList does" followed by "By the way,
you can configure it only for the (internal) fsck run during the
object transfer with transfer.fsck.skipList" feels more natural
presentation order.

> diff --git a/fetch-pack.c b/fetch-pack.c
> index 490c38f833..9e4282788e 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -19,6 +19,7 @@
>  #include "sha1-array.h"
>  #include "oidset.h"
>  #include "packfile.h"
> +#include "fsck.h"
>  
>  static int transfer_unpack_limit = -1;
>  static int fetch_unpack_limit = -1;
> @@ -33,6 +34,7 @@ static int agent_supported;
>  static int server_supports_filtering;
>  static struct lock_file shallow_lock;
>  static const char *alternate_shallow_file;
> +static struct strbuf fsck_msg_types = STRBUF_INIT;
>  
>  /* Remember to update object flag allocation in object.h */
>  #define COMPLETE	(1U << 0)
> @@ -935,7 +937,8 @@ static int get_pack(struct fetch_pack_args *args,
>  			 */
>  			argv_array_push(&cmd.args, "--fsck-objects");
>  		else
> -			argv_array_push(&cmd.args, "--strict");
> +			argv_array_pushf(&cmd.args, "--strict%s",
> +					 fsck_msg_types.buf);

This made a reader wonder what fsck_msg_types.buf[] has.

It is empty or a comma separated list of things, prefixed with =,
that is constructed by repeated calls to fetch_pack_config_cb(), so
syntactically what we feed index-pack looks like "--strict",
"--strict=thing", or "--strict=thing1,thing2,....,thingn".  And each
"thing" is either "<msgtype>=<value>" or "skiplist=<objectname>".

The buffer that has both msgtype specification and object name
should not be called fsck_msg_types, though.  It is probably
fsck_exception or something.

> +		strbuf_addf(&fsck_msg_types, "%cskiplist=%s",
> +			fsck_msg_types.len ? ',' : '=', path);
> +		free((char *)path);
> +		return 0;
> +	}
> +
> +	if (skip_prefix(var, "fetch.fsck.", &var)) {
> +		if (is_valid_msg_type(var, value))
> +			strbuf_addf(&fsck_msg_types, "%c%s=%s",
> +				fsck_msg_types.len ? ',' : '=', var, value);
> +		else
> +			warning("Skipping unknown msg id '%s'", var);
> +		return 0;
> +	}
> +
> +	return git_default_config(var, value, cb);
> +}
