Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EB57202A7
	for <e@80x24.org>; Tue,  4 Jul 2017 07:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbdGDHTN (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jul 2017 03:19:13 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:40892 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751631AbdGDHTM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2017 03:19:12 -0400
Received: from tigra (tigra.domain007.com [192.168.2.102])
        by hermes.domain007.com (Postfix) with ESMTP id DF3C4D400BD;
        Tue,  4 Jul 2017 10:19:09 +0300 (MSK)
Date:   Tue, 4 Jul 2017 10:19:09 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git ML <git@vger.kernel.org>
Subject: Re: Should "head" also work for "HEAD" on case-insensitive FS?
Message-ID: <20170704071909.phs4bf5ybdord2lv@tigra>
References: <87ziclb2pa.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ziclb2pa.fsf@gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 04, 2017 at 12:00:49AM +0200, Ævar Arnfjörð Bjarmason wrote:

> I don't have a OSX box, but was helping a co-worker over Jabber the
> other day, and he pasted something like:
> 
>     $ git merge-base github/master head
> 
> Which didn't work for me, and I thought he had a local "head" branch
> until realizing that of course we were just resolving HEAD on the FS.
> 
> Has this come up before? I think it makes sense to warn/error about
> these magic /HEAD/ revisions if they're not upper-case.
> 
> This is likely unintentional and purely some emergent effect of how it's
> implemented, and leads to unportable git invocations.

JFTR this is one common case of confusion on Windows as well.
To the point that I saw people purposedly using "head" on StackOverflow
questions.  That is, they appear to think (for some reason) that
branches in Git have case-insensitive names and prefer to spell "head"
since it (supposedly) easier to type.

I don't know what to do about it.
Ideally we'd just have a way to perform a final check on the file into
which a ref name was resolved to see its "real" name but I don't know
whether all popular filesystems are case preserving (HFS+ and NTFS are,
IIRC) and even if they are, whether the appropriate platform-specific
APIs exists to perform such a check.

