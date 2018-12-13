Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DEA620A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 19:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeLMTE1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 14:04:27 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33451 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeLMTE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 14:04:26 -0500
Received: by mail-qt1-f196.google.com with SMTP id l11so3445986qtp.0
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 11:04:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eisL/onH9WwkwseWhltUZJRRB+ApAoqt2X4mM01w1Oo=;
        b=hA+R/2J/4nWMJXfhnMOiYxv9eoNTAhN/+hSUM5cVe2GLKD5hZkEHpCL+voxgd/dSpY
         UspRbuuStxEtDel33zk4a1Dn+TLgzaESC5D/rJuxt184KRXDDW1eIHOTwrS1kUFKAPX0
         gNERJU/ZhPUbON4ciWBiSrhUyDgu6vdZXyUdKsX+Op5j4zZoBuGKIHNF/OaBmOCk8D47
         1a5QybA1uy13ecb/q4KRX6ih3VSJXq+PCdYspmB3qeJGFo8e8FkMGP2L1VbM/YMBU06Z
         QsK8akEZ+6u9XC8bugYBq/dtWLuKYWUqZH5u3xumc8AwdRWDuIsXBLHGRFN+xLezHHrR
         NZsA==
X-Gm-Message-State: AA+aEWZBetSlQ8vbRxJOTAgNOc3dNMe15+aixNplxEryldsMYXni47IX
        ZxddyVUjpsorvPUK9P4MrhDM8FImy/XhKj+eWWQ=
X-Google-Smtp-Source: AFSGD/WDQG6lUXSnI5t3/LWJB+C/yRoji8xtGP9LNFjnTqyJQwLzYSl8A7mJz6jnEzPdBWEUomohDqTI3CBwh4foOSI=
X-Received: by 2002:ac8:36ba:: with SMTP id a55mr24742869qtc.236.1544727865999;
 Thu, 13 Dec 2018 11:04:25 -0800 (PST)
MIME-Version: 1.0
References: <CAGZ79kYsk8YEUUhMVF9fBC++fop3CPyobXTgHTuF2Lgikf9CJA@mail.gmail.com>
 <20181213190248.247083-1-sbeller@google.com>
In-Reply-To: <20181213190248.247083-1-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 13 Dec 2018 14:04:14 -0500
Message-ID: <CAPig+cRHcZTS3QNXMbfFk+V2Z+HhWnXAKfkcWMePbmjDK+oKUQ@mail.gmail.com>
Subject: Re: [PATCH] submodule update: run at most one fetch job unless
 otherwise set
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        sjon@parse.nl
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 13, 2018 at 2:03 PM Stefan Beller <sbeller@google.com> wrote:
> In a028a1930c (fetching submodules: respect `submodule.fetchJobs`
> config option, 2016-02-29), we made sure to keep the default behavior
> of a fetching at most one submodule at once when not setting the

s/of a/of/

> newly introduced `submodule.fetchJobs` config.
>
> This regressed in 90efe595c5 (builtin/submodule--helper: factor
> out submodule updating, 2018-08-03). Fix it.
>
> Reported-by: Sjon Hortensius <sjon@parse.nl>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
