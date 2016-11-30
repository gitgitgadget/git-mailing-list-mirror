Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12ECE1FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 21:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751040AbcK3V4M (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 16:56:12 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:35332 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbcK3V4K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 16:56:10 -0500
Received: by mail-qt0-f175.google.com with SMTP id c47so202347379qtc.2
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 13:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2Jl0CIsLraoQqJ/BQnatLQqdqCVR163JH6mVm/KV+fk=;
        b=dIhBTU/GXAJeSH/xu1zfhdp1NUYfEIHQ84J6DeSHcA9cfH3iF/ZsFQsLo4mmEJLxcr
         OUjVR5YOvGwSZKCJcQXWuFiGcqOAnqcRklMdOsY0kxiHLQBKGFg9Bi+PYgQGL80l533U
         voiKRBzmJAONLmyzulKrjDejiI6OerpmiQL1LkTMv5fRrVoRkHye/PpbI1KPdsW15F6S
         Op91lNPFsFhxVzxG48lR33hloDIkszsIDWwWzLHR7Ir6MZnJImm+M2AFsgVhZ50A6SJf
         CtYRyELv6WCABwblwVZrUfgZb2a5rWrhrWyBLNlTYfGnMQNEmDNOSb0HPxLgw/kqkGeZ
         8bBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2Jl0CIsLraoQqJ/BQnatLQqdqCVR163JH6mVm/KV+fk=;
        b=dmSxLp3NlygqhC7t/eheRqxifV6WuAHBTHxXG5h0uM2xjbya5ZGQ2tztCOTcSWOj6z
         +hv5blh1jE987ckD8HhwMEgze9IM8AhN0zCkdk2Wnlh2XS9Xeu8aA7HTJzcliwPXTBL3
         Yjj/3qfQZZpRUEyfl6Z9+8KR6sIuITJbo7IWynAqrrVSj3ATmwFKOJJB0W6Uh4BBAfJ1
         vcxEzyr0tZqkT0cTMqqxw9SzHRYseVP4hlcNJ8+pt4DgG8BN3VcUXvtKDQIH8NrtOjlo
         uY9rho63228sNTE7Sstt7SDDiVhP8c6VfIkUejLQZILEtfhmwhTmF4u5XJbRZWggNXnk
         Qsug==
X-Gm-Message-State: AKaTC01MlBJv6UxYsltuCVArBHLkWIl9lTbxGm2PILeSNGlsTEJqwPKa3dFofMgWSPZRAjVwR46yOiMNBUZdeTC4
X-Received: by 10.200.50.53 with SMTP id x50mr30908164qta.207.1480542969899;
 Wed, 30 Nov 2016 13:56:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Wed, 30 Nov 2016 13:56:09 -0800 (PST)
In-Reply-To: <xmqqfum8d4w3.fsf@gitster.mtv.corp.google.com>
References: <20161122192235.6055-1-sbeller@google.com> <20161122192235.6055-5-sbeller@google.com>
 <CACsJy8Ce3Oa-xJ4BwgRRy6neM=Jxkfqq7yboHZDXLDG2tu9GzQ@mail.gmail.com>
 <xmqqpolcd73b.fsf@gitster.mtv.corp.google.com> <CAGZ79kar0F7x5U2yZ30ZnWZ9b=EJA=1nT8rxTMRVJPggyFS_XA@mail.gmail.com>
 <xmqqfum8d4w3.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 30 Nov 2016 13:56:09 -0800
Message-ID: <CAGZ79kZSAJauwBwrxf+QAhQgyu4ACn+8LrwjpFGVaUQfSzHEAg@mail.gmail.com>
Subject: Re: [PATCHv2 4/4] submodule: add embed-git-dir function
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2016 at 1:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>     git relocate-git-dir (--into-workingtree|--into-gitdir) \
>
> I am not sure if you meant this as a submodule-specific subcommand
> or more general helper.  "into-workingtree" suggests to me that it
> is submodule specific, so I'll base my response on that assumption.
>
> Would there ever be a situation where you already have submodule
> repositories in the right place (according to the more modern
> practice, to keep them in .git/modules/ of superproject) and want to
> move them to embed them in worktrees of submodules?  I do not think
> of any.

 "Hi, I made a mistake by using submodules. I don't want to use
  them any more, I rather want to:
  A) make it a separate git repo again and I'll keep them in sync myself
  B) ... "

 "I abuse submodules for what git-LFS was designed for, and the
  submodule is on a different mount point, please keep the git directory
  also at that mount point".

Not sure I agree these problems and the proposed solutions are beautiful,
but that is what people may think of as a fast hack?

>
> If there is no such situation, I do not think we want a verb that is
> direction-neutral (e.g. "move" or "relocate") with two options.
> Rather we would want "git submodule unembed-git-dir" or something
> like that.

So when we want to have a generic function in C ("relocate_gitdir")
for both worktree and submodules, the recursive flag is not supposed
to invoke a submodule specific helper, but a generic helper.

Alternatively we make the function not as generic and claim the
recursive part is submodule specific and we can happily call
"git submodule [un]embed-git-dir" recursively.
