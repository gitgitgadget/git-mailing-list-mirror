Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85897C433E0
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 12:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 587DD20792
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 12:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="eKQcpbnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgFLMHR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:07:17 -0400
Received: from mout.gmx.net ([212.227.15.19]:41339 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbgFLMHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 08:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591963620;
        bh=n7HRjr6K8h6qnAtN7G0bPF3WgCukb96vIgXk5h11He0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eKQcpbncj52Odph3cmZ09zcvySQReJDSGCSP+i1HcrXdsFhHfkTslyvc2sD5l0Lkt
         iOLtDpOatNX0b45wTBY550zMjM9MYWqY93NWaHvX69RRck7OSu6UAzLgaw5Jfr9YC/
         Wsye49GUUTCFp+nBncdJUUi3shqIwLnZ0HSETmv4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([89.1.214.156]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNKhs-1jY6X339sw-00OrUs; Fri, 12
 Jun 2020 14:06:59 +0200
Date:   Fri, 12 Jun 2020 14:07:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Matt Rogers <mattr94@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com, Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH 8/9] fast-export: respect the possibly-overridden
 default branch name
In-Reply-To: <xmqqimfxjwk6.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006121403340.56@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com> <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com> <20200610233912.GU6569@camp.crustytoothpaste.net>
 <CAOjrSZvV6+ApfmOBa7rdXDPQJbExRsOfodO16i_1N5QjjhCB1w@mail.gmail.com> <xmqq3672cgw8.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2006111559300.56@tvgsbejvaqbjf.bet> <xmqqpna5bq2l.fsf_-_@gitster.c.googlers.com> <xmqqtuzha6xn.fsf@gitster.c.googlers.com>
 <xmqqimfxjwk6.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:A5nD8wihEJFgtwlCCqWR50iSzprceaHdf/MMFWTvQ0iC4vmUMdh
 bR9d1PjbQxkfZZ2M+v5OhsWgK6CX+N5wen/FXUGzpxYIa9WlYzSwlZhm6g2nPScpQnIY//n
 PsVIDtjeHQ+ZzbstSvaqgK7nhEp5hHzbwgaHSXrd5mCsVbvdqv9lhXNlRunMtbJZ5f3RWjS
 BmFiIaEYq6s6FQKPCb3Xg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kCsUGWdfVmk=:dAGTvADO+aGsNSmsEFEyFX
 1LMkqkdmoBG7M3c+DB+GzJ4o7f+AdF3dTX+NZDvm0hJMiouHObcwtc4upKi3TK/dLMiKD1RZe
 dLusoGmO9AwPFJyhEwpP5R5dhTvhUPYGR9daYnbmipP8RDRxYm+GOokQMu8pyrlkN7hx+R4Gl
 8RlUusUbP7XRiLpFjSJCtbf8LLLMhDUp8BY/CcQGBfkkTRnZeAwMfFTtfrweDpDT23M5PFyUG
 gCBPby/pdPSlgESFtvHj0Oc/gI1osIM2LRzWHqrOjYXh8cZhXT/3TEi7+RuuVavgqzscu0Veh
 ekfkXWrOcKAH+4mFhIvDmKt7PMebvITz7RhttrPtozOnYiSEBaVny64LYwwnFxJ7MpHScOpzn
 2GHCTkE39BNBwaD7qOedHFxLUptar+GG721n3NDLwzx/nwicE0T8mbQYTKMSpNsLnyvyyfyLD
 ZuN8y4l9BbcBGELVt9pkRKJflp7GrKQ8t/KuY/yPcRi/nBPyQZTwEnEbNVgKdy+lDZzGkbn8W
 xmaP4KMSDyB3FTR401fYNMAnbJTnuQi1Da6KGvXOHErUaeTgEdHm3X3mTv5/i5d9C63sUobv8
 D4q1FiXcoXtOHw/QkWrRFk1VlNzpEnpiI9+SbViID0VN3/DmNxfJpQovx8a5Ek8bGVotD4cMp
 aMIEOcBK12j9+VwTDtbgM1zq3EZXEIylghWxaqtHlYphZ2jSBVQp7eeLe/aAL1RR/nlMVv03Y
 Nf9xYeFku5JAYXZIwu/hnRL56GISvaGKIfXXecDhfVzRKi4Uz+XQw4yBMP1ttoDAkbx+Kgp18
 7MJDQAA5xGonwd9/x3x44lxZlPR2oO4YgEeok38JLTuTtpKW8P0GOPFaQGHed3+5E8qEfS/gV
 6R/54Rx/m9kbpTCFdBFCxK3XQ4QA4pQQbv0JZJuvPDkxLpwDp1Uje7MIoy4yjdvPPqnKAYrcT
 n1YS5y1zYMiBa/oQ2JKXXRIEf27XGUoEVM44WSO+R4ByoQDU0/67vBY27FJ3PdjQNDhhCeEXx
 Ca3xpY6UyBqK/cmR/XmaxYbvCwKI9JYsc0FmiR+gRY+MRRdvehUX6afn8MAApMKa38i9KqSEw
 xHMIGMV4lBhVFmSK3yhY+RHuRGMd3rFU77DYjbJEpU0/F5Lc0atNpWg8jwo94VRPUlZZH2PvD
 44BI+iIMXJCjJBe8eqHbtdTl/iI1FoQx4CTepP2vCidziV4oqHLhORh+F+Dy5J/612bHEr8B2
 4ScIN434wXVK5spiW
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 11 Jun 2020, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> >> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> >> index 85868162ee..a306a60d25 100644
> >> --- a/builtin/fast-export.c
> >> +++ b/builtin/fast-export.c
> >> @@ -497,7 +497,7 @@ static void *anonymize_ref_component(const void *=
old, size_t *len)
> >>  {
> >>  	static int counter;
> >>  	struct strbuf out =3D STRBUF_INIT;
> >> -	strbuf_addf(&out, "ref%d", counter++);
> >> +	strbuf_addf(&out, "ref%d", ++counter);
> >>  	return strbuf_detach(&out, len);
> >>  }
> >>
> >> @@ -522,7 +522,7 @@ static const char *anonymize_refname(const char *=
refname)
> >>  	 * anything interesting.
> >>  	 */
> >>  	if (!strcmp(refname, "refs/heads/master"))
> >> -		return refname;
> >> +		return "ref0";
> >
> > This is obviously wrong.  It should return "refs/heads/ref0".
> > ...
> > So, I guess we should just fix the patch I am responding to to
> > return "refs/heads/ref0" instead of "ref0", and queue it as one of
> > the preparatory steps.
>
> ... and the follow-up step to become part of the series you are
> working on to allow customing what the primary branch is called
> would turn the second hunk to
>
> 	-	if (!strcmp(refname, "refs/heads/master"))
> 	+	if (!strcmp(refname, get_primary_branch_name(0)))
> 			return "refs/heads/ref0";

Right.

> By the way, with your "two variables" approach to make both the
> "default" (for 'init' and 'clone') and the "primary" (for
> 'fmt-merge-msg' and 'fast-export') configurable, we'd need accessor
> function(s) for the primary branch name for the given repository.
> The get_primary_branch_name() helper function might want to take a
> "struct repository *" argument in addition to "please give me an
> abbreviated refname" boolean, given the recent push to pass the
> struct to everybody.

My current state defines a `repo_main_branch_name(flags)` function where
the flags can be `MAIN_BRANCH_SHORT_NAME` and `MAIN_BRANCH_FOR_INIT`.

So I think we're on the same page.

BTW I heard from a couple sides that "primary" would imply that there is
also a "secondary" branch, and potentially an ordering of all branches,
which is why I did not really consider "primary" as candidate. Besides, it
is so much more awkward to type than "main" (especially when you're as
tired as I am right now...).

That's why I try to stay with "main" for the moment.

Ciao,
Dscho
