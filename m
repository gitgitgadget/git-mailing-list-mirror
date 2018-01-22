Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7AA91F404
	for <e@80x24.org>; Mon, 22 Jan 2018 23:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751126AbeAVXsG (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 18:48:06 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36344 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbeAVXsF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 18:48:05 -0500
Received: by mail-wm0-f44.google.com with SMTP id f3so20152260wmc.1
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 15:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=sXH1BYyBOwIGRsd24rNR2vnJpHDjA5P864WfR1uqp8Q=;
        b=d7YMr2V+1KCuE74Gp8SZfuzwfQdq+52qvlhCcmE7YKPPNVKayeCGMMNlJja9s3IZTe
         u+czwRMLZy5PjFhlneB4WM6FZBfcghDk4jeYga4koTiQEdLoSIwBR8KVuJVTVGdfQL7k
         U6bh3e82praGiW4uRSCHxcV+HkGbQNk0b/d70HKw9Q28pifxq1lmFtZaA/usbaYiTSNg
         9Y3OQYmwcfA+WNtff1On0gq80v5YaKmlakx5KpprWtFPro7XY9RqfHA78Qon6k38Ps6v
         /tvxn4TwgpZ+AGzl4rp1ePko4Cv1RmWCmRnjcx2xfZIHSE8i0CXmdWs2Kkwvg0CE7Pyh
         t6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=sXH1BYyBOwIGRsd24rNR2vnJpHDjA5P864WfR1uqp8Q=;
        b=SgTHFy5zwBRIp+SNxXGtPPa/A8sPw9ObUFY5eRqLFuQLilvmOytmTkL5A628Hr33+g
         XIofzCqTLbJqgpsKXzZMbSKgdUiSIAxgfCQY1y83K5AToAJW4vL7KoJPHNCHhzTNYENF
         R5W6VBtqmUjLWZ6KtsuioU8UIHLHaRZ8JwLOijAVKcS/anuYzlU49XQ5JwHdkR+WCceK
         dFOP5qf1qOop5+iDLNW7GX84Lz/zWnNzEe3Rg0yowi0f1+SHVsKGMM5YkN/+krx/wFfB
         0a+Yk4/u1MqKrHyej0zPwqDqDh+8RBxmIZJZfZc73XWUex27PT1RszghxeFMYPrIIs91
         StJg==
X-Gm-Message-State: AKwxytfexMlDiECtSrGMQJlN9lRspfLcLCDmR1Syx16YyepS05844cJV
        8GjHCGBc0QJqlXTF9i+EZNM=
X-Google-Smtp-Source: AH8x225x6mD0wagVEC90Uyd2U1IYLIkz0qMQXbCa+ImF86NRzvjEYbK3sCWSUcwOj6MlSc2aFct2yA==
X-Received: by 10.80.148.248 with SMTP id t53mr16499728eda.180.1516664884326;
        Mon, 22 Jan 2018 15:48:04 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id b12sm11542004eda.81.2018.01.22.15.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jan 2018 15:48:03 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 12/12] fetch: add a --fetch-prune option and fetch.pruneTags config
References: <20180121000304.32323-1-avarab@gmail.com> <20180119000027.28898-1-avarab@gmail.com> <20180121000304.32323-13-avarab@gmail.com> <xmqq372xmxcu.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <xmqq372xmxcu.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 23 Jan 2018 00:48:02 +0100
Message-ID: <87tvvdh2vh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 22 2018, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Add a --fetch-prune option to git-fetch, along with fetch.pruneTags
>> config option. This allows for doing any of:
>>
>>     git fetch -p -P
>>     git fetch --prune --prune-tags
>>     git fetch -p -P origin
>>     git fetch --prune --prune-tags origin
>>
>> Or simply:
>>
>>     git config fetch.prune true &&
>>     git config fetch.pruneTags true &&
>>     git fetch
>>
>> Instead of the much more verbose:
>>
>>     git fetch --prune origin 'refs/tags/*:refs/tags/*' '+refs/heads/*:refs/remotes/origin/*'
>>
>> Before this feature it was painful to support the use-case of pulling
>> from a repo which is having both its branches *and* tags deleted
>> regularly, and wanting our local references to reflect upstream.
>>
>> At work we create deployment tags in the repo for each rollout, and
>> there's *lots* of those, so they're archived within weeks for
>> performance reasons.
>>
>> Without this change it's hard to centrally configure such repos in
>> /etc/gitconfig (on servers that are only used for working with
>> them). You need to set fetch.prune=true globally, and then for each
>> repo:
>>
>>     git -C {} config --replace-all remote.origin.fetch "refs/tags/*:refs/tags/*" "^refs/tags/*:refs/tags/*$"
>
> I think the last one is supposed to be a regular expression on
> existing values.  Shouldn't the asterisks be quoted?
>
> Otherwise, it would appears as if "refs/tags:refs/tags///" are
> replaced with "refs/tags/*:refs/tags/*", but it certainly is not
> what you are doing.

