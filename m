Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB4DC6FA8E
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 16:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjCBQ5N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 11:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjCBQ5M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 11:57:12 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DEB17CCE
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 08:57:10 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id z42so18279221ljq.13
        for <git@vger.kernel.org>; Thu, 02 Mar 2023 08:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m5Xkt7ZcRYvEe5ZnBa1mQDE1dZmCto9n+UZbuVP0wMI=;
        b=OTjweFc9+y6nWiT6h4iiPrShnFLTrBi2wWRyXWgTkrTN5lP3ioFGp97cH1RnzMzPH+
         VzSrfHqIcuFabl1D0fspufiVOluBR/FBAhPAIw+3Sr7Xe2yb+wqFcMZNu+BCahf1DVwj
         5WeE7iww7RcT6mwNxaUk8rtllezKUUgz5hSt5fJJBQszCAHG0eQp46JMdUVTkxC1Exb/
         VMMevw0WXDXzWdhxtSa5d0QpXY8T8GstqOm6yRVPkjpNQuiIZRw6PEvg/86xfXFd7lHo
         XPVslbiis7f6pA/8wgSg9AnqscPtK3wrk0obKVNAUIJm+GevBzGsxQIEcJW0NongMouu
         zjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5Xkt7ZcRYvEe5ZnBa1mQDE1dZmCto9n+UZbuVP0wMI=;
        b=W/xLux14gAXDh2U80al7O7676oa5jU8xmm5D5bVZHyDu0I8SBjqAi5GL4FB8c2hQNx
         KHnHZ5Sk5HlIA/88O42kjv6EmyhFMJnfZTtoZOsF2ZOax6/E7XyMhhcAPXsSOOKbyguV
         dvjAOaHOR+dvVlVzhFTI8GS+oajIL0oVFWs3w/vWXOxEvoMzjw8qGWWI6DIzNdDC2BC5
         x+0hIeDN88GU2YzPkZNYkc9XL2SNgMsrgiNe1XpQ88vLu6XdtNsZTzBaCriYyPSoGS2u
         UVbRWZRuIKT7v/F6GIlIhWDoVE1HIcsrS10qos2h2sIrLj88ZsFu9GbQyOTHwEVgcq6Z
         M+UA==
X-Gm-Message-State: AO0yUKWiB75hK4eHYUc7cb41qIPyN+x2I25WdZvoAyFMMkHj/5LoeEma
        QGPxN8Lv+T+oxHufLTtUWcajEPFYUh8zaA==
X-Google-Smtp-Source: AK7set8/ntXoyzfwE9u0S6T/hHl1+mCxM/p9DuH5ngCH3DhBYbETeVt5zHLnk/DdfdxL/yWQZyHgBg==
X-Received: by 2002:a2e:97d3:0:b0:293:4b9c:a164 with SMTP id m19-20020a2e97d3000000b002934b9ca164mr3409673ljj.48.1677776228367;
        Thu, 02 Mar 2023 08:57:08 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id s6-20020a05651c200600b002934b8d115csm2180580ljo.51.2023.03.02.08.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 08:57:07 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: so/diff-merges-more (was Re: What's cooking in git.git (Feb
 2023, #01; Thu, 2))
References: <xmqqr0v7o0pp.fsf@gitster.g> <871qn5pyez.fsf@osv.gnss.ru>
        <kl6lr0v2i0gn.fsf@chooglen-macbookpro.roam.corp.google.com>
        <87wn4tej2f.fsf@osv.gnss.ru>
        <kl6lh6v43s4g.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqr0u7ku3j.fsf@gitster.g>
Date:   Thu, 02 Mar 2023 19:57:06 +0300
In-Reply-To: <xmqqr0u7ku3j.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        02 Mar 2023 08:15:28 -0800")
Message-ID: <87wn3zqefx.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>>> Finally, event without "log.diffMerges-m-imply-p", the rest of the
>>> series still makes sense, so if the conclusion is to remove it, let's
>>> still merge the rest, please! Let me know, and I'll then remove the
>>> patch and will change documentation accordingly.
>>
>> Oops. Sorry, I missed this the first time I read this message. This
>> alone should have warranted a response.
>
> Hmph.  I agreed with you that the last step to add the configuration
> would not make sense unless we are planning to break users later,

It does make sense to me, and to anybody who does want -m to behave the
same sane way the rest of similar options behave. I've already got it
you don't care, but there are people here who do.

> but I have been under the impression that the remainder were OK
> clean-ups.  Perhaps it is mostly because I read them so long ago and
> forgot the details X-<.

It's not a cleanup, it's rather adding missed feature that allows to get
precise '-m' behavior with --diff-merges. To remind you, there was a
discussion back then when --diff-merges= options were introduced, do
they need to immediately cause output of diffs for merge commits, or
suppress the output till '-p' is specified as well, like '--cc'
originally did, and like '-m' still does.

The conclusion at that time was that it makes sense to take immediate
action as this allows to output diffs for merge commits only, a new
opportunity that was not present before.

However, by making such decision we lost ability to provide exact
behavior of -m using --diff-merges= set of options. This has been
pointed out later to me in the list, and felt obliged to finish
implementation by providing the feature.

  --diff-merges=hide

is exactly that.

>
>> I'm not convinced that the series makes sense without
>> "log.diffMerges-m-imply-p":
>>
>> * The main patch is
>>
>>     diff-merges: implement [no-]hide option and log.diffMergesHide config
>>
>>   which gives us a way to redefine "-m" as "--diff-merges=hide
>>   --diff-merges=on". However, we haven't seen any compelling reasons to
>>   use --diff-merges=hide [1].

I think --diff-merges should be complete and be able to provide exact "-m"
behavior, rendering the latter pure shortcut.

Complete orthogonal interfaces are good thing by themselves, and useful
applications of them are often found later. That's common knowledge.

>> I'm also fairly convinced that if we go
>>   back in time, "-m" wouldn't have the semantics of 'do nothing unless
>>   -p is also given', and I don't think we should immortalize a mistake
>>   by giving it an explicit option.

Yep, and I provided a config option that fixes this mistake. What's
wrong about it? The complete orthogonal interface finalized by the
aforementioned feature allows me to achieve this goal easily.

>>
>>   All the other patches in their current form are dependent on this
>>   patch going in.
>>
>> * diff-merges: support list of values for --diff-merges
>>
>>   This only makes sense if we want to accept multiple values, which we
>>   don't without the main patch.
>
> Now you mention it (and show example in the previous bullet point),
> I have to agree that we would not want this, not because we do not
> want to have --diff-merges with multiple values, but because it
> introduces an odd-man-out option that is not "last one wins" that is
> not used anywhere else in the UI.

It's still the last one wins, and I believe I've carefully described it
in the documentation of the options.

Thanks,
-- Sergey Organov

