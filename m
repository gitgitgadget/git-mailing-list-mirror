Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78F0D1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 16:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeHJTNv (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 15:13:51 -0400
Received: from mout.gmx.net ([212.227.15.19]:55871 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727687AbeHJTNv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 15:13:51 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MbfnB-1fV8DX0Kaz-00J1Ui; Fri, 10
 Aug 2018 18:43:06 +0200
Date:   Fri, 10 Aug 2018 18:43:07 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/4] t5552: fix flakiness by introducing proper locking
 for GIT_TRACE
In-Reply-To: <20180810140908.GA23507@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1808101833330.71@tvgsbejvaqbjf.bet>
References: <pull.17.git.gitgitgadget@gmail.com> <20180809194712.GC32376@sigill.intra.peff.net> <xmqqo9ebb6z3.fsf@gitster-ct.c.googlers.com> <20180810140908.GA23507@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WcHADHE2NIiE9/Jj2ejTmylfauUDReh9eH1brCH9NZMtvu6htLQ
 rEADkwLq7ttIUhP9LVmI5v54/WiSJO2XbNkzh5gX9UHNTcXHTqPRjAATHa3A2Hq/kphWOk1
 YVUJeWY4tobdtlLwrtS+47PwRvWnreRaPCfUFaWtsjmB4/GmET9BVlyUvC/e5uL1tcuQ+mu
 +vqTQ0MSYg65bT/D4zkew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Yh8ocVVr0S8=:/TkmWVbCDRzYkTCZAbLd9g
 nhdBzvrPf20m5aUS5WTTwwIRd8PEuij0S89gYn9ZFkqsyCs3kKaku6cAF0V6n2XkQcWQBhbyl
 u2WK8RSPen98qzRgMgzCymi6slXu8DjKZN2WZRT4LNtbuU4TjR7jLtXsdoLkR2wW6FFUCRNCf
 veF1g8rQrFxWRobQgdzVF5jFlNO7rdw2tMZsXVqdsXW9lddSB7mZ5a9ASFMLw6yn1pphtxOWJ
 LHre14+iuSlyqFEsRZXIHGX7K94wnxFjt//WxYdoq0sxhIN8B86k69gubACn5x2vrZcQY2KLI
 RLsC3H9XvmG2IKX7Ly+nGae6BFPs6E/eOFyTFXl7oYGvk56aNTSWrrxSnFhjNnM32zb5hQ7P6
 T6mik9J0hMzUnT0e2ksf3DWA3OXJDJIUAXQc6wFjFuSCFc+CHlf4WururzNDdhLzDcdow9R6S
 ZxSAMXlfXfD8NoRDMyr6KDF2jOxjNYkO9SaCpdiEforc9E4p6i4Altjenls+El7T85kqES5Hx
 n/7p+xD1GG0Yw2P4fs1vVBKdT/5tCB0RiXUtc/g+HX3ah3cXdBkeHKT4bYmR/exXtfL5Tnfxp
 Qxbi3WO3n5CCeMENn048Ft6a44GOpH/JXjzgwyGg/zmFJC9g+bqAWrHPkVP2Nrr6fkVfYUiCJ
 YQHGJlnyFGS3Ago7YuiVWWgUn30mRQZLM+k6F7U13m97TkDMCBrsgJ59FhMefKVS5iwxULNWe
 Jl0sQJcM1S4jbJbpiph5XM/TPe41pGS+BrLjAKEb7tnU/FdYUYpOnd4prmV7dd9zOx357NpuI
 nszla48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 10 Aug 2018, Jeff King wrote:

> On Thu, Aug 09, 2018 at 01:49:52PM -0700, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > Are you sure that it's not well-defined? We open the path with O_APPEND,
> > > which means every write() will be atomically positioned at the end of
> > > file. So we would never lose or overwrite data.
> > >
> > > We do our own buffering in a strbuf, writing the result out in a single
> > > write() call (modulo the OS returning a short write, but that should not
> > > generally happen when writing short strings to a file). So we should get
> > > individual trace lines as atomic units.
> > >
> > > The order of lines from the two processes is undefined, of course.
> > 
> > Correct.  But I am more worried about the "mixed/overwriting"
> > breakage, if there is one; it means we may need to be prepared for
> > systems that lack O_APPEND that works correctly.  I initially just
> > assumed that it was what Dscho was seeing, but after re-reading his
> > message, I am not sure anymore.
> > 
> > I think the "do not trace the other side" approach you suggest for
> > these tests that only care about one side is more appropriate
> > solution for this particular case.  We then do not have to worry
> > about overwriting or output from both sides mixed randomly.

Just so everybody knows: I never received the above two mails. Something
is seriously rotten in GMX. This seems to have started a week or two ago.

> Here it is as a patch on top of jt/fetch-negotiator-skipping, which lets
> us pursue any fix for interleaved trace output on Windows without the
> pressure of an impending flaky test.
> 
> My gut says that looking into making O_APPEND work there is going to be
> the nicest solution, but my gut is not very well versed in Windows
> subtleties. ;)

Your patch seems to be a patch in the original sense of the word: it is
not a solution.

And let me spell it out very clearly (as I have mentioned to Jonathan a
couple times, without any response): t5552 fails regularly, way more than
rarely, see for yourself:

https://git-for-windows.visualstudio.com/git/_build/index?definitionId=1&_a=history

And the reason it fails was analyzed by me and described in the commit
message (I am sorry that the cover letter was still stale and talked
about flock(), which I had decided was not the right approach after
fighting with Linux over it).

