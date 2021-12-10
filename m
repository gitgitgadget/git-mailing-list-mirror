Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD38EC433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 17:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241294AbhLJRgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 12:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbhLJRgK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 12:36:10 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5A6C061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 09:32:35 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id lt10-20020a17090b354a00b001a649326aedso8616580pjb.5
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 09:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=HSFYfb6/TwOFa1n8BjV/pTNJax+Bl0ybgg3AYktgGJc=;
        b=UvsXuYnqmp/LuSKo4ExbKinRkhEfmRsv0KSS3jVopS5cxcpaLpV+Yprkds1uE/FzCn
         sYdwpvsf/nVDBvcLt1MQtcvDYVm6DNCJC1gG/lYPcqfMhXRtDLzbemNI3ZR71ppiTTkD
         zLXU/c7v9sQuws7TtCsvQcI52PqAI7mSh0leS7YhXEbpTuoa8Huzq/yeHvXB1a0WgvD5
         HQZcyQvzuU17ZCK85s2LQENrdz7/P6rrCY4OSUkiZOu4jFbkhu8aijyWNm0cl69tCz0e
         DQzLb8mvRrpWxToVSMzaZ8+XJjCasPYNVJZHAn4CxfkWYASpXnpDsL4mc3ENnkOo2H6F
         7wqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=HSFYfb6/TwOFa1n8BjV/pTNJax+Bl0ybgg3AYktgGJc=;
        b=dfI5CPv70IRWv7h0R0K208ujFPnv1qBoztoU28d+LiIaLi7Bj4sJeQCm/sIDhto/5P
         a/dEp+aew+4l84e27iAMC92P/bXxQMKWZRhWvpl5d+esG9qBWCVGAQyh8QXyeX9GO2MH
         KitNPl85tNM+3tSZ+WDLUJ+kYrkLp90BDTbmtEXaPaVSg+GHxrXUCWqIDSChQ1AsaJME
         23DK4wd9VbJUTHlc8NoJ6MYd+8KiNtUaRww0btMiU12aliXusqmzzh/Wn+tmOCqRcbOR
         2KcD6hSs/TyGGVAn+hm2uC0pC6NXODY0BeFcm43kXj7YEUFXgIQsgC/t9XEKby94xr4p
         AGCA==
X-Gm-Message-State: AOAM533h1Y1AgkpSzeK0QB0ICy2TbiLCX64QTjK6Lw4ksJ/H/nag360v
        j7q6XMSYQt/c+gaz5cOxL9fqLvBBxTnwDA==
X-Google-Smtp-Source: ABdhPJwrkSafrcN3DBuo6oHv1xLUZ0FglJrkvX9Tu9YXJjKOnV22GCZEN+ot0XtIWu86Hricjc/7we9N4OOLUw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:1644:: with SMTP id
 il4mr25475770pjb.39.1639157554850; Fri, 10 Dec 2021 09:32:34 -0800 (PST)
Date:   Fri, 10 Dec 2021 09:32:32 -0800
In-Reply-To: <211210.86ilvxe09w.gmgdl@evledraar.gmail.com>
Message-Id: <kl6lzgp88ixb.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1638859949.git.steadmon@google.com> <ba7d557725e70f2ae8f10ae5992c8168eb97f2fc.1638859949.git.steadmon@google.com>
 <kl6llf0war1x.fsf@chooglen-macbookpro.roam.corp.google.com>
 <YbKHBsl7w1uNhLb6@google.com> <kl6l35n19w97.fsf@chooglen-macbookpro.roam.corp.google.com>
 <211210.86ilvxe09w.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH v5 1/2] branch: accept multiple upstream branches for tracking
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        gitster@pobox.com, emilyshaffer@google.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Dec 09 2021, Glen Choo wrote:
>
>> Josh Steadmon <steadmon@google.com> writes:
>>
>>>> > @@ -121,11 +168,18 @@ int install_branch_config(int flag, const char=
 *local, const char *origin, const
>>>> >  	advise(_(tracking_advice),
>>>> >  	       origin ? origin : "",
>>>> >  	       origin ? "/" : "",
>>>> > -	       shortname ? shortname : remote);
>>>> > +	       remotes->items[0].string);
>>>> > =20
>>>> >  	return -1;
>>>> >  }
>>>>=20
>>>> When there is more than one item in remotes->items, this advice is
>>>> _technically_ incorrect because --set-upstream-to only takes a single
>>>> upstream branch. I think that supporting multiple upstreams in
>>>> --set-upstream-to is a fairly niche use case and is out of scope of th=
is
>>>> series, so let's not pursue that option.
>>>>=20
>>>> Another option would be to replace the mention of --set-upstream-to wi=
th
>>>> "git config add", but that's unfriendly to the >90% of the user
>>>> population that doesn't want multiple merge entries.
>>>>=20
>>>> If we leave the advice as-is, even though it is misleading, a user who
>>>> is sophisticated enough to set up multiple merge entries should also
>>>> know that --set-upstream-to won't solve their problems, and would
>>>> probably be able to fix their problems by mucking around with
>>>> .git/config or git config.
>>>>=20
>>>> So I think it is ok to not change the advice and to only mention the
>>>> first merge item. However, it might be worth marking this as NEEDSWORK
>>>> so that subsequent readers of this file understand that this advice is
>>>> overly-simplistic and might be worth fixing.
>>>
>>> Sounds like we should just have separate advice strings for single vs.
>>> multiple merge configs?
>>
>> That sounds like a good idea if it's not too much work. Otherwise, a
>> NEEDSWORK is still acceptable to me (but that said, I'm not an authority
>> on this matter).
>
> We haven't used Q_() with advise() yet, but there's no reason not to:
>
> 	advise(Q_("fix your branch by doing xyz",
> 		  "fix your branches by doing xyz",
>                   branches_nr));

Neat, that should do it in most cases. I think this one is a little
trickier because the plural advice messages requires constructing a
list, e.g.

Singular:=20
  "\n"
  "After fixing the error cause you may try to fix up\n"
  "the remote tracking information by invoking\n"
  "\"git branch --set-upstream-to=3D%s%s%s\"."

Plural:
  "\n"
  "After fixing the error cause you may try to fix up\n"
  "the remote tracking information by invoking\n"
  "\"git config --add my_new_remote remote_name\"
  "\"git config --add my_new_upstream1 upstream_name1\"
  "\"git config --add my_new_upstream2 upstream_name2\"

But perhaps this is not too hard since you've already included examples
of how to format lists of strings [1]

[1] https://lore.kernel.org/git/211207.86mtlcpyu4.gmgdl@evledraar.gmail.com
