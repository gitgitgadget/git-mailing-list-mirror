Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EBC91F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 12:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfKMMag (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 07:30:36 -0500
Received: from mout.gmx.net ([212.227.15.15]:60747 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfKMMaf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 07:30:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573648222;
        bh=Cd4DllHoiYQLHGdU6wpppo2w2yjG3UvnFgzJy+9T7JQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=B8Rk8MLP4EtFKFLLn6XZu97emlrUmMeK2kFKMvzpC7tbr7yBU/T7MRfqGdUCKdSjK
         QOSWll947nwye+TlPvQyB9VhtAS9w+O3nyhPZg+8YhwN+5Xwuc4ioH0iTM+CW38d7I
         fI5kCPmuMZ3sTKJZih0s8cNzCmu0s6Pygsi0zGXg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhuK-1ihSiC2lhS-00DslO; Wed, 13
 Nov 2019 13:30:22 +0100
Date:   Wed, 13 Nov 2019 13:30:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 1/9] Start to implement a built-in version of `git
 add --interactive`
In-Reply-To: <xmqqd0dwbfd6.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1911131326300.46@tvgsbejvaqbjf.bet>
References: <pull.170.v4.git.gitgitgadget@gmail.com> <pull.170.v5.git.1572869729.gitgitgadget@gmail.com> <ff59d2d0b3b8b591a806ef71b4bcfd350000b06e.1572869729.git.gitgitgadget@gmail.com> <xmqqh83fnfah.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1911091154550.46@tvgsbejvaqbjf.bet> <xmqqtv7cjj2n.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1911110949590.46@tvgsbejvaqbjf.bet> <xmqqeeyehawj.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1911121459270.46@tvgsbejvaqbjf.bet>
 <xmqqd0dwbfd6.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QHVClYqQwAtnauAffWpTMPXeoKs+eqIXgYgl7cWOkROGCDUZLtK
 cakcuwZOEGm9FDehmCSajCf1sKWj1k48hwsq/gDgJHT5nBwSD3i8pW7WKUz5A3tKigHZRoT
 y9GUQzsYn/BkiTGuzi01BHijr3CLviPC9duoL5fGZ/qP445TOHklUlCDGyFmzSA2eMpqBVN
 RwyoDsGcxJfXnOdkIz+Yw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uZCvXtTguPQ=:QMqkoJclC6JMpQ0UnL3mxd
 umSi4Me1tVskC1ne2IoLO9DjIGoSM60w2L3j6M7Y0nCL+JRjab2X0Itpg3ftVKjd5H20dmUUR
 4NSg3EsDL/Arez1B6+edf184PTrzul2eKzWiDlmfOGGWx8UzdzT7DrwgWlGN+tSurXhvo86fS
 liFUH8Yl09IZ4l0e3mNrHE/KmPTCpu1z4z2iovF/6bM4JGI4OFiMWbwP8FB4x9q0qvQjmgavu
 PHl+NaX+ztOyZ9esRzCbewmPErM9DQEqSsr1pjeZkpWbPE/80cCEgzPaLyenVXmTPoiaDla2u
 28rE/ksoBHkhD5GQjyFUwSnEVBW1EtvJ9fR5OgPDLp1ovVoJUkxtUmNAynl1/rlISPpq/G7uv
 tSpAy7uYKF57iMH6t2TfAw57jH/VTOwPcnipPUuF2kIcEZXKyhVUUIWZW9+vb8bjIhmMSPFK9
 21tfUZTcO5gsdA7JtywTA47z9yuhePwtTWLDQ+Zn+/i3PXS+XZGsJJ6eXC1MWx6zr49sGmCKJ
 4th4nKeyI+C3PHzwV3wD0IBjOTB3BRZpMNkQGanqCySMEw0MMI0CFS+vYbA0d6onHPt/EKVfH
 +sKXSH5v5nIRtcCZq6AkK/xX0VzvdA4uRrrSsYtEek0CWJRbA5lEDTgBNC/qa4/vyMo6LF85A
 jqUDAZEsjxIoiB2wPELNy90z2Avs0oZTeTGjmnk8bJ63MpjH6olQ7X2M9nKlRQ9LLBPA24RVE
 MI2QMm2+l4U/C5OjdBdFex8BoY/DGr9OLA3lJX9NSU4lGb0gm4rb7tQE6LnFyx7rMdMDOz2zh
 mHTi9TO6NkjV4zS7lo1q1mSZy5Gh6e3OYhI2wFnrzAzJNMFhH19fZalsOTJpDgLCDxtKjuS8x
 iJuwkr7bQeVrYhpNi0FCUdhI54Uz0kcoN71/e7xBCKAKoOXoLMrCsxqiVwuLm5dmGWxgdepGC
 uYhymyv3Rqi34pSfoOAQkaDxeQAVAbGHaslUELzhHVsw+5XbxTE2BCTHCtcsdrS/yQlerzmQJ
 liMATzXQ0ccynchEECXTAwdKfqGyTAuQxoswKpHK9smAi1FinYzL+FjNv1Gw4ykyMO8Q5r1Hz
 5hDmq3ls9cJAIXHAHcKSnllhQN2L/QhXABHOVYqJ+izedSKAsOnfgzZ5c+kgUv4NfPNIFRafB
 IdYxC2c9Ynlu2+k8E6EVSNeqadDEUDmf5rXa1URlcN0XmXl3F2oujDxdFUgdS1xv58DIUFer+
 RG/fCS4SD5QpkQaFqLURfTAZjz2pF1pvaA6JBpaj9EE58LoJXM39gXBqdmks=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 13 Nov 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> Regardless of the language the scripted version was written in, I
> >> think the '--helper' approach is always the poorer choice between
> >> the two [*1*].  It limits the modular decomposition to what suits the
> >> original language, the impedance mismatch between the original and
> >> target language forces us to unnatural style of inter module
> >> communication, and the unnatural interface layer, which we know has
> >> to be discarded at the end, must be written [*2*].
> >>
> >> So, I'd prefer to see "because this is a better way in the longer
> >> term" over "because the --helper approach would not work".
> >
> > Hmm. I feel distinctly unheard.
>
> The feeling is mutual ;-)

