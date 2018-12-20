Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A72E1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 20:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389022AbeLTUF3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 15:05:29 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:39326 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731497AbeLTUF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 15:05:28 -0500
Received: by mail-it1-f196.google.com with SMTP id a6so3527326itl.4
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 12:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=lOChkGmhLtviLFHnGgw9fSrkkSFxtrEn3Up+jKULjh8=;
        b=EceZghsG9O6obgX+cwnNflK8PRGM2ATnd3fpiL2cl5TKla4RN0cMquA5FyAo3TnjuT
         Rd0xHd8yd8fDBlxe7qVg7QxO6PeLyWnqTWew/zBkRCmMfHFTWVbIvIki6x+C2gOXyVA9
         sY5a9NffAbreiqyWfz3yCBAGxmNpqCGcUWx7kCORvnOZPLn5n+HLP3sx7YYX0JcRys1S
         lYB6aYlL4a/k0d9X2f5IDlyzkeHuV8m+2LFZvOC5GwX4iTUAZgkGTPvXZzi6JkcJB7Bo
         n/ahDHgH++ujxFKgwGkXuXHdc+QMvt/CWVvdF3yaN4mzwIH4ypLxbOyOQphQEC/4rQ7X
         xbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lOChkGmhLtviLFHnGgw9fSrkkSFxtrEn3Up+jKULjh8=;
        b=TQU15l6wvWTcJ+OMsB8hFtIFWD/S2ZMKRk4CUEZmhaxQ2mpP/t2Z/9SVVdo3HG5bse
         LdtDYUSo3GERxp+8hkplHDm7xf/rc1FWldUAB3DGZ/EQlZbTBuP4oUQZ50s4377x5M3Z
         MNqXpD83guu9049eByps4T6TheBWJsuwkWWejAs7YMivk61+X4AmYdMQ1y1UbMbsw5rN
         CEP08RyjBLjL40Dh5ynodjittJHoYNsaWf5q8AD8GENAF13dWsCZHt+egyMfbN3wV5pW
         AyigHurwI5ePTszNBrvlEp1mxJ99275XDbAe45BmSEF8qPIdZdGSXNz2C5gFFvYUWbl4
         o8TA==
X-Gm-Message-State: AJcUukdbMHSywXHBS2r35l5ea/3vHgB2WiR0b2YoSua2g4i2NqJsLJOR
        mkkNc+QdJQ4XGlUBJ3bcCXzr6uujZntx4MOyDD+YnRMe
X-Google-Smtp-Source: AFSGD/X/ORgnfk3kNIioTno4HYphhbU1qZicHvW0CFt/kskBCMVL8AFM1XlCYcqxmd2HK2cVEQqhoPVj0SKiWEXkMvM=
X-Received: by 2002:a24:4545:: with SMTP id y66mr51939ita.174.1545336326638;
 Thu, 20 Dec 2018 12:05:26 -0800 (PST)
MIME-Version: 1.0
From:   Stan Hu <stanhu@gmail.com>
Date:   Thu, 20 Dec 2018 12:05:15 -0800
Message-ID: <CAMBWrQ=nWQpyp3JPkBAzmZUioUTThUC9y9=xiHCtUTvA9m2yUA@mail.gmail.com>
Subject: Incorrect tree shown with ls-tree ref^{type}:{{folder}}
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Suppose I have a repository that has the following files:

foo/bar/test1.txt
foo/{{curly}}/test2.txt

The following works fine:

$ git ls-tree master^{tree}
040000 tree 9284ac5fef7ad99a2bd508a8c89bde8bd1a88e9f    foo

$ git ls-tree master^{tree}:foo
040000 tree 69497de4d9a72713f87df8280a147e0a597c4055    bar
040000 tree b2abdac384f111c1a8a518e05b963a3bb2541659    {{curly}}

$ git ls-tree master^{tree}:foo/bar
100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391    test1.txt

$ git ls-tree master:foo/{{curly}}
100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391    test2.txt

However, the following returns the root tree instead of the tree
belonging to {{curly}}:

$ git ls-tree master^{tree}:foo/{{curly}}
040000 tree 9284ac5fef7ad99a2bd508a8c89bde8bd1a88e9f    foo

I believe the problem is on this line in sha1-name.c:peel_onion()
(https://github.com/git/git/blob/b21ebb671bb7dea8d342225f0d66c41f4e54d5ca/sha1-name.c#L1004):

if (len < 4 || name[len-1] != '}')

Since name is "master^{tree}:foo/{{curly}}", peel_onion() returns
early, thinking it is done.

I can append a '/' to force peel_onion() to work, but is that the
right thing to do here? Should this condition handle the
"ref^{type}:filename" case properly?
