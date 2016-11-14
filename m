Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C67741F858
	for <e@80x24.org>; Mon, 14 Nov 2016 19:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935704AbcKNTOi (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 14:14:38 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33802 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932343AbcKNTOh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 14:14:37 -0500
Received: by mail-pg0-f48.google.com with SMTP id x23so54328348pgx.1
        for <git@vger.kernel.org>; Mon, 14 Nov 2016 11:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=La6ly0jCpYcTfJUTSK1RMxPzT/yZzqalFxMNOVmK3t8=;
        b=UqwtMzAvBpmExJFgsjB7acNXiGBOlGnpHVHBu/TclCrWB8AF9+K5NaEWkHCHeC8KC+
         /NTcQUxRumWoqD54fBHnpXP/lNnUeTKM8QcbespeosDjgPQDp4fO9tu+nwY+TzO6OjbY
         ofXjzcGPcboGQB8m1lrJWUQq0hHA6UlttyKgGHjBj4lKuo7ED/8168hsRzY+kvzGS9bE
         wgsPr2zRm+I5MFq8ckaR6UXT7ITURR3B65Lc2oFnY5gAsNME3H5jUGrFmgmrWfG9qsvU
         WObo/U77uRLdvFG/k/LHaA7F/Hk728GmtmwCQTByFqPAwvqjP6C8Xsq1e4r5g0QEb0jd
         4Dug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=La6ly0jCpYcTfJUTSK1RMxPzT/yZzqalFxMNOVmK3t8=;
        b=aDRlycY+phhQPzE1QAqrwoFN7SekQGbIEff08AwSDbrqBaawwSTq48z6vjssWJzhou
         Rf++Kn9cNJct+JQCdr6lF6s1khmFW6BMHj3NfDBho4qab1DzYVwTh9Q+feAdhxRTppx8
         YhuMCUDNL2OhxanfNpLbx0RdNT/iIPRw83z+/MiRjlw3FS9R/nVDVJMs8W1SZW85acTm
         pjfFXwJf7N8/K4Ij0Pfw5K5hK1H/irIa8hS6mJwFX6pC1rYWr/pUTibinOYmYbIph9tm
         3X+IMzTRDm5ccu2/6mZKmWDJYQiXtsgxEudBi1/u3EIWJOZ3LkBpjDzRNfJ7H3Ku6FWZ
         dHLg==
X-Gm-Message-State: ABUngvep58BXURniutGSqOzOiA9zJNkpjjd5jzIDptKZk4xgef/Fv3lrLJrbEUtwuFhGKzt4
X-Received: by 10.99.113.5 with SMTP id m5mr18416186pgc.34.1479150871779;
        Mon, 14 Nov 2016 11:14:31 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:5dfb:30a4:a03d:dd8c])
        by smtp.gmail.com with ESMTPSA id 71sm12431118pft.25.2016.11.14.11.14.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 14 Nov 2016 11:14:31 -0800 (PST)
Date:   Mon, 14 Nov 2016 11:14:29 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        sbeller@google.com
Subject: Re: [PATCH v3 5/6] grep: enable recurse-submodules to work on <tree>
 objects
Message-ID: <20161114191429.GB181044@google.com>
References: <1477953496-103596-1-git-send-email-bmwill@google.com>
 <1478908273-190166-1-git-send-email-bmwill@google.com>
 <1478908273-190166-6-git-send-email-bmwill@google.com>
 <xmqqk2c6x79c.fsf@gitster.mtv.corp.google.com>
 <c83066bc-5b2b-998c-7e22-c4fccbaba5de@google.com>
 <xmqqfumtyjoy.fsf@gitster.mtv.corp.google.com>
 <5a60b630-15fc-6b63-fb03-25aa0d1ef081@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a60b630-15fc-6b63-fb03-25aa0d1ef081@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/14, Jonathan Tan wrote:
> On 11/14/2016 10:56 AM, Junio C Hamano wrote:
> >Jonathan Tan <jonathantanmy@google.com> writes:
> >
> >>>>to:
> >>>>HEAD:file
> >>>>HEAD:sub/file
> >>>>
> >>>>Signed-off-by: Brandon Williams <bmwill@google.com>
> >>>>---
> >>>
> >>>Unrelated tangent, but this makes readers wonder what the updated
> >>>trailer code would do to the last paragraph ;-).  Does it behave
> >>>sensibly (with some sane definition of sensibleness)?
> >>>
> >>>I am guessing that it would, because neither To: or HEAD: is what we
> >>>normally recognize as a known trailer block element.
> >>
> >>Yes, it behaves sensibly :-) because "Signed-off-by:" is preceded by a
> >>blank line, so the trailer block consists only of that line.
> >
> >Oh, that was not what I was wondering.  Imagine Brandon writing his
> >message that ends in these three questionable lines and then running
> >"commit -s --amend" to add his sign-off---that was the case I was
> >wondering.
> 
> Ah, I see. In that case, it would consider the last block as a
> trailer block and attach it directly:
> 
>   to:
>   HEAD:file
>   HEAD:sub/file
>   Signed-off-by: ...
> 
> It is true that neither to: nor HEAD: are known trailers, but my
> patch set accepts trailer blocks that are 100% well-formed
> regardless of whether the trailers are known (to provide backwards
> compatibility with git-interpret-trailers, and to satisfy the
> certain use cases that I brought up). The "known trailer" check is
> used when the trailer block is not 100% well-formed.
> 
> This issue can be avoided if those lines were indented with at least
> one space or at least one tab.

Who would have thought my simple example would cause this kind of
discussion!  I can update the commit message and indent the output so
that it looks like the following:

to:
  HEAD:file
  HEAD:sub/file

-- 
Brandon Williams
