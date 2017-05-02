Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 393881F790
	for <e@80x24.org>; Tue,  2 May 2017 17:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751226AbdEBRzi (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 13:55:38 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34516 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbdEBRzg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 13:55:36 -0400
Received: by mail-pg0-f43.google.com with SMTP id v1so65003950pgv.1
        for <git@vger.kernel.org>; Tue, 02 May 2017 10:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wBmaP5oMBBEPRTImbljZYkIFi+oh9gEOyr63eitk1Qs=;
        b=fj0tAkDCwF1CmGZt7W+22wqd/d9aCFApQ6aJuDXeOvHxYhCQ9c/VSiElvEWr9gPM5m
         vzrJxmGroyewi+zN2dhnBJ/U+YdaOkH79GBpRWL+0917lcllzYm6QTGS3NLWSEL9++p8
         /ljZZ9Wjr/o96+Oe58LzLAsrDHgMxR33oZiTQwQZ/UI9aBcaLeqCuGa3j58RIZwz6kjM
         fpiTuTketqgdUQxNzXxKxWA7JHPEIp1Y+wNUOrkEnJ8GHv3tLjiAfLa3CqXg/8ZtjiwU
         jYrRRcIZOLvGhvZnQuVS0wMUmKKN2wM8t7ZYbYP0ts5D6Npr8j94xNYkSsmBHo0fb3LQ
         5EQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wBmaP5oMBBEPRTImbljZYkIFi+oh9gEOyr63eitk1Qs=;
        b=lPSwCt7FD/2yzwunoqkE5qoHQDT5SBJFHx2ZpEVSmpF8Ixs+U6yvot6ZvnSF6aTs+A
         MApz+Jr7bTFvj1Sl9MDanc6WGHupcbb7GBIHVd/q+E5i1lxKZlz21X6g30AnJVEIr+pF
         h7kDPlERoc7AfO4AT2ShkqfBWO88F+BwntSjlMXKNVCcZCcgz0I1gB3PWxpWeV/HdYqE
         bFg0TuJrZR0DLd0B1YDMklNYbYtfLd6sZYraZN+cNTB5/9IcwTYFPlWgXbwfsa/cJ+Yh
         95oPk/IKkQ66GQOREbnfasVukd5b1dA4zMiGslD/YxTkpmXVlCKpbJ/W8BApq2VsCYzk
         oRHw==
X-Gm-Message-State: AN3rC/6Cs2oGGgml3MVOuUMhNNuCPz7fFHN4c0cdQsTbS+Me/tPUgOSt
        7Z+aES8s3fxowi780ssI+VXRUPJBIBUc
X-Received: by 10.84.241.136 with SMTP id b8mr43566893pll.107.1493747736016;
 Tue, 02 May 2017 10:55:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Tue, 2 May 2017 10:55:35 -0700 (PDT)
In-Reply-To: <20170502172555.GA181268@google.com>
References: <20170428235402.162251-1-bmwill@google.com> <20170502010239.179369-1-bmwill@google.com>
 <20170502010239.179369-6-bmwill@google.com> <CAGZ79kbbz3AAjbg_dV9RVS8kgLs-zWZxt5tsFbQczCm78LcTVw@mail.gmail.com>
 <20170502172555.GA181268@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 2 May 2017 10:55:35 -0700
Message-ID: <CAGZ79kZxYCr+H3PLdnxJp7_aG=JmeMTGry51ppCe3=R2xLrP1w@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] submodule: improve submodule_has_commits
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 2, 2017 at 10:25 AM, Brandon Williams <bmwill@google.com> wrote=
:
> On 05/01, Stefan Beller wrote:
>> On Mon, May 1, 2017 at 6:02 PM, Brandon Williams <bmwill@google.com> wro=
te:
>> > +
>> > +               if (capture_command(&cp, &out, GIT_MAX_HEXSZ + 1) || o=
ut.len)
>>
>> eh, I gave too much and self-contradicting feedback here earlier,
>> ideally I'd like to review this to be similar as:
>>
>>     if (capture_command(&cp, &out, GIT_MAX_HEXSZ + 1)
>>         die("cannot capture git-rev-list in submodule '%s', sub->path);
>
> This wouldn't really work because if you provide a SHA1 to rev-list
> which it isn't able to find then it returns a non-zero exit code which
> would cause this to die, which isn't the desired behavior.

Oh. In that case, why do we even check for its stdout?
(from rev-lists man page)
       --quiet
           Don=E2=80=99t print anything to standard output. This form is pr=
imarily
           meant to allow the caller to test the exit status to see if a ra=
nge
           of objects is fully connected (or not). It is faster than
           redirecting stdout to /dev/null as the output does not have to b=
e
           formatted.

>
> I feel like you're making this a little too complicated, as all I'm
> doing is shuffling around already existing logic.  I understand the want
> to make things more robust but this seems unnecessarily complex.

ok. I was just giving my thoughts on how I would approach it.

Thanks,
Stefan
