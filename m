Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31A1F202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 17:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753928AbdGLRX5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 13:23:57 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33390 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753870AbdGLRX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 13:23:57 -0400
Received: by mail-pg0-f50.google.com with SMTP id k14so16291296pgr.0
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 10:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S2iYTaDarHU6agCP8omNbh4juP5miKXVtbJJDku/LDI=;
        b=CIFaXYtFaup5GbGs3/OVJ3BvUH/b6QefuIBmGVXHCT+yqnuSgm1l2fhVQSXQqz89yY
         tFf3z0IqFtydVwe/NWgiP5y5IMSTzieJwM8Rbc1irbanc/LkD56GOl4jPzCml4z+V+YW
         5m1tYzdwJZfis3rLuO/Aa4zU8ydgpqK1cm8qjvmy/4qs5BSkLFU43edPSoL/fwxvb6iS
         SV9vOjo77ytPhKbtVyxF4UWas6LSzR49UZd+0va8gAL38sRyPTPK03PVvudYjj0SaH+R
         VTf+QFV8R6WSpJqkZWP6PyhQMq97ziyWVWpY5mYWnNiXvGiQXbnVdSxo35078Ybb50/G
         ay6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S2iYTaDarHU6agCP8omNbh4juP5miKXVtbJJDku/LDI=;
        b=TziRAJFu9T26EKeY3gvcjHCShok9/ps9FeyiSkticKRiVpkqwZvVtyodz38iCmI9ug
         qt80bjC/GTJBowLUsUb+JZAN2S1xSVjgaeic6HNP9I5ntTQM2izJndq5NxSvFX2rY9LI
         +w42hzjtjlkdglGWI0mrygZmxFFjyj9CIKqWjW/+qx56ienuK8rxtFbXBrPm2uCdg97A
         WfU/M4VxXMcBHrRZAm3cuy4Nabff5JoTsGKue7STwAEPz0lE7DBquRFQtK64wPl2uosb
         iRBQi2zq1zoLzY/OKoJyxzaThhvcxuwFjVHNyVdfvFFbyX267UjFVfG4jJIDSENypirq
         wstw==
X-Gm-Message-State: AIVw110LOmMfo4Q6Vsz5sZti3jw2KprNAHOmKulyS+bzch0TE1yfyCkO
        hdWbhmzbM89ztOqG
X-Received: by 10.99.142.202 with SMTP id k193mr4951774pge.86.1499880235000;
        Wed, 12 Jul 2017 10:23:55 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:3d1f:bb9:8897:56b4])
        by smtp.gmail.com with ESMTPSA id t11sm6229657pfi.66.2017.07.12.10.23.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 10:23:53 -0700 (PDT)
Date:   Wed, 12 Jul 2017 10:23:52 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] repo_read_index: don't discard the index
Message-ID: <20170712172352.GA65927@google.com>
References: <20170711220408.173269-1-bmwill@google.com>
 <20170711220408.173269-2-bmwill@google.com>
 <CAGZ79kbsjBMW0TBha=+uyZ4JN-vFaXVa1DeFkJ21w2Zrqfhi4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbsjBMW0TBha=+uyZ4JN-vFaXVa1DeFkJ21w2Zrqfhi4g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/11, Stefan Beller wrote:
> On Tue, Jul 11, 2017 at 3:04 PM, Brandon Williams <bmwill@google.com> wrote:
> > Have 'repo_read_index()' behave more like the other read_index family of
> > functions and don't discard the index if it has already been populated.
> 
> instead rely on the quick return of read_index_from which has
> 
>     /* istate->initialized covers both .git/index and .git/sharedindex.xxx */
>     if (istate->initialized)
>         return istate->cache_nr;
> 

I can include this in the commit msg.


> such that we do not have memory leaks or other issues. Currently
> we do not have a lot of callers, such that we can change the contract
> of the 'repo_read_index' function easily. However going through all
> the callers and then looking at the implementation, may hint at a
> desire to have repo_read_index documented in repository.h
> (There is a hint in struct repository, that its field index can be initialized
> using repo_read_index, but what does repo_read_index actually do?)

And I can document the function better in repository.h :)

-- 
Brandon Williams
