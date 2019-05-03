Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A41FB1F453
	for <e@80x24.org>; Fri,  3 May 2019 20:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfECUtn (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 16:49:43 -0400
Received: from mout.gmx.net ([212.227.17.21]:57257 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfECUtm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 16:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556916558;
        bh=ehqtWrNXtm8qQgWABqMVJQaKUaGwsgRfi4fW7TuoKII=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WUTu5IZ0egzxLD5alM+NjEPMe2P2kmOU6v+BxT0ISqxm+El3YP36OPrqMnkSQCFHW
         F4HunKagxlLWzTp7e+NrDFXKFHSmCOpWDD5cC7qYLhUIwLQLOPyuZwAl0P1E8VRowI
         sVhXv+sik3NndKeliXTRGjBkR/V2c5SRx3wgVcmk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIyCj-1hKjAt2AOX-002Z9K; Fri, 03
 May 2019 22:49:18 +0200
Date:   Fri, 3 May 2019 22:49:17 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 2/2] archive: avoid spawning `gzip`
In-Reply-To: <87ftpwip5m.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905031437590.45@tvgsbejvaqbjf.bet>
References: <pull.145.git.gitgitgadget@gmail.com> <44d5371ae6808ec40e8f52c3dc258a85c878b27e.1555110278.git.gitgitgadget@gmail.com> <20190413015102.GC2040@sigill.intra.peff.net> <20190413221646.GL12419@genre.crustytoothpaste.net> <nycvar.QRO.7.76.6.1904261051310.45@tvgsbejvaqbjf.bet>
 <87ftpwip5m.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-650633921-1556916559=:45"
X-Provags-ID: V03:K1:fGZSOBXCmsC/3Jn2Vfy5CGN6dtg8QKhG0LYqN965bp7os/DsYGD
 VWUp7M+GoXexyV+rLD7CgIJZPW4WgpMj1cmjeVJSNoE3wcLFXX8ZWCKM6HjGzxImhg3O1KZ
 OCo8p1V3E8bq9YZvcOxcTxWARIZNB6nu7qraO2VTM7DTa/TWKIsHjWW1Rr2ju42daKYZsZW
 6ZTlhc7IKc7sJz6+xt3fA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bL2/EK2zj2s=:6eKO1QHNmrQkUaefk2o5KV
 rI07gdfePkSKNaGsyKf9mhCaieSonpbilOjo3YluV1lzI8YRp6kl7R5kToA9Py53ibvEbLCZI
 tXJDoDniaYeVTeIR12mAS6a0HHfL6KEJ+jcfE18PgV05cE65RaXDm6uwrGA8pgK5uTtovWa6M
 U5rBQtSU8+xs8eKrGSqtr05bppMt2j3p3lKButpjqq4OQynkTphhrgZeTNnjjM9BmN8qSnLAt
 yNV0L8dfRrNgHB0ntCjYZTCdovevvWrdBF2kHUks2d5+YO/DrbSFlhPNa/o1FctYmk5Ez4Q59
 i511lad/YprG8uwrhtDaSVcV9UPBzjj8U3CUDk8wKsmOWASGOHloKv39Dza8AwWzTuvw0sEPC
 Oi2Rji3hcm+oQZygCVtkb5V7huJtEM3RTtWGjT6pYXPbvp/VM3+caxbZjOSTOR8bLHgCmzNvh
 uDT0ehLYDUwR0gugDpsxDIhO2XUUBMVQRUM+ZSSt6mW3P0hFUf+I3NUDmwcLO1zloJkQPlg2P
 VAwI/f+IEmOAQer3eMiJK079mEZrA8/8x3PPp3f+xzqmu5xE18Pna+D4isrPdnXuJfBw3z8IG
 kAPbiU6WmfveBnfWQrrBtyRb/I5WuMq6/RgEA4ydwPFpqsPdMQnw3rfEJKgbO46EE6X6TSHLZ
 tjTS0WKTPM1gzqWJ1IzNxW6N/90bNkwjhWxrWbQ12QKA4hO0lF01uPanuQeEoXCKZ5A8TE/yk
 pvHQ2RJQVw8JqdiE6UeAqoLd2EyV1jd8wJi2KBOVQ3e/IF/IX9iu5xywRvDTdpNDBJ8NFgr8D
 n+oUCwpGEF7FTfUzdKz3GqfAhbzGrG5SCDSIN0bFDvHm4pU4JFT8Uy/b7m1jADPUrNJQNK4ec
 +NvOYn9bySEzELPj/GLGku+QNToi7z/DImYj/vOG1n9HiA22IwKDXvlk7B+qwiiyakpmD1rJR
 EcnWf0JOttQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-650633921-1556916559=:45
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 2 May 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, Apr 26 2019, Johannes Schindelin wrote:
>
> > On Sat, 13 Apr 2019, brian m. carlson wrote:
> >
> >> On Fri, Apr 12, 2019 at 09:51:02PM -0400, Jeff King wrote:
> >> > I wondered how you were going to kick this in, since users can
> >> > define arbitrary filters. I think it's kind of neat to
> >> > automagically convert "gzip -cn" (which also happens to be the
> >> > default). But I think we should mention that in the Documentation,
> >> > in case somebody tries to use a custom version of gzip and wonders
> >> > why it isn't kicking in.
> >> >
> >> > Likewise, it might make sense in the tests to put a poison gzip in
> >> > the $PATH so that we can be sure we're using our internal code, and
> >> > not just calling out to gzip (on platforms that have it, of
> >> > course).
> >> >
> >> > The alternative is that we could use a special token like ":zlib"
> >> > or something to indicate that the internal implementation should be
> >> > used (and then tweak the baked-in default, too). That might be less
> >> > surprising for users, but most people would still get the benefit
> >> > since they'd be using the default config.
> >>
> >> I agree that a special value (or NULL, if that's possible) would be
> >> nicer here. That way, if someone does specify a custom gzip, we honor
> >> it, and it serves to document the code better. For example, if
> >> someone symlinked pigz to gzip and used "gzip -cn", then they might
> >> not get the parallelization benefits they expected.
> >
> > I went with `:zlib`. The `NULL` value would not really work, as there
> > is no way to specify that via `archive.tgz.command`.
> >
> > About the symlinked thing: I do not really want to care to support
> > such hacks.
>
> It's the standard way by which a lot of systems do this, e.g. on my
> Debian box:
>
>     $ find /{,s}bin /usr/{,s}bin -type l -exec file {} \;|grep /etc/alte=
rnatives|wc -l
>     108
>
> To write this E-Mail I'm invoking one such symlink :)

I am well aware of the way Debian-based systems handle alternatives, and I
myself also use something similar to write this E-Mail (but it is not a
symlink, it is a Git alias).

But that's not the hack that I was talking about.

The hack I meant was: if you symlink `gzip` to `pigz` in your `PATH` *and
then expect `git archive --format=3Dtgz` to pick that up*.

As far as I am concerned, the fact that `git archive --format=3Dtgz` spawn=
s
`gzip` to perform the compression is an implementation detail, and not
something that users should feel they can rely on.

> > If you want a different compressor than the default (which can
> > change), you should specify it specifically.
>
> You might want to do so system-wide, or for each program at a time.
>
> I don't care about this for gzip myself, just pointing out it *is* a
> thing people use.

Sure.

> >> I'm fine overall with the idea of bringing the compression into the
> >> binary using zlib, provided that we preserve the "-n" behavior
> >> (producing reproducible archives).
> >
> > Thanks for voicing this concern. I had a look at zlib's source code,
> > and it looks like it requires an extra function call (that we don't
> > call) to make the resulting file non-reproducible. In other words, it
> > has the opposite default behavior from `gzip`.
>
> Just commenting on the overall thread: I like Ren=C3=A9's "new built-in"
> patch best.

I guess we now have to diverging votes: yours for the `git archive --gzip`
"built-in" and Peff's for the async code ;-)

> You mentioned "new command that we have to support for eternity". I
> think calling it "git gzip" is a bad idea. We'd make it "git
> archive--gzip" or "git archive--helper", and we could hide building it
> behind some compat flag.
>
> Then we'd carry no if/else internal/external code, and the portability
> issue that started this would be addressed, no?

Sure.

The async version would leave the door wide open for implementing pigz'
trick to multi-thread the compression, though.

> As a bonus we could also drop the "GZIP" prereq from the test suite
> entirely and just put that "gzip" in $PATH for the purposes of the
> tests.
>
> I spied on your yet-to-be-submitted patches and you could drop GZIP from
> the "git archive" tests, but we'd still need it in
> t/t5562-http-backend-content-length.sh, but not if we had a "gzip"
> compat helper.

We need it at least once for *decompressing* the `--format=3Dtgz` output i=
n
order to compare it to the `--format=3Dtar` output. Besides, I think it is
really important to keep the test that verifies that the output is correct
(i.e. that gzip can decompress it).

> There's also a long-standing bug/misfeature in git-archive that I wonder
> about: When you combine --format with --remote you can only generate
> e.g. tar.gz if the remote is OK with it, if it says no you can't even if
> it supports "tar" and you could do the "gz" part locally. Would such a
> patch be harder with :zlib than if we always just spewed out to external
> "gzip" after satisfying some criteria?

I think it would be precisely the same: you'd still use the same "filter"
code path.

Ciao,
Dscho

--8323328-650633921-1556916559=:45--
