Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8815C6FD1D
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 11:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjC3L2A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 07:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjC3L16 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 07:27:58 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90CF30D2
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 04:27:57 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id k17so22965250ybm.11
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 04:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680175677;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FbWrxBEhtLkQcXyJJq3D8d6T5XpkHvIoPnHZSm092YM=;
        b=ZeGckVr3oJrfS/COm+TJz5sK5T22VNME5U/cr+h73Ky9jMnQ9GdSp8gyLbLZdOEJyV
         xSAwF2+FuowpYngYkY0D/oQPAnPSW35uPEU8Lza2oafDGcNdw+bK0Q9w+abtD4toSVSv
         sJsh2Xh0fTCeueVAb8KH+MpKwKxMm35TIsxLTPG60mPn+ykS/B2AYksWJ/4sY1vifa+y
         3UU7ILL0xfbyv1iW6424lq6v1e9+bxzKmMcnBTEqX99ygqyLxWM41dcsOlIzgEP3OaP9
         vejhnRU9UFrpiTB4I5/ZtDJnv+Xzvv6ApCI0SB3LwXH6c+vZ8IPvF65QXRPnVPUrVZjP
         MugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680175677;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FbWrxBEhtLkQcXyJJq3D8d6T5XpkHvIoPnHZSm092YM=;
        b=pDOrTLEHILWTPCh+DWO3skSu4+JgYlwVWyY+AnBS2fUKpVGyS2wkV5UOhX7PbfcHrL
         yTuLmUuDd34YcJcCrM5cSx68LlPXAg9W+0YuotTv5vC21cF6YJTJ1xVtch0y3Nn3+pY4
         QeAQGBIXyX2AdXEnoiSAj0kFCBnDQGuZzvrrePB84dkOV1keQRXD+hhOseZxaGgEAtpM
         zpyqBo+/9PNVpLqpSD1cv4qmbyISWl/wgUJJ/OkkhunjAXKifI25/+DJOrAYy40JUa5T
         ylMLQO+0crn+qTvGgphPDo4b0bmy4SoZ9GrjoQxYke/ZjEytm0lGzkTSJ+snCxZR3aoM
         fNYw==
X-Gm-Message-State: AAQBX9dO1TWTU3tyZanS8OA1o1fU9I7N/OQW6IgOskWXlquU1/5SDm2x
        PgnwY8f79LOS1eergZXLyJ4GNzFqznoSCc8fTFy9E8Zi9W/5hA==
X-Google-Smtp-Source: AKy350aT94PW89dbyKqnpIbQWUSOx8sHDmERlhce7gVxkjt1amYyJvdpYmlPZiIme1bDBWQWO0E3zw5Fmn8ITEbBr8U=
X-Received: by 2002:a25:8712:0:b0:b6a:2590:6c7f with SMTP id
 a18-20020a258712000000b00b6a25906c7fmr11787349ybl.2.1680175676791; Thu, 30
 Mar 2023 04:27:56 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 30 Mar 2023 13:27:45 +0200
Message-ID: <CAP8UFD1fLOYpa85BmLfKgboFKs41ThzbH1gofhE3KwnwA1QnsA@mail.gmail.com>
Subject: Draft of Git Rev News edition 97
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-97.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/631

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Saturday
April 1st in the afternoon.

Thanks,
Christian.
