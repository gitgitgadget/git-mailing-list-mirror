Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B78C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 21:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241900AbiEXVb6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 17:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiEXVb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 17:31:56 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0873A4198E
        for <git@vger.kernel.org>; Tue, 24 May 2022 14:31:54 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gh17so24892487ejc.6
        for <git@vger.kernel.org>; Tue, 24 May 2022 14:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=W0p5RKE8tXKzyg1gViViC7ALnHNEM9aSox3UTOiCDQ4=;
        b=Z1lkCKWW6rv4cgbx/xl6qvucBvUOxLo8QPXlN4uiW5n2kEvgwRUg/3I0ZIPhGmIKL6
         OZjTqOs4JgSsbfthuGT0YYEXZnio3MaiF2R5fwaBVtjqsrNtDziJiXWgC4FbdgrrFiJA
         1Mijabz7UREstzCiG2qeeiS+HOARpcSq/FzPtB3PqQxi9L5CWlFMiDcqVXtHKS41YyEg
         P9oz+7PUyZQAd/lRcjaTsTy/qnlMXIJaTpDZeDoHAT+t4stGjGJSqUmcWd1yR1sAAig6
         fZ/yAAtZ3rTU0yzbJ/rBU+YG3HmFhmAbNvv6Vrks8DJxdZHpFj+txewZevdQijnHv+75
         tZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=W0p5RKE8tXKzyg1gViViC7ALnHNEM9aSox3UTOiCDQ4=;
        b=5P/VxzB9/5dB25HbfTY6guUZPnCiQi3R1DR9d23gElnyOQEhWoFcsXrX0vcXwFi5C/
         UjGtYAsaztr78RQyfuMJOErLMvrNspiRRAS5hxwtgB1FuMw08SYylZlRYA2tIBZRyEl1
         byHbVls57ZaVFQqLhSvFhjHggL2lSgiUmNhNpTZNoBJqW7QQzzj+1MvDhdI4U+B9dvC6
         HlPkivkvEpG/q3QS0qEh7byiptxDLRqU+DDcnf7JVERai6dSCaDdqsdLFsqkW1tk5TK+
         5S2aBDBmvWIsmoHITx3y/+r0lNjwAyTzfMuxNDMOQj2WtbL80+bDwriRv05AoS1QxDJb
         03qg==
X-Gm-Message-State: AOAM530EUB/qlx4xSYc8HxwJmUoeLV3ew/J3tAzP4JHd6eD5vJBSfQYe
        1hqgfEMuWSYRMqLlARJPexpgj55FGds=
X-Google-Smtp-Source: ABdhPJzeOKsvEqtZpQBVJxhFy8NM/j7LPLXgKKBXu3Kg5yu58ikkEVmpN3lDz+EQHQbJH1Jd9Ls6oA==
X-Received: by 2002:a17:907:7243:b0:6f4:1ce5:4ac4 with SMTP id ds3-20020a170907724300b006f41ce54ac4mr25574593ejc.198.1653427912403;
        Tue, 24 May 2022 14:31:52 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id my9-20020a1709065a4900b006fe8d8c54a7sm7069001ejc.87.2022.05.24.14.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 14:31:51 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntc87-003bKW-1W;
        Tue, 24 May 2022 23:31:51 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        me@ttaylorr.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>
Subject: Re: [PATCH] urlmatch: create fetch.credentialsInUrl config
Date:   Tue, 24 May 2022 23:01:35 +0200
References: <pull.1237.git.1653329044940.gitgitgadget@gmail.com>
        <220524.8635gzxr9h.gmgdl@evledraar.gmail.com>
        <0dc38d46-7c5a-5532-c843-ef3c8b6cfa28@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <0dc38d46-7c5a-5532-c843-ef3c8b6cfa28@github.com>
Message-ID: <220524.86ilpuvcqh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 24 2022, Derrick Stolee wrote:

