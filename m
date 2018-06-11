Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76C3F1F403
	for <e@80x24.org>; Mon, 11 Jun 2018 17:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933547AbeFKRxb (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 13:53:31 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33426 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932821AbeFKRxa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 13:53:30 -0400
Received: by mail-wm0-f67.google.com with SMTP id z6-v6so16621519wma.0
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 10:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=T78wsMwETSxLPmY4ISBEGYbUJtZ3YTjRt6OnjdCYk7Y=;
        b=XnaoZr5g11aGmJlOQ4l+8fJwKc+mxmRyuG9hCtH8H+vkXlLhxclCKfIeV20MexHE0k
         UwwZvT9kT8payjiypR7PDOVugt3yfC654KNLxaVXNXGZ4eKOg2NyS9UJ9HuRgfxGgdzM
         bKd3Ek8H5dTy536SIojYSZEYRIdjRG8uNki5fLLChctWtldn+djk3CmQObtAX6uawsnk
         M3gYzlkhgzisKww53WfxkRWyzcMLPjNglw9BeLCnReT1by1z/l3WJ5GrhRyOWK/F6tBi
         ta0Wp+WtBmZxkWOdX19iERovJYCY+2yCoWzlX2OZW3b4UTzucCP14Z7aVI1K4/0iu8fZ
         MNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=T78wsMwETSxLPmY4ISBEGYbUJtZ3YTjRt6OnjdCYk7Y=;
        b=X7h7KMIca9XcvJL54uKM9drNfGSYnRw83qQTEA++V6tQZtnozZL/egql8SkCsbdo8t
         r1slpc24GyScIaRJLsjFD/Fq6YpwQYqbMt11FIVYt5wEoHqGArzRZQlzskhYqyyH4AaD
         JydaCOMhYGdQT742C4f6DbXfu3xvs5CNr957mXqWPJSvdN0LRUaaaQ5YCMMfRNTZ+D/9
         /NKtt9qkSilJuO4Zqm1rdMMMLHYvo8jEXYzbhOF1RdBGYWTJNf2gbQ4HG1FPsBAue3ms
         74iMGjCtrdR9SdPdCdHj53RBavZxUv9aN+qFX8WT6KxKUvQMzu1Cxs3Vf999GuRPWhnI
         MhaA==
X-Gm-Message-State: APt69E1zJwwF5904r5SgRaST9Qzk8EJ8ouXvthK/wwiSKalP6ClfLXbf
        YsUPGFIyTv+yFZcxofrwzRA=
X-Google-Smtp-Source: ADUXVKL99b9vJFiOV2aIFKdyG7r5yT3EmmMwkFlHbl/Sb6Ydr/LK9RB4uS4JJqJj7OTZUxJGH4+Twg==
X-Received: by 2002:a1c:4189:: with SMTP id o131-v6mr99668wma.7.1528739609019;
        Mon, 11 Jun 2018 10:53:29 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n71-v6sm4117059wmi.14.2018.06.11.10.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 10:53:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Matthew Coleman <matt@1eanda.com>,
        Stephon Harris <theonestep4@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org, Rick van Hattem <wolph@wol.ph>,
        Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH v2] completion: reduce overhead of clearing cached --options
References: <xmqqmuy2wz4j.fsf@gitster-ct.c.googlers.com>
        <20180417220219.30445-1-szeder.dev@gmail.com>
        <20180607054834.GB6567@aiede.svl.corp.google.com>
        <20180608211639.7611-1-szeder.dev@gmail.com>
        <20180608212348.GA42503@aiede.svl.corp.google.com>
Date:   Mon, 11 Jun 2018 10:53:27 -0700
In-Reply-To: <20180608212348.GA42503@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Fri, 8 Jun 2018 14:23:48 -0700")
Message-ID: <xmqqzi01b46g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi,
>
> SZEDER Gábor wrote:
>
>> Being in RC phase, I'm all for aiming for a minimal solution.
>> However, I don't think that the better fix would be erm.. any "less
>> minimal":
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index f2aa484758..7aeb575cd1 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -3244,7 +3244,10 @@ __gitk_main ()
>>  	__git_complete_revlist
>>  }
>>  
>> -if [[ -n ${ZSH_VERSION-} ]]; then
>> +if [[ -n ${ZSH_VERSION-} ]] &&
>> +   # Don't define these functions when sourced from 'git-completion.zsh',
>> +   # it has its own implementations.
>> +   [[ -z "${GIT_SOURCING_ZSH_COMPLETION}" ]] ; then
>
> Needs a - before the } to avoid errors in a shell where the user has
> chosen to use "set -u".  See v1.7.4-rc0~159 (completion: fix zsh check
> under bash with 'set -u', 2010-10-27) for more details.
>
>>  	echo "WARNING: this script is deprecated, please see git-completion.zsh" 1>&2
>>  
>>  	autoload -U +X compinit && compinit
>> diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
>> index 53cb0f934f..049d6b80f6 100644
>> --- a/contrib/completion/git-completion.zsh
>> +++ b/contrib/completion/git-completion.zsh
>> @@ -39,7 +39,7 @@ if [ -z "$script" ]; then
>>  		test -f $e && script="$e" && break
>>  	done
>>  fi
>> -ZSH_VERSION='' . "$script"
>> +GIT_SOURCING_ZSH_COMPLETION=y . "$script"
>>  
>>  __gitcomp ()
>>  {
>
> Except for that tweak,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Thanks.
>
> Now it just needs a commit message. :)

OK, can we see the final version of this patch so that we can work
it around before 2.18.0-rc2?  I am assuming that we are treating
this as a Git 2.18-rc regression that needs to be fixed before the
final?

Thanks.
