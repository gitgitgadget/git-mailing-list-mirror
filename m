Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0296220D0C
	for <e@80x24.org>; Mon, 19 Jun 2017 15:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752875AbdFSPvK (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 11:51:10 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34490 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753357AbdFSPuf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 11:50:35 -0400
Received: by mail-pg0-f54.google.com with SMTP id 22so22043162pgc.1
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 08:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DuHm1yxE+Gh5JtFttmBgKUrvEJpD4kRFIjXTlGA/c3I=;
        b=HaawpEUziyeFHz5ldocsPMDh/4RG9Y+BQN8bY6Z3hqC84hUjo1zyGwwhe9eaX6GFtX
         +BKFYR41wKdEOT+7T9KMfwR8bCurt/T7Hk7EhYnk5KaKn9Pe+0nEaeUYFJ8F8r3/CWbU
         Gce8ijM/t46+PdO42p/EEVAkv96nvaRoyqBI1sgPcnkYSUsWVk7ScjbC8j1tvD94kSfL
         62A94ZHgveLphXVS2jBgZYy/X9C336eKWux6HceGsTlxcLXLj00E19e/P8RII/yz+gLR
         kEdLf9y7OznnWDeIJNqUo9BbRTgf76yaOAz9aO5Uh7Ln9JhXXMhyfcqPqzX/jtQfXM19
         K2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DuHm1yxE+Gh5JtFttmBgKUrvEJpD4kRFIjXTlGA/c3I=;
        b=NJWOE5rwAggyBOGyVUrvWwOBZcPtzutiI2yLyiPVIW/y9qHJnyb0uJk5hnHQKBXkRe
         6Q16ePfrnx6yBO0uOKdGRJt952JxBspzpe2bQkLDY4Hkkr0jiCOIrAAJaHlp5JmXn44a
         3Ls4u6JnwxAXGTGuGE/1LegfbVqHdxo1A53puEaDF32m/5L0nGzpKcD7x5EC4z0wA87L
         ted9m1r/5dOhrjCht+hsg4W1iZyh/lOh5viTwVZzUltUgp8xkhVEVcaBaXdxXJd8LW0B
         q8XblBpoX0Rd3LF2/Ax4dZft3Jkzw69ce/sh/cIwqY6OSTwlfNgazhENWU53ZfpmCK9q
         3y5A==
X-Gm-Message-State: AKS2vOwdsZrEyXbk8V9VhNTAAy7mKVaxXxpBLwMaRMDCkx9wo7MrjKRD
        3nbqJsmpzR60MYUHGGZi95PkT6i30cE8
X-Received: by 10.84.209.228 with SMTP id y91mr30385391plh.210.1497887434897;
 Mon, 19 Jun 2017 08:50:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Mon, 19 Jun 2017 08:50:34 -0700 (PDT)
In-Reply-To: <14e804c6-0798-8bbd-b182-66c3cd2b870c@vaisala.com>
References: <14e804c6-0798-8bbd-b182-66c3cd2b870c@vaisala.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 19 Jun 2017 08:50:34 -0700
Message-ID: <CAGZ79kbFeptKOfpaZ23yK=Zw9mJ0_evqPstHKkD1HSCaP_pC5g@mail.gmail.com>
Subject: Re: Behavior of 'git fetch' for commit hashes
To:     eero.aaltonen@vaisala.com, Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+cc Jonathan who did some work in the area.

On Mon, Jun 19, 2017 at 5:09 AM,  <eero.aaltonen@vaisala.com> wrote:
> Hello,
>
> I am seeing greatly different behavior for 'git fetch' commands on
> version 2.7.4 and 2.13.1 when the argument to fetch is a commit hash.
>
> I am working on a custom Continuous Integration (CI) system. The
> projects have dependencies that are simply fetched as repositories to a
> project subdirectory.
>
> In order to prevent a race condition in updating branches, I want to
> checkout the actual commit that was built in a previous job.
>
> Environment
> ===========
> Problem occurs with Git clients
> - 2.7.4
> - 2.13.1
>
> and Git server
> - Atlassian Bitbucket v4.14.3
> - git version 2.12.0
>
>
> The problem can be reproduced as follows, with
> - <authoritativeUrl> = URL to primary repository
> - <forkUrl> = URL to fork of the primary
> - <sha1> commit hash in a recent branch
>
> 1. git clone <authoritativeUrl>
> 2. cd resulting_directory
> 3. git fetch <forkUrl> <sha1>
>
> For version 2.7.4
> =================
> Git exits with exit code 1.
>
> However, if I first do 'git fetch <branch>', then 'git fetch <sha1> will
> also work
>
>  * branch   <sha1> -> FETCH_HEAD
>
> For version 2.13.3
> ==================
> Git exits with exit code 128 and message
> fatal: Couldn't find remote ref
>
> However, the workaround for descbibed abot for git version 2.7.4 no
> longer works. The result is always
> fatal: Couldn't find remote ref
>
> Desired result
> ==============
> Commit is in .git/FETCH_HEAD and can be checked out.
>
>
> I want to checkout a specific commit without creating any extra named
> remotes in the local git clone.
>
> Finally,
> What is the expected behavior for 'git fetch' in this case?
> Is there some other way I can achieve my goals?
>
> --
> Best regards,
> Eero Aaltonen