Yes, well spotted. I copied this from an escaped version and forgot to
update that escaping. Will fix.

> I also wonder why the existing one does not expect a leading '+',
> which I think is what we place by default when you clone.

I didn't raise this because I didn't want to get side-tracked with yet
another thing, but it appears to me that a + prefix in tags refspecs
does absolutely nothing. Consider on a fresh git.git clobbering the new
v2.16.1 tag locally:

    $ git tag -a -m"fake" -f v2.16.1 v2.16.0
    Updated tag 'v2.16.1' (was eb5fcb24f)

This should clobber it, and does:

    $ git fetch --prune --dry-run origin '+refs/tags/*:refs/tags/*'
    From github.com:git/git
     t [tag update]          v2.16.1    -> v2.16.1

But so will this without +, which seems like a bug to me:

    $ git fetch --prune --dry-run origin 'refs/tags/*:refs/tags/*'
    From github.com:git/git
     t [tag update]          v2.16.1    -> v2.16.1

But maybe I'm missing something.


>> +-P::
>> +--prune-tags::
>> +	.... This option is
>> +	merely a shorthand for providing the explicit tag refspec
>> +	along with `--prune`, see the discussion about that in its
>> +	documentation.
>
> So would "git fetch -P origin" be like "git fetch --prune --tags
> origin"?

No, as I understand it --tags just has the effect of considering remote
tags that aren't tags of the branches you're fetching, so e.g. on a
fresh git.git:

    $ git tag -a -m"fake" -f v2.16.2 v2.16.0
    $ git fetch --prune --tags --dry-run
    $

I.e. it does nothing. Whereas this will prune the new fake tag:

    $ git fetch --prune origin 'refs/tags/*:refs/tags/*'
    From github.com:git/git
     - [deleted]             (none)     -> v2.16.2

And so does the --prune-tags option:

    $ ~/g/git/git-fetch --prune --prune-tags origin
    From github.com:git/git
     - [deleted]             (none)     -> v2.16.2


>>  +
>>  See the PRUNING section below for more details.
>>
>> diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
>> index 18fac0da2e..5682ed4ae1 100644
>> --- a/Documentation/git-fetch.txt
>> +++ b/Documentation/git-fetch.txt
>> @@ -148,6 +148,30 @@ So be careful when using this with a refspec like
>>  `refs/tags/*:refs/tags/*`, or any other refspec which might map
>>  references from multiple remotes to the same local namespace.
>>
>> +Since keeping up-to-date with both branches and tags on the remote is
>> +a common use-case the `--prune-tags` option can be supplied along with
>> +`--prune` to prune local tags that don't exist on the remote. Tag
>> +pruning can also be enabled with `fetch.pruneTags` or
>> +`remote.<name>.pruneTags` in the config. See linkgit:git-config[1].
>> +
>> +The `--prune-tags` option is equivalent to having
>> +`refs/tags/*:refs/tags/*` configured in the refspecs for the
>> +remote. This can lead to some seemingly strange interactions:
>> +
>> +------------------------------------------------
>> +# These both fetch tags
>> +$ git fetch --no-tags origin 'refs/tags/*:refs/tags/*'
>> +$ git fetch --no-tags --prune-tags origin
>> +------------------------------------------------
>
> This description is too confusing.  First you say "having
> ... configured in the refspecs for the remote", but configured
> refspecs for the remote (I presume that you are missing 'fetch' from
> that description and are talking about the "remote.$name.fetch"
> configuration variable) are overridden when you give explicit
> refspecs from the command line, so the above two are not even
> equivalent.  The first one gives a refspec explicitly from the
> command line, so other configured refspecs like
>
>     [remote "origin"] fetch = +refs/heads/*:refs/remotes/origin/*
>
> should be ignored, while the second one, if --prune-tags tells Git
> to behave as if
>
>     [remote "origin"] fetch = refs/tags/*:refs/tags/*
>
> also exists in the config, would not cause other ones for the same
> remote from getting ignored.  So...

Indeed, I'll reword this. FWIW I meant something closer to "declared in
the refspecs of the remote" not "configured ... remote".
