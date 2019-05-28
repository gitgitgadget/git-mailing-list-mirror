Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E95D81F462
	for <e@80x24.org>; Tue, 28 May 2019 11:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfE1LGs (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 07:06:48 -0400
Received: from mout.gmx.net ([212.227.17.22]:39383 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfE1LGr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 07:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559041597;
        bh=HyURmUFBtEl6fmbZVS/yAUG1OTIU4RADJqi4CrYCuT4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ejv0RIE9DOeCK8ldOcz1Wo9dDsaGz/G7ovwlq4eao7/D8V5yXHU87gM1lVTfVygAX
         yZriIJeZAQWaJTVrUHqEhjp5d6goinMAb4Qq3fB50ejMfklXTKvd4f7qJFOwW1YZWt
         hpfdT6LZs94XEroCIBmOruS4v+NBl9wNazs4xKrs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LjdS8-1guKNJ33Ae-00bfgC; Tue, 28
 May 2019 13:06:37 +0200
Date:   Tue, 28 May 2019 13:06:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Alejandro Sanchez <asanchez1987@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/4] am: fix --interactive HEAD tree resolution
In-Reply-To: <20190524063955.GD25694@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1905281301070.44@tvgsbejvaqbjf.bet>
References: <20190520120636.GA12634@sigill.intra.peff.net> <20190520121301.GD11212@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1905230858570.46@tvgsbejvaqbjf.bet> <20190524063955.GD25694@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GttUGx7o28RM17TQnsnjlq4BEWl9moUrj+FksyRSEf4BMYYNU/q
 AgS8yRpQhM8pa+TEmAmmVV3cbEWqpHei1LDCKmVDqmtMh4vH0b8UT/bbPl1ZxHR97l650Hm
 P+yihmQZ8AkABwkdiU+86TgGqgWUDysCfVYnwxFwDhdQAhnTGqVpXdZ9kIFAvvfe/67kgig
 f3r9YIlzV8WZLRPFaY1jA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pCLdk9qbuXg=:BrfFb825qXdB3UAZAuwywx
 1nDLptaua56HCTbzlGTLDnf6+wwWrSYvXktJPF6mD6tJPOxBN56lZJkheS5LVICTocOGzkPo/
 OXOU7kRgTbwKM8RolgaD7A6kVFp+x3S0R5zef8sNOn+vLXGkXLBIVcocqXt1yaUuUTeOvJqQz
 oIwIT0yfqPLQzE53drFhz0o13b1j4qGL5RdhqDTIZLn03l5Qv0+r2ZFAz5Y1Lek+in8za/Wn1
 7GJPK2tvf109tuR+TOp9ljzBnAkoCZdD/wGuIaYgGMdbW85q+q8q0JrjMpv4Zbm5y+SEzT64a
 2IQAfhsUyWtN9JNztqg2cSSTYHiN0IeweHAtd/2y4Z4tAgZPN0kYGenA66O2j4Ja5ZZ1WFuKE
 Yu8BSHOy25j3k/NWObeSjuP/BCM98KXBnLmcsdtrTM1nAtckhY+k/caTccdScYKdne0fFZ2+4
 4RNMOxHNkyN+bv/3DfjqLwsqiuljacwqPPJNkB/ibkZmzyz9jNXYbhQZ0UMluOKSf36np80O9
 c/NlzUZOOdrnn1BY/9n0/AkU2nUyEPKWR/CLv5EjjJ7zxGrYkjo3FQA0NxTmCkBty34PLP08R
 q7Vk3QRJ5AL4sxdYv1/h3z2nQwYxRmWrv8r2KvjPmyPr6kz5jCb28TwJmjNkslPvq1XqEPtf2
 T/rmIttoOMjxIrznXZAvwyIlRHCYBZ+HlliUx0F1YZEfnGz/4gkkPZim0pWXSSk1cqcrE9fwe
 /MjdS+nHOojOP/GzQCPLYlmQ+kAVGJNOE2C2JLhU4zbRc7KX4gNgPJzUI/sgoAi6EdLlW0jgx
 NIpEh+HyI900YyckM4phfN2aiL+tpBJQa4ITfHuxwi7SdBmf6A8tHkVScsOs9XtrysKCdTW0J
 dOdil066MbPxEAFFfuG7emWbLWUQ8K2kFOUHJaF8KpVib9W3tEIx5CFd1OlSshmVWEujqg9D5
 ufZsfNO4K6ZMIBlSsQnNkwzyQBiMjEqIYKIxUeVNpt4mufWSAg/Lo
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 24 May 2019, Jeff King wrote:

> On Thu, May 23, 2019 at 09:12:27AM +0200, Johannes Schindelin wrote:
>
> > > +	echo no-conflict >expect &&
> > > +	git log -1 --format=3D%s >actual &&
> > > +	test_cmp expect actual
> >
> > I would prefer
> >
> > 	test no-conflict =3D "$(git show -s --format=3D%s HEAD)"
> >
> > or even better:
> >
> > test_cmp_head_oneline () {
> > 	if test "$1" !=3D "$(git show -s --format=3D%s HEAD)"
> > 	then
> > 		echo >&4 "HEAD's oneline is '$(git show -s \
> > 			--format=3D%s HEAD)'; expected '$1'"
> > 		return 1
> > 	fi
> > }
>
> This, I disagree with. IMHO comparing command output using "test" is
> harder to read and produces worse debugging output (unless you do a
> helper as you showed, which I think makes the readability even worse).
> Not to mention that it raises questions of the shell's whitespace
> handling (though that does not matter for this case).
>
> What's your complaint with test_cmp? Is it the extra process? Could we
> perhaps deal with that by having it use `read` for the happy-path?

I would prefer it if we adopted a more descriptive style in the test
suite, as I always found that style to be much easier to work with (you
might have guessed that I am spending a lot of time chasing test
failures).

Succinctness is just one benefit of that.

A more important benefit is that you can teach a helper that verifies
onelines to show very useful information in case of a failure, something
that `test_cmp` cannot do because it is totally agnostic to what it
compares.

> Or do you prefer having a one-liner? I'd rather come up with a more
> generic helper to cover this case, that can run any command and compare
> it to a single argument (or stdin). E.g.,:
>
>   test_cmp_cmd no-conflict git log -1 --format=3D%s
>
> or
>
>   test_cmp_cmd - git foo <<-\EOF
>   multi-line
>   expectation
>   EOF

I guess that you and me go into completely opposite directions here. I
want something *less* general. Because I want to optimize for the
unfortunate times when a test fails and most likely somebody else than the
original author of the test case is tasked with figuring out what the heck
goes wrong.

You seem to want to optimize for writing test cases. Which I find -- with
all due respect -- the wrong thing to optimize for. It is already dirt
easy to write new test cases. But *good* test cases (i.e. easy to debug
ones)? Not so much.

> But I'd rather approach those issues separately and systematically, and
> not hold up this bug fix.

Sure.

> > > +test_expect_success 'interactive am can resolve conflict' '
> > > +	git reset --hard base &&
> > > +	printf "%s\n" y y | test_must_fail git am -i mbox &&
> > > +	echo resolved >file &&
> > > +	git add -u &&
> > > +	printf "%s\n" v y | git am -i --resolved &&
> >
> > Maybe a comment, to explain to the casual reader what the "v" and the =
"y"
> > are supposed to do?
>
> OK. The "v" is actually optional, but I figured it would not hurt to
> have us print the patch we just generated. I'll add a comment.

Thank you.

Ciao,
Dscho
