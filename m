Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C1981F597
	for <e@80x24.org>; Mon, 16 Jul 2018 19:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbeGPUGA (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 16:06:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40235 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730180AbeGPUGA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 16:06:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id t6-v6so33041377wrn.7
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 12:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hTjCPW5hPeL0/1MiywG+4rdMiz+J5PkXAQj0a5btg0Q=;
        b=KrQ0hBcFr7uMQme1wlK//ixpssmliOBsMDMRV8iwV7c88XOpOESRwc2JYKEvnQDV/f
         XZDm7jebcbd3elXE12hISjtFOUaV3tVVU65E7r89hPXA/8HA6/Q5MjbatkhMe64fQv9G
         0c70Ry3pJvGwXwexFzyIcZ35vGhi6Xv+SRmBp92Ca1WUriYvUAB46Po26cz8VwUUurO4
         sbh30x9ovdUsONYg11frKhsrgInbPy5LUxzNEDiCTv7KVEIj2SeKO5YO1CFj3cUYlv7E
         By/ou3kRfvZHwFNiCKkRnMk+YzcgwPOqud6BS7nP2NqUwFkcjg+sgsAczV40Int9dYpT
         Y6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hTjCPW5hPeL0/1MiywG+4rdMiz+J5PkXAQj0a5btg0Q=;
        b=o6i/T/wd+syYo2FqoW6llSukqJavhvcLujAW3IBX2qOB1Hu70XDdMtYvdj59hErBr0
         JYZ6O8aBDeIBJB6p8j8ZdAiG7OAFULycJXPGfIJawWUbLhzQJyf/z9ZVF+y0gCtWJ+vk
         O4AO50y85nRBQOsO9OObyTiH4fV/apeqcDjrJ6Zx9Idz9P2eiq6V44aQAkzxnDG0Wn29
         vuk2HdEwBc1H8154T/st7vmxdXLJiEpwmeXDcvrQo3JKz6PvFRSbkSwfQGrpb7ilU/JL
         B66soN03O3Gf+qur3XTtAoRH4XkXdby0llzU4AF+8mWLwL2qBzzVQvWaBerKvidka0Ku
         IoDQ==
X-Gm-Message-State: AOUpUlHRTNapcMZ9wOgqDAk9CHIZzhJDQKZeRqXoSxwkQTqzGLw6X+xe
        O3eaqp6XBWTOoPxTvqUiSWY=
X-Google-Smtp-Source: AAOMgpejMC7IZfNT9d3nbaFq5ZA5ZgLyG6xhj0U4srDP1Spu1fijzzgO1RFlwL/NfAYw4FiWVOWDIw==
X-Received: by 2002:adf:e841:: with SMTP id d1-v6mr13066954wrn.269.1531769826586;
        Mon, 16 Jul 2018 12:37:06 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n8-v6sm47693130wrt.56.2018.07.16.12.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 12:37:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] builtin/submodule--helper: store update_clone information in a struct
References: <20180712194754.71979-1-sbeller@google.com>
        <20180712194754.71979-5-sbeller@google.com>
Date:   Mon, 16 Jul 2018 12:37:05 -0700
In-Reply-To: <20180712194754.71979-5-sbeller@google.com> (Stefan Beller's
        message of "Thu, 12 Jul 2018 12:47:52 -0700")
Message-ID: <xmqqo9f7t1jy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The information that is printed for update_submodules in
> 'submodule--helper update-clone' and consumed by 'git submodule update'
> is stored as a string per submodule. This made sense at the time of
> 48308681b07 (git submodule update: have a dedicated helper for cloning,
> 2016-02-29), but as we want to migrate the rest of the submodule update
> into C, we're better off having access to the raw information in a helper
> struct.

The reasoning above makes sense, but I have a few niggles on the
naming.

 * Anything you'd place to keep track of the state is "information",
   so a whole "_information" suffix to the structure name does not
   add much value.  We've seen our fair share of (meaningless)
   "_data" suffix used in many places but I think the overly long
   "_information" that is equally meaningless trumps them.  I think
   we also have "_info", but if we are not going to have a beter
   name, let's not be original and stick to "_data" like other
   existing codepath.  An alternative with more meaningful name is
   of course better, though, but it is not all that much worth to
   spend too many braincycles on it.

 * Is the fact that these parameters necessary to help populating
   the submodule repository are sent on a line to external process
   the most important aspect of the submodule_lines[] array?  As
   this step is a preparation to migrate out of that line/text
   oriented IPC, I think line-ness is the least important and
   interesting thing to name the variable with.


If I were writing this patch, perhaps I'd do

	struct update_clone_data *update_clone;
	int update_clone_nr, update_clone_alloc;

following my gut, but since you've been thinking about submodule
longer than I have, perhaps you can come up with a better name.

> @@ -1463,8 +1469,9 @@ struct submodule_update_clone {
>  	const char *recursive_prefix;
>  	const char *prefix;
>  
> -	/* Machine-readable status lines to be consumed by git-submodule.sh */
> -	struct string_list projectlines;
> +	/* to be consumed by git-submodule.sh */
> +	struct submodule_update_clone_information *submodule_lines;
> +	int submodule_lines_nr; int submodule_lines_alloc;
>  
>  	/* If we want to stop as fast as possible and return an error */
>  	unsigned quickstop : 1;
> @@ -1478,7 +1485,7 @@ struct submodule_update_clone {
>  #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
>  	SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, 0, \
>  	NULL, NULL, NULL, \
> -	STRING_LIST_INIT_DUP, 0, NULL, 0, 0}
> +	NULL, 0, 0, 0, NULL, 0, 0, 0}

The structure definition and this macro definition are nearby, so it
is not crucial, but its probably not a bad idea to switch to C99
initializers for a thing like this to make it more readable, once
the code around this area stabilizes back again sufficiently (IOW,
let's not distract ourselves in the middle of adding a new feature
like this one).
