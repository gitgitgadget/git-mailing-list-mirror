Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E04C433EF
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 12:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359231AbiD2MeJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 08:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359174AbiD2MeA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 08:34:00 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4C78567A
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 05:30:42 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id m128so14214669ybm.5
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 05:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=nsJcOR5jymALUa1zOxZ7E7y2Fs2xPVdP0B3ZKqDZRC8=;
        b=eUngpfugb6Aeppf8XoMw4gKqZzVQlKZZ8UbXYj/6Zij3+ItE8q5kxKf8KC/ejDaxz0
         ESk0J+S15GhBYGJTNMsBR4L5+S94GhCPQJUT1JYKabfsFm8JEAF7EKJF0SwaI5SeAkOK
         raVcbxJ3zx+3MeqdWPVW9o3fVDFnxSvDNQ9if6CitXopLZo3eq5sHjdjbBdEuoM2GZsv
         dVQALNtx7k9X4YoAyuscX05XPOYNL7JcPDU6reArZAFrC5euy29I9hQTRcQnVJ/BR+vL
         O4t5MixITkycHelc1WAIMQ6l08/W3tyEgtvtXYUSl7M0qN+2iks/b3xM2uEvoNOMdvzB
         XUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nsJcOR5jymALUa1zOxZ7E7y2Fs2xPVdP0B3ZKqDZRC8=;
        b=uqVpZ441lSSRKffdaRyXf0oD2pDMbmfzBBpnW2Ytvi2CT/h6gyeGUNnOdwIRWbp/yD
         O7fVoeJya+BvhdwM0+fC276jDpY3IUGXpaEg+gf5QXmrF+iCd9QnbmvrsUIlrQvG9W2h
         8ZxcNPicVIsDewdaUFvTLKoPrWGbc4YsPcD5K/10h1XzBcqKFtnea2Rxlb4Wb/IDPjMQ
         03B190TLFdZT8fcRWdNF9EoRhSXgg5j6PtfvEAWFEyOlAYGXT/ez4K4TYNOUwp6iEdH0
         UFVGF9vz6dak27mIwvMjMOqVvJ6J9L+LvV9JggZGGGNKWjEwlmKsFRSLuvOI1d5JrLWu
         quJg==
X-Gm-Message-State: AOAM532Ekw9vFGNJEVxokC8YuDqERy6GgOLvhM5sseoJcUiADMLtddn5
        PkVeZPaIKZZ4V8cfGxY3qp8JzWtZVGKVDy5yq2+z59kWHIU=
X-Google-Smtp-Source: ABdhPJzGtlntambXiJJX2hmSzW1VvWWtIqKKUzhKPpCNDtfoUqmU4UKePFz15G9yFJX4ZnivB5guI0qWPzwEVOSBS80=
X-Received: by 2002:a25:20a:0:b0:645:74e4:8cc9 with SMTP id
 10-20020a25020a000000b0064574e48cc9mr35104098ybc.518.1651235441669; Fri, 29
 Apr 2022 05:30:41 -0700 (PDT)
MIME-Version: 1.0
From:   Jack Adrian Zappa <adrianh.bsc@gmail.com>
Date:   Fri, 29 Apr 2022 08:30:30 -0400
Message-ID: <CAKepmagtT6=AzP5=-AhTtR1GbAb5nXJ8h24WsqTDm5B=7CSCyg@mail.gmail.com>
Subject: Is there a reason why variable expansion is not allowed in git?
To:     git-mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was trying to make my .gitconfig cleaner and easier to maintain, and
I found that variable expansion isn't a thing.  Why is that?

A use case that this would be useful is having several commands
requiring the same parameters which are long and hard to read and
maintain, such as a regex.  You can see my question on SO here:
https://stackoverflow.com/questions/72005402/is-there-a-way-to-define-and-use-a-user-defined-variable-in-the-gitconfig-file

Although an answer was submitted, it is a very roundabout way to do
something that should be very simple.  There is the %(var) expansion
for paths available, so I would think that a similar simple text
expansion wouldn't be that difficult.  Perhaps by using curly braces
rather than parenthesis?

Is there a place where I could request this as a feature?

Cheers,


JAZ
