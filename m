Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C7952027C
	for <e@80x24.org>; Thu, 18 May 2017 15:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932992AbdERPmO (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 11:42:14 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33390 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932980AbdERPmK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 11:42:10 -0400
Received: by mail-pg0-f42.google.com with SMTP id u187so24619567pgb.0
        for <git@vger.kernel.org>; Thu, 18 May 2017 08:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8U7Aq+bs5Ho1BZa209ApehPt+iMAuRBL5VwrmZHEHtY=;
        b=V/g7y4W+zqyTSdZ32Qr83rlo1pOLUHQtEZhZ7vSdCKn0GJn6xLhFgzlB/bDQ0/CNkA
         ubu4sy7PlWXoB7Pv/MBATxqUdZR4Oq5uY2gvlqjQtnskIAyJ9bYhSmXQ1mQOWp9+U0SK
         ucowdiwW2chDCNVBRw3DwAMRyLNBXrqorpHCFoy+O15uRMmwOjZ3fNM1Q0Ky1C+H1J5E
         bl2MblyGw5pIkhc1V07e79ee2N3AlToj/XnJ4ywUFRVOrotYOHgKnlgPoWd2R/5gunJe
         pzSNMvktwW3c3WioBz4YAA6UIpqj0YDbGQ/1ht04kfCv1l37/LE5G68M3jb0VfjlXrXV
         fWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8U7Aq+bs5Ho1BZa209ApehPt+iMAuRBL5VwrmZHEHtY=;
        b=p9PHckQkEOYoKDp5z/S9kVBNNa+IuSzBbDteyDBbMcivK8lXymTief+pmYpecsLFch
         6MWk6hX9wbqhvyjH6h9v5INbT/NSRUdyPF9/ccAjHUpS1ULOukpPdwPMiAn+poNsPeiA
         dNHfF9pjy6aUYVMJRA34Qvof+CZqTjnwD6+nDpzNzSw/8GpNbrUfQY3X3nkY+cQ8cyYY
         LVd1IczHUSdkrXupjcM+XmR35ycIF+SHg+PO0BWLJyIARBEWFtSnV86ChbhjROB26ecL
         a3nkh+z1TEX0lGQrO8WzeA89xbx6k0+zyBn7Krmu/0SO2KxVmJYaP4JFXLXEDQI2VWGF
         vqPQ==
X-Gm-Message-State: AODbwcCBMDlEWdKux8IhqHNiA6a6lOXACBDPGHj4EEhCInLYdo+Orw5R
        9SJKBq32YkufDJZe
X-Received: by 10.99.136.65 with SMTP id l62mr5202325pgd.151.1495122129594;
        Thu, 18 May 2017 08:42:09 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:1838:1185:c4dc:8c8d])
        by smtp.gmail.com with ESMTPSA id a11sm11788733pfe.109.2017.05.18.08.42.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 May 2017 08:42:08 -0700 (PDT)
Date:   Thu, 18 May 2017 08:42:07 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 10/23] files_ref_store: put the packed files lock
 directly in this struct
Message-ID: <20170518154207.GC112091@google.com>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <dd7637060bac1a27e03563edc82649812dcf897c.1495014840.git.mhagger@alum.mit.edu>
 <20170517131753.rditx62clmkrdmeq@sigill.intra.peff.net>
 <20170518001717.GF185461@google.com>
 <20170518011153.luuacy5jay6vinzv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170518011153.luuacy5jay6vinzv@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/17, Jeff King wrote:
> On Wed, May 17, 2017 at 05:17:17PM -0700, Brandon Williams wrote:
> 
> > > This made me wonder how we handle the locking for ref_stores besides the
> > > main one (e.g., for submodules). The lockfile structs have to remain
> > > valid for the length of the program. Previously those stores could have
> > > xcalloc()'d a lockfile and just leaked it. Now they'll need to xcalloc()
> > > and leak their whole structs.
> > 
> > Wait, why would this be the case?  I would assume that you would
> > allocate a ref_store (including a lockfile for it) and then once you are
> > done with the ref_store, you free it (and unlock and free the lockfile).
> > I'm definitely not versed in ref handling code though so I may be
> > missing something.
> 
> One used, you are not allowed to free a lockfile struct (actually these
> days it's just the "tempfile" part of it), because it lives on the
> cleanup-handler's tempfile_list forever.
> 
> This is a holdover from the early days of the lockfile code, but I think
> we could loosen it (and that's the right solution in the long run).
> 

Ah ok, thanks for the info!

> > > I suspect the answer is "we don't ever lock anything except the main ref
> > > store because that is the only one we write to", so it doesn't matter
> > > anyway.
> > 
> > Really? I can envision a case in the future where we'd want to update
> > a ref, or create a ref inside a submodule.
> 
> Oh, I agree it's a probable thing for the future. I was mostly wondering
> about the immediate change. I think this patch makes things slightly
> worse for that future, but the right fix is to remove the weird tempfile
> lifetime requirement in the first place.
> 
> -Peff

-- 
Brandon Williams