Maybe I could take your comments more seriously if you acknowledged the
fact that I am _very_ familiar with the vagaries of converting scripts
to C. Like, very, very, very familiar.

> > It may appear compelling, conceptually, to shun the `--helper` approac=
h,
> > but the more important reality is that it is the only one that makes a=
n
> > incremental conversion possible at all.
> >
> > It took an entire month of 60-hour weeks to complete the conversion of
> > `git add -i`/`git add -p` to C, and only at the very end was I able to
> > run the test suite with `GIT_TEST_ADD_I_USE_BUILTIN=3Dtrue` and see it
> > pass.
>
> Yeah, that is developer comfort, and of course it is nice to have
> than not to have it.

Comfort has little to do with it. Driving out bugs has a lot more to do
with it. Which is the point I am trying to get across the entire time.

> But compared to the downside impact to the quality of end result
> that is inherent to the '--helper' approach, I'd prioritize the
> quality of the end result over developer comfort.
>
> > It is indeed _in spite of_ the success of the `--helper` approach that
> > we cannot use it here.
>
> As I do not see those past '--helper' ones necessarily successes, we
> must agree to disagree here.

Right. But if I recall, you never even saw the need for the conversions
in the first place. Maybe you still don't?

> In any case, the log message needs to express why _you_ ended up
> taking the non-helper approach.  Even though it is far less
> relevant, compared to that, what other approach you instead wanted
> to take, I do not veto you from having your own opinion.

Okay. I will take that as an indication that I can go forward with the
latest proposal. After all, I described pretty well, I think, why _I_
ended up taking the non-helper approach.

Thanks,
Dscho

> >> [Footnote]
> >>
> >> *1* In only one case I would recommend using "--helper" approach,
> >>     though.  When you are not expecting the developer to be able to
> >>     come up with a better split of the program into modules than how
> >>     the scripted version is, and you want to ensure that the
> >>     developer have something to show when they faild to complete the
> >>     project after N weeks.  You are a more experienced developer
> >>     than an average GSoC student, and there is no pencils-down time,
> >>     so the exception would not apply.
> >>
> >> *2* In "git submodule" for example it was quite natural for the
> >>     module that gives a list of submodules with its traits the
> >>     program cares about to be written as a shell function that
> >>     writes the data to its standard output.  And consuming modules
> >>     sit at the downstream of a pipe, accepting its output.  When you
> >>     are writing these modules both in C, you wouldn't connect them
> >>     with pipe to carry the list of submodules, but a piecemeal
> >>     conversion using the "--helper" approach meant that there always
> >>     remained _some_ consumer that wants to read from the pipe, so
> >>     long after the module lister was rewritten in C, it still needed
> >>     to support a mode where it sends its output to the pipe, instead
> >>     of just passing an array of structures.
> >>
>
