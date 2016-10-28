Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2459920193
	for <e@80x24.org>; Fri, 28 Oct 2016 03:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934542AbcJ1DAn (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 23:00:43 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34711 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751584AbcJ1DAm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 23:00:42 -0400
Received: by mail-oi0-f46.google.com with SMTP id p136so40772165oic.1
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 20:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cakoose-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=qsW57A4gIUEAygFJJPIf3xyHct5gzVCWeiNUO9msOeQ=;
        b=zRWtyAd75MVfKsuUZijtiH15fMW1gzdS5ZCxEkGMHlc5nBxxYUHlhkGV6JOPnS2Uwq
         5oQl22ymHB7bKEePHDVOLqYxbhPtYBdmPPEL4UrxHeTkjq+Cy+UjSsHYDdwV7umY2u3z
         ji2rH/tdMNP3AQIHH/9ch0sxNJulIAJ7Tn5hLgx1ayDwJSN8ojDO+TJll/VNBXWPjZjN
         PhhKKPuqiEa7xb9VEIp7VmJA1RmU8jGmxSSpMVCQ1rzjHVbYqrOCOIs39Y3s8u56LvTg
         xBHisVS7DTx6sorz3JXcg1k/m/nGPDNCEUHVSRKNfvaq2Mg2UX3QgH5MvlZYrsn4EBOU
         9LbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qsW57A4gIUEAygFJJPIf3xyHct5gzVCWeiNUO9msOeQ=;
        b=U+in2DKpnsE2TAP+JC4DJhLkaR7FdTBXJPt3zbOdGEQ3YDeUaBPiySl25e5XqTuZ7R
         rbHaugvKfRFghwr5RwWEW1SMat5/KvN4qpy2djFiF6r1vPt17figf9t0E8XyB0FabSod
         oTQvltUqRVbVjAUGriLGxEMEU20FsEejrWfh+HInuXcEXMG34xPDCvief1EsZCX5gde9
         /eZicShcyquk0vgPNn4BV7FQyG2ZlrxGx2MvcF7zOUHvfmFQ7gEse5Rl9GfWcTqf2evg
         dAh9HOo1dpsV75plC/JR2YxQZUzaPC9e+p6DlZ+vxpP0fJpOt4FhC+sQdtX2BIUwiQw/
         N2JQ==
X-Gm-Message-State: ABUngvd6T6bsY+Rnf8U67LakxKjLwUWJ6vllW0wlv3MlwyzuQml5KMlSOo0PXclzz3XkhczMuzpvJIla3QP78w==
X-Received: by 10.107.195.4 with SMTP id t4mr9127676iof.221.1477623641368;
 Thu, 27 Oct 2016 20:00:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.132.146 with HTTP; Thu, 27 Oct 2016 20:00:40 -0700 (PDT)
From:   Kannan Goundan <kannan@cakoose.com>
Date:   Thu, 27 Oct 2016 20:00:40 -0700
Message-ID: <CAM7aVoUOxx6Fa+yG2JzQhoX-mE4Lgp9ejvwncx5bdL+1tuQQFg@mail.gmail.com>
Subject: "git push" says "src refspec XYZ matches more than one" even without
 explicit XYZ argument.
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1. My repo has a branch named 'v1' that is tracking 'origin/v1'.
2. My repo has a tag named 'v1'.
3. I have "push.default" set to "upstream".

I made a commit on branch 'v1' and tried doing a push:

    # git push
    error: src refspec v1 matches more than one.
    error: failed to push some refs to 'git@github.com:whatever/ns1-go.git'

If I rename the branch to 'v1-dev', then the push goes through.

I understand why the command "git push origin/v1 v1" is ambiguous.
But if I do a plain "git push", I thought Git would know to push my
current branch.

[Git version 2.10.1 from Homebrew on Mac OS 10.11.6.]
