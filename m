Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 368CB20899
	for <e@80x24.org>; Fri, 18 Aug 2017 05:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750739AbdHRFQz (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 01:16:55 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:36688 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbdHRFQz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 01:16:55 -0400
Received: by mail-yw0-f171.google.com with SMTP id u207so53059057ywc.3
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 22:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=i300hV3F5xEil7CX5PDu7gfGSGJd+GsaS9ZAeQtbERE=;
        b=PdWtwsFa8CPYM3mWIk6GzUpJTVd942UeOnNswwAaOhl2rRic1YL3o/6DXh5Y4NZyVo
         xdSWU44IzpVscOnZNH7OdTlG9Kbc6T9NGcZ38KdHFMxjMDlrIWTK6PciGLwenZaQp9to
         0yX+vpCgER6jEl143QtnpJT43IKdHh7aYKkGSBMS2KMBqj0oW9sfyUCLb2pwlpAVxown
         ogpekCHBhJhGQQAexUVyyNGpcOn/Sw3qIRAyB03lqFr3jswaaMdGYFV63FP9JMmXDJIj
         gOvKcKLU7gIXsSW6zHTilC2jrOXkiLOX8v12ApbL+Z1yQ31TU6ycApQNL6tSAZNLmIJb
         bMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=i300hV3F5xEil7CX5PDu7gfGSGJd+GsaS9ZAeQtbERE=;
        b=gm1QzWgaw8CSMSIX32w64zER5CO2DtcQOoIdr1nXGsYWqupXF+OLY3kUAW/tmBMFtj
         RYs7XUCgbMDS4C5udokYFwFqTbJQw9q7DSqdpKcGq5XDGI6kSErXMqKC3Fvz2C6EeQn2
         EaPFEzs141RG0jWTVQJO+xNMwLTyocyw0Dn/FwAHLNIxmARiPkPffYZXgS0GGhrqY3WF
         LmeDxC46IJ4jUAWN5/0GyNij87S50YzRTeE1+YnzXI7CVez4nGWsPMn0HOWTl4mbE/1U
         L8xWyI6LQOwlnV92stWk+ZBX+jl365r93NjAehQrEahGk44/od2wbwiqci/DW0I1QJob
         rPeQ==
X-Gm-Message-State: AHYfb5htS6kH9RI5Js2MoGTfERePGf8eUHIJpmkeowfhc5q8Z7NKWyhD
        bN/Evgi2UoKG4JXM00wZUXN3RjgxGBWw
X-Received: by 10.129.229.4 with SMTP id s4mr6157965ywl.130.1503033414168;
 Thu, 17 Aug 2017 22:16:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.211.10 with HTTP; Thu, 17 Aug 2017 22:16:53 -0700 (PDT)
From:   R0b0t1 <r030t1@gmail.com>
Date:   Fri, 18 Aug 2017 00:16:53 -0500
Message-ID: <CAAD4mYi24dHNhG1MFkPaeVv9P-9UN_FxSvZmX6XFHrfA7K0hoQ@mail.gmail.com>
Subject: [bug] Git submodule command interprets switch as argument and switch
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The issue is as follows:

R0b0t1@host:~/devel/project$ git submodule add
https://github.com/user/project -f
Cloning into '/home/R0b0t1/devel/project/-f'...

My .gitignore's first line is *, and then I explicitly allow things.
Despite the presence of "project/" in the .gitignore the submodule
command says it is ignored. The "force" flag is interpreted as a flag
and also as the destination directory.

It is possible the argument parsing code for other commands exhibits this error.

R0b0t1.
