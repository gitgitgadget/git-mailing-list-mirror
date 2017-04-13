Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F0A020960
	for <e@80x24.org>; Thu, 13 Apr 2017 18:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755408AbdDMSgZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 14:36:25 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34899 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754867AbdDMSgX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 14:36:23 -0400
Received: by mail-pf0-f170.google.com with SMTP id i5so32067763pfc.2
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 11:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O+H6zWV+C94W9Q2ud5KUR2CdyYpFofuTmfOOBIaF78g=;
        b=rT2NK8kZqqYmJBVU5GHSW3xJyLaHjN/mX7bRYn5qZB4/JIX1UIUouSM6S2T8KBgbFZ
         bzvLJN4xg8/a2JJHcms+NDsfQbSwvU4Kfl+ai+ZTmBa+qiiP14TAYGt6ScZj+26azh2k
         Qy6IzjBxwJhSFbOOyCzJJ/DIU9pYppICCdaTnEWNuhqsFnepwbmRLlVK5TAzPP6GZvOu
         LFbf7M6THcinGrM+2AabutfzXiPUXHqLDjrEKs3589GUeRY8TG7zCCeIt9ODMsSh8KIS
         LJw1a12TLXPG5SodnC8ssHivuZtgnDkQfSjAVkyCfZVyi7FU2zBlaarrtpkvHPHEHvpU
         FtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O+H6zWV+C94W9Q2ud5KUR2CdyYpFofuTmfOOBIaF78g=;
        b=QzQayOfJn05UBSfw0psADQ+6yosO2M1d3WwyWe4fJxDwBXzXyJe+F1xqNkv3lMQ0et
         CTktyxwZ6pAQ/wnUnWL5auh5zrqG4FDm5HtC1TuuRMGzEsgLjNHoaWQ61xjTzEmlUxPl
         MgutLPNDBEoTEUqKxbxS8o/kUDl9sly5BphlME+CgiIM3DQHNNB69r9aj9hEaohcupPR
         8po/XDjqoIXidyV1+d5e0DGNBs4Ok5totlcyIYlhlEj75jH303ZML41aRXhM5rwtYCBC
         jOCu4ctHozbtgajUfvR8QcK8wXOhD/sd0e+EyyILbeuzinnLJTnKyYsSDPiISjQ9m3hp
         wOrA==
X-Gm-Message-State: AN3rC/5RLnwdaaXoXIOlNIJCpxNKt6sKlFi+8v/e3rGoZl6JEriATy4a
        siDGIpssxkoxVzFC
X-Received: by 10.98.220.8 with SMTP id t8mr4104929pfg.144.1492108577287;
        Thu, 13 Apr 2017 11:36:17 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:1426:66e2:260b:9db9])
        by smtp.gmail.com with ESMTPSA id j4sm20521612pfk.91.2017.04.13.11.36.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 11:36:16 -0700 (PDT)
Date:   Thu, 13 Apr 2017 11:36:15 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] ls-files: fix recurse-submodules with nested
 submodules
Message-ID: <20170413183615.GC96917@google.com>
References: <CA+P7+xqE-SZ5D6pk6-Dx+-VzHijmgmrUR2F=-370Rh8oKr10Nw@mail.gmail.com>
 <20170413171224.3537-1-jacob.e.keller@intel.com>
 <20170413180357.GA96917@google.com>
 <CA+P7+xr6zkb4kLTM-+0f5OTtt583WR_0j=NEebOdYuO3Z6h1+w@mail.gmail.com>
 <CAGZ79kaRpAPFd8+rQUxKTmDfrQWdPGEEWGSVzstwUbj-7hRAKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaRpAPFd8+rQUxKTmDfrQWdPGEEWGSVzstwUbj-7hRAKQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/13, Stefan Beller wrote:
> On Thu, Apr 13, 2017 at 11:31 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> > Spinning out a process is one of the big downsides of working with
> > submodules in our code. Unfortunately, spinning out a process is also
> > one of the biggest ways we isolate submodules, and if we wanted to do
> > this "in-process" we would need to add an abstraction layer that lets
> > us handle submodules in-process in some clean way.
> 
> Yeah if we had less globals and a repo struct (class) which we could
> operate on, that would be bring in the abstractions that we'd need.

Agreed, though we're probably pretty far from that becoming a reality.
One day though!

-- 
Brandon Williams
