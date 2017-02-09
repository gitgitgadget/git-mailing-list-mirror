Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6937B1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 19:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753667AbdBITrX (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 14:47:23 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33198 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752307AbdBITrV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 14:47:21 -0500
Received: by mail-pg0-f68.google.com with SMTP id 194so1088305pgd.0
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 11:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EN4DlZ0RBMKtFg3nuB3sB2uVGYaGmwDdn8kYhuBNkYE=;
        b=kJl5PHxKY6OGmOPhaNaNFPkFuKz8btgJch3aLVvfTTQFfFEz8s9Gg3dlkR+0WEMyGn
         hMJbabc+cbjpkkQaVERbxN3JVx4p91oDUEd7yuwc3gWASIsKM933BV10CT2FfaN2YgL2
         qBGXIOBIEUWpw0PZ2dKXmOYRrOn5lcP3LGKcXHXAPG/F02BNNxZAmyU6VIu1fXnM96mh
         R7zcM3WzNrNodwA+JYafVIdVU5CNSI0BwsNWfxbjtTUS4t0h18NxSKsYi/U7DQwXcbKM
         uDozq615svgAKFWcbtOx+onGuT0YQ8xkLAT6TfivApVLncIBd0Kh0dL/+8OrwwA7VbKU
         fuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EN4DlZ0RBMKtFg3nuB3sB2uVGYaGmwDdn8kYhuBNkYE=;
        b=W2d9Z/wgPz2l3dRN3tWUyUD0oGbRpGaco0sv4vESNC7ajSfjY/G+USHuimfp8pyV5P
         8X+T4jQDWZ2DPPQ5uP/TZJlRknsDtmX5OGAQe6x2QVRzANq1X/BwuhpuFA5j25NuEceF
         3zBJzuGJBBYH4vSmAJjfCCPTVu2yNx5JzMrWZXG1hUw2utv6tcg2UINHd4JqE7w5W4oa
         6zYvntHe30Y1HfDfipO++pO8xLwOiHv5iF1T+BPHpPV8vFor7w5RzqNiVfeXjtsNcZBW
         RE4yV+Rt0f7SE4o7Y6erw9puLThSl6pYwtAJw0nPrI6QQUPgMXW4UuZWAgfK0GedUNBd
         sQmg==
X-Gm-Message-State: AMke39kpfYUXZyla1tNYWf6nhDqgoQV8jFm9AlXQiquaYasH61OppzErYOuL4e6EcYgcqQ==
X-Received: by 10.84.225.133 with SMTP id u5mr6304627plj.148.1486669605532;
        Thu, 09 Feb 2017 11:46:45 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:704f:61dd:c9f4:9782])
        by smtp.gmail.com with ESMTPSA id 21sm2943712pfy.4.2017.02.09.11.46.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Feb 2017 11:46:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     Ashutosh Bapat <ashutosh.bapat@enterprisedb.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Bug with fixup and autosquash
References: <CAFjFpRe8zqxs4OLbCrjnuEzF=75sbBJ+HuZqek49B=O=TFHq8A@mail.gmail.com>
        <xmqqbmucuwb0.fsf@gitster.mtv.corp.google.com>
        <07eb2367-9509-afb0-2494-f02a44304bc4@drmicha.warpmail.net>
Date:   Thu, 09 Feb 2017 11:46:44 -0800
In-Reply-To: <07eb2367-9509-afb0-2494-f02a44304bc4@drmicha.warpmail.net>
        (Michael J. Gruber's message of "Thu, 9 Feb 2017 16:07:22 +0100")
Message-ID: <xmqqpoirp2or.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 08.02.2017 23:55:
>
>> Let's hear from some of those (Cc'ed) who were involved in an
>> earlier --autosquash thread.
>> 
>> https://public-inbox.org/git/cover.1259934977.git.mhagger@alum.mit.edu/
>> 
>> 
>> [Footnote]
>> 
>> *1* "rebase -i --autosquash" does understand "fixup! yyyyyy", so if
>>     you are willing to accept the consequence of not being able to
>>     rebase twice, you could instead do
>> 
>> 	$ git commit -m "fixup! yyyyyy"
>> 
>>     I would think.
>
> Doesn't this indicate that rebase is fine as is?

Not really, unless you ignore "if you are willing to accept" part,
which actually is a big downside.  And --fixup-fixed will make it
worse, unfortunately.

> - teach "git commit --fixup=<rev>" to check for duplicates (same prefix,
> maybe only in "recent" history) and make it issue a warning, say:

This is a very good idea worth pursuing, and (I didn't think things
through, though) we may even be able to bound "recent" without
heuristics---scanning between <rev> and the tip for duplicates might
be sufficient.

> Additionally, we could teach commit --fixup-fixed to commit -m "fixup!
> <sha1> <prefix>" so that we have both uniqueness and verbosity in the
> rebase-i-editor. This would allow "rebase -i" to fall back to the old
> mode when "<sha1>" is not in the range it operates on.

This is also a possibility, but it needs cooperation between both
"commit" and "rebase -i".

I personally do not think rewriting "fixup! yyyyyy" on the title
during rebase is worth doing, but that is not because I have a
concrete reason against it but it just sounds like too much magic to
my gut feeling.  Perhaps it can be done reliably with minimal change
to the code.  I dunno.

Thanks.

