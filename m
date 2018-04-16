Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31A181F404
	for <e@80x24.org>; Mon, 16 Apr 2018 20:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbeDPUTI convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 16 Apr 2018 16:19:08 -0400
Received: from dd28836.kasserver.com ([85.13.147.76]:49409 "EHLO
        dd28836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeDPUTI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 16:19:08 -0400
X-Greylist: delayed 555 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Apr 2018 16:19:07 EDT
Received: from [192.168.42.152] (dslb-178-000-100-134.178.000.pools.vodafone-ip.de [178.0.100.134])
        by dd28836.kasserver.com (Postfix) with ESMTPSA id AF5D53002BB;
        Mon, 16 Apr 2018 22:09:51 +0200 (CEST)
To:     larsxschneider@gmail.com (Lars Schneider)
Cc:     git@vger.kernel.org (Git Mailing List)
In-Reply-To: <F1738316-71EF-4053-82E5-F009F491CCE8@gmail.com>
Subject: Re: Optimizing writes to unchanged files during merges?
From:   lists@haller-berlin.de (Stefan Haller)
Date:   Mon, 16 Apr 2018 22:09:54 +0200
Message-ID: <1nnder4.l460na1kohjpiM%lists@haller-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
User-Agent: MacSOUP/2.8.6b1 (Mac OS 10.12.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> wrote:

> An engineer works on a task branch and runs incremental builds — all 
> is good. The engineer switches to another branch to review another 
> engineer's work. This other branch changes a low-level header file, 
> but no rebuild is triggered. The engineer switches back to the previous
> task branch. At this point, the incremental build will rebuild 
> everything, as the compiler thinks that the low-level header file has
> been changed (because the mtime is different).

If you are using C or C++, look into ccache. We're using it to work
around this problem, and it's a near-perfect solution, I'd say.
