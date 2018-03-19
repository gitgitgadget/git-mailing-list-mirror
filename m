Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BF5E1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 20:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031562AbeCSUej (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 16:34:39 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:41857 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030425AbeCSUeb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 16:34:31 -0400
Received: by mail-pf0-f175.google.com with SMTP id f80so7499676pfa.8
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 13:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ginc96jGcN+pJuRhzVZP/t7gMiAZUZ5n2zHy83inqpg=;
        b=KrsRcHcMGMemfrJVsEsZ78fXZ8tI95/bzx3fYzUi5TMzcy/U7raEF9BH1XXQQG6gzg
         3+1KjziNLnZ1dLPuzIZ4zLr+dBHsSDO8ePcM2kZvv/mpq5REWHApP9Sn50PzxmF8p57j
         d+yhi+A/Okd2hX99lgU6sjr3KrfiKBkQBmxylpzWQJVSiznHahUxlaWhm02tYhesHnHW
         ZCdwJivva5VBKv210gcrIiCpaYFTdtbklpKOIgplGww0qQS05u7CgJ/CmDmJnFa5ChIr
         u82wn4N+FWb4HJHWrybAOg8rQoBTRg8Y/cQ/KEsXHCaapygas5kamVOJEhYrIeQ3gwmN
         ntPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ginc96jGcN+pJuRhzVZP/t7gMiAZUZ5n2zHy83inqpg=;
        b=pe74EmuXTlFDjwchnb6Gcp8ohoM06/NsXC0QFDmAfyJQ3znqZAjl/BfWGsoED/YPKb
         iTpyusCpHFHckTg5rpoA3O/o9A4dFPpITAG8UT5ZjbpzCLRvEDXnzDFmY0fNZmSKhReW
         khP0AFXlyZf/qc5ji2ECjBR1Ysz/2XJsDO+3Bxvf6co21W+5FL8caPRpmLFGWzusj8TX
         LgGrmBgTt6VTeZBOEZ7djotgqs1ti1MRH1DqDpqi0bR5SRAf8L6Qs8BSBuqbPMdRYGHR
         EIft+bTzXxozkuxSIy2RVtLthefMrBb61yts4iT7c6Kq8EDsVtCMDdOZJ7TtD7yB4PXD
         MCag==
X-Gm-Message-State: AElRT7GShnpO1CUF7w8tp4Ybxf27A6jgYaVOEpXIeXOCLm2FB6J/cidB
        3ByqUheTpGBUxTyeIpBBftechA==
X-Google-Smtp-Source: AG47ELsHF5BT/JtnQE0ze42sSEHB/AqZ7CEWzv2+N1/Snu+a5aInvfJtieFH9gUwM++YX5DMSFx0+Q==
X-Received: by 10.101.85.204 with SMTP id k12mr10396501pgs.40.1521491670578;
        Mon, 19 Mar 2018 13:34:30 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id w27sm56332pge.20.2018.03.19.13.34.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 13:34:29 -0700 (PDT)
Date:   Mon, 19 Mar 2018 13:34:28 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 44/44] packfile: keep prepare_packed_git() private
Message-Id: <20180319133428.1f26cd2ec85af8eb22b09376@google.com>
In-Reply-To: <20180303113637.26518-45-pclouds@gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
        <20180303113637.26518-1-pclouds@gmail.com>
        <20180303113637.26518-45-pclouds@gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat,  3 Mar 2018 18:36:37 +0700
Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> wrote:

> The reason callers have to call this is to make sure either packed_git
> or packed_git_mru pointers are initialized since we don't do that by
> default. Sometimes it's hard to see this connection between where the
> function is called and where packed_git pointer is used (sometimes in
> separate functions).
> 
> Keep this dependency internal because now all access to packed_git and
> packed_git_mru must go through get_xxx() wrappers.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

The patches up to and including this one look good.

I also see that the question I asked in patch 10 about lazily
initializing some fields is answered here.

If we're planning to avoid making the user call prepare_packed_git()
(which I agree with), I think we also need to ensure that we always use
the get_xxx() wrapper whenever we access objects.packed_git. Currently,
there are still some functions in packfile.c that do not do so (notably
for_each_packed_object()). Could these be changed too? (This should not
be too difficult for you to do on your own, but I can send a fixup
patch if you want.)
