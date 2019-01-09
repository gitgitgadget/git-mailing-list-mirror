Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A25D61F803
	for <e@80x24.org>; Wed,  9 Jan 2019 20:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfAIUWH (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 15:22:07 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37509 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfAIUWH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 15:22:07 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so8381582edb.4
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 12:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kk9shHjFfvc6juuMQMNtlO1oEWGg8usCxld32oAjH/M=;
        b=gv4lf7vmMm/Ekr5PI5PgPj+bnmftvuwuVHgzmNOibSlQATXJHQTn9agkyw3X2TARbM
         seIBR4CwfopnaPuntR8TYfB0aU1F1aNz71RuQKH0FYJ9KGkcOgR8Om9FUAC91XK9VBAD
         1vc1FAQbsA4lXQq6/yqImy3zTYOAthXyzp7XfT88udK3NTXjQvL+e7XEZaSBo0Zp91wq
         mHBf26PFqB/brbmzDQ1lbp+M75ruC77/6bL80DKZ+Lkk0Dee1p52UBbpxtQFHhYcIYAP
         HpM3xrhVfcdEpSGERc0hLfc/waMVO65luTm73fovLYltzMw/Il33WgU9yC/jv3i0wppe
         MtVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kk9shHjFfvc6juuMQMNtlO1oEWGg8usCxld32oAjH/M=;
        b=AcSm251auiPQNMNH/zj84RwckIHalal3WMRhRynFi8Z813ByYcB5rpOLTuQlkLuDmj
         EJGae71sXdcWKoq2cQR8AeCy7FSVwcz2W4vx9Sk9KfUWo+9dkfq4O9ZfCq0TeD9/xK/L
         DsWjD7EQ1FqAGHq/qwO5wlSpO2+wQxlJb3AgBYLoDsAjOuWI8EJ6BTB5njNxtva8vm6+
         3nugrFf2XdCI3GMb/VkYI2RTQXo6IFY9LO6yBHQCR1hn/BbItEbWU1sorBuO/k6Visia
         RQF6yjTXOlw6A7+saIVQYp918zaV/pRBahYuVno41fHLbSDKw3kpUHQRsa2fzxREPKBh
         xDXQ==
X-Gm-Message-State: AJcUukfm0kuVc0n8f/NhIu3dC61B39crhO7USVq3+cvc2ZjwYQyGKoWu
        YIca3y8NZrLPcOOB+icllIRGO0Tl0auvnWy7ct89x1kgdFkXeA==
X-Google-Smtp-Source: ALg8bN7rECjL2k+wLnfHZekTRifM1TQEPJJXZ6h7j6k9FQ+KvArxcBakDcLNSH5Xi6ID628k/07rrRHh5UPcfqfCUuQ=
X-Received: by 2002:a17:906:5a11:: with SMTP id p17-v6mr6353373ejq.43.1547065325033;
 Wed, 09 Jan 2019 12:22:05 -0800 (PST)
MIME-Version: 1.0
References: <20181227162536.15895-1-pclouds@gmail.com> <20181227162536.15895-11-pclouds@gmail.com>
In-Reply-To: <20181227162536.15895-11-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 Jan 2019 12:21:54 -0800
Message-ID: <CAGZ79kagNUFYhe_juPrjWgGHGPdkow2+LjrUdXR84oNToh69kg@mail.gmail.com>
Subject: Re: [PATCH 10/75] diff.h: avoid bit fields in struct diff_flags
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 27, 2018 at 8:26 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> Bitfield addresses cannot be passed around in a pointer. This makes it
> hard to use parse-options to set/unset them. Turn this struct to
> normal integers. This of course increases the size of this struct
> multiple times, but since we only have a handful of diff_options
> variables around, memory consumption is not at all a concern.

Makes sense, and continues
8cc633286a (Merge branch 'bw/diff-opt-impl-to-bitfields', 2017-11-09)
