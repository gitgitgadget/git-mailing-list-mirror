Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3AD01FF34
	for <e@80x24.org>; Thu, 11 May 2017 07:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754981AbdEKHyX (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 03:54:23 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32944 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754783AbdEKHyX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 03:54:23 -0400
Received: by mail-pf0-f193.google.com with SMTP id a23so2351093pfe.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 00:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tSecQuLAwnn0thkrpnsRMTjOHhjHu3PJg3sz2SEdonU=;
        b=rRcYuAXprZLEjZekWEKzQKqQKoCMutWKCRQAXjPBK33D3Xjt0Me91Ar30FPaEbeyi5
         aQwbcY8x6zFoJWoeC++5nuNAH76egQZq7jww4WzUW4zboQC7UTb/oCCWNkpTgT9bxsLG
         T6oqqy7hca2hBD39vZbt3ET2TFeWhcxbbN79zYJ/rdVlqVGaiMkrZ477KfZElkvdN+4r
         F1/0ZCIkBMroTvHJM8Fd8VYNYEbqjUqKCxAZx/NTru8CaMla5DI651iKS6pjAHzv+t8E
         TolceAuBmYVtg/Nda6osEvIgX/pGMhC8TB/7QM+ka9bpvkifMPW+qyhbor4b8K4BOXNc
         2tZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=tSecQuLAwnn0thkrpnsRMTjOHhjHu3PJg3sz2SEdonU=;
        b=CNckyxYRUKQofR+KmNU9Xk3IsWCzhlKl4VYxrvnq5vlxm8eboqbE1UhLfz8gbpT54n
         Np4+zfOl7nKA3xF3ExvZ9vgrbDA8Mdj67TD6sziKkzZSdfWEJSbQx/cp20togt/cccoR
         O/5uhGGK5SJIXcWCxWGmdAeUHxtFfAFHrgRZ44XOWmK+C9iZBmDOEr2JlSMmpDhchqkD
         aXH5jXi5uPDVK4jOQqm/BU1sKfXrqOVrqUmqCM5EX2CBaNq3xT6o075OLHSgzNBDXWR2
         QFSnhEVkZd6uJzaUGCK1C2ehSFKVbf062889jnbVtopQGZ98EgvENe9seumL/DAKNo9l
         n6LA==
X-Gm-Message-State: AODbwcDQeDFPOwovFLbAHvGdlGR1EEeVsJAaNLKYCTH25DhDNKwY2EBU
        Kk4ro/jdR9Zc7A==
X-Received: by 10.98.198.4 with SMTP id m4mr10868109pfg.160.1494489262436;
        Thu, 11 May 2017 00:54:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:91c4:5195:150f:b3e6])
        by smtp.gmail.com with ESMTPSA id e24sm2142991pgn.1.2017.05.11.00.54.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 00:54:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Sebastian Schuberth <sschuberth@gmail.com>,
        Raphael Stolt <raphael.stolt@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Possible bug in includeIf / conditional includes
References: <C1ACB28C-F1B4-42A1-8135-797DEFD9F03C@gmail.com>
        <b80c68fa-fe1e-3cf8-3c7e-527a4d941108@gmail.com>
        <CACBZZX7CgeW1OK+g9Mbir62MMaCx4sHFZngUuWz_H241Sb355g@mail.gmail.com>
        <20170511062616.f7rg6f5cgrqeh7gf@sigill.intra.peff.net>
        <20170511062924.6euaynsbyocjcw3q@sigill.intra.peff.net>
        <CACBZZX4ob04fG9ZZtvbdcqrYOKijoZohVdUCNyeayHZtdtNyxQ@mail.gmail.com>
        <20170511074257.xueofze3dv3xwrql@sigill.intra.peff.net>
Date:   Thu, 11 May 2017 00:54:19 -0700
In-Reply-To: <20170511074257.xueofze3dv3xwrql@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 11 May 2017 03:42:57 -0400")
Message-ID: <xmqqbmqzbzh0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, May 11, 2017 at 09:19:50AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> 1. It says "The included file is expanded immediately, as if its
>> contents had been found at the location of the include directive.". At
>> first I thought this referred to glob expansion, not
>> s/expanded/interpolated/, the example section uses "expand" in the
>> context of pathnames, which caused the confusion.
>
> Perhaps it should say "The contents of the included file are expanded
> immediately, as if they had been found at..."?

Or s/expanded/inserted/, perhaps?  The word "expand" does not quite
click to me in this context.  Just like Ævar, I associate the word
with an act of replacing some template-with-blank with the result of
blanks-in-the-template-filled.

Regarding 2. and 3., I agree with your comments.

Thanks.
