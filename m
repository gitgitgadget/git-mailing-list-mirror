Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0B2A1FC96
	for <e@80x24.org>; Sat,  3 Dec 2016 00:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753150AbcLCAXz (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 19:23:55 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33195 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752550AbcLCAXy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 19:23:54 -0500
Received: by mail-pg0-f48.google.com with SMTP id 3so112832479pgd.0
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 16:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tx9DPGU6qt/ML9gCuoHn26WRkEy6pujtvYEGRzzEzVs=;
        b=po7cZ4QvmNeVcTRf/U6IRKuo+x1K1en4o1MzCvbLKmwTC+D5rZAuccJSiugNpWnf9I
         5iVRIojt0uoe/YiJpDLYLdmQ+tNktVhefxHzJ7oYp8PUVoT6rbWBpV/D65CrL9Jk8rsr
         +u3sht+qVK8tS8XMpZjze1GwzjN+KuJzgp3uPYvea64oEzxejJFfUVMJdpSIF/iZfhHk
         C4MS0kPjVlkh3EjIyRixzmfSv3gpZ/ob+LLoEzALd7EYnpKQiTdEHn9qwJ/NE8LtFHdV
         Mt5fDA9pthwaeDRrMEHLbtz8E9taFDn37qi7OfWfkTKzwhshprn+YABj4bhk1xr5kBrc
         inNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tx9DPGU6qt/ML9gCuoHn26WRkEy6pujtvYEGRzzEzVs=;
        b=jg2SL8HHx7nWEbQqRPWiisfVpe8MhS792gdeTr2OjgU94WHNtL/Qifp2MHHzk/sYJY
         sEX9fHrNbG478xKnX1kcPFpSauQ1ZwIopWF1Q89suefCeTr5idPJNMJjU/XKaHg/FKOk
         SBHZ6Doaj9kfPynwX2NauRFZj/q7yhB3L4p+f0WOsrUVE0R08IqgdS8R6w0LhzS0ZX0a
         eSjKUuwtLDVhexjmYx01WvpL1e/ewJ6lXqPk8BtUphuQWQdmc63TthF1C9kbUH22Gnts
         7lWTdoUl/HNtvUlQPueKCUjt8fiwhpdMnahn4DVSFtVdukNxNPCyrzJsbiq7sqQYObbM
         rPdw==
X-Gm-Message-State: AKaTC00El0pSm3ikoL+Vm4cAFWOJX+igUFobCRKdYqMIBv3ByDcysiDa3XIX4Kojcnji+YDX
X-Received: by 10.84.209.136 with SMTP id y8mr103099299plh.114.1480724213754;
        Fri, 02 Dec 2016 16:16:53 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:217c:34ba:fcf8:d822])
        by smtp.gmail.com with ESMTPSA id o68sm10208672pfb.42.2016.12.02.16.16.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 16:16:52 -0800 (PST)
Date:   Fri, 2 Dec 2016 16:16:51 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6 1/6] submodules: add helper functions to determine
 presence of submodules
Message-ID: <20161203001651.GE117792@google.com>
References: <20161201205444.GG54082@google.com>
 <20161201205944.2py2ijranq4g2wap@sigill.intra.peff.net>
 <CAGZ79kaqzssfN_bRQYpqC9HsKmyQZNCQcs+T5ke95Sf-C5PaRQ@mail.gmail.com>
 <20161201215934.g7dt5ioekmx6ssii@sigill.intra.peff.net>
 <20161202183622.GB117792@google.com>
 <CA+P7+xpoO=ieRyQb8r8Xz12nN10f53LKeVMgAO8XPdSwvG7fuA@mail.gmail.com>
 <20161202184944.GC117792@google.com>
 <CA+P7+xoi_UNSv-dKVFWf7T4o3uBtGa0wR6=nnYX+kjzLAmw6ug@mail.gmail.com>
 <CAGZ79kYPpc0=NAJaNPW+8faszOPAkq=b3m-EopY5A8oFwh+9=g@mail.gmail.com>
 <20161202214529.mjekdaixrdoyroxq@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161202214529.mjekdaixrdoyroxq@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/02, Jeff King wrote:
> On Fri, Dec 02, 2016 at 11:28:49AM -0800, Stefan Beller wrote:
> 
> > I just reviewed 2 libc implementations (glibc and an Android libc) and
> > both of them
> > do not use chdir internally, but use readlink and compose the path 'manually'
> > c.f. http://osxr.org:8080/glibc/source/stdlib/canonicalize.c?v=glibc-2.13
> 
> Interesting. It might be worth updating our implementation. The original
> comes all the way from 54f4b8745 (Library code for user-relative paths,
> take three., 2005-11-17). That references a suggestion which I think
> comes from:
> 
>   http://public-inbox.org/git/Pine.LNX.4.64.0510181728490.3369@g5.osdl.org/
> 
> where it's claimed to be simpler and more efficient (which sounds
> plausible to me).  But back then it was _just_ git-daemon doing a
> canonicalization, and nobody cared about things like thread safety.
> 
> Looking at the glibc implementation, it's really not that bad. We
> _could_ even rely on the system realpath() and just provide our own
> fallback for systems without it, but I think ours might be a little more
> featureful (at the very least, it handles arbitrary-sized paths via
> strbufs).

I've actually been working on updating our implementation of realpath
today.  Its slow going but we'll see if it works when i'm done :)

Also we can just drop in realpath since it requires that all path
components are valid, while ours allows for the final component to be
invalid.

-- 
Brandon Williams
