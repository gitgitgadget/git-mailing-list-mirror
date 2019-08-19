Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 149231F461
	for <e@80x24.org>; Mon, 19 Aug 2019 23:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfHSXWR (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 19:22:17 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:37959 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbfHSXWR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 19:22:17 -0400
Received: by mail-io1-f54.google.com with SMTP id p12so5681690iog.5
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 16:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=A2uMLFNmy0kIU6G5HcIR7ZTg6wgraReHJ79Y0bOk7Gk=;
        b=uqGRqMdL1Sm4sbAaKmK5x1FU0XWZvvwNLJvk8djXF11iRXunS2nt+8B6CWPgrFSFRZ
         8Dx90pNZSpcrIpY9fTfjXM0eZRvJovPXawyguPY2PzN3WAUOY9QeR4kKzGq9DBm0uvQ+
         9LELFMMhKe9qS5TFdRRVvqo4byQNReU8665Ru/snkL+P898mGc74vf6pl0F0h+eGiNCZ
         9mSMUf6SFOiBIcoGCRP2SspeHs8nRlqlcCm9Xy42SrRPxzgQEyMszM7yMQVbWCjogniX
         JwwutV/9XQ8nwcRCbvFq302dty+HoPUzozC99hoyfrBN4dXm50YoI5OYrO0Ps/rYxypp
         Dcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=A2uMLFNmy0kIU6G5HcIR7ZTg6wgraReHJ79Y0bOk7Gk=;
        b=QgrZ3vLnP1i2WbfO4E0HMghAyj63W+U3JU1jkfY6c2uCZsTTM4VPEL4cfoE9S78psx
         SfgeOxJdDE768CYaiw7YCtEp659mQmLYqpr67vwxXP7NRYedIlLM6vkwdtJWkKzGJuNV
         jKGzQgKD5LGn8jYYP/xia+rylQ26zH7RJO2qathemkZx81soFU2zPJQgU+TrNVitUG6R
         KomjMQMfEGo7o1loroBgwMjG5OztH19E5HjWAxh7Vfc5AIDj1sgUFq5ZvHY50wuC+rV8
         d4cJyAsaNRcWlO5a5m1Csy+cvu/TtCGeFk0hNUYvU4KPEtBDgY5jXfCJvyunZ+uric1R
         /OPw==
X-Gm-Message-State: APjAAAUSfZMT0TpYh8Blxzv207/KrbmlroJDTYzxz0QTCj5DTssU6MsV
        nBUdt+65mimfAmABCalWY+l/PT1lRHDS/FuXuk4eAGkyFrk=
X-Google-Smtp-Source: APXvYqzSk8aY1QeTGxfX4nNgkKCsQ9fuwrcPGlJzdlzRU5grVCdayMc3KWiv6iKVSuG5T3RMStKqHHVPwuNN64A6O4o=
X-Received: by 2002:a6b:b9c2:: with SMTP id j185mr25637192iof.148.1566256936422;
 Mon, 19 Aug 2019 16:22:16 -0700 (PDT)
MIME-Version: 1.0
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 19 Aug 2019 16:22:05 -0700
Message-ID: <CAGyf7-GBx3FSCQTipmkNBtnwMANg5A0FXiiPc2az0NiRLRT+xg@mail.gmail.com>
Subject: Fully peel tags via for-each-ref?
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running "git for-each-ref", it's possible to use %(*objectname)
to get the SHA of the object a tag is tagging, and %(*objecttype) to
get the type. However, in the case of an annotated tag of an annotated
tag, this still isn't "fully" peeled--%(*objectname) is the tagged
tag's SHA.

Is there any way, with "git for-each-ref", to output the "fully"
peeled SHA of a tag's ultimate target, regardless of how many layers
must be traversed?

Best regards,
Bryan Turner
