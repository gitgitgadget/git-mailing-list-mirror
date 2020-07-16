Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA10CC4345C
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 23:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9551F21473
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 23:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594940997;
	bh=LUTFknJkOzevTm7PS94PtC8DvagRnni5DMm5Ik/MwGc=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=RdeFtcEVw1Dywh3FD2u8DO6TGJfNAZ1VcPezAxfqSmDSUoGXpXqb/X6I608qX5Hzh
	 v5XHJZeRVDZwIn8jhKc+n/wY10hI5AqS/YAJdc2cMGXYznaT3vrZtOAnk5drymtmc4
	 s5FRXCLTqS5AMJoiI9ouiK6fghNqJ3iHHrSDr+44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgGPXJw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgGPXJV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 19:09:21 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4133FC08C5F8
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 15:54:33 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id o38so6286171qtf.6
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 15:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=WgBRR3pm35tdFsCADI3yASFfTxWdRB6jDOHUgepS+RU=;
        b=DCiuGSDEuk+6qaprsQhd7vJ02jkUarpYtp+Ts07fC2V0muPQmOLYUIpDE1d6jvYy+y
         kZBiWMB81d+RW0FxVyeiaHh81D0ZiE9EO1BUAbWHH5MNfmWRqOV8SBsz3Emz3Yvj2ng0
         SaG4y8krLXct2pFmhKXG9ubWs9i58oQzVF25c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=WgBRR3pm35tdFsCADI3yASFfTxWdRB6jDOHUgepS+RU=;
        b=pgkpcAKrqHPu+vSEQjJOxfndcFlHRlJdKDsitGvgRWzMLErxaz8vBjy8qa1GWqSmPh
         S0OdIyB9iD7RkdBbfuMQdT8DNYzlEGb7RIlTA8CJtTSnDUM1fwocFJK5vvvq/JDIA9lq
         YweEvCoN5GwuTQiKPV27D00CWbSVGsZl/ljQFEMfaayZrHv0ksgkHKaP3TRMSp91RMxx
         EeaBJa9FGFBl8vP1jdlEnW5r7w9QfCtFEzWJ9CsybjKH9doxsyliXqpqQ8L+GNaruSnm
         +Y83DP5Sc1rTEvvvMcaQNjcCDSlf9qDZogWlT8lnW/N94K2u+i7oGtgl3BBFLk/ym12j
         SzWQ==
X-Gm-Message-State: AOAM531ziBXduT+3gbzti13yEwBz7oIXQ2bOAejkQIjLfU2E4nTW938X
        00hOIc9aCnGWGH/JACMNv5hj5w==
X-Google-Smtp-Source: ABdhPJzWXkwvQpn2dlKiH7iQUGxc0ZJV/thI5TzYBCvcrZyIqMWTQJDxVSbwhfvCI5ncD8mile1sDA==
X-Received: by 2002:aed:279d:: with SMTP id a29mr8002837qtd.112.1594940072210;
        Thu, 16 Jul 2020 15:54:32 -0700 (PDT)
Received: from chatter.i7.local ([87.101.92.156])
        by smtp.gmail.com with ESMTPSA id z68sm8506769qke.113.2020.07.16.15.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 15:54:31 -0700 (PDT)
Date:   Thu, 16 Jul 2020 18:54:29 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Compressing packed-refs
Message-ID: <20200716225429.i7pb6xorkwdsf5fn@chatter.i7.local>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20200716221026.dgduvxful32gkhwy@chatter.i7.local>
 <xmqqsgdrf64c.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsgdrf64c.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 16, 2020 at 03:27:15PM -0700, Junio C Hamano wrote:
> I think the reftable is the longer term direction, but let's see if
> there is easy enough optimization opportunity that we can afford the
> development and maintenance cost for the short term.
> 
> My .git/packed-refs file begins like so:
> 
>     # pack-refs with: peeled fully-peeled sorted 
>     c3808ca6982b0ad7ee9b87eca9b50b9a24ec08b0 refs/heads/maint-2.10
>     3b9e3c2cede15057af3ff8076c45ad5f33829436 refs/heads/maint-2.11
>     584f8975d2d9530a34bd0b936ae774f82fe30fed refs/heads/master
>     2cccc8116438182c988c7f26d9559a1c22e78f1c refs/heads/next
>     8300349bc1f0a0e2623d5824266bd72c1f4b5f24 refs/notes/commits
>     ...

Let me offer a more special-case (but not crazy) example from 
git.kernel.org. The newer version of grokmirror that I'm working on is 
built to take advantage of the pack-islands feature that was added a 
while back. We fetch all linux forks into a single "object storage" 
repo, with each fork going into its own 
refs/virtual/[uniquename]/(heads|tags) place. This means there's lots of 
duplicates in packed-refs, as all the tags from torvalds/linux.git will 
end up duplicated in almost every fork.

So, after running git pack-refs --all, the packed-refs file is 50-ish MB 
in size, with a lot of same stuff like:

5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c refs/virtual/00018460b026/tags/v2.6.11
^c39ae07f393806ccf406ef966e9a15afc43cc36a
...
5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c refs/virtual/00bcef8138af/tags/v2.6.11
^c39ae07f393806ccf406ef966e9a15afc43cc36a

etc, duplicated 600 times with each fork. It compresses decently well 
with gzip -9, and *amazingly* well with xz -9:

$ ls -ahl packed-refs
-rw-r--r--. 1 mirror mirror 46M Jul 16 22:37 packed-refs
$ ls -ahl packed-refs.gz
-rw-r--r--. 1 mirror mirror 19M Jul 16 22:47 packed-refs.gz
$ ls -ahl packed-refs.xz
-rw-r--r--. 1 mirror mirror 2.3M Jul 16 22:47 packed-refs.xz

Which really just indicates how much duplicated data is in that file. If 
reftables will eventually replace refs entirely, then we probably 
shouldn't expend too much effort super-optimizing it, especially if I'm 
one of the very few people who would benefit from it. However, I'm 
curious if a different sorting strategy would help remove most of the 
duplication without requiring too much engineering time.

-K
