Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD82620248
	for <e@80x24.org>; Sat,  6 Apr 2019 05:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfDFFgu (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 01:36:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45315 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfDFFgu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 01:36:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id y3so4152037pgk.12
        for <git@vger.kernel.org>; Fri, 05 Apr 2019 22:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=92zEIwZaNWkqvSTeSc1lsedel1AZUcy5ZEBQSP92L+0=;
        b=IPtoH5SBTobE7XWZL7EpV65ilK8KFoJ+VDDff3+jBy2BaZbOLHuUgmAoA09Q7FTgO1
         ThvrDlIYqSYi4YkWYMUTSLAKiMHOKeKyMyi3ZDTajJiSvp2Omy9i68CseX9LtAxiIEPO
         32TRzY3reG6S+JIz19+Od6vu8WpvhJlGtzIoTeGT+tKI1tHfm699G+sJWOCNhONF9w+Y
         Qdi4X0aZ3F9MMnMFg4dfLlvOdiaI0oqJt/lTYlcC167qo1eQFf/EvTwm7uWXmDM2EK7V
         zBSTibKTbrtCreWiNNHN/0gELMVK7rEH7n3+XKy4f8foZm8SopM6Xq8nQaFA5R40CycI
         FBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=92zEIwZaNWkqvSTeSc1lsedel1AZUcy5ZEBQSP92L+0=;
        b=Qw5CKo2Ico16nkTJavTqxFfTkinA6VxuAW57P2/hbc3VsN2qDYaZmZ6b+ZG314WHIp
         eTQQIoJTx27FR0T5ryEFAvyO1R1ucjSXuQuFMMcsLaeQLQxUQmS7cxuN8AAtzx5xBYQu
         4Up0Nefa0fjrqJD5yXqmZzHegxgXRkpsR9NTGi47F5ns5d3A5sW8LfHEZ3mcNJREKbLG
         /4spn2eI1Ht6lEq9rLN5deiy3ELHSoyu7cogNrOFthxDrx6/Uh+urx33g1LSga2URIcT
         SXONWoigSUY6VmLdnvTOrj1r1/ngJMAQXt9CySwFuw1T4Bqc/iDYyidv61HK9y8tJ46O
         pwug==
X-Gm-Message-State: APjAAAXP4aUvU1ODTBlG7PISml2ysydp5ih6XIyeRDs48Tr60CvIrKuG
        zqlgTaB+uk83aFHWsW1BsN1OWA==
X-Google-Smtp-Source: APXvYqwqFDUWqtZh1GLh63dJ9ScdFBCDiLcgzfESW35r8kG7Ter7xdpkK1F/Gjps94S/myittjljtA==
X-Received: by 2002:a62:59cb:: with SMTP id k72mr17099821pfj.111.1554529009651;
        Fri, 05 Apr 2019 22:36:49 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:e077:74b2:7faa:e131])
        by smtp.gmail.com with ESMTPSA id f2sm6058021pgc.30.2019.04.05.22.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 22:36:49 -0700 (PDT)
Date:   Fri, 5 Apr 2019 22:36:48 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 6/7] rev-list: let traversal die when --missing is not in
 use
Message-ID: <20190406053648.GD37216@Taylors-MBP.hsd1.wa.comcast.net>
References: <cover.1554435033.git.me@ttaylorr.com>
 <a3a80b4b2a988eb65d85a5acd54c584d047073c7.1554435033.git.me@ttaylorr.com>
 <20190405184111.GE2284@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405184111.GE2284@sigill.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 05, 2019 at 02:41:11PM -0400, Jeff King wrote:
> On Thu, Apr 04, 2019 at 08:37:54PM -0700, Taylor Blau wrote:
>
> >  3. have the traversal machinery communicate the failure to the caller,
> >     so that it can decide how to proceed without re-evaluting the object
> >     itself.
> >
> > Of those, I think (3) is probably the best path forward. However, this
> > patch does none of them. In the name of expediently fixing the
> > regression to a normal "rev-list --objects" that we use for connectivity
> > checks, this simply restores the pre-7c0fe330d5 behavior of having the
> > traversal die as soon as it fails to load a tree (when --missing is set
> > to MA_ERROR, which is the default).
>
> I think this is worth doing, as it restores the earlier behavior. But a
> few general thoughts (which I've shared already with you, but for the
> benefit of the list):

I agree that it's worth doing. One question that I have is _when_ you
feel it's good to do. I'm happy to write it and include the change in
v2, but if others would be happy not to grow the series too much between
re-rolls, I'd be just as pleased to send it in a new series after this
one.

>  - actually doing the "communicate failure to the caller" would probably
>    not be too bad as a single-bit PARSE_FAILED flag in obj->flags. But
>    it does require the caller understanding which objects the traversal
>    would try to parse (i.e., rev-list would have to understand that it
>    is on its own to check blobs, even if they don't have a PARSE_FAILED
>    flag).
>
>  - speaking of blobs, this series does not help rev-list find a
>    mis-typed or bit-rotted blob at all, because it never opens the
>    blobs. Does that mean my expectations for rev-list are simply too
>    high, and that we should be expecting fsck-like checks to catch
>    these? I dunno.
>
>    It would not be too expensive to convert the existing "do we have the
>    blob" check in rev-list to "do we have it, and is its type correct?".
>    But obviously finding bitrot would be super-expensive. Which leads me
>    to...
>
>  - there actually _is_ a --verify-objects option, which would check even
>    blobs for bitrot. It was added long ago in 5a48d24012 (rev-list
>    --verify-object, 2011-09-01) for use with check_connected(). But it
>    was deemed too slow for normal use, and ripped out in d21c463d55
>    (fetch/receive: remove over-pessimistic connectivity check,
>    2012-03-15).
>
> That last one implies that we're OK relying on the incoming index-pack
> to catch these cases (which is going to do a sha1 over each object).
>
> It does seem like we should bother to notice failures when it's _free_
> to do so, which is the case with these tree-loading failures. Which is
> basically what this patch is doing.
>
> -Peff
Thanks,
Taylor
