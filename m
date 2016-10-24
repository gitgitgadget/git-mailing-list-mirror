Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1866520193
	for <e@80x24.org>; Mon, 24 Oct 2016 19:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941339AbcJXTKQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 15:10:16 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:38569 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941198AbcJXTKM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 15:10:12 -0400
Received: by mail-qk0-f170.google.com with SMTP id v138so6251691qka.5
        for <git@vger.kernel.org>; Mon, 24 Oct 2016 12:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cckLqxcbH2IhJwT7ov/7fl7bT87HExBEldYhMIPC1Rk=;
        b=TpwKrAFefSqd08ziCRMoql8KoDaF2bq9wwph+QODWPavSSN3dltLNPKVY9i6Yp5+5F
         HeZb5NaMr4VCsA/qg9nNaKQSmQBUEO0p4R+kDgsypaL256M7mupfoVycXriFCm9+JmSz
         ymFLcJSyaGWhyUabFd+l2xH8yqgvrxdmEwn+h1U5v7LqXe8KukEzlGWPwSrSJFQ0nkhp
         yBXVCq5EfUygCr7iPiGYSb03gkd13ODHoi4AYiu5xoFesFMgyFZvOBpvDjM5yXG824s+
         jKpATzshjonEBxu8q4b5li9Bvg5/DtDaTRj8y2mz+FbbqzhLBt7W/4NL3D33FLuG5fEm
         6vZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cckLqxcbH2IhJwT7ov/7fl7bT87HExBEldYhMIPC1Rk=;
        b=Seqq3QyUkYewIF/xyMkk63Ax7A8tuIESUqEr6akLxCSx6re9gcaJTqTZBdpiywosY6
         8lR8wZYwD+SYbRkMwD9PdijrJee7VEIJq7/ngGuI3oXwX5qLIrnul8ZOKG+quyXGaYpS
         DCUbjV+9NPrKv1SvV1+j8c2oWWJ3sqZTBotbNqaJpNzC6ZKJySvEwaUxkyROn240+2rN
         /X1PRX2ylp/daklnEVR72mmSIzmlqd18KEcI8BI7g4Xehj5ntfyDg8UTGWdus02pAAeI
         CyuizTvNAwxhvygYPS0rZAb5W2BkXyxAOfaHMeB6H3fv1UrrDvlVLAPMDiLGP3wpyZ84
         QOgg==
X-Gm-Message-State: ABUngvcZ617yYRFxQOctoLx0tKrEZgO6KLBlT79YLxu6fkxdQWmAfS23xU+LJm8gYJi2padUF3g+6jsrHO1EWw4Z
X-Received: by 10.55.142.130 with SMTP id q124mr15311989qkd.220.1477336211047;
 Mon, 24 Oct 2016 12:10:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Mon, 24 Oct 2016 12:10:10 -0700 (PDT)
In-Reply-To: <61637cd9-8f83-c988-15c0-54f948153c07@kdbg.org>
References: <20161021235939.20792-1-sbeller@google.com> <20161021235939.20792-3-sbeller@google.com>
 <c6c5ce05-3511-a992-e079-316f0ce90ecd@kdbg.org> <xmqqh984aldl.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaukGh2ynkOQcF=skzxTMYr8CFRyGJw6FEmNsTAcaG_VQ@mail.gmail.com> <61637cd9-8f83-c988-15c0-54f948153c07@kdbg.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Oct 2016 12:10:10 -0700
Message-ID: <CAGZ79kZrsxjSfa=CSs5V56ePabnD3-W7FHC7KkRO6jytX+GrAw@mail.gmail.com>
Subject: Re: [PATCH 2/3] submodule tests: replace cloning from . by "$(pwd)"
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 23, 2016 at 3:14 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 22.10.2016 um 22:46 schrieb Stefan Beller:
>>
>> I have looked into it again, and by now I think the bug is a feature,
>> actually.
>>
>> Consider this:
>>
>>     git clone . super
>>     git -C super submodule add ../submodule
>>     # we thought the previous line is buggy
>>     git clone super super-clone
>
>
> At this point, we *should* have this if there were no bugs (at least that is
> my assumption):
>
>   /tmp
>   !
>   + submodule     <- submodule's remote repo
>   !
>   + foo           <- we are here (.), super's remote repo
>     !
>     + super       <- remote.origin.url=/tmp/foo/.
>       !
>       + submodule <- remote.origin.url=/tmp/foo/./../submodule
>                      submodule.submodule.url=../submodule
>
> When I test this, 'git submodule add' fails:

Yes this setup currently fails because the  /tmp/foo/./../submodule
is computed to be /tmp/foo/submodule.

In the test suite the directory "foo" is usually called
"trash\ directory.tXXXX-description" and the remote of
the submodule is created inside of it, such that:

/tmp
   !
   + foo            <- we are here (.), super's remote repo
     !
     + submodule    <- submodule's remote repo
     !
     + super        <- remote.origin.url=/tmp/foo/.
       !
       + submodule  <- remote.origin.url=/tmp/foo/./../submodule
                       submodule.submodule.url=../submodule
                       current result=/tmp/foo/submodule

works.

>
> foo@master> git -C super submodule add ../submodule
> fatal: repository '/tmp/foo/submodule' does not exist
> fatal: clone of '/tmp/foo/submodule' into submodule path
> '/tmp/foo/super/submodule' failed
>
>> Now in the super-clone the ../submodule is the correct
>> relative url, because the url where we cloned from doesn't
>> end in /.
>
>
> I do not understand why this would be relevant. The question is not how the
> submodule's remote URL ends, but how the submodule's remote URL is
> constructed from the super-project's URL and the relative path specified for
> 'git submodule add'.

I was not precise here. If you have the working setup as above, you can clone
super to super-clone and it keeps working, because of the current "bug".

The difference between "super" that is cloned from . and "super-clone" that
is cloned from "super" is only the remote url, and currently
/tmp/foo/super
/tmp/foo/.

+ relative path ../submodule resolve to the same submodule remote.

>
> Whether ../submodule or ./submodule is the correct relative URL depends on
> where the origin of the submodule is located relative to the origin of the
> super-project. In the above example, it is ../submodule. However, the error
> message tells us that git looked in /tmp/foo/submodule, which looks like the
> /. bug!

Correct.

At the time I was trying to fix the urls in the test suite with the
bug fix and I then
realized that this bugfix introduces a lot of pain to our test suite,
because we do
these secondary clones quite a few times. The pattern usually is:
* setup super (cloned from .)
* clone super to super-clone
* trash super-clone for testing purposes and delete it.

>
> I do not understand where you see a feature here. What am I missing?

The ease of use in our own testing suite is the feature I was talking about.

When we would fix the bug, we would not just need to fix
s|../submodule|./submodule| when setting up super, but we would need to
fix it every time again in reverse when creating these short lived
"super-clones"
that get tested on and deleted.

So maybe the correct fix for the testing suite is a double clone, i.e. instead
of


    # prepare some stuff
    git clone . super

we rather do:

    # mkdir upstream && prepare stuff in upstream
    git clone upstream super

However that way we would end up not exercising the
code path to be fixed with the actual bug fix i.e. we'd never clone from /.
because it is silly conceptually. We could add a new test for that though
that only tests that cloning from . constructs the correct URL.
However that is already tested in t0060 resolving the relative URLs
via the git submodule helper.

Thanks for bearing this discussion,
I feel like I am missing the obvious point here,

Stefan