> On 5/24/2022 4:18 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Mon, May 23 2022, Derrick Stolee via GitGitGadget wrote:
>>=20
>>> +fetch.credentialsInUrl::
>>> +	A URL can contain plaintext credentials in the form
>>> +	`protocol://<user>:<password>@domain/path`. Using such URLs is not
>>> +	recommended as it exposes the password in multiple ways. The
>>> +	`fetch.credentialsInUrl` option provides instruction for how Git
>>> +	should react to seeing such a URL, with these values:
>>=20
>> Re the previous discussion about this (in the v1 patch /
>> https://lore.kernel.org/git/pull.945.git.1619807844627.gitgitgadget@gmai=
l.com/):
>> In what ways?
>>=20
>> That's rhetorical, the point being: Let's adjust this documentation to
>> discuss exactly why this is thought to be bad, what we're mitigating for
>> the user etc., are there situations where running git like this is
>> perfectly fine & not thought to be an issue? E.g. no password manager
>> and you trust your FS permission? Let's cover those cases too.
>
> This documentation is not the proper place to tell the user "do this
> and you can trust your plaintext creds in the filesystem" because that
> is asking for problems. I'd rather leave a vague warning and let users
> go against the recommended behavior only after they have done sufficient
> work to be confident in taking on that risk.

I don't mean that we need to cover the full divergent views on different
approaches to local password management, but not leave the user hanging
with the rather scary "exposes the password in multiple ways".

I.e. if I read that for any software whose implementation I wasn't very
familiar with I'd be very afraid, and in git's case for no reason.

Does in mean that git has some scary git-specific feature that would
expose it. perhaps there's a local log that's unsecured where attempted
URLs are logged, or perhaps we send the raw requested URL to the server
so it can suggest alternatives for us. We do neither, but even a
generally knowledgeable user won't know that about git in particular.

Whereas what I think you actually mean and are targeting here is better
explained by:

    Git is careful to avoid exposing passwords in URLs on its own,
    e.g. they won't be logged in trace2 logs. This setting is intended
    for those who'd like to discourage (warn) or enforce (die) the use
    of the password helper infrastructure over hardcoded passwords.

All of which I *think* is correct, but maybe I've missed something you
know about, as that "in multiple ways" is doing a lot of work.

I also wonder if this wouldn't be even more useful if we took some
lessons from ssh's book. I.e. per "git config -l --show-origin" we know
the original of all config. We could be even more useful (and more
aggressive about warning about) cases where we have passwords in config
files that we detect don't have restrictive permissions, as OpenSSH does
with your private key.

Ditto perhaps when the origin is "command line", as we do nothing to
hide that from the process list on shared systems (and that would be
racy whatever we did).

>>> ++
>>> +* `ignore` (default): Git will proceed with its activity without warni=
ng.
>>> +* `warn`: Git will write a warning message to `stderr` when parsing a =
URL
>>> +  with a plaintext credential.
>>> +* `die`: Git will write a failure message to `stderr` when parsing a U=
RL
>>> +  with a plaintext credential.
>>=20
>> You're implementing this with strcasecmp, so we also support DIE, DiE
>> etc. Let's not do that and use strcmp() instead.
>
> Sure.
>
>>> +static void detected_credentials_in_url(const char *url, size_t scheme=
_len)
>>> +{
>>=20
>> Just generally: This is only=20
>
> Did you intend to say more here?

Probably, but if I did I forgot about it, by now. Sorry.

>>> +	char *value =3D NULL;
>>=20
>> This init to NULL should be removedd, as we....
>>=20
>>> +	const char *at_ptr;
>>> +	const char *colon_ptr;
>>> +	struct strbuf anonymized =3D STRBUF_INIT;
>>=20
>> nit: Just call this "sb"? The's at least one line below over 79
>> characters that's within the bounds with a shorter variable name, and in
>> this case it's obvious what we're doing here...
>
> I will not change this name to be less descriptive.

Sure, just a suggestion. The other way is to just re-wrap that one
line... :)

In the end I don't care, "just a nit", but just as one datapoint from
reading this code: I find this varibale name in particular to be the
polar opposite of descriptive, we're explicitly not anonymizing the URL
in this function, since we're not stripping the username part.

