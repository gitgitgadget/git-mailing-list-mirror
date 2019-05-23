Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D8AE1F462
	for <e@80x24.org>; Thu, 23 May 2019 16:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbfEWQ5b (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 12:57:31 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:46688 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730899AbfEWQ5b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 12:57:31 -0400
Received: by mail-io1-f45.google.com with SMTP id q21so5399285iog.13
        for <git@vger.kernel.org>; Thu, 23 May 2019 09:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dk0or+3rG6rxXVfxjwROCL8S3Tfkv3JjtAuoIAN6+AI=;
        b=mF61EYz5slvI0lp6AzoQjd+gH/ObUwX2Ae9u3YvrPsNWkfKmYnTP1JfUHltY4t5SnO
         lsAELRhGPNciMnQKY/3GUzZLlD+nzneBKSn0C6R2+huWrWM/kcCduJwh4rsVjaS2IOBJ
         MWtLLFobZQUa/dFp11Nuh8XCxGGmYTIj5GzrO0/E1U3BdsF9bZTCZyqxp7q3iXz3ZGyt
         N4SxQ1gl+8zdTUtRPW5uU7o9sTFz1ZTzKyrynAEtFebAyWdcQ4twD+agudfWu0x+RUlj
         4tfsxTmki+peJ8GQsY+5wVhk+p39yp+IaFUXtiI8oxcvDsJZPBV/0xTUYlBset/4iif6
         jiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dk0or+3rG6rxXVfxjwROCL8S3Tfkv3JjtAuoIAN6+AI=;
        b=U6sM/Y4uNqUv6Ga2x+4v1zlJ6YuRFgya0+1E0SBkYDIISZ8dcykkYwVhmZK3Aik3kA
         52F01rhppoWfA+cGK5GZgvVUVzMRPXc2r5EFPX3Vs2HAxmIBVU8mxsv+0dIGT56oxbTw
         4lkD3s49vfsWNTgQopLqp6u1VUa4cBeQTxOzjjmLsd4Rdr6PMGzaTvY+AtKeb20xuG3E
         fP0l+nFx+dbRFPz+ssAwbFxejYJVq5SQyxOUcFnkx64A5HrSajeqg8hN0JhFwJeB0RtF
         DzVKb6JQyd0KGOeit3BE8aE29yFuxhdU+Sw9BDw88t6pMQbLn0CichNKei6Vlpe1CAdC
         bE9w==
X-Gm-Message-State: APjAAAXsSwZdA/PoLuJ3fbNq5+CvuERa2JZEPeKT76jWXG/5GgmaZMPO
        /Y0sOt49oQszae/GT3dVRKs3RUKTRhfNdnndejnWcN3LF8wD0g==
X-Google-Smtp-Source: APXvYqyZ+RP3kdsgSXeOGIy1nKRRH9qo04MLO3MeHsMLAqnqs1AdHPK8P93klpWl0hXv0om+9R+Dtc6Q1RwSSDDb8po=
X-Received: by 2002:a6b:8ec4:: with SMTP id q187mr26756367iod.280.1558630318116;
 Thu, 23 May 2019 09:51:58 -0700 (PDT)
MIME-Version: 1.0
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 23 May 2019 13:51:47 -0300
Message-ID: <CAHd-oW40x3-4rye3QeVGix5pfTCoCHmiwg8ddCeq1E6YYongag@mail.gmail.com>
Subject: [GSoC] How to protect cached_objects
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, everyone

As one of my first tasks in GSoC, I'm looking to protect the global
states at sha1-file.c for future parallelizations. Currently, I'm
analyzing how to deal with the cached_objects array, which is a small
set of in-memory objects that read_object_file() is able to return
although they don't really exist on disk. The only current user of
this set is git-blame, which adds a fake commit containing
non-committed changes.

As it is now, if we start parallelizing blame, cached_objects won't be
a problem since it is written to only once, at the beginning, and read
from a couple times latter, with no possible race conditions.

But should we make these operations thread safe for future uses that
could involve potential parallel writes and reads too?

If so, we have two options:
- Make the array thread local, which would oblige us to replicate data, or
- Protect it with locks, which could impact the sequential
performance. We could have a macro here, to skip looking on
single-threaded use cases. But we don't know, a priori, the number of
threads that would want to use the pack access code.

Any thought on this?

Thanks,
Matheus Tavares
