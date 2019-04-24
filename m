Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FD811F453
	for <e@80x24.org>; Wed, 24 Apr 2019 00:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfDXAsw (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 20:48:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36163 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfDXAsw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 20:48:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id b1so11208985wru.3
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 17:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=a5BjhrlCxviy84XI77dTVwHebmXZTeyvt+e3ZkbiTqM=;
        b=hbftwC/qADMU7xMHCuCb2qHZMX6VVv5CCdtS6oEfFF4KIMIlR1kYQv1feOqgCWrfo5
         zhvJgjrcSO9RnGxUm5L326VpwKpnAlhxMoMoutFIMX5TJ+/p4DjVMB3CnyNYMCuzNpzJ
         vFiAu1+/pVZM9EeGa1+jq/B/LOLJv579oABVcSKe/UJf8M512VQ/y7yp4/2nYODs22wi
         CdI6rLMpBXuOL0aEGymfYgsrxaBgdWUTzt7igU38ZFerEJqbG8Ditcg4wHd2gUQdC5RO
         9xEDAHtFtGrWsBJ/2McoKlYs5GqdSo4qNxHAv/rhUkld4F+Wyryl/G9Ap6fN2NHYgWGN
         bMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=a5BjhrlCxviy84XI77dTVwHebmXZTeyvt+e3ZkbiTqM=;
        b=llK7zvvggwHz8D5NqSAQIcqIDDgB4iOxWldqX4JSjyGI+69GUwlRoYQhkuXOMTBy6J
         h2zKRJeVnB82LlHicpAoyS+DkHveUP4sCVDB/+kJFvRm3AbvU1nvd6CnuFwWAremrsyM
         CShZbQIKdQ2dePdvJbnwdZswixUv8nPa5/vTI4pPAPv5VVhPtfcsL7Ew5anbfvOVyHBg
         m98OUerZLXefTT6seidfgPSuEHIokmBCy5IiX6XF0RpnKprk+tDO6OutRysBgZu7PHN9
         iL/eTiny66vvX1cjORWr3dW8l/fIAZcacYSj0ES/ZKXJyZVXJdI71jFFPm/ioykfrwGm
         QOjA==
X-Gm-Message-State: APjAAAUEyTArPnOLu2BzfigEFlxyjGAXYOT/JxLn+P95N7gCVTgj+scx
        V64tNddpG1UMk0FsxYQzIqE=
X-Google-Smtp-Source: APXvYqzpKAjaA/AjmLXVHRlaq8XtcVWIIjahHrnBTi69OvIri54w7OYQ2E0VFpLq/oDCJcKTsnGZDQ==
X-Received: by 2002:adf:f108:: with SMTP id r8mr3874980wro.252.1556066930093;
        Tue, 23 Apr 2019 17:48:50 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id y3sm17095381wmi.27.2019.04.23.17.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 17:48:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "CHIGOT\, CLEMENT" <clement.chigot@atos.net>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] git-compat-util: work around for access(X_OK) under root
References: <AM6PR02MB4950BB0152893633FF95DC99EA230@AM6PR02MB4950.eurprd02.prod.outlook.com>
        <xmqq4l6p57x6.fsf@gitster-ct.c.googlers.com>
        <AM6PR02MB495010DED643EC262D116DD0EA230@AM6PR02MB4950.eurprd02.prod.outlook.com>
Date:   Wed, 24 Apr 2019 09:48:48 +0900
In-Reply-To: <AM6PR02MB495010DED643EC262D116DD0EA230@AM6PR02MB4950.eurprd02.prod.outlook.com>
        (CLEMENT CHIGOT's message of "Tue, 23 Apr 2019 11:31:02 +0000")
Message-ID: <xmqqwojk449b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"CHIGOT, CLEMENT" <clement.chigot@atos.net> writes:

> From: Junio C Hamano <jch2355@gmail.com> on behalf of Junio C Hamano <gitster@pobox.com>
>> > On some OSes like AIX, access with X_OK is always true if launched under
>> > root.
>> 
>> That may be the case, but you'd need to describe why it is a problem
>> here, before talking about the need for a "work around".
>> 
>> For example, if a directory on $PATH has a file called git-frotz
>> that has no executable bit, perhaps "git frotz" would execute that
>> file but only when you are running it as the root user, but not as
>> any other user.
>> ...
>
> This patch is needed in order to have hooks working on AIX. When run as root,
> access on hooks will return true even if a hook can't be executed.

Ah, OK, so the issue is not that AIX allows the root to execute even
files that have no executable bit, but X_OK check on it returns
useless answer when we want to know if an attempted execution of the
file by the user would succeed.

That was exactly the kind of information expected in your log
message to explain why this change is a good thing to have.

>> Does the true UID matter for the purpose of permission/privilege
>> checking?  Why do we have to check anything other than the effective
>> UID?
>>
>
> Actually, I don't know. Bash is doing it but I think EUID is enough. 

I wasn't questioning if it is "enough".  If the root user "su"es to
a normal user, does the issue that exec(path) and access(path, X_OK)
are incoherent still happen?  If not, checking for !uid is actively
wrong, not just unnecessary.

>> > +     return access(path, X_OK);
>> 
>> I think the last "fallback to the system access()" is wrong, as the
>> "special case for root" block seems to except that the function may
>> be called to check for Read or Write permission, not just for X_OK.
>
> That's a mistake from me. It should be "mode" instead of "X_OK". It seems that 
> most of the time, it's used only with X_OK or F_OK that's why it has worked. I'll 
> fix that. 

Yup, and have the function fall-back to the system supplied access()
after doing geteuid() and finding that the user is not the root user
without doing anything else---and use the remaining lines in the
function for the special case.  That would make the function's logic
easier to read, too.

>> See how FILENO_IS_A_MACRO defined immediately before this part uses
>> the "#ifndef COMPAT_CODE" to guard against exactly the same problem.
>
> Alright, I now understand how this work.

Good.

> By the way, do I need to recreate a thread with [PATCH v2] ? Or I'll add the new
> version in this one ? I don't know how you're proceeding.  

As the patch we are discussing in this exchange has not been
accepted nor merged to the 'next' branch yet, you'd be sending a new
version as a whole (i.e. not as an incremental patch on top of the
version we have reviewed here) with "[PATCH v2]" on its subject
header.

Emily Shaffer has been writing and revising a tutorial on the
procedure recently, which may be of interest to you, and I am
interested in using your fresh eyes to see if its expectation
for the readers is set appropriately.

  https://public-inbox.org/git/20190423193410.101803-1-emilyshaffer@google.com/

Thanks.