What you cannot see easily, unless you go the route that I offered
Jonathan (open a PR on gitgitgadget/git which will automatically run the
test suite on Windows, macOS and Linux, and of course you can do anything
in a PR, including narrowing down what tests are run) is that sometimes
those lines in the `trace` file were clearly *incomplete*. That is, even
if both processes tried to write atomically, one managed to overwrite the
other's buffer in flight.

This is a pretty serious thing, even worse than the failing test suite,
and I don't think that your patch acknowledges how serious this is.

And please don't give me that "but it works on Linux" response. Seriously.
Sheesh.

Even if you have not managed to trigger it, the POSIX standard seems not
to define clearly what the behavior is of two competing write() calls,
unless you lock the files appropriately, as my patch series does.

So unless you are willing to ignore, to willfully keep this breakage, I
would suggest not to introduce the ugliness of an overridden upload-pack
for the sole purpose of disabling the tracing on one side, but instead to
get this here bug fixed, by helping me with this here patch series.

We don't have to rush this, you know? We have to fix it, though.

Thank you,
Dscho

> -- >8 --
> Subject: [PATCH] t5552: suppress upload-pack trace output
> 
> The t5552 test script uses GIT_TRACE_PACKET to monitor what
> git-fetch sends and receives. However, because we're
> accessing a local repository, the child upload-pack also
> sends trace output to the same file.
> 
> On Linux, this works out OK. We open the trace file with
> O_APPEND, so all writes are atomically positioned at the end
> of the file. No data can be overwritten or omitted. And
> since we prepare our small writes in a strbuf and write them
> with a single write(), we should see each line as an atomic
> unit. The order of lines between the two processes is
> undefined, but the test script greps only for "fetch>" or
> "fetch<" lines. So under Linux, the test results are
> deterministic.
> 
> The test fails intermittently on Windows, however,
> reportedly even overwriting bits of the output file (i.e.,
> O_APPEND does not seem to give us an atomic position+write).
> 
> Since the test only cares about the trace output from fetch,
> we can just disable the output from upload-pack. That
> doesn't solve the greater question of O_APPEND/trace issues
> under Windows, but it easily fixes the flakiness from this
> test.
> 
> Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I'm assuming that this really isn't triggerable on Linux. I tried and
> couldn't manage to get it to fail, and the reasoning above explains why.
> But I wasn't 100% clear that Dscho hadn't seen it fail on non-Windows.
> 
>  t/t5552-skipping-fetch-negotiator.sh | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
> index 0a8e0e42ed..0ad50dd839 100755
> --- a/t/t5552-skipping-fetch-negotiator.sh
> +++ b/t/t5552-skipping-fetch-negotiator.sh
> @@ -28,6 +28,19 @@ have_not_sent () {
>  	done
>  }
>  
> +# trace_fetch <client_dir> <server_dir> [args]
> +#
> +# Trace the packet output of fetch, but make sure we disable the variable
> +# in the child upload-pack, so we don't combine the results in the same file.
> +trace_fetch () {
> +	client=$1; shift
> +	server=$1; shift
> +	GIT_TRACE_PACKET="$(pwd)/trace" \
> +	git -C "$client" fetch \
> +	  --upload-pack 'unset GIT_TRACE_PACKET; git-upload-pack' \
> +	  "$server" "$@"
> +}
> +
>  test_expect_success 'commits with no parents are sent regardless of skip distance' '
>  	git init server &&
>  	test_commit -C server to_fetch &&
> @@ -42,7 +55,7 @@ test_expect_success 'commits with no parents are sent regardless of skip distanc
>  	# "c1" has no parent, it is still sent as "have" even though it would
>  	# normally be skipped.
>  	test_config -C client fetch.negotiationalgorithm skipping &&
> -	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" &&
> +	trace_fetch client "$(pwd)/server" &&
>  	have_sent c7 c5 c2 c1 &&
>  	have_not_sent c6 c4 c3
>  '
> @@ -65,7 +78,7 @@ test_expect_success 'when two skips collide, favor the larger one' '
>  	# the next "have" sent will be "c1" (from "c6" skip 4) and not "c4"
>  	# (from "c5side" skip 1).
>  	test_config -C client fetch.negotiationalgorithm skipping &&
> -	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" &&
> +	trace_fetch client "$(pwd)/server" &&
>  	have_sent c5side c11 c9 c6 c1 &&
>  	have_not_sent c10 c8 c7 c5 c4 c3 c2
>  '
> @@ -91,7 +104,7 @@ test_expect_success 'use ref advertisement to filter out commits' '
>  	# not need to send any ancestors of "c3", but we still need to send "c3"
>  	# itself.
>  	test_config -C client fetch.negotiationalgorithm skipping &&
> -	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch origin to_fetch &&
> +	trace_fetch client origin to_fetch &&
>  	have_sent c5 c4^ c2side &&
>  	have_not_sent c4 c4^^ c4^^^
>  '
> @@ -121,7 +134,7 @@ test_expect_success 'handle clock skew' '
>  	# and sent, because (due to clock skew) its only parent has already been
>  	# popped off the priority queue.
>  	test_config -C client fetch.negotiationalgorithm skipping &&
> -	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" &&
> +	trace_fetch client "$(pwd)/server" &&
>  	have_sent c2 c1 old4 old2 old1 &&
>  	have_not_sent old3
>  '
> @@ -153,7 +166,7 @@ test_expect_success 'do not send "have" with ancestors of commits that server AC
>  	test_commit -C server commit-on-b1 &&
>  
>  	test_config -C client fetch.negotiationalgorithm skipping &&
> -	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" to_fetch &&
> +	trace_fetch client "$(pwd)/server" to_fetch &&
>  	grep "  fetch" trace &&
>  
>  	# fetch-pack sends 2 requests each containing 16 "have" lines before
> -- 
> 2.18.0.1058.g0926f0b71f
> 
> 
