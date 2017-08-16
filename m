Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F1731F667
	for <e@80x24.org>; Wed, 16 Aug 2017 22:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752420AbdHPWxG (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 18:53:06 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33592 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752368AbdHPWxF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 18:53:05 -0400
Received: by mail-pg0-f48.google.com with SMTP id t3so2074789pgt.0
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 15:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xsfKSVASQC25YtXJYY8JIh8BQncihEc8HdOwJxiYK0Q=;
        b=ZMB5m8FPKB7RJSvKSib0O5LXa17FslUrhzx335d9ZFUJ4vwat48IPy70VZkChEUHs1
         Xcw1EcJahxjOc4sS7cYJDw7VUlCcJs1cTu71YCAT3W4CraAG02U7qRN95T78bxrWqexB
         9SL8+U8w/5Nvwj2ZmXDdphgxy9YOuOnPWY39iU8zTnXl7zV91JwktYnRy5tSnTYdb1Dp
         R6r4C/X1D2DGq35l0tYHL48ed1+uI2tUHNryMia8G18sLUI89WoUlXw8bBS6ghqDdVLh
         1bxeIat8k7idtamCTeWxRsFgJBWAn2LgfvdzsS83oDTRl4+Bw1j4cVxmca52wpWiu6Yh
         JC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xsfKSVASQC25YtXJYY8JIh8BQncihEc8HdOwJxiYK0Q=;
        b=O25isL7rBwl95exOaJk9c7j5FMcMU6NZ+lWBZhfs5WesPVaGJgMj+8o/SNzAxstE9O
         xKHmpFy06ipnIrmlJLvqVXIhTuthglO1ie8TC4cnbkH4Bz76npL/GlLXu8UrQsEN2qBq
         8ExlpBBC8ldxmEbPxDnLadfR7+l6BT3O58VX9m4ghjnU16zJ8pylxLpvbMwMO63V6n8Q
         i8GUzv9UMzEpY2MgcV45zuv2jeYdLHAt85GpBV8pWaaOaK/ZSvu08cH8ebiSkoOx2Eiu
         aPhXQzB+AccT2AK4tOnw9Xxm5dNqxq7MxQm4Kw8Bb38OZgUbj8XfLWKbjLywy/MDLOBA
         /dUQ==
X-Gm-Message-State: AHYfb5jsSQ+fgtgn3SMwZR2j2YPWk4MNXlRS4xwsU1udL+CnuOflaZ/t
        J0wPLoz0FBkXg0ck
X-Received: by 10.99.9.129 with SMTP id 123mr3002023pgj.445.1502923984891;
        Wed, 16 Aug 2017 15:53:04 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:5897:a569:433e:2b7b])
        by smtp.gmail.com with ESMTPSA id d4sm4704094pfj.59.2017.08.16.15.53.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 16 Aug 2017 15:53:04 -0700 (PDT)
Date:   Wed, 16 Aug 2017 15:53:02 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH 01/10] pack: move pack name-related functions
Message-ID: <20170816155302.06c3a7a9@twelve2.svl.corp.google.com>
In-Reply-To: <xmqqinhtzt3w.fsf@gitster.mtv.corp.google.com>
References: <cover.1502220307.git.jonathantanmy@google.com>
        <368a1095557aa5f68cebd4d4e08628351c03b843.1502220307.git.jonathantanmy@google.com>
        <CAGZ79kYQP74fTu1hFDLyKhS-2NTbUhtirWTxRMNavgO09SenYg@mail.gmail.com>
        <20170808135001.48f2440e@twelve2.svl.corp.google.com>
        <CAP8UFD20_Q7djbJfMmrGEnN3j2NasHyvuNAfZHMr_bNRjO0qpw@mail.gmail.com>
        <20170809101646.4bc67606@twelve2.svl.corp.google.com>
        <b65a5d52-490f-5ea6-aef5-8d2f6c916536@gmail.com>
        <xmqqinhtzt3w.fsf@gitster.mtv.corp.google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 11 Aug 2017 14:34:27 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Ben Peart <peartben@gmail.com> writes:
> 
> > On 8/9/2017 1:16 PM, Jonathan Tan wrote:
> >
> >> Ah, I forgot to mention this in the cover letter. I thought that one
> >> header was sufficient to cover all pack-related things, so if we wanted
> >> to know which files used pack-related things, we would only need to
> >> search for one string instead of two. Also, the division between
> >> "pack.h" and the hypothetical "packfile.h" was not so clear to me.
> >
> > I prefer having source and the header files that export the functions
> > have matching names to make it easy to find them.  I would prefer
> > packfile.h vs pack.h myself.
> 
> Meaning "If we have packfile.c, packfile.h is preferrable over pack.h"?
> I tend to agree with that.

Fair enough - I've changed it so that the functions now go into
packfile.h. I'll send it out once I know what to base it on (at least
jt/sha1-file-cleanup, and a few more branches that also modify
sha1_file.c).
