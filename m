Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 661CE1F454
	for <e@80x24.org>; Fri,  8 Nov 2019 18:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbfKHSr2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 13:47:28 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:52654 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfKHSr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 13:47:28 -0500
Received: by mail-pf1-f202.google.com with SMTP id f20so1994820pfn.19
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 10:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nGP43EtXMq+HdBw2jYu0gEgDLqP/sw7S/yM3l/4DgRs=;
        b=irPc5qz4mOv6oeA9hGcyC1/tUPKPWD7g6iVCQlAdJKbN8aF1WxRW1FMxPMRRhzQrUT
         /0+CnH6fFmWOqxKDnIOPckyeTpKNdTQty4aQjjCbqHqskIE3PTxgfZoqI+WAKsTyCnHA
         KvDSQmnTlqsyXEtOASlcIPmRoPNgdNdTaBuPu6kKdqqMnFFGyR+lY/8pvJT3WM00SfJq
         U5SYA4ZhvXctyKqxhj847QRibSxrhqt+KrywgowSslrKY5P69iD8XrdV7UUS2E5Jb7Lg
         oGU2S7FX3VHUThYaQl17JzRyVvb3tnSHu5uXbeH45oTZqQUPaowgdDu+q6xihGMyf7Fa
         Iq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nGP43EtXMq+HdBw2jYu0gEgDLqP/sw7S/yM3l/4DgRs=;
        b=uBuGcv2g4zLxMNWJkUcdPCWrfkK+EAt3pby1a7gmWR/G/p8GYFevVrj4f+JV42Z9sh
         ZeprfYwraVnp9jQllMovhUVUzqSTmfuleE/ZDRzVfmg7j+DZHzbGBuiZC8DRXxD+A8nS
         oJ2BWYfZAWZf2hYIWXxjzsXxNsB4sVH96q2h8TYWO3HlfWmS66H5eorgbX/uHr6MMb2Z
         rquV70qXhdkA4xR0RXsQebjAdJnDFPoKHrmv8TmXdKirTz5lon8q1CxfaU/Z93iTC1Ah
         mcQ8FSfHbWVbMfIcv0DUdkwWsPdjxaDbUVeATmXR4rxCungXJF1Yb1M4YFOtYIOOVtz4
         1IDw==
X-Gm-Message-State: APjAAAU1f+6I3MFHihXkf6udYTEdmmcXICX33FT6r89cNcVKUU0Tewo3
        Qc3vahrqmWZmYY8JEvugJ//RCWZJA9M7sc9pJAga
X-Google-Smtp-Source: APXvYqzONKfz145u2PKv2HHIXm0h5N2rlU1Qyin9EHSa4EEhWCZ574MOXQKPvAlk/3ZQgLxe2PvBBRrczZQx19Qc1Y8Y
X-Received: by 2002:a63:4553:: with SMTP id u19mr13502291pgk.436.1573238846936;
 Fri, 08 Nov 2019 10:47:26 -0800 (PST)
Date:   Fri,  8 Nov 2019 10:47:23 -0800
In-Reply-To: <bc43c70e-861d-425d-d7c4-73a3e25b7383@cheerful.com>
Message-Id: <20191108184723.246596-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <bc43c70e-861d-425d-d7c4-73a3e25b7383@cheerful.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: Re: [BUG/FEATURE] Git pushing and fetching many more objects than
 strictly required
From:   Jonathan Tan <jonathantanmy@google.com>
To:     nospam@cheerful.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> $ git fetch --all
> Fetching origin
> remote: Enumerating objects: 29507, done.
> remote: Counting objects: 100% (29507/29507), done.
> remote: Compressing objects: 100% (33/33), done.
> remote: Total 53914 (delta 29478), reused 29500 (delta 29471), pack-reused 24407
> Receiving objects: 100% (53914/53914), 31.90 MiB | 111.00 KiB/s, done.
> Resolving deltas: 100% (42462/42462), completed with 7382 local objects.
> --
> 
> $ git push -v origin 'refs/replace/*:refs/replace/*'
> Pushing to XXXX
> Enumerating objects: 2681, done.
> Counting objects: 100% (2681/2681), done.
> Delta compression using up to 8 threads
> Compressing objects: 100% (1965/1965), done.
> Writing objects: 100% (2582/2582), 1.96 MiB | 1024 bytes/s, done.
> Total 2582 (delta 95), reused 1446 (delta 58)
> remote: Resolving deltas: 100% (95/95), completed with 33 local objects.
> To XXXX
>  * [new branch]            refs/replace/XXXX -> refs/replace/XXXX

Could you verify that refs/replace/XXXX (or one of its close ancestors)
was fetched by the "git fetch --all" command? "--all" fetches all
remotes, not all refs.
