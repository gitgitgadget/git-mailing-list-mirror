Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 376D5207D6
	for <e@80x24.org>; Mon,  1 May 2017 23:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750829AbdEAXZo (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 19:25:44 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33929 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbdEAXZn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 19:25:43 -0400
Received: by mail-pg0-f68.google.com with SMTP id t7so18106901pgt.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 16:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YQI7UYsayCImuSJjtoJpIotrwIlU7GsEJn1yF9pK5Hs=;
        b=ICd8QJPkQAvf0FkzksFstY8k2xCcwAlDSoK/PxlLaFWQ8nQYLXcDtJThPuCUOeeiy+
         Dbnjwj6kE0maKil18A9Ax9NmGHjV931UKUSoy06WwmyRMHUOqqOuIJya2n7O4RnnYxOe
         drt0x9joxhKL54UeuVmKb8xzJTZdTNBDoI/UtOSFBSY8fzVBNiSLq72W0e29xFiv69On
         a1jHysL36J0m3IaScIb8aeUnSdxAEQ7U76ykVudubVIS7ZcR14kVD42ETDHIdA6bo2X2
         /TvxMtyX0x6wWTAF2KFhskERwUJxK63JesyQ2l2Umyt5OqLdhYrEHOiPevk/UvYENvv2
         z4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YQI7UYsayCImuSJjtoJpIotrwIlU7GsEJn1yF9pK5Hs=;
        b=I30Ut2BM0Boh6V5SPIS2lmKv8/4JWT39MJluwRz6m9szKh+iwxQYpUPTuv1VdgZx8J
         MgYigyqEJ3hB6QqwfeUysJOgJ7zz6jYCRurcaIBP3wsWO30haSu4kBkkJ2DxOabhWFy8
         HeAqDXxeazEjx+kRVbco6ax3N3lw0liQf29FUCWYYQdHlTdB/v2cWHvHCTM5fd5fN4o/
         VXXeMhr0hZyrgr3xbQ9rXvhDbnN5NyzGY5QmDHaDGOXKwJoP1ki17SBy0GrUEJCisLt6
         u9Tu/qPwHe8s/MzpW5zk1IT9AumwS5jBDPQxtIriA5Jvz/xeliOFh5zNAo7v2B1DzRtY
         30GA==
X-Gm-Message-State: AN3rC/6j6MyBqv5o1rRz84auHyPMmgThKPZYTcet6PSQX8KjkU3MMXgm
        63h1Gz/Qx7g0wQ==
X-Received: by 10.99.53.207 with SMTP id c198mr29326089pga.182.1493681142900;
        Mon, 01 May 2017 16:25:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3c5e:d1c1:579c:ef99])
        by smtp.gmail.com with ESMTPSA id n65sm23670508pga.8.2017.05.01.16.25.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 16:25:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 0/3] Make diff plumbing commands respect the indentHeuristic.
References: <20170427205037.1787-1-marcnarc@xiplink.com>
        <20170428223315.17140-1-marcnarc@xiplink.com>
        <20170429124052.yhgwofbbd5pkd24p@sigill.intra.peff.net>
        <20170429131439.ohgren3i7xr4tjex@sigill.intra.peff.net>
        <xmqqlgqhjs8b.fsf@gitster.mtv.corp.google.com>
        <20170501051528.tpw3zlcpercdwdln@sigill.intra.peff.net>
Date:   Mon, 01 May 2017 16:25:41 -0700
In-Reply-To: <20170501051528.tpw3zlcpercdwdln@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 1 May 2017 01:15:28 -0400")
Message-ID: <xmqq60hkgnwq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> PS Outside of our test scripts, I'd probably just have written:
>
>      perl -lpe 'print "extra line" if $. == 2'
>
>    I think we have traditionally preferred sed/awk to perl, but given
>    the heavy use of vanilla perl elsewhere in the test suite, I think
>    that is maybe just superstition at this point.

I would have avoided sed with 'a', 'i' and 'c' in one-liners myself,
and a Perl script like the above would probably have been my choice.


