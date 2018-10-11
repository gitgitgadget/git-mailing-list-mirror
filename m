Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B2DA1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 23:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbeJLGaE (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 02:30:04 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:49290 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbeJLGaE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 02:30:04 -0400
Received: by mail-qt1-f201.google.com with SMTP id f20-v6so10307227qta.16
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 16:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DReJNR8cyD1JoX09XJ9OtYaHh0AdQmBrRLxDIQ7KgSc=;
        b=fwzrU6sW8MS1xfggoBtQ1sSJmmCsK30+GXona7Sh72USXoPP+W/5OqBdgJjiH5767T
         usnmFE/Lz20zAu0KMT33oYMuGzVXPMzshbEN2nZrIKP2Y76qiSIV2XKEBiQ2+XdHXp73
         A8lneSMmAMXhAca4Xa4Nh1xxORf06sIEZffIS3vsf7AXp4c1GNAVhLCaGOSYsyMFgvd5
         jdJzDjlcJIwXU43hmyjsuSYIqb34/s0AAAQHAvM7PnctD3rYAq4tXDFmD7bV7KDG8mdR
         zE5PsT9JcK+0Blylyju2yNH+sp4WX8+kXZ2j+SBsoh11FfXGF7GHGkysKLd1m8qKGw4N
         hirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DReJNR8cyD1JoX09XJ9OtYaHh0AdQmBrRLxDIQ7KgSc=;
        b=iU6VD6625xxHiN833IYLGrnkvnFvcsbEykTSYzppBRlAzN3H1SHahlFZLlsUxH8gQs
         GLTASOJLgT677tMMiFxnB2H/Kxw0VPsfKw9CEKTJVSc/V15Gl7iocqaywpW4kSoQDdV2
         j3V4Ep0I54rLw6F2FGDKCjW27BxTYqO/f7TJ05XFCXh3WcwfBNWNnPEuO8oVp/jbZG7n
         as/uvIOcDJuGHwARTjlSr8t3tLjr+iQZxaSSQXNaqz6WUIzgKgSaGAhFgirjNWFBDiYP
         k+80KqIs5hkL6fdZNI8Wi3UFgNDlH+WHD5pBlW22rOHc9i1oIMmhbbfmfh4gGxSpo+cL
         +n6A==
X-Gm-Message-State: ABuFfoieqTyLNPVa0kKBwhJm3amn3ZwMDwWVhHqklcPTXaOlb6+BpNod
        lwDyRoYKEvxfWE8NNPdVvnp+xQVTGB2CnA6iy9d+
X-Google-Smtp-Source: ACcGV61nPexRtDo6APmirudwGcEoxPYNX53r3GzBDgQMhjc7Y4S9LTOVRK0Hr2I+YZMX7fbvuBOjtdRlo+AttyjAQTNx
X-Received: by 2002:ae9:e013:: with SMTP id m19-v6mr3058744qkk.12.1539298837660;
 Thu, 11 Oct 2018 16:00:37 -0700 (PDT)
Date:   Thu, 11 Oct 2018 16:00:28 -0700
In-Reply-To: <20181011211754.31369-19-sbeller@google.com>
Message-Id: <20181011230028.200488-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181011211754.31369-19-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 18/19] submodule: don't add submodule as odb for push
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The submodule was added as an alternative in eb21c732d6 (push: teach
> --recurse-submodules the on-demand option, 2012-03-29), but was
> not explained, why.
> 
> In similar code, submodule_has_commits, the submodule is added as an
> alternative to perform a quick check if we need to dive into the submodule.
> 
> However in push_submodule
> (a) for_each_remote_ref_submodule will also provide the quick check and
> (b) after that we don't need to have submodule objects around, as all
>     further code is to spawn a separate process.

After some investigation, I think I understand. I would explain it this
way:

  In push_submodule(), because we do not actually need access to objects
  in the submodule, do not invoke add_submodule_odb().
  (for_each_remote_ref_submodule() does not require access to those
  objects, and the actual push is done by spawning another process,
  which handles object access by itself.)

I'm not sure if it's worth mentioning the commit in which the call was
introduced, since nothing seems to have changed between then and now
(the same bug is present when it was introduced, and now).

I also checked the users of push_submodule() (transport_push()) and
indeed it doesn't seem to make use of the additional objects brought in
by add_submodule_odb().

Do you know if pushing of submodules is exercised by any test?

Other than that, the code itself looks good.