Wouldn't descriptive be something more like uri_redacted_password or
uri_no_password in this case?

>>> +
>>> +	/* "ignore" is the default behavior. */
>>> +	if (git_config_get_string("fetch.credentialsinurl", &value) ||
>>=20
>> ...initialize it here, and if we didn't the compiler would have a chance
>> to spot that if we were getting it wrong.
>
> We do not necessarily initialize it here. The compiler doesn't notice
> it and the free(value) below segfaults.

Yes, sorry I meant in combination with the *_tmp() variant below...

>>> +	    !strcasecmp("ignore", value))
>>> +		goto cleanup;
>>> +
>>> +	at_ptr =3D strchr(url, '@');
>>> +	colon_ptr =3D strchr(url + scheme_len + 3, ':');
>>> +
>>> +	if (!colon_ptr)
>>> +		BUG("failed to find colon in url '%s' with scheme_len %"PRIuMAX,
>>> +		    url, (uintmax_t) scheme_len);
>>> +
>>> +	/* Include everything including the colon. */
>>> +	colon_ptr++;
>>> +	strbuf_add(&anonymized, url, colon_ptr - url);
>>> +
>>> +	while (colon_ptr < at_ptr) {
>>> +		strbuf_addch(&anonymized, '*');
>>> +		colon_ptr++;
>>> +	}
>>=20
>> Could we share code with 88e9b1e3fcb (fetch-pack: redact packfile urls
>> in traces, 2021-11-10), or for consistency note this as <redacted>
>> instead of stripping it out, as we do for that related URL-part
>> redaction?
>
> I'm happy to replace the asterisks with <redacted>. Otherwise, I don't
> see anything we can do to share across these methods.

Yes, I just meant adding a "<redacted>". I briefly looked at whether it
made sense to share the implementation, but I think probably not.

I didn't think of this at the time but your implementation also leaks
the length of the password, which <redacted> will solve in any case.

Just for the implementation: It's slightly more wasteful, but in this
case we don't care about performance, so perhaps a strbuf_splice()
variant is easier here? I.e. add the full URL, find : and @, then
strbuf_splice() it. It gets rid of much of the pointer juggling here &
adding things incrementally.

> Specifically,
> the test in that commit seems to indicate that the redacted portion is
> only the packfile name (the $HTTPD_URL is not filtered).

By HTTPD_URL it means "the path", i.e. it's the equivalent of stripping
CURLUPART_{PATH,QUERY,FRAGMENT}.

So a hypothetical shared implementation would just be a matter of
searching for the '/' once we're past the (optional) '@', but better to
leave it for now.

>>> +	strbuf_addstr(&anonymized, at_ptr);
>>=20
>> Maybe not worth it, but I wondered if we couldn't just use curl for
>> this, turns out it has an API for it:
>> https://curl.se/libcurl/c/libcurl-url.html
>>=20
>> But it's too new for us to rely on unconditionally, but we could add
>> that to git-curl-compat.h and ifdef it, then we'll eventually drop this
>> custom code for ryling on the well-tested library.
>>=20
>> I think doing that would be worth it, to show future authors that curl
>> can do this, so maybe we can start relying on that eventually...
>
> Since we can't rely on it, I'll leave that to another (you, perhaps?)
> to do that ifdef work. I don't think it's worth it right now.

Yeah, probably not.

>>> +	if (!strcasecmp("warn", value))
>>> +		warning(_("URL '%s' uses plaintext credentials"), anonymized.buf);
>>> +	if (!strcasecmp("die", value))
>>> +		die(_("URL '%s' uses plaintext credentials"), anonymized.buf);
>>> +
>>> +cleanup:
>>> +	free(value);
>>=20
>> I think you can also just use git_config_get_string_tmp() here and avoid
>> the alloc/free. That's safe as long as you're not calling other config
>> API in-between, which you're not.
>
> OK. And that also avoids the need for initialization you mentioned.

*nod*
