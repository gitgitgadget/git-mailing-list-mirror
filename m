Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 391B320248
	for <e@80x24.org>; Mon,  8 Apr 2019 20:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfDHU7o (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 16:59:44 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44148 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfDHU7o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 16:59:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id g12so8001108pll.11
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 13:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yFo19yNwTMKqQHT6DSYgUcC/BAyZHy73f/CryG/Hzzg=;
        b=qNopiIefR2MscJswEOiu+gi8OlxqGnzzLidorp3C2mshfj//zjFOhVJ2pv/DBrGh8r
         G0wutZwLjfQlgAbicQAswLGmlyt4IgIirhyHSGWlts/TzmVoKpLi09AE+T2Zzvevq8hq
         Sc1WA8I5eoaf2svgE/Pvst54AivGV4WajdxSQtARd2krdPzQDcginH9pmj/Fpy3EbAJ/
         reXNqmA6rzM/EQ4tVPbTR0dA2J3gRcpvg3LHonyh1hi8NFDZGYqzTN4F0X6Jrbxz0v80
         PJ+97EYNcD5+4cvAvSGXYgShBlvcurNkwpL2piCPqphbeStFz6w7xLeZZq+Kr/GajPTv
         vGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yFo19yNwTMKqQHT6DSYgUcC/BAyZHy73f/CryG/Hzzg=;
        b=Qa++vfCM8CyQvELOiP33Ett4iUU+2tUXj8UTJtvq+ufL0YE2kgBzX3XkQt4NIOXLRs
         KcrvCJRUkC4Qaf90Js/PAJ9JtidFQqHR8WNG6OZNNxNY5d2N7bLRD/YV6lX0zwdoMS44
         7HeLwFw+VXTyEc5RKnqtfxZM7hCDHbZaStVx1iq7uMEdvapQpDnPIuwXHW5EXXZFGSXt
         WVUTnDQCIRx5cn/G8b14C3B767vKK60Rs11pAKUgkcB358iOsgfbSOypjio3RuuH968U
         BPv2NnB0oWsztRUuGpGQA78n7OQxAN/njryyxYmu8w6O9tAJaug33MKlB/V4X1448AAC
         7IjQ==
X-Gm-Message-State: APjAAAWVI4ifgkCZxZh8kNerzgQT3aYhLOk2Not3B7dxSOCyByEo+9+N
        mZdD8geX534qzdeGLcpH3QYemg==
X-Google-Smtp-Source: APXvYqzJbDpZNNmBUVgc4OiS0aa751LF16Eph/QhGaoDI3801rQUipiIVOe7N3vMpXVjAac2fQr3mA==
X-Received: by 2002:a17:902:2b88:: with SMTP id l8mr31006881plb.262.1554757182673;
        Mon, 08 Apr 2019 13:59:42 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id x5sm15011321pfi.91.2019.04.08.13.59.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 13:59:41 -0700 (PDT)
Date:   Mon, 8 Apr 2019 13:59:34 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        jonathantanmy@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v2] rev-list: exclude promisor objects at walk time
Message-ID: <20190408205934.GI60888@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        jonathantanmy@google.com, jrnieder@gmail.com
References: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
 <9f327d6d8dc5e71eb0039aef3ac76ea16c2adab3.1554417917.git.steadmon@google.com>
 <20190404230759.GA26623@sigill.intra.peff.net>
 <20190404234726.GG60888@google.com>
 <20190405000001.GA20793@sigill.intra.peff.net>
 <20190405000934.GH60888@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405000934.GH60888@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.04.04 17:09, Josh Steadmon wrote:
> On 2019.04.04 20:00, Jeff King wrote:
> > On Thu, Apr 04, 2019 at 04:47:26PM -0700, Josh Steadmon wrote:
> > 
> > > > Did you (or anybody else) have any thoughts on the case where a given
> > > > object is referred to both by a promisor and a non-promisor (and we
> > > > don't have it)? That's the "shortcut" I think we're taking here: we
> > > > would no longer realize that it's available via the promisor when we
> > > > traverse to it from the non-promisor. I'm just not clear on whether that
> > > > can ever happen.
> > > 
> > > I am not sure either. In process_blob() and process_tree() there are
> > > additional checks for whether missing blobs/trees are promisor objects
> > > using is_promisor_object()...  but if we call that we undo the
> > > performance gains from this change.
> > 
> > Hmm. That might be a good outcome, though. If it never happens, we're
> > fast. If it does happen, then our worst case is that we fall back to the
> > current slower-but-more-thorough check. (And I think that happens with
> > your patch, without us having to do anything further).
> > 
> > > > One other possible small optimization: we don't look up the object
> > > > unless the caller asked to exclude promisors, which is good. But we
> > > > could also keep a single flag for "is there a promisor pack at all?".
> > > > When there isn't, we know there's no point in looking for the object.
> > > [...]
> > > I'm not necessarily opposed, but I'm leaning towards the "won't matter
> > > much" side.
> > > 
> > > Where would such a flag live, in this case, and who would be responsible
> > > for initializing it? I guess it would only matter for rev-list, so we
> > > could initialize it in cmd_rev_list() if --exclude-promisor-objects is
> > > passed?
> > 
> > The check is really something like:
> > 
> >   int have_promisor_pack() {
> > 	for (p = packed_git; p; p = p->next) {
> > 		if (p->pack_promisor)
> > 			return 1;
> > 	}
> > 	return 0;
> >   }
> > 
> > That could be lazily cached as a single bit, but it would need to be
> > reset whenever we call reprepare_packed_git().
> > 
> > Let's just punt on it for now. I'm not convinced it would actually yield
> > any benefit, unless we have a partial-clone repo that doesn't have any
> > promisor packs (but then, I suspect whatever un-partial'd it should
> > probably be resetting the partial flag in the config).
> > 
> > > > I didn't see any tweaks to the callers, which makes sense; we're already
> > > > passing --exclude-promisor-objects as necessary. Which means by itself,
> > > > this patch should be making things faster, right? Do you have timings to
> > > > show that off?
> > > 
> > > Yeah, for a partial clone of a large-ish Android repo [1], we see the
> > > connectivity check go from >180s to ~7s.
> > 
> > Those are nice numbers. :) Worth mentioning in the commit message, I
> > think. How does it compare to your earlier patch? I'd hope they're about
> > the same.
> 
> Thanks, will include them in the v3 commit message. Unfortunately it's
> hard to compare against v1, because v1 doesn't call rev-list at all, and
> thus we don't have a good measurement in the trace / trace2 output. The
> rev-list timing has been pretty consistent at just a bit over 3 minutes,
> but the overall clone takes anywhere from 12-20 minutes, so any
> difference between v1 and v2 performance just gets lost in the noise. If
> I get a chance on Monday I may go back to v1 and add some timing.

For the record, the V1 abbreviated check takes about 5ms
