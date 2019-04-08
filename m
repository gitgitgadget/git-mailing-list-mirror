Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD18D20248
	for <e@80x24.org>; Mon,  8 Apr 2019 22:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfDHWXq (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 18:23:46 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45896 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfDHWXq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 18:23:46 -0400
Received: by mail-ed1-f68.google.com with SMTP id f19so6110999edw.12
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 15:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rguTvFDPwhFDyhMioNikqM5ND3UD56V3/SRpb0GPKB4=;
        b=Z4CxaZ6x/Gc51yi+oyNe33Zzu8FR+LvzeG/lbJ4Fe3HK8VH4gPtZ/LRDop7RUkoAs7
         LwCNI4kjuub3jR4pwbnWUqAcbFHSKPa/lswnGIf47fC0UyPQeaaNHlTaczVhitpWQV1R
         xClt6sPSVqZATy7mf/dFyxJwsfLwuQy+whAF6YNRJHTsNbRlHbz/Nzycfc1GBr0qFJH3
         5bnueHyLHbp1Vv4Zk/MOPzZdUutnxd67ug4ZHSfPegvHl9VjfnEcsp9dRM5ZXvCJs3uE
         UnNGL512Jf7Z+wnpsK0JLWZJmkDWboHkhYZYcjqWMPov6Xs7B6Q6/EZrbjdjwrcwt/ov
         0d3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rguTvFDPwhFDyhMioNikqM5ND3UD56V3/SRpb0GPKB4=;
        b=pXEnsPxywoHXx+91qovjUJ5988O8+uypzHMve7fwOsfkwWYAQX63713GPV7jJBTm9n
         k2Z1OmLaLM/K9+NEdl3l81W87apl0/UVkfgrk9hOd+9l+v2nSznL9ALWYgzyMAmKNftD
         1KgXNuAYVIayrH+f2YqBo0reumwfP5JX81w2ah1FGgx89CA8WudE4diARq47hAeqStE/
         25HotXPnIOoczsVsQ0R/X4cYhhm2v0VV5+gjVVualzltFBUtPAlQvQ9QyDvWTcmyCxSA
         QeLiRKfAmnXvYosn8S3KYvP5gib//jeDVVR/FkLnKCVI5KIf6nz6fmRBtTS9ehAvknee
         TcVQ==
X-Gm-Message-State: APjAAAVhlNIT2fIcdHE97X9/sdJG+liaDt2yg1sz9yiBQ5D4Xyk1mJli
        L0sSvhYHcyevS9m7Mjjl2g5VKpy/S6LZXz2UFF8=
X-Google-Smtp-Source: APXvYqxYmuQANGffeJmSHv3xqxhJMHX9I0gZQqwLYx61PFUxVpB2pTrH9nzXZXbQ03+uTYFfOIxRM7K+dkCqK18KBk8=
X-Received: by 2002:a17:906:d503:: with SMTP id ge3mr18052703ejb.2.1554762224653;
 Mon, 08 Apr 2019 15:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
 <9856e7fc74f51b60ae162cbed3f5c0cf8c603222.1554757275.git.steadmon@google.com>
In-Reply-To: <9856e7fc74f51b60ae162cbed3f5c0cf8c603222.1554757275.git.steadmon@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 9 Apr 2019 00:23:33 +0200
Message-ID: <CAP8UFD3fWi=3rYY1LAzn8XWvHQswDZmkWj7TNicTE+qbnOGkJQ@mail.gmail.com>
Subject: Re: [PATCH v3] rev-list: exclude promisor objects at walk time
To:     Josh Steadmon <steadmon@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 8, 2019 at 11:46 PM Josh Steadmon <steadmon@google.com> wrote:
>
> Helped-By: Jonathan Tan <jonathantanmy@google.com>
> Helped-By: Jeff King <peff@peff.net>
> Helped-By: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>

Your S-o-B is duplicated an there is a spurious line between the
duplicated lines. Do you use an automated script/hook to add your
S-o-B?
