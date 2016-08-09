Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E4F11F859
	for <e@80x24.org>; Tue,  9 Aug 2016 20:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbcHIUbi (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 16:31:38 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:32852 "EHLO
	mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932473AbcHIUbd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 16:31:33 -0400
Received: by mail-it0-f43.google.com with SMTP id f6so3404813ith.0
        for <git@vger.kernel.org>; Tue, 09 Aug 2016 13:31:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qerthNavFYiZ3ek0u1xUzdf4oDDOlTHGGA/zuGJ/HNw=;
        b=PZukGNa2xnMsHXmBU2iIT1/2rtAC+rxttL9fIgkX9uE18qq6/eRPe91ECp7tlv2Yda
         2SZfm6j1BJnDyynSSPXRvGozcIq/WYv9olXNRh7bY/Sjv2isuhOBcmcHPJR1oRcwo7Bo
         rw6QmnSROe2maoU9uoePROEOy0OnJCQFuY4DTXJveakjONEDHFUJCRC2G01OzJcukYP9
         RWL09RaIYgk5hda2tgppgomkxdExjTHPbJ5p3bdCzHlTCRs9QPLWRXhQn5chXaMWe4KO
         /yiXPxLZLKL1ULm2KRCdnEZD12Md7hqz58L1l5zt5FNY68iJUeN/i44GHXjDUu7ojnSW
         +x0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qerthNavFYiZ3ek0u1xUzdf4oDDOlTHGGA/zuGJ/HNw=;
        b=Nv3AleDQyVmSFKjID6VvqEGiYquyDtXMyrC0NZEfPemMVotGmWMLnJIMrTC+uLyeZU
         tvzVJd+QZh9bYzyHuBSuJUsOypMH/tMG+zC3L/6PKWWmPPH8Mpfuf6Kxh+aQZ/zF1yw9
         h4TkXE5Hz3zM5LcWpptkDux5opPU/75WLVmPCSaq6t1Lns9zXnu+J7KzY1clyDFxfBRy
         0FRbXjG1nKfIluvuD+/9Ijy+jO6lM928spSDv7QQeidYZE3/vEqxQCVGOHiuBz7nYKDB
         Nix1P4oOykitbwoQm/f9gKSKD9OFQBcXL+brztFvekp/iiVagfdOXnra4kDkTzTC6jX5
         YLDQ==
X-Gm-Message-State: AEkoouvR3Qz6xVJGY+hJMSK6gicSjx+NH9Cz2zOlwLONxkQIhiDJsa2JzcaOKxaZbQAQnWX+ncPqmICNBdghK9Pm
X-Received: by 10.36.217.9 with SMTP id p9mr1252939itg.46.1470774691812; Tue,
 09 Aug 2016 13:31:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 9 Aug 2016 13:31:31 -0700 (PDT)
In-Reply-To: <xmqq8tw5aijv.fsf@gitster.mtv.corp.google.com>
References: <20160809040811.21408-1-sbeller@google.com> <xmqqk2fqc583.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZKTV5PCAR41O1t1c_y6N18u6gsoWozOfr=EPHic-7wYw@mail.gmail.com>
 <xmqq8tw5bzs1.fsf@gitster.mtv.corp.google.com> <CAGZ79kY8EiGaugsh4FxKYp1FxqYr10JfGqsrfsnhULB+OBnFXw@mail.gmail.com>
 <xmqq8tw5aijv.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 9 Aug 2016 13:31:31 -0700
Message-ID: <CAGZ79kbPvj6dU1DMaCh7ieJbs0qWimdHSD8xFfUyV98md2pywQ@mail.gmail.com>
Subject: Re: [PATCHv2 0/6] git clone: Marry --recursive and --reference
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 9, 2016 at 11:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> The way I understood and implemented it is
>>
>>     here is a path, try to use it as an alternate; if that is not
>>     an alternate, it's fine too; maybe warn about it, but carry
>>     on with the operation.
>
> My expectation is without "maybe warn about it".  And not adding it
> as an alternate (because it is not usable) is just "doing as I was
> told to do", nothing noteworthy.  Because "do it only if you can" is
> an explicit instruction to the doer that the caller does not care
> about the outcome, I'd think there shouldn't be any warning, whether
> it is used or not.  At the same time, if the caller wants to know
> the outcome, and using if-able as a way to say "I prefer to see it
> happen, but you do not have to panic if you can't", I'd think it is
> OK to give "info:" to report which of the two possible paths was
> taken in either case.  Throwing a "warning:" only when it didn't do
> so does not make much sense to me.

I think this whole thing needs a new config variable to be set.

At the time of cloning you may run

  git clone --recursive --reference <other-super-project-location>
or
  git clone --recursive --reference-if-able <other-super-project-location>
or
  git clone --recursive

The first two should trickle down to the submodules, i.e.
in the first case we maybe want to run

    git config submodule.alternate=required-superproject &&
    git submodule update --init --recurse

In the second case
    git config submodule.alternate=optional-superproject &&
    git submodule update --init --recurse

And in the third case we maybe only want to record
    git config submodule.alternate=none # implicit by not setting it as well
    git submodule update --init --recurse


Then later when we run
    git submodule update
we have this option to know if a submodule alternate should be treated
as optional or required referenced as the existence
of the superprojects alternate (as a boolean indicator) is not enough of
an indicator what the user later wants.


>>
>> I see. This way the user is most informed.
>
> Yes, and if we were to go that route, "clone" without "-v" should
> not report which of the two it took.  It is OK for "submodule" to
> look at what "clone" left as the result and do more intelligent
> reporting that is better suited for the context of the command.
>
>> The current implementation
>> of "submodule update --init" for start from scratch yields for example:
>>
>> Submodule 'foo' (<url>) registered for path 'foo'
>> Submodule 'hooks' (<url>) registered for path 'hooks'
>> Cloning into '/home/sbeller/super/foo'...
>> Cloning into '/home/sbeller/super/hooks'...
>> warning: Not using proposed alternate
>> /home/sbeller/super-reference/.git/modules/hooks/
>> Submodule path 'foo': checked out '7b41f3a413b46140b050ae5324cbbcdd467d2b3a'
>> Submodule path 'hooks': checked out '3acc14d10d26678eae6489038fe0d4dad644a9b4'
>>
>> so before this series we had 3 lines per submodule, and with this series
>> we get a 4th line for the unusual case.
>>
>> You would prefer to see always 4 lines per submodule?
>
> If the user says "--recursive --reference", then the user probably
> deserves to be notified.  As I said (eh, rather, as I wanted to say
> but failed to say so), I do not have a strong preference either way.

With a new config option we can trigger the notifications based on that as well.

"required superproject" would die when the submodule alternate is not there,
and the "optional superproject" would always state if it found an alternate.

Thanks,
Stefan
