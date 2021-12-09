Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E97C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 23:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbhLIXuh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 18:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbhLIXug (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 18:50:36 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB48C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 15:47:02 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id c131-20020a621c89000000b004a343484969so4520863pfc.3
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 15:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=su+jbA/OL2uWAVnEVcNNT32gQeYu+n0hPY/YcbZOHxY=;
        b=O+Y/rP9Uq4q3EgvkFV8xwddTxXfO09SOoSEhK8pjiw4ImcHGCIihmYZvKOtFk9RdG0
         3i2nIBsUFaEA1DpQsVAXfwi6WvORopkPKXuA+a3PMH6NnUSpIZmPFMmZ/tq8zPHGdmDZ
         xuEZwIfcO3sOooFhQ37ndfx6EfKVy7nvX5S7HDu2GthIRySY17VRZFK1JRjtS1juUtid
         nMxk7bqVCbfDW2M1YGNK6YvdyWNNgkt+1q+CalALD9t7wMr5aQHMret/GTqeILJNP/3q
         52lEZ295TMfHeMilCIrAcvb7r85SllNc8UiCHRLtjrNbP9MJQ1zvxQndzKO4NgMu1x0f
         fsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=su+jbA/OL2uWAVnEVcNNT32gQeYu+n0hPY/YcbZOHxY=;
        b=XGtqs4aSwF90/0o5e7VFvII+XZ0QkUMgA2Z2JOeWSVv+SlLqjEBXMGiQaficPWuAFI
         js4/LmoX7mTJJLB/PRFHhBJznhzGixSO5nFmnah59K7b4trMs4hpOlqVmaJw4O+iprmp
         KsAvJJ67YVKN41X9oTmYS7Ep5Tlp/Zw+qwly6V43G3u1DVPo0kT6t4fmSV5fJMPTa0Qx
         0ip4FDt7yFU9Tm9Lb52BNSITdFZANBhMDUrHt8q0oe9vsobXl6JoS3fcQD5aWoHsPtiz
         vPpvrRJtOz+qPl0Kl08rVXJ0nZ4MiPyRAZuI5YNFIJ7eKKVOOMkGLoBG5NOBQjVSVzH5
         rtkQ==
X-Gm-Message-State: AOAM530+2T5nEMRo4FyV5LiGZFsFEs0ova6/0hTZfAX4gUpoy8d5Kj8V
        jRwkYY9PummJS+qlgjVjIIkjGlIOOSLPnw==
X-Google-Smtp-Source: ABdhPJx+nL3LgWDI6ZPVY6xvnH+B/PhCzWx2kIOeZ5UmNB2x2JvYn2CLYQ8SLMPTutFav7pXZMGGk1yCLfhsBA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:7e86:: with SMTP id
 j6mr19838669pjl.25.1639093622123; Thu, 09 Dec 2021 15:47:02 -0800 (PST)
Date:   Thu, 09 Dec 2021 15:47:00 -0800
In-Reply-To: <YbKHBsl7w1uNhLb6@google.com>
Message-Id: <kl6l35n19w97.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1638859949.git.steadmon@google.com> <ba7d557725e70f2ae8f10ae5992c8168eb97f2fc.1638859949.git.steadmon@google.com>
 <kl6llf0war1x.fsf@chooglen-macbookpro.roam.corp.google.com> <YbKHBsl7w1uNhLb6@google.com>
Subject: Re: [PATCH v5 1/2] branch: accept multiple upstream branches for tracking
From:   Glen Choo <chooglen@google.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, emilyshaffer@google.com,
        avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

>> > @@ -121,11 +168,18 @@ int install_branch_config(int flag, const char *local, const char *origin, const
>> >  	advise(_(tracking_advice),
>> >  	       origin ? origin : "",
>> >  	       origin ? "/" : "",
>> > -	       shortname ? shortname : remote);
>> > +	       remotes->items[0].string);
>> >  
>> >  	return -1;
>> >  }
>> 
>> When there is more than one item in remotes->items, this advice is
>> _technically_ incorrect because --set-upstream-to only takes a single
>> upstream branch. I think that supporting multiple upstreams in
>> --set-upstream-to is a fairly niche use case and is out of scope of this
>> series, so let's not pursue that option.
>> 
>> Another option would be to replace the mention of --set-upstream-to with
>> "git config add", but that's unfriendly to the >90% of the user
>> population that doesn't want multiple merge entries.
>> 
>> If we leave the advice as-is, even though it is misleading, a user who
>> is sophisticated enough to set up multiple merge entries should also
>> know that --set-upstream-to won't solve their problems, and would
>> probably be able to fix their problems by mucking around with
>> .git/config or git config.
>> 
>> So I think it is ok to not change the advice and to only mention the
>> first merge item. However, it might be worth marking this as NEEDSWORK
>> so that subsequent readers of this file understand that this advice is
>> overly-simplistic and might be worth fixing.
>
> Sounds like we should just have separate advice strings for single vs.
> multiple merge configs?

That sounds like a good idea if it's not too much work. Otherwise, a
NEEDSWORK is still acceptable to me (but that said, I'm not an authority
on this matter).
