Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EB2F1FF7F
	for <e@80x24.org>; Thu,  8 Dec 2016 00:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933659AbcLHAEB (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 19:04:01 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33131 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932400AbcLHAEA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 19:04:00 -0500
Received: by mail-pg0-f46.google.com with SMTP id 3so167269621pgd.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 16:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6Z7zom2U3vXmhMiRiSPSLPFicqtRrwXA399mGC2hq28=;
        b=IXP00r0HU1SiWCZXLVNKDqGLlJ+T83hQgH2hs1f/3tl1dW/P5uJaMlFFxIVRKNqN48
         afc6c3wwhFSskx2F5YW7Rboys8FLMo64tPb8CHrT/mKGSEvdXVKCunSFgdHJFpb2kyVB
         UBIhTgVL3NG8GbLIh+1h60qveOfnkfwyGss468C6vnQiemzIqRNxoPCwVdLptP8aK+C9
         WnuaRYMkrLz2JPDi4JUJ/OptyrxVmdmdqXox5TmQKWOKhXfX+F1yQ8wq3JKO3ezp4KDP
         RNdEhN6SwVnkvLopu+e+i4kVURu94pqQwR4H1CMzDRQy04b+dPzPkYsjL8nABp4nAbUN
         Ft/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Z7zom2U3vXmhMiRiSPSLPFicqtRrwXA399mGC2hq28=;
        b=eviJjecKYhSS4vaGGJ6wbwKWwluHCmFAQrwgihUXYvcWdLD6ghSUI3JtFGuFyoAkz2
         87xuRYDFXtq2TlV3tEByjmOR02GIiOnCCmNxCoZ2BOcCKho5IWmILgCU/R1T7HI8KnrQ
         Sul5I4FaUShfY5lcfzuS0n64u9E/lFW39lZUEJhN9/FbNH9FUdDrqBVy4iSOrbpzXzHI
         lJSnToBQSPgGxk1VO+87nYfDG3BCUdllPyyXBDT48QRaZPq1G36yW4pZCSNUGEPAzg8+
         smqOXUhoI53/QbTN9cliS4Oa8sE+hdXVnX9kh9ZQjx5mGT4hGEU60ZyxTrKVXIoaAn1j
         EJug==
X-Gm-Message-State: AKaTC03pmvOZ367QxBU4enYtvqtxDUry9jdmfVcfKxz2lalLJjNFei/SC2ZrahMIN+vJ4t9q
X-Received: by 10.84.211.144 with SMTP id c16mr152827997pli.37.1481155439760;
        Wed, 07 Dec 2016 16:03:59 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ccae:4719:31da:e07d])
        by smtp.gmail.com with ESMTPSA id 72sm45094904pfw.37.2016.12.07.16.03.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 16:03:58 -0800 (PST)
Date:   Wed, 7 Dec 2016 16:03:57 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/17] dir: convert create_simplify to use the pathspec
 struct interface
Message-ID: <20161208000357.GJ116201@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481061106-117775-3-git-send-email-bmwill@google.com>
 <CACsJy8AX09pxkyUkLU905v1MpXocLzV5bK0APuNmMUNb50Lavg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8AX09pxkyUkLU905v1MpXocLzV5bK0APuNmMUNb50Lavg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07, Duy Nguyen wrote:
> On Wed, Dec 7, 2016 at 4:51 AM, Brandon Williams <bmwill@google.com> wrote:
> > Convert 'create_simplify()' to use the pathspec struct interface from
> > using the '_raw' entry in the pathspec.
> 
> It would be even better to kill this create_simplify() and let
> simplify_away() handle struct pathspec directly.
> 
> There is a bug in this code, that might have been found if we
> simpify_away() handled pathspec directly: the memcmp() in
> simplify_away() will not play well with :(icase) magic. My bad. If
> :(icase) is used, the easiest/safe way is simplify nothing. Later on
> maybe we can teach simplify_away() to do strncasecmp instead. We could
> ignore exclude patterns there too (although not excluding is not a
> bug).

So are you implying that the simplify struct needs to be killed?  That
way the pathspec struct itself is being passed around instead?

-- 
Brandon Williams
