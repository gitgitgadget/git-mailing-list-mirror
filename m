Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B41C636D4
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 21:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjBJV7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 16:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbjBJV7L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 16:59:11 -0500
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A6E7E015
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 13:59:10 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 981131F5A0;
        Fri, 10 Feb 2023 21:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1676066350;
        bh=UFRIaQPO0XSpWFVUzoCguMezsKn/thdlh+eLEWwo//o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CVJUWCy3lFeHzdOYmeY5FCs0SNOtOdKnrFJk1xBOhlc0QJTLWTf8UHsQG1SHn16Ei
         mNArzOiROMYaRxUJ99/FiEgddrZVw/qZgXwvji0PXs2hF2VzWSPaGGfVvfcaEdM688
         MiIB7N59Bl/0koAQiLAvj8BlK4Mt7zQZvX8xlMbw=
Date:   Fri, 10 Feb 2023 21:59:09 +0000
From:   Eric Wong <e@80x24.org>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC] fetch: support hideRefs to speed up connectivity checks
Message-ID: <20230210215910.M7535@dcvr>
References: <20230209122857.M669733@dcvr>
 <20230210214951.684909-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230210214951.684909-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> wrote:
> Eric Wong <e@80x24.org> writes:
> >    git -c transfer.hideRefs=refs \
> > 	-c transfer.hideRefs='!refs/remotes/$REMOTE/' \
> > 	fetch $REMOTE
> > 
> > I initially considered passing --negotiation-tip OIDs, but this seems
> > like an easier solution as I'm not yet familiar with this code
> > and prefer to avoid writing too much C.
> 
> --negotiation-tip supports ref name globs too. Would that be sufficient
> for your purposes?

Yes, I tried using globs but didn't want to figure out how to
pass the resulting OIDs to rev-list.
