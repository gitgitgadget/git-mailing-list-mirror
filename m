Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BFAC202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 18:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754526AbdCISXr (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 13:23:47 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34473 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbdCISXq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 13:23:46 -0500
Received: by mail-pf0-f181.google.com with SMTP id v190so31674035pfb.1
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 10:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qPzhq7K81/XaLojjUnoyoiNGcx+TEKmyzsH/4p4hHF4=;
        b=G3eqtoZ1/Qidx7LsA72yBwpLqTb9luCNoZryiL4LrQW03lB8jSQovMc0BJtPZVXUXN
         uaB1CXUhjpT7P7vdvfDvK5GqQAKBAOiGWIPq5UlGNf7pknb/eDy8t/SPAKXKHo5rDjOc
         N6Xqr9BT3V+slnh2SSzvYUztvaeZLk+Ow/XPHVoHNBpPWDNpy+H4M1U/SzXCcM0UhEqc
         8ct8mjYOuXgH2mwJVCJq9YuofX/ujxbS2KG9KrFno0nipxWOb/lUi0TJ5vMRQ/HAC4Id
         y7/EOSUIIY56bIIj4HvWnIzgtwJgdd2E5LYUmFy5dq5rPwtgSTC27ffr1zxcpLangVj3
         hqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qPzhq7K81/XaLojjUnoyoiNGcx+TEKmyzsH/4p4hHF4=;
        b=gBoniKgW9e5bXd3Ah9BAUgSn5tH2O8xjVhlTs8T3rIL+o/a4ywfpKoLnmOQGrhzoFa
         5hr+XHuBk6wjwg9gLUkSOIbIbpBnpMBTTeGpRIIbdARK9/tHeGUYzmNhp8SikqBNZqSx
         j2bQP3vYLGF9Nng9/CnF6uaNJF9ztNdWdJSULmqlZAV0NQSBtt17bKgmDpR8etvHyCbv
         iAOyhdjGSCtO12NQXTtPJHKTDsUKNdlFUnYSYMnn8MKtptVkZQNjWIpiykcEtKPELBsV
         kqIbba1nSTFctmn/Dc8t16wEtI1iicyg9afgRX9BH6un8uuNcvDdD4FYiEkuqGjh5AAt
         Oq7Q==
X-Gm-Message-State: AMke39kB570zE/aG562tGV7c9UjBWY1S0gLtlfGiYJAj1sQE8cT4CkZiMGJPaAmaXQqePSdJ
X-Received: by 10.99.61.195 with SMTP id k186mr14939361pga.154.1489083347706;
        Thu, 09 Mar 2017 10:15:47 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:24ad:64a3:afd2:c7bd])
        by smtp.gmail.com with ESMTPSA id e16sm4000342pfb.102.2017.03.09.10.15.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 10:15:46 -0800 (PST)
Date:   Thu, 9 Mar 2017 10:15:45 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/11] submodule deinit: use most reliable url
Message-ID: <20170309181545.GE153031@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
 <20170309012345.180702-1-bmwill@google.com>
 <20170309012345.180702-4-bmwill@google.com>
 <CAGZ79kZG+Y+AtYYxeE5hmsNxfwmNp1h7aKAem=JD3yiKB6STPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZG+Y+AtYYxeE5hmsNxfwmNp1h7aKAem=JD3yiKB6STPw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/08, Stefan Beller wrote:
> On Wed, Mar 8, 2017 at 5:23 PM, Brandon Williams <bmwill@google.com> wrote:
> > The user could have configured the submodule to have a different URL
> > from the one in the superproject's config.  To account for this read
> > what the submodule has configured for remote.origin.url and use that
> > instead.
> 
> When reading this commit message, I first thought this is an unrelated
> bug fix. However it is not unrelated. In a later patch you introduce a mode
> where submodule.<name>.url may not exist in .git/config any more,
> (there may be a .existence flag instead?) such that url="", which is
> obviously a bad UI:

So the later patch doesn't actually omit submodule.<name>.url but we
could end up with this if you init and then deinit without actually
cloning the submodule.  So maybe the best bet is to drop this patch from
the series and we can include one like it in a follow up which uses a
helper function that you suggest.

> 
>     Submodule '$name' (<empty string>) unregistered for path '$displaypath'"
> 
> Like the first patch of this series, we could have a helper function
> "git submodule--helper url <name>" that figures out how to get the URL:
> 1) Look into that GIT_DIR
> 2) if non-existent check .git/config for the URL or
> 3) fall back to .gitmodules?
> 
> Instead of having such a helper, we directly look into that first option
> hoping it exists, however it doesn't have to:
> 
>   git submodule init <ps>
>   # no command in between
>   git submodule deinit <ps>
>   # submodule was not cloned yet, but we still test positive for
>     > # Remove the .git/config entries (unless the user already did it)
>     > if test -n "$(git config --get-regexp submodule."$name\.")"
> 
> I am not sure if there is an easy way out here.
> 
> Thinking about the name for such a url helper lookup, I wonder if
> we want to have
> 
>     git submodule--helper show-url <name>
> 
> as potentially we end up having this issue for a lot
> of different things (e.g. submodule.<name>.shallow = (true,false),
> or in case the submodule is cloned you can give the actual depth
> as an integral number), so maybe we'd want to introduce one
> layer of indirection
> 
>     git submodule--helper ask-property \
>        (is-active/URL/depth/size/..) <name>
> 
> So with that said, I wonder if we also want to ease up:
> 
>     GIT_DIR="$(git rev-parse --git-path modules/$name
> 
> to be
> 
>     GIT_DIR=$(git submodule--helper show-git-dir $name)
> 
> >                 then
> >                         # Remove the whole section so we have a clean state when
> >                         # the user later decides to init this submodule again
> > -                       url=$(git config submodule."$name".url)
> > +                       url=$(GIT_DIR="$(git rev-parse --git-path modules/$name)" git config remote.origin.url)
> 
> In the submodule helper we have get_default_remote(), which we do not
> have in shell
> (which we seemed to have in shell?), so maybe it's worth not using origin here,
> although I guess it is rare that the original remote is named other than origin.
> 
> >                         git config --remove-section submodule."$name" 2>/dev/null &&
> >                         say "$(eval_gettext "Submodule '\$name' (\$url) unregistered for path '\$displaypath'")"
> >                 fi
> > --
> > 2.12.0.246.ga2ecc84866-goog
> >
> 
> Thanks,
> Stefan

-- 
Brandon Williams
