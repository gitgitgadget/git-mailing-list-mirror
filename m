Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A6701F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 20:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbdARUua (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 15:50:30 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36112 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752726AbdARUu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 15:50:29 -0500
Received: by mail-pg0-f49.google.com with SMTP id t6so7289534pgt.3
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 12:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bs5Jz7yKPncBwxuf3dS2+l8UF4Cn5BWjHC96V3fHbgw=;
        b=KN0U68+m8nfTmy0LDF2Ihp9n98Jmy6PvbxTfGHP3LRqyTvof+Dy+pGSWesl5asi7VW
         nLSMy1WBwaSCq2M6e4fbbRXAFGpkxi1LJU6Vk52VIl+9ocfYncHPUCORgqEbp9Iqo05K
         s8h+8HrK6ZUzWZaDq4Chj/8nW5aITIF7CEd0nc+HcpSRStCB825kjxPxL7nlFSAgffAS
         1abCVn0/3EXuINZvaM/IPk0VqU+aapO9HiEbRs3wo9x0bzKMV4o422xSoCPALgT26hZp
         /60/iToO/gEySG1M4LAdhuOyypwmYSJ2NB0Z+wcWP4d524uMHdFvhBhDNYesgCrjsPSY
         t7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bs5Jz7yKPncBwxuf3dS2+l8UF4Cn5BWjHC96V3fHbgw=;
        b=eyww20nNk/8PcZagw/+qW/DoBGDWKhr19yYvl7RCP0Nm+6Nc9twGn6LE1CbBjY6Uct
         /cFSuC8Q27wW1qYS4uVFD0KqG1vZnj30F43bUBbpiS6NvK9RE96Up4AUdhnIk9oj+Bps
         EhCjOnKrrCdw0VM37gnCG4R+231Hp2DAUTwp+NTfD8ZpPFW2/z2aBEG3hLRTRxUz2Esd
         FF2JWgawF9a6nurHeM6G4BAcvlt9gV5136r8zbPuxhLP75hbysCFPMntgv/JvIpHsSV5
         Ip2tDlnpRDluwfozxy0XaTVDx1sUN2fFBRz6c55Uei5ha7TtTOC+x5a4/fIv6kCkzKQm
         U43g==
X-Gm-Message-State: AIkVDXIjmV8yHAR4jvgDJtoftVo87u5RBr3ppwStuedzVs2k2VuQHdu6bCLQBRT2kIn8xLP3
X-Received: by 10.98.67.72 with SMTP id q69mr5893629pfa.14.1484772628662;
        Wed, 18 Jan 2017 12:50:28 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:1d68:bc5d:3a1b:2ccb])
        by smtp.gmail.com with ESMTPSA id 89sm2830736pfo.40.2017.01.18.12.50.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 Jan 2017 12:50:27 -0800 (PST)
Date:   Wed, 18 Jan 2017 12:50:26 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 25/27] attr: store attribute stacks in hashmap
Message-ID: <20170118205026.GC10641@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170112235354.153403-26-bmwill@google.com>
 <CAGZ79kZv2=dNt=TeJXbac4S20WcdOZo=iVa-b+4zkOoGVM1OFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZv2=dNt=TeJXbac4S20WcdOZo=iVa-b+4zkOoGVM1OFA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/18, Stefan Beller wrote:
> On Thu, Jan 12, 2017 at 3:53 PM, Brandon Williams <bmwill@google.com> wrote:
> > -static void prepare_attr_stack(const char *path, int dirlen)
> > +/*
> > + * This funciton should only be called from 'get_attr_stack()', which already
> 
> "function"
> 
> > +               /* system-wide frame */
> > +               if (git_attr_system()) {
> > +                       e = read_attr_from_file(git_etc_gitattributes(), 1);
> 
> read_attr_from_file may return NULL, so we'd have to treat this similar
> to below "root directory", i.e. xcalloc for an empty frame?

The push_stack function doesn't do anything if 'e' is NULL, so we should
be fine here.

> 
> > +
> > +               /* root directory */
> > +               if (!is_bare_repository() || direction == GIT_ATTR_INDEX) {
> > +                       e = read_attr(GITATTRIBUTES_FILE, 1);
> > +               } else {
> > +                       e = xcalloc(1, sizeof(struct attr_stack));
> > +               }
> > +               key = "";
> > +               push_stack(&core, e, key, strlen(key));
> 
> If this is a bare repo, could we just omit this frame instead of pushing
> an empty xcalloc'd frame? (Same for the stack frames of system wide
> and home dir) ?

The reasoning behind having the object created even if its a bare repo
is so that later we can easily see that a frame has been read and
included and doesn't need to attempt to reread the frame from disk
later.  It also made things simpler when storing the object in a hashmap
since storing a NULL ptr was awkward.

Though looking at Junio's discussion we may want to rethink how the
stacks are handled.  I still need to think about it some more.

-- 
Brandon Williams
