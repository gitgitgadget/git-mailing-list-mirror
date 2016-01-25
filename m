From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 13/19] mingw: outsmart MSYS2's path substitution in
 t1508
Date: Mon, 25 Jan 2016 18:04:40 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601251751350.2964@virtualbox>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <1a4477f951edc9f58a24163d3935a7b35a3f14b2.1453650173.git.johannes.schindelin@gmx.de> <xmqqa8nubekj.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1601251727370.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Thomas Braun <thomas.braun@byte-physics.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 18:05:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNkZT-0004jl-61
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 18:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757524AbcAYREv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 12:04:51 -0500
Received: from mout.gmx.net ([212.227.15.15]:58882 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757519AbcAYREq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 12:04:46 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lzc5y-1a1Hzu3R2Y-014nD2; Mon, 25 Jan 2016 18:04:40
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <alpine.DEB.2.20.1601251727370.2964@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:nZHo1oAh4SXlfUaN7yEijMLVl3d6UVGuoFnc4gpP3/RA0tjLTgI
 t9MEMulBMyuEfCLWE22gY1Xj5V71F1ARo3L7eTOreUujcBOlzimP5mKAeYVmWTBOlBtYSoq
 iej9iVYSwRHT/rKNgUIbllMJXJrnV0S2RrfZcC1Gm3DoX1mMzhEdEdLfvt6E6uzfs6IoGy0
 7hF4HrfRUVhZNs4VfBXmQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ON6S66CVBjs=:hSyOXOt1y66nenZQMpHP4s
 qJIs19zL40EXpqNchlQwCsm6qqa1HG2NxiMrFHIGfa+vMyDSSPJhkjUEhsEiD5j4g/vokFGoQ
 /RJMCg8RiWizDf3QQiFlhcig0v+x3kftQ0Ji4P/W3tNOXUPeXT/luEDd+Rrg8RgL4tOpNVHXG
 4EzUA0JA0YY4jyEzAIPAhYfLV+h8W+GzmqrbjkjY7UthXJdYfxIG8KOOiKY4sXVBmAgwHKdEa
 miskaqLXUr3wwqBR63KIY0rTpHIRNHDZyRTWq8vhOb9FQLKjkiVNASUCf/R3b1iBxgIeIy3Gh
 nxUJamuJ/vISGsUlBFjBH+9vSot06wFUWGIEc5QXIeXbo4FNPqfeHfAATHPKoddFuYOdlAQ3l
 4HAAQSsfA3dsCBlDU2ri31GcETHSkTpBRRZszR+8EboBvIqAXjkcqrPmISKiH50gUWrU4IpSp
 ejt+qqSNfgoTtmmmtz3nZxzwpsYPHYV5eIutzM3IWtp6ABG/i+42D6JolHrS+eLzJL/UqOmmt
 No9Mtj6MfgZDgql6xTy+MMATslr3bmCEBO1s1cpPgkPBcuaM2giHRpW961BkCfY7cMy53OhCU
 e8XL8Wuvv/stGdt/M/8Xlaab1RtvUwV8kfYO8m0FeYEwouQH2CfQmUPRgM3D4LlYrkpRsaa0c
 UhScG3fNzZ6M/VYXtx7tm0+o2Gce0jQjQBhBDfQwBpviCj/58y95kT3NUs2q1UpBuzdyh6U61
 SQN4YbFwn7EHJEVUD0/OBs4hXw3Hp2NZMN4MK/M0JQZZphMQd3WCO+k0mfWTLchs/eWnl0hr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284741>

Hi Junio,

On Mon, 25 Jan 2016, Johannes Schindelin wrote:

> On Sun, 24 Jan 2016, Junio C Hamano wrote:
> 
> > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> > 
> > > From: Thomas Braun <thomas.braun@byte-physics.de>
> > >
> > > A string of the form "@/abcd" is considered a file path
> > > by the msys layer and therefore translated to a Windows path.
> > >
> > > Here the trick is to double the slashes.
> > >
> > > The MSYS2 patch translation can be studied by calling
> > >
> > > 	test-path-utils print_path <path>
> > >
> > > Signed-off-by: Thomas Braun <thomas.braun@byte-physics.de>
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > ---
> > 
> > This feels wrong.
> > 
> > The point of this test is that you can ask to checkout a branch
> > whose name is a strangely looking "@/at-test", and a ref whose name
> > is "refs/heads/@/at-test" indeed is created.
> > 
> > The current "checkout" may be lazy and not signal an error for a
> > branch name with two consecutive slashes, but I wouldn't be
> > surprised if we tighten that later, and more importantly, I do not
> > think we ever promised users if you asked a branch "a//b" to be
> > created, we would create "refs/heads/a/b".
> > 
> > The new test hardcodes and promises such an incompatible behaviour,
> > i.e. a request to create "@//b" results in "@/b" created, only to
> > users on MINGW, fracturing the expectations of the Git userbase.
> > 
> > Wouldn't it be better to declare "On other people's Git, @/foo is
> > just as normal a branch name as a/foo, but on MINGW @/foo cannot be
> > used" by skipping some tests using prerequisites instead?
> 
> As Eric points out, this is not so much a behavior on Git as of the MSYS2
> Bash. In fact, if you call `git.exe checkout -b @/at-test` from a cmd
> window, it works just as advertised.
> 
> But your comment made me inspect the entire t9100 again, wondering why
> things work when we copy the contents instead of symlinking them. And you
> know what, even if I could have sworn that I verified for every patch in
> this series that it is actually necessary to pass the test suite, it is
> *not* necessary.
> 
> So I backed it out and it won't be part of v2 anymore.

Whoops. This was meant to be a comment on your comment on 12/19. I'll
reply to the appropriate mail...

As to the patch 13/19 that we are discussing here, I agree that it is
better to simply skip the test with the offending argument. See

	https://github.com/dscho/git/commit/ca5edbe

Ciao,
Dscho
