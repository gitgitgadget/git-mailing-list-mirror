Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EDE61F403
	for <e@80x24.org>; Tue, 19 Jun 2018 18:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967141AbeFSSSi (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 14:18:38 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36732 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966078AbeFSSSh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 14:18:37 -0400
Received: by mail-yw0-f193.google.com with SMTP id t198-v6so234019ywc.3
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 11:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GF2gr4snalkrkgSMbV0sIMaCbJBrcBQ/ODdegtl30hs=;
        b=KVCtB/E/w2p+fv8pSrU+mBDybNbc+PW5EHNyZLHiyj7fFJASecCVrn3g4xok173BRy
         iEIkc4NKPx0iQLgMqg+xD1Aqvss6Px4YIwpwLb6RJALgqlEWDNuUkU6FlgCIdwfOxeiE
         HLrwVZ11aoIqKv1L2HZIwlJD3+02YYHwOG2bsF7Rc1wqPfoEWdTWmV0ifBwDKMd9WL60
         pkbup5xA8UL+kXuoZkWkV3VyDNt3KP/akypbOX6krp8JRbdN68qzKHk0+w7d6gym0ZBU
         PjFhqZbki2EEFc5e0rjoeQQOCZXphmGb0otZ2nK1Me3mgYBCpXSI6eDzhF80BiQ1bgG2
         OkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GF2gr4snalkrkgSMbV0sIMaCbJBrcBQ/ODdegtl30hs=;
        b=bOXx3z25axFXUvDsHdjcdW5yIlEoTLM+7pY7tZI3bHfZCKT0+Dtoj3DIAkBXMKSTKe
         rKCJTe5DQqFZQJOPNk6gu+cN0jRN4O0xuvNppMEA3CdvF7RGMkaffJ60LPiPFbTVtVrH
         +YQxIy+4T82r/Wf+W+SphEHgilVGwcXmpSd48L8dJfwoy3eyHwYdA8XAz5NnUa76b6OS
         Q1ApdpzTVoUy255dT1W06WW2RgVyvf1iRjIgUf9qad9/dFSJjYg7HfHpNTZcpTQ8nPAU
         fr0ClOPyE+HzUhonzppzoYcePDWBa056vRxISXttUT92Ey9Q20TuLoO6m/PFXexa5pO+
         CWEQ==
X-Gm-Message-State: APt69E0Ms+hZfLMTKud2wesnurIJFS9/DVYknM466mzicqF716f7Bs2Q
        gPUSZn2r6QfuX04F66S7eYgpAYw96CcXqsWFLEYmqg==
X-Google-Smtp-Source: ADUXVKK6hotx7aD6wiS958gCi9EceEFUJs2qit9MZupuUQRk4QLQWEbZ4q4yR1iYHKYFAxLFaGpykAxdQuiApwG4Zc0=
X-Received: by 2002:a81:e544:: with SMTP id c4-v6mr8489800ywm.345.1529432316071;
 Tue, 19 Jun 2018 11:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh8mj70w6.fsf@gitster-ct.c.googlers.com> <20180604150543.7304-1-xiaolong.ye@intel.com>
In-Reply-To: <20180604150543.7304-1-xiaolong.ye@intel.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 19 Jun 2018 11:18:25 -0700
Message-ID: <CAGZ79kakUs9A4jSXv6NtsAQtOcaHRPTZOA-X_t_hUHsh50p=+A@mail.gmail.com>
Subject: Re: [PATCH] format-patch: clear UNINTERESTING flag before prepare_bases
To:     Xiaolong Ye <xiaolong.ye@intel.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 4, 2018 at 8:09 AM Xiaolong Ye <xiaolong.ye@intel.com> wrote:
>
> When users specify the commit range with 'Z..C' pattern for format-patch, all
> the parents of Z (including Z) would be marked as UNINTERESTING which would
> prevent revision walk in prepare_bases from getting the prerequisite commits,
> thus `git format-patch --base <base_commit_sha> Z..C` won't be able to generate
> the list of prerequisite patch ids. Clear UNINTERESTING flag with
> clear_object_flags solves this issue.

This makes sense;
Reviewed-by: Stefan Beller <sbeller@google.com>
