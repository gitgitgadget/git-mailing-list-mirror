Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60016209FA
	for <e@80x24.org>; Fri,  7 Apr 2017 15:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754860AbdDGP0H (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 11:26:07 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37851 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754686AbdDGP0F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 11:26:05 -0400
Received: by mail-wm0-f47.google.com with SMTP id u2so1336822wmu.0
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 08:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uv0grJFN5lCGoKvTnrPhJNW7HHTMdMPuyYyQIPxS9UY=;
        b=J2X9xyE/FjOEeDMUqTkbWc35qhMYyd548He/jI+SuQxFaE+0M8PNxqe4l00ByUkypl
         n5M/UJbF09CXH4Iyr0grg6kkwmHxRgH24kZk7jf1IwU/WlrJhMrF+GqMXczPeBJ83lzR
         IKafIWdVLMp0likXw5JC0rYJdR+NO6vJyJ3fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uv0grJFN5lCGoKvTnrPhJNW7HHTMdMPuyYyQIPxS9UY=;
        b=XsosOXniF/NfWLrKpQ9D+dkxfwDS2YZNrH/u97XfQc2h/eCouDPnF1eW3adOP/oXSJ
         JxBu/U7NZutGZ0YI3tPOkmNyLkT3p+kKHglwvhdQG3vokKgwXz8srNCbfszH1JcR7Gsz
         J6coGHVLBq34z7MY9xvrINptP202jNqvE0DPWEDPPu45utVbi9kEdE8psuW/NFbdES20
         bSxVFGSGTPrIkBzyXbzbz+a8Db31aDYw5+I/RoN4o3FXvRJ47mK0Bp3ju51tIw7SaXbn
         8skUQE4IJtkup+r+dTHSREzmM95FDo0gJOxqVykjTpfqAdeG4ir2mASvXG4EhXY6c+oA
         +Q0Q==
X-Gm-Message-State: AN3rC/46BfTYOCC5mR5WbnpE0MqVUVLDl25MJNXTWuSrxp/4CS1LmdwcM8/KqWK0M0B0cl6nMZmeSYvswiI0LzBu
X-Received: by 10.28.72.67 with SMTP id v64mr10397578wma.98.1491578762602;
 Fri, 07 Apr 2017 08:26:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.142.247 with HTTP; Fri, 7 Apr 2017 08:25:41 -0700 (PDT)
In-Reply-To: <CAGZ79kaGQHvGv-ZpfppbATucrJWVdS8Lq33CKs5AbV7qDGE3BA@mail.gmail.com>
References: <CAA-fqg2EwfMQ-KoAMHDFca1c7jpQgihhqsLejEK3Zs8O1D4DLg@mail.gmail.com>
 <CAGZ79kaGQHvGv-ZpfppbATucrJWVdS8Lq33CKs5AbV7qDGE3BA@mail.gmail.com>
From:   Ben Nason <bnason@netflix.com>
Date:   Fri, 7 Apr 2017 08:25:41 -0700
Message-ID: <CAA-fqg1DGUmdXEAnYfEuK2Wts2wLfEr2hhharAghbCexL1+yAw@mail.gmail.com>
Subject: Re: [BUG?] Issue with merging from another branch after replacing
 subdirectory with submodule
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

Thanks for the reply. Is there any known workaround for this
situation, so that a manual resolve isn't needed for every single
merge in this scenario?

Thanks,
Benbuck


On Thu, Apr 6, 2017 at 4:05 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Apr 5, 2017 at 11:10 PM, Ben Nason <bnason@netflix.com> wrote:
>> Hi,
>>
>> In git if you replace a subdirectory with a submodule in one branch,
>> every successive merge from another branch without that change will
>> cause a conflict. To reproduce this please see below (DOS batch file).
>>
>> Is this expected behavior?
>
> Yes.
>
> "git submodule update [--init]" only (creates or) updates existing
> submodules. It doesn't take care of removing submodules that are
> no longer recorded in the tree.
>
> "git merge" currently also does not touch submodules. (we may have
> git merge --recurse-submodules soon, though). So as soon as there
> is a conflict between the submodule (or an unrelated repo, who happens
> to live inside this other repo), and new directories/files that would appear,
> the merge errors out.
>
> Ideally Git would be smarter than the current behavior.
>
> Stefan
