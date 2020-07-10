Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549F5C433E1
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 20:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 170F520748
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 20:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POyyV4Wt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgGJUVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgGJUVk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 16:21:40 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87746C08C5DC
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 13:21:40 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id r7so1517012vkf.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 13:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ciyW6LlflE4Aqz/IIhYfSMS3IpHvXUKhRDB1pZfYk5s=;
        b=POyyV4Wt+XHWiVAPHy4oUNYqgEKj+BypYLbi3YkJjdwMSzX3hPQXNElz6FtW8yO4l2
         xo5QYodjT5wzLQwxGm7G6sTUakwJFL5Z058Ew/CEs81ROaDBeWJlCPvSdz6D0PjqYAi+
         WU6CGLk15y/1KoHxgI25OGINFUv3+P+WpdLcBtdWRALffLAO//9VcJUY1IqvkLWRM3kh
         S2pFCA5WgTBon/1Lp+nCmIfABG5p2xBPyd3lD3JtB5/WBCKBMC5D00Gq+5rthhBtrokv
         PqYzLZ08h5vhP/Il5I8S19SKmNzH5F2SSUUomrEvKUvArBcoHUIf5/biPOo4KEzZhJvb
         +XAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ciyW6LlflE4Aqz/IIhYfSMS3IpHvXUKhRDB1pZfYk5s=;
        b=kERA8I3W4E/jgGxJ0T5eDRlgeQs6CebJcutLBYW1OBx9hYDqzxXdmSIx1n4GcGwoTt
         pno3H8nQPaeoMNVTS9Tc6Kl9J/V5sziyBTjy0mbaCGU5Trt1esbx6lFYyPDOpcTCDB02
         0hkLSdBO8yIUVXYvXCKVf8VH02CDojzaoKOmnqZXSxdtyvjdkTPLZxxgRf1bnfIu+sDQ
         t54XxcyrALkn3Yh8PkY4JGzgWZczC0Ypwo/h+feuIrwDi1I0g9Z1q0o7i5zmDGPQyLui
         GPJpLBM5SGz7zIYzUAdgJi+u/uQWLvB52lmnLVyNpsojoS9OSXyOQ3N/QmLD5+rhTzEI
         +iig==
X-Gm-Message-State: AOAM532fj0vKcXYgWzTZuU5tLdObfpPX1he1qBfugxKSZtlP71EhIGIF
        A3kMD9SUsrTvHqYg1mdmEQgh1iN9r5NXQiVsg74=
X-Google-Smtp-Source: ABdhPJxv/jQHqzlu6RHNf8pYhFynU/3wj2VX0/JTz8eOQh60PKMJcFteFqPCEx70reme0Rl0QdPXkE13gMQjuMZkENw=
X-Received: by 2002:a1f:f4cb:: with SMTP id s194mr26724952vkh.48.1594412499716;
 Fri, 10 Jul 2020 13:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net> <20200710024728.3100527-38-sandals@crustytoothpaste.net>
In-Reply-To: <20200710024728.3100527-38-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 10 Jul 2020 22:21:27 +0200
Message-ID: <CAN0heSqmn087O5hb7qRSVJqA4FepH78Eb7hvJjqSXk9gmywZRg@mail.gmail.com>
Subject: Re: [PATCH 37/38] docs: add documentation for extensions.objectFormat
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 10 Jul 2020 at 04:50, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
> new file mode 100644
> index 0000000000..70d69cf9ab
> --- /dev/null
> +++ b/Documentation/config/extensions.txt
> @@ -0,0 +1,7 @@
> +extensions.objectFormat::
> +       Specify the hash algorithm to use.  The acceptable values are `sha1`
> +       and (if supported) `sha256`.  If not specified, `sha1` is assumed.
> ++
> +Note that this setting should only by set by linkgit:git-init[1] or
> +linkgit:git-clone[1].  Trying to change it after initialization will not
> +work and will produce hard-to-diagnose issues.

s/by set/be set/

Martin
