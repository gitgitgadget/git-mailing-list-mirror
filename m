Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C99D320951
	for <e@80x24.org>; Fri, 17 Mar 2017 12:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751110AbdCQMJ5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 08:09:57 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:64653 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751031AbdCQMJy (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Mar 2017 08:09:54 -0400
X-AuditID: 1207440f-129ff70000003517-d4-58cbd18a3530
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 7D.14.13591.A81DBC85; Fri, 17 Mar 2017 08:07:39 -0400 (EDT)
Received: from [192.168.69.190] (p579061F1.dip0.t-ipconnect.de [87.144.97.241])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2HC7a7v006382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 17 Mar 2017 08:07:38 -0400
Subject: Re: Shared repositories no longer securable against privilege
 escalation
To:     Joe Rayhawk <jrayhawk@freedesktop.org>, git@vger.kernel.org
References: <148971018136.2144.12683278043600094739@richardiv.omgwallhack.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <195b30d7-9ea2-7a9b-79ca-41b7bb890a30@alum.mit.edu>
Date:   Fri, 17 Mar 2017 13:07:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <148971018136.2144.12683278043600094739@richardiv.omgwallhack.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqNt98XSEwcsbLBZdV7qZLDraVrE4
        MHmsmrOB1ePzJrkApigum5TUnMyy1CJ9uwSujNUXqgvWCFR8m9XP2sC4gLeLkZNDQsBEovPs
        WqYuRi4OIYEdTBIfZ3QwQjjnmSQ2LPjKDlIlLBAscXLqMiYQW0TAXmL69SvMXYwcQEV+Esfm
        eYKE2QR0JRb1NIOV8AKV7Dy8jRnEZhFQldh4aBEjiC0qECIxZ+EDRogaQYmTM5+wgNicAv4S
        57+/YQOxmQXUJf7Mu8QMYctLbH87h3kCI98sJC2zkJTNQlK2gJF5FaNcYk5prm5uYmZOcWqy
        bnFyYl5eapGuiV5uZoleakrpJkZI0PHvYOxaL3OIUYCDUYmHV2D+qQgh1sSy4srcQ4ySHExK
        orwvVpyOEOJLyk+pzEgszogvKs1JLT7EKMHBrCTCGzkHKMebklhZlVqUD5OS5mBREudVX6Lu
        JySQnliSmp2aWpBaBJOV4eBQkuAVvwDUKFiUmp5akZaZU4KQZuLgBBnOAzTc+zzI8OKCxNzi
        zHSI/ClGRSlx3kKQhABIIqM0D64XlhReMYoDvSLMawCyggeYUOC6XwENZgIa/PbDCZDBJYkI
        KakGRgm3pfdaP6Wp/N/gV78toS2wTNcxumDbccZuvrLV0X5sM/0a9t/MZlpyIijs/rW1Lkm1
        Ijeuei96utPD7P/2Pp2FQVLreBl5XcXEWqrV19XslgtpWT81jXNpXdo1br4zl5w2TDX7/zbw
        z7HfUXEMOZrfRB91+PxSOJLvse907ePyrXsPM7B0KrEUZyQaajEXFScCAGK7oV/lAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/17/2017 01:23 AM, Joe Rayhawk wrote:
> Git has started requiring write access to the root of bare repositories
> in order to create /HEAD.lock. This is a major security problem in
> shared environments as it also entails control over the /config link
> i.e. core.hooksPath. Permission to write objects and update refs should
> be entirely separate from permission to edit hook execution logic.
> 
> Given that /HEAD is not dynamically modified in the normal lifetimes of
> bare repositories, /HEAD.lock creation failure should probably be, at
> worst, an ignorable soft failure. Alternatively, some form of stale
> lockfile handling (currently there is none) could be made to work with
> a writable HEAD.lock in a read-only bare repository.
> 
> Obigatory HEAD.lock creation was introduced in the following commit:
> 
> commit 92b1551b1d407065f961ffd1d972481063a0edcc
> Author: Michael Haggerty <mhagger@alum.mit.edu>
> Date:   Mon Apr 25 15:56:07 2016 +0200
> 
>     refs: resolve symbolic refs first

Thanks for the report. This is indeed a problem for people who want to
set restrictive privileges on $GIT_DIR. I'd never thought of that use
case, but it makes sense. Is this practice recommended somewhere or
required by any Git hosting tools? (I'm curious how prevalent it is.)

The locking was added intentionally, to ensure that the reflog for
`HEAD` is written safely. But the code didn't do that prior to the
commit that you referenced, so (as a special case) ignoring failures to
lock `HEAD` due to insufficient permission is probably a reasonable
compromise.

I think the special case could be restricted even further to when `HEAD`
has the `REF_LOG_ONLY` flag in the reference transaction. I don't think
that `HEAD` would ever show up in a transaction solely to verify its old
value in a typical server scenario, but if so, that situation could be
special cased too.

(I can't resist pointing out that the *real* bug is storing special
references like `HEAD` in the top level of $GIT_DIR, but that can't be
changed now.)

Michael

