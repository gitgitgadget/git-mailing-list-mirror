Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D01C54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 23:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6773D20CC7
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 23:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NUoDuwUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgDWXTt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:19:49 -0400
Received: from mout.gmx.net ([212.227.17.20]:34155 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728391AbgDWXTr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 19:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587683974;
        bh=x+0T/UBMzRUH4KH6lvY9NPJFvGLbXzZ1dWMw0S79yO0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NUoDuwUb/2vQSKbSze+9YwDJlav4i1dhGvs2BazO4Sg82L5UBhoX+V+XrzZ/k+6YE
         0YkaxwggSz3fQP0TRUY1yCVZW+AUlRQHf6J8swyiZmWRf5mDnKphUXEXChlpkCeeSa
         jYJuBYyxjiYOX5npI3/5H3wNzzYjuXglR7nh1zWo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.237]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MF3HU-1jPYDe219M-00FR7z; Fri, 24 Apr 2020 01:19:34 +0200
Date:   Fri, 24 Apr 2020 01:19:34 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ilya Tretyakov <it@it3xl.ru>
Subject: Re: [PATCH 3/3] credential: handle `credential.<partial-URL>.<key>`
 again
In-Reply-To: <20200422235708.GF140314@google.com>
Message-ID: <nycvar.QRO.7.76.6.2004240057220.18039@tvgsbejvaqbjf.bet>
References: <pull.615.git.1587588665.gitgitgadget@gmail.com> <66823c735b1d5ea2047a29656e82fa6fe895f6f1.1587588665.git.gitgitgadget@gmail.com> <20200422235708.GF140314@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TcxbfJoT3VLLwZ8lv8zzRerefMlRlnAMz2wiwAcy0rqV+ATWuDL
 VwI5w3Sg3bT86HH2MVbX9dDXXKqfE+7cA2lKk9NOWa47JPIpivH67OFi8t0dgi/AJoEzmvJ
 ROynfX8agg0f+a4IuWJmDKW/TZ2P1T7SBQgbKWHqzBfFVWlTT3poi6e5JQYqpPSpTjtkCAf
 LPk1EB/+dNIXIdDlZ0Kjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:paYc2bw8OMU=:UHvPoaCEWpf5zGVApjHLEP
 zmny4t3RilaXJSdy+j6PT7xnkW9ZG5o08EZcUZul5dGqlYGnLeINiFS9eKqAJrLBPaUC/9MQG
 lyodlIPzSLMRK8m18hiJGS6n4rPR0pwSASHnVmBzjq+BcShe/fGZwuNHRE8pOey3GabJqQJmR
 20YNdAfpSumyvEyVgG9zd55KGlUHa3SGilbmjjkE1xb1wMOvJZB5cVaNNSplbSDY5Ba6AMCsY
 JQmTfQEvxEE0Xw2RfbO/72tdav5e/SDAUvfUA4VXV3poua8jMc2DrEEpygIZyheCVZ/gubkMR
 wGf4QiXcBc/WqwSXt/K+0/Ze+XK4C5yWNqoZGTakQgbKd9+NeK1bnonQllqdFy8AFK18qQqiK
 ib8KhvKiuelNs2uoZxYRem/hyp5UG7rHQxwyzPOnn40yW/cZ06JVO+6R02iQiHwAzHCyxwu6x
 H1JhpKIF/j8yIAzaT34U3COVK9VHld+R3lFBe6dXR9UsGN21bGHDXjMMnaCLVW62712ajnVeR
 EPv818iXQRA3A6vHBeW2u620goupY33m695GIoOwe8+/2sQ4Q9mlYqjpbRNDaBZ1WTBYF+S/+
 tHplXS0895MBvj3s2uinceW+bNoJmuT86gDcl7Ai7rHWLCNILbU+XbH8yKf+4nxAQVunGoOeV
 CwkBeCTXo3S551uf46OI/nE1AD6aG+Ur1ndSJzPZTyp7MAZzGwrzrqH2Yo+dLoTzmJs+xvK+n
 JP6a6j05oPHDfXHez3Zof1TuhIqlSOkxLxgwmfOFpKQW6Ls97xzqSRjVLbyufNE89s9hThc/6
 /XxBwc1Gu1Ptb72GEBehjLYWoRVBodcY6JHPnJ5TEAziEIfOG9uuwg0yA08V/iAtIyTJuL12Q
 bYWfqPHD0O+unn/JvaU1LyQYDmchTMfY8MIuhd6ZrmokZDGpIvh8a13LFK6Xpk6Mo3+NBStKQ
 sQjOUFW2EQQ99g/6b3H6xrKBPe3r/+zQS8Ra5p/GwB+HEVKIa2AjSYe9sjOYWuOPS8/+NyGGX
 qcwiBg+eEJ+4Ic/vT8PyeSFMU+4XJHG1L8Ke5jD6KKHrIDbBAD2IFreJJlKQ/E3JqYkLdZYZe
 EbjD/Zm1OmUVfhIvHIM/SaXkMRhuBt0pb3uoUD9gtj+ryhaO0P729siE2rgZvfez/4G2x1lbV
 /9gaGADM7bK6YeKukGoA+M2Cd8QlLluLQDtXLQ378rj10QjrZXN+KgK0VwT+wfGUXrcsK8XJl
 hRTTIbzyB1wrIoRBe
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Wed, 22 Apr 2020, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
>
> [...]
> > --- a/credential.c
> > +++ b/credential.c
> > @@ -53,7 +53,12 @@ static int credential_config_callback(const char *v=
ar, const char *value,
> >  		char *url =3D xmemdupz(key, dot - key);
> >  		int matched;
> >
> > -		credential_from_url(&want, url);
> > +		if (credential_from_url_gently(&want, url, 0, 0) < 0) {
> > +			warning(_("skipping credential lookup for url: %s"), url);
> > +			credential_clear(c);
>
> Hm, the error message doesn't seem right here, since `url` is a config
> key instead of URL whose credential's are being looked up.
>
> Should the error message include the entirety of `var` to make
> debugging easier?

I suppose you're right.

BTW I just realized a much worse issue: `credential_clear(c);`. This
clears the wrong struct. It should clear `want`, not `c`.

> [...]
> > --- a/t/t0300-credentials.sh
> > +++ b/t/t0300-credentials.sh
> > @@ -448,4 +448,17 @@ test_expect_success 'credential system refuses to=
 work with missing protocol' '
> >  	test_i18ncmp expect stderr
> >  '
> >
> > +test_expect_success 'credential config accepts partial URLs' '
> > +	echo url=3Dhttps://example.com |
> > +	git -c credential.example.com.username=3Dboo \
> > +		credential fill >actual &&
>
> Can the tests also check the behavior with bad URLs (that we are
> appropriately tolerating and warning about them?

Yes, my bad! The next iteration will have a test for that.

> Stepping back: one thing I like about the code in "master" that uses
> urlmatch_config_entry is that it is not treating these config keys
> in the same way as URLs that Git would fetch from.  For example, if
> one of the config keys contains %0a, then that's perfectly fine ---
> we are not going to write them to a credential helper or to libcurl.

That is actually not what the code does, at least not in `maint-2.17`. It
very much warns about `%0a` in config keys. The test I am adding to verify
that the warning above is exercised correctly looks like this:

	git -c credential.$partial.helper=3Dyep \
                -c credential.with%0anewline.username=3Duh-oh \
                credential fill >output 2>error &&
        test_i18ngrep "skipping credential lookup for url" error

That is literally the only way I get `credential_from_url_gently()` to
return `-1` in the lenient mode.

> The only problem is that the pattern matching syntax doesn't match
> the behavior that users historically expected.  (Keeping in mind
> that we never actually provided the behavior that users expected.
> `credential.example.com.helper` settings applied to all hosts.)

Yes, I fix that, too. It is a bad usability bug, in my eyes, and I think
it is better to fix it while I'm in the space anyway.

> Would it make sense for parsing these config url patterns to share
> *less* code with credential_from_url?  Ramifications:
>
> - unless we add specific support for it, we'd lose support for
>   patterns that are specific to a user (e.g.
>   "credential.https://user@example.com.helper").
>
> - likewise, we'd lose support for
>   "credential.https://user:pass@example.com.helper".
>
> - we could control what "credential.https:///repo.git.helper"
>   means, for example by rejecting it.  When we reject it, the
>   error message could be specific to this use case instead of
>   shared with other URL handling.
>
> - we wouldn't suport "credential.example.com/repo.git.helper"
>   by mistake.

I think we can have _all_ of this _without_ violating the DRY principle.

Remember: my main motivation for keeping 2/3 apart from 3/3 was so that it
is really easy to verify that 2/3 does not break the callers that _need_
the strict mode.

And since that is the case, we can then enjoy the benefit of the shared
code for the one caller that wants to match also partial URLs.

> - to sum up, we could specifically define exactly what cases we want
>   to support:
>
> 	[credential "example.com"]
> 		# settings for the host
> 		...
>
> 	[credential "user@example.com"] # maybe
> 		# settings for the host/user combination
> 		...
>
> 	[credential "https://"]
> 		# settings for the scheme
> 		...
>
> 	[credential "https://example.com"]
> 		# settings for the host/scheme combination
> 		...
>
> 	[credential "https://example.com/"]
> 		# likewise
> 		...
>
> 	[credential "https://user@example.com"] # maybe
> 		# settings for the host/scheme/user combination
> 		...
>
> 	[credential "https://user@example.com/"] # maybe
> 		# likewise
> 		...
>
> 	[credential "https://example.com/repo.git"]
> 		# settings for the host/scheme/path combination
> 		...
>
> 	[credential "https://user@example.com/repo.git"] # maybe
> 		# settings for the host/scheme/user/path combination
> 		...
>
>   without accidentally promising support for anything else
>
> What do you think?

I added tests for all of those. They all work as a naive user (like me)
would expect them to.

I threw in another test, too:

	[credential "/repo.git"]
		...

And I also threw in negative tests, to verify that non-matching protocol
or host name or path mean that the config setting is ignored.

Thank you for your thorough review, it really helps me,
Dscho
