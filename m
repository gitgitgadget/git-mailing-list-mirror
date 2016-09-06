Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C50241F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 14:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756624AbcIFOHN (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 10:07:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:64521 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756586AbcIFOGu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 10:06:50 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LjdS8-1b5jLH2EYa-00bauS; Tue, 06 Sep 2016 16:06:35
 +0200
Date:   Tue, 6 Sep 2016 16:06:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix a segfault caused by regexec() being called on
 mmap()ed data
In-Reply-To: <20160906071255.ggsoj2lh2f3kubhj@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1609061521410.129229@virtualbox>
References: <cover.1473090278.git.johannes.schindelin@gmx.de> <xmqqwpiqp3ho.fsf@gitster.mtv.corp.google.com> <20160906071255.ggsoj2lh2f3kubhj@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KovgMgcroJhCc7kJ5NwXXrZBa99A6+x69ULAKc+CMlfopjsCPEh
 MyAMLRyZtFnh23KqPOzLEW0KVMJHeZ8mwXraQ6j+ARlltipXYkYb3gdxWW7XrUl8nvcG1V7
 xWWjRpC8YCp0q31uucuKvB4imbdXHCIn7qjYqgdkzfz8c1CbKYfTZTaIc/MxjRb8obESK+E
 gxElkn4OIowUDtM/DT4hQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UsEEd/Q4Oqs=:5jTCe2lTHHuGaWxJ0Xe9Cf
 rXOep2E4jnOqccCvV1sXyuFR1NQwcX9S6P7IH/wFbnG+HvOctPM5KCY9tLcFj0PVvARMyBv2t
 mmKqeOxKMF9KAyqot1xLjPXo8pXHYoM6fJBXQNkfG6zA4IZ/WcuD8qqoULPb8CMW8crJn7Pn2
 PHQLCcUofhIESwNsdn8lN4SpLHEIN7/Vn3Y5+A1FrKx/HgghrH5+qnsNfgIxkdl7QzcTDvyCq
 kTOb8Eldgdsb+gduANW5KOj02UwIeHGW9pKhuWLFrcXVo2hFV8uiCrmNERB2zHyNghofPES4c
 sEyV55OkBRYqUbDk/z8yrw2xiIUJ6zXsbCtYt1ZGz3bhubz2RnQGUCdIXORv9J/lnnYV0bL52
 /3T+a0Ai3SIjO7+VpshtRphIAUcTweOnTsoDD0ehwr/JZTtkU29k3OnOECNNQ0UyR/3S/jYoL
 Bz8tHVOVlZUgi4rEmkBRZHQtJCORthXazc97CSY8Yy+X1m9qIF/x59yDOJobiDi6WYm0oQ8ST
 SrSJiZZ/b5s0Lt2UvBrigGpaLBmaBmw/HpV4COl4Wv1NIRMrKYkz+C2CLtJ4qGSbcOrHcM/Wd
 4FQKJ2pH8Rc1eAJvKsF8EdBKo47Iuve4yEEcsqGFNjm+OLp9IPsEHFbNwDigz8fxakgnFwEGz
 +KbcK7VAfyhrQ5NasJ6GyIYwRR2gYCQ7QKgrWwxUI+swT64sEMKrGT50ELUbfZENwQK0RmrRm
 +pDj4brHiAPNcRuBpCYRTVCbc5MWWLOBdpYvQ6bvJwoEyI/baVcrjcvc82oZK16Ehi9BzR+EW
 xrybkT9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff & Junio,

On Tue, 6 Sep 2016, Jeff King wrote:

> On Mon, Sep 05, 2016 at 12:10:11PM -0700, Junio C Hamano wrote:
> 
> >  * We could use <ptr,len> variant of regexp engine as you proposed,
> >    which I think is a preferrable solution.  Do people know of a
> >    widely accepted implementation that we can throw into compat/ as
> >    fallback that is compatible with GPLv2?
> 
> Maybe the one already in compat/regex? ;P

Indeed. That happens to be the implementation used by Git for Windows,
anyway.

> I think re_search() the correct replacement function but it's been a
> while since I've looked into it.

The segfault I investigated happened in a call to strlen(). I see many
calls to strlen() in compat/regex/... The one that triggers the segfault
is in regexec(), compat/regex/regexec.c:241.

As to re_search(): I have not been able to reason about its callees in a
reasonable amount of time. I agree that they *should* not run over the
buffer, but I cannot easily verify it.

The bigger problem is that re_search() is defined in the __USE_GNU section
of regex.h, and I do not think it is appropriate to universally #define
said constant before #include'ing regex.h. So it would appear that major
surgery would be required if we wanted to use regular expressions on
strings that are not NUL-terminated.

So I agree that a better idea may be to simply ensure NUL-terminated
buffers when we require them, although that still might be tricky. More on
that in a reply to your comment to that end.

Ciao,
Dscho
