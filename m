Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE47B20229
	for <e@80x24.org>; Wed,  9 Nov 2016 09:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbcKIJ6k (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 04:58:40 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:35162 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbcKIJ6h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 04:58:37 -0500
Received: by mail-it0-f43.google.com with SMTP id e187so197530380itc.0
        for <git@vger.kernel.org>; Wed, 09 Nov 2016 01:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PmV4MsxLENTrmyl4d5iQUFmtbbFhf8kel5GWHDjBgiI=;
        b=GH4ICqW10URwriZrGpsKzuTq+T3Al8krPokh9STfMT5c9gPCLjIYgDJ+iix7rmgfTt
         8N6mXAxmIANuV2kHrczPQjgm5WvSdPrjZLe+zFkHtlcOP6LhNR9WVYOlK90zLtaEE/R2
         lUZWsw5EU4j5bSb5lUF0vjQUYsMTzUzTm1+oK0E/KHubrvY/Uqg7J7gUwrjduM0HMd4j
         77dShtLf4AH5/VMBvdYIomktGnjn5rsfyIe58ndbs2hFeO6SWhyqX4w5zgvyhs3I3NBl
         tB23jndfgVwogzNUDWLMKqog9+1FadNA5Eh0hwiB90NtBKK16qxWF9cEi7FhH2aoXjuL
         vAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PmV4MsxLENTrmyl4d5iQUFmtbbFhf8kel5GWHDjBgiI=;
        b=U12XaRxfsTBGHL3k0nl+j3qBpBSbVfLu5uE0clE2aQKVzrS2H3HLV3+kZKbtOR3hGG
         a6YkZaZHZNWjOlkv26yuon6Malk9E5I+o0yR9PYJFLugSW3yPr/Fx1zjp163lIRKuAfT
         1LYkBQNeJHLHEtzEJRpxvn1InKY5bCq4Fu9znb2PHmaVLEJ1wojoyGx3Nqn5K4bzqh36
         raEOwUUDCdgwo6c0j8IcilCuxERMyN811bV42K1WviDTrZ68pTWfQTLC4ak+ilEnhsAj
         3flsoRWm1+GppY3m+uvf3PJNrnvclJS1HMeljMVmJuXu+OhyR5Av9snUkPPOMQy/Itoz
         xtJA==
X-Gm-Message-State: ABUngvfIbL0IIhr27+joTuhtgc2yZjkUnIS4kFf13yBBEkopHdeib09qVIo4I4xuktUYCCo1fmZuL8ZE5yh/2w==
X-Received: by 10.107.59.9 with SMTP id i9mr13984766ioa.176.1478685476012;
 Wed, 09 Nov 2016 01:57:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Wed, 9 Nov 2016 01:57:25 -0800 (PST)
In-Reply-To: <20161028185502.8789-33-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com> <20161028185502.8789-33-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 9 Nov 2016 16:57:25 +0700
Message-ID: <CACsJy8BKwvaw8CsorZhoYDw6gxoosv0gPRRpdwW87+YMASCVcA@mail.gmail.com>
Subject: Re: [PATCHv2 32/36] pathspec: allow querying for attributes
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 29, 2016 at 1:54 AM, Stefan Beller <sbeller@google.com> wrote:
> The pathspec mechanism is extended via the new
> ":(attr:eol=input)pattern/to/match" syntax to filter paths so that it
> requires paths to not just match the given pattern but also have the
> specified attrs attached for them to be chosen.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/glossary-content.txt |  20 +++++
>  dir.c                              |  35 ++++++++

Pathspec can be processed in a couple more places. The big two are
match_pathspec and tree_entry_interesting, the former traverses a list
while the latter does a tree. You don't have to implement attr
matching in tree_entry_interesting right now because nobody needs it,
probably. But you need to make sure if somebody accidentally calls
tree_entry_interesting with an attr pathspec, then it should
die("BUG"), not silently ignore attr.

The way to do that is GUARD_PATHSPEC macro which makes sure if only
recognized magic is allowed through. This macro guards all pathspec
processing functions. So you can add a new PATHSPEC_ATTR macro (or
some other name) to the "Pathspec magic" group near the beginning of
pathspec.h, set it whenever attr magic is present when you
parse_pathspec(), then lift the GUARD_PATHSPEC restriction in
match_pathspec() only because this function can handle it. Whenever
attr magic is used by any other functions, it will die() the way we
want.
-- 
Duy
