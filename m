Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F7AC433DF
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 12:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADA6D2074B
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 12:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WznmyodS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgFLMqC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:46:02 -0400
Received: from mout.gmx.net ([212.227.15.15]:53629 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgFLMqC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 08:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591965948;
        bh=KoXpHkKPA93DtY+JX/nTIjv4q9H4cqXe5fZUlmvElM4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WznmyodScIBhECX8+DxPvhEYrGbmGr4g01GdgGcNIrxl6G+dp9jPZgJ/IK/J/dJvd
         87A6vUrbN42yvCmVIo0DHHWN4UNxxMqedbWS4Ot64tv6n+K+Pji0hYQ4De2tVdTpmj
         +dc2vcF0/uF4AANgI6NlhtdR0Il59BrWpiLkfbxM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([89.1.214.156]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5wLZ-1jpTgl04T5-007Wl8; Fri, 12
 Jun 2020 14:45:48 +0200
Date:   Fri, 12 Jun 2020 14:45:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Don Goodman-Wilson via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net
Subject: Re: [PATCH 1/9] init: allow overriding the default branch name for
 new repositories
In-Reply-To: <20200611234611.GA6569@camp.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2006121431110.56@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <90912e32da1192cfc3b39a18cb606caa46e85b1c.1591823971.git.gitgitgadget@gmail.com> <08e46af3-ff52-8bce-b75a-db8c390c9641@gmail.com> <xmqqwo4di49l.fsf@gitster.c.googlers.com>
 <20200611234611.GA6569@camp.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/+n+BMJnkgEfjDIliQAS0hI+J09yjYjMYKAKSF1p1VgWH6PmSwe
 9zZK3YxaROLnJLJKJL49cQV3A32QjshOVmkJCEjV1Oe5HNj7MGBl05Hb1toEAqoiksVP2Fr
 a99gUp8WTHwmRFvR/O19DTub36I98p+q8DYJUUaSdHdhRql0y+n7Fn7a0WQOI1DIO6F1cVn
 mg/LIQKYr2bQtOjwe8xdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aV1iWJwzSn0=:itgtnyN/59oREWcWH0UyD1
 4A8y+uGGi4xP1Q/Y7XAfAU/P95Nl/x1QXbyuPw7+dSzU75rCEz3jv3zK38lAgjUVeflELPmJV
 2VZ4pS9DzL1VoNUHk/MF52LBRr5n1g1kCMAmyo9AeIhmADYkf4gle9tLnjtl+pQDxGLzQy03M
 3/wXmXK4ICbXhrqcl3BpQDZLSG7hga3wWNrIzpiq5TCrlxprGu4yzVvHqq+JZT/UPyaXzo9S+
 NepoC3f/thW+T1RcarF5voauCZ/o0TmpypOT6b3wc0KLwc15Ni5w2e6wa/+xVZfiMR9FHSrlA
 vvQNqtj4k1MXS0PANZOopaKFfztfrgs+9FWUNueEPaOPCIIDu0aw5jnTKa9eFYVI0MoyZ3J0l
 4+/3JYZUadi1/kcgvPjEJkwucBWkGv6JwN6YW5xD36bMb7wX4fVpumY4/D+z954RxbsrDlPHh
 IChlc/cRfQfjrZ9o6gmfqK0q9e0pI/NJbkqv62peNClhod+ddU+2tdI+PpNR+cSm+z+z3wo+g
 03xUwk8/W4fp9kC4fi7jxGGOCZOSA9WGGXhZR+qlmfBYa4hFhF6x+VIqsROkvvctYFRfOe+8a
 nbCZDqjlAMzsNGTqbTt0dvNl3CmqC5iys5hrYF5od2y/LT4eQZBTpX7VvVMdfJrQzjjtVEuOx
 JKlGR/yp2IKXgMDOEplNcHA1Far6FB/o3FAMNMe4vzcfWVIvqXHgEm7nucmOeJ1/1qgcRVJIV
 kbZ8nAWeNlFQOu9eKQHLwDhLraPxaM+zIb5sx9fDTRdT/FERx26Ytc2x1xSsAQkv5zf5/oGT0
 5m+aTZ3KMqEDVDbcez1bWS0TqvQ9LtT/e0CfIl2T6zbjc6aLgI8GrM8GmLNnI9iAk8BRsDevD
 jmuBz9pM+4EzzC/AJu3aAR0T7GHb777Xj7dnLURvfg9b5b0fpvZ7YcgFPGrn4i655jg5TImxU
 WwHIaoizMWPOk0Uzi7fzzw+DOR/HmV27vqCacUem8Fp1jCay6VHjUE70cqtu7AAc+BYNnPxyI
 7wGagSlRe7kCrJE+pUSQANeOT0nIDxmIBsOMNVgC8irmEisbqE+i8NZCienHjvXmhvaSl3rui
 vwI32t9YZeJ6HXEQA5e/jJZg7kmvnPYq4v1zBE0Br65s0F0PSMRJkTrHTo/hxF72+6IiUt3LF
 C+1hf64cjDCH/wGBWgsWxZ4NNKZztccxTp2M4TRwqN36bzAIdErLqzJ9R7KlTkpQq2oqiMqdK
 opSOlNc9yf6s/7AaU
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Thu, 11 Jun 2020, brian m. carlson wrote:

> On 2020-06-11 at 23:14:46, Junio C Hamano wrote:
> > Alban Gruin <alban.gruin@gmail.com> writes:
> >
> > > Why adding yet another environment variable instead of relying only =
on a
> > > config option?  I understand it's for the tests, but can't we add a
> > > shell function in test-lib.sh (and friends) that tries to read
> > > `GIT_TEST_DEFAULT_BRANCH_NAME', and, if it exists, sets
> > > `core.defaultBranchName'?
> >
> > Can you produce such a patch that does it cleanly?  My knee jerk
> > reaction is that I would suspect that you end up having to touch
> > many places in the t/ scripts, but if you prove otherwise, that
> > would certainly be appreciated.
> >
> > And no,
> >
> >     git () { command git -c core.defaultBranchName=3Dmaster "$@" }
> >
> > is not an acceptable solution.
>
> I would also be delighted to see such a solution, but my experience with
> the SHA-256 work tells me there's unlikely to be one.  We do a lot of
> "git init" operations in random places in the test suite and as a
> consequence it's very hard to make a change without touching a large
> number of tests.

That's a valid point, indeed.

> If we were writing things today, perhaps we would use a function (e.g.,
> test_init_repo or such) to wrap this case, but we unfortunately didn't
> think about that and we're stuck with what we have now unless someone
> retrofits the test suite.

There is actually `test_create_repo` (see
https://github.com/git/git/blob/v2.27.0/t/test-lib-functions.sh#L1145-L115=
9):

	# Most tests can use the created repository, but some may need to create
	# more.
	# Usage: test_create_repo <directory>
	test_create_repo () {
		test "$#" =3D 1 ||
		BUG "not 1 parameter to test-create-repo"
		repo=3D"$1"
		mkdir -p "$repo"
		(
			cd "$repo" || error "Cannot setup test environment"
			"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" init \
				"--template=3D$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
			error "cannot run git init -- have you built things yet?"
			mv .git/hooks .git/hooks-disabled
		) || exit
	}

But I agree that few test scripts use it:

	$ git grep 'git init' v2.27.0 -- t/ | wc -l
	765

	$ git grep 'test_create_repo' v2.27.0 -- t/ | wc -l
	296

Ciao,
Dscho
