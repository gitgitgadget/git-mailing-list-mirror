Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E181C74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 18:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjCWSpq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 14:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjCWSpe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 14:45:34 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ABEFF24
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 11:45:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso3896849pjc.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 11:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679597133;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTBH6R5RbE4PMj57joQeyKWWfGYVZrpTITmM+R+n/9c=;
        b=k65HB2uIl3ntua+fGEjNbH9IqNB8V44EaHM8om0E10Zmps+bY2lYg3var+WjdsEDya
         TpFQsTT+wuhPhnCfstM0Mc2WJQ/uOS97djYbROQHPhAnSD4xzZOKclKJSfU3qp18BzNf
         LbE6HyKKf+JaA/cll16tSsnTEzwR2VLfo9ctkMXNoHKHj+woozQBJiH7LgpmFamRA0FX
         NMRXpXVfhKaAnHm88VV5a4MJwWAjd6O603ciMgNnRaI9ulAmqfDGCCye5MeRuHzPrPai
         MTt/sJBRkin6i8pNyqvIJJ6artVqAMkXVRY+sQdbIzY89O+oNr7z0m+vSgNjtkW7KrHL
         cULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679597133;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XTBH6R5RbE4PMj57joQeyKWWfGYVZrpTITmM+R+n/9c=;
        b=bB/zzE7yDvPn/YmSAkrelSGub1zBTYAdaNYyXqhEjhQbV5L54+MPc/KZP+Bm/9hG6V
         HqTCIuQ4C+HLyQHwKrWy10W8Nz+Axm6bCZEnRzA02Ts75YM4ymmXfqMO5WzG/GlyhH5S
         y2BjkodrS9KNAVlYQZpvny0otYotPJ5wThoqLaAOT756kybZrmnPQMYa6VUS7nmdoXXe
         M68fkcMM6X7dGTnJgH4BvMKdQeQX9RjYluuqruIPj6ujxlsKMaDOMW9XFTNamJU/8n+R
         hsmFxTbjNgRaqOPSWizvc1jjmEH7qtS6fgVXl0EJgv+peXmQyQaGI85EFZWmgFVzOg4d
         HiJQ==
X-Gm-Message-State: AAQBX9ee0X87sJAnWsksvMEUOXbAyf8RklvyVeCORojEDsMXjFWazPn/
        f3PpopPLVv2NAjSDMijyq2k=
X-Google-Smtp-Source: AKy350YROup0lSdXsPAer+BLDQDsa9yIBU6m9NAoMj7apGBmSIsEja+s8JsvT9TTkwPfEE/yegw+TA==
X-Received: by 2002:a17:90a:e7d1:b0:23d:294:6a5a with SMTP id kb17-20020a17090ae7d100b0023d02946a5amr6764764pjb.22.1679597132553;
        Thu, 23 Mar 2023 11:45:32 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id w3-20020a17090a528300b00233acae2ce6sm1599066pjh.23.2023.03.23.11.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 11:45:31 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, newren@gmail.com, Johannes.Schindelin@gmx.de,
        sorganov@gmail.com, chooglen@google.com, calvinwan@google.com,
        jonathantanmy@google.com, felipe.contreras@gmail.com
Subject: Re: [PATCH v8 3/3] rebase: add a config option for --rebase-merges
References: <20230312210456.92364-1-alexhenrie24@gmail.com>
        <20230320055955.461138-1-alexhenrie24@gmail.com>
        <20230320055955.461138-4-alexhenrie24@gmail.com>
        <f062165f-2e59-67b5-ebff-b029c29dd4d6@dunelm.org.uk>
Date:   Thu, 23 Mar 2023 11:45:31 -0700
In-Reply-To: <f062165f-2e59-67b5-ebff-b029c29dd4d6@dunelm.org.uk> (Phillip
        Wood's message of "Wed, 22 Mar 2023 16:54:49 +0000")
Message-ID: <xmqqttyb8fxw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> @@ -1514,13 +1542,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>   				break;
>>     		if (i >= 0 || options.type == REBASE_APPLY) {
>> -			if (is_merge(&options))
>> -				die(_("apply options and merge options "
>> -					  "cannot be used together"));
>
> This isn't a new change but having thought about it I'm not sure
> moving this code is a good idea. If the user runs
>
> 	git -c rebase.updateRefs=true rebase --whitespace=fix --exec "make test"
>
> then instead of getting an message saying that they cannot use apply
> and merge options together they'll get a message suggesting they pass
> --no-update-refs which wont fix the problem for them.

Hmph.  Instead of dying here, ...

>> +			if (options.autosquash == -1 && options.config_autosquash == 1)
>>   				die(_("apply options are incompatible with rebase.autoSquash.  Consider adding --no-autosquash"));
>> +			else if (options.rebase_merges == -1 && options.config_rebase_merges == 1)
>> +				die(_("apply options are incompatible with rebase.rebaseMerges.  Consider adding --no-rebase-merges"));
>>   			else if (options.update_refs == -1 && options.config_update_refs == 1)
>>   				die(_("apply options are incompatible with rebase.updateRefs.  Consider adding --no-update-refs"));

... we get caught here, and the next one is not triggered.

>> +			else if (is_merge(&options))
>> +				die(_("apply options and merge options "
>> +					  "cannot be used together"));
>>   			else
>>   				options.type = REBASE_APPLY;

What's the reason why "cannot be used together" is moved to the last
in the chain?

The first two new conditions in this chain try to catch an
invocation with some apply-specific command line option
(e.g. "--whitespace=fix") when used with configuration variables
specific to the merge-backend (e.g. "rebase.merges") and suggest
overriding the configuration from the command line, and I suspect
that the motivation behind this change is that their error messages
are more specific than the generic "apply and merge do not mix".

But are these two new errors and hints universally a good suggestion
to make?  I actually think a command line option forcing us to use
the apply backend should simply silently ignore (aka "override")
configuration variables that take effect only when we are using the
merge-backend.  "git rebase --whitespace=fix --rebase-merges",
giving both from the command line, is making conflicting and
unsatisfyable request, and it is worth giving an error message.  

But if you configure rebase.autosquash only because you want to it
to be in effect for your invocations of "git rebase -i", you
shouldn't have to override it from the command line when you say
"git rebase" or "git rebase --whitespace=fix", should you?

Thanks.
