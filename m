Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C42C352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 13:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbiLFNBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 08:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbiLFNBM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 08:01:12 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50E026572
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 05:00:48 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-144bd860fdbso4152033fac.0
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 05:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tOpFyzHL71q3WTfS+2y8skg56Skx0uvndZSUMwH/omE=;
        b=Knaqe8nRMTJgmvmbOIhzL1RLlvRmfARVqHlCv0phR6rSf6aiyUTIg2xLsSRN42EZ1M
         g2k0bjWY5B8yuGSQirwXiJVOjXa3e7vAIB2QLFukhXo973nes5PY+Dznf6SYTAPvJg/y
         qkiceLkAQlGb5ADn98snOFRYXIoUz7scsqHWpMqAZ//k4Y+k0yWifgOf5KdXci93Wkgv
         1Q3KJzMNLki7ZeAo8PkMZB/QW/NS+pyBGDYvxkXpO8M7nkBhxlFcPMhuycj9hdnOEId9
         G5PU61xv1DH6Bn+XDgyDXYM3Yn2daPzjWPMHaEVA4QjLWloALZnLxnPv39AEzfuXljAR
         eiaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tOpFyzHL71q3WTfS+2y8skg56Skx0uvndZSUMwH/omE=;
        b=3wqUTLrCkf3ygz/+QuofRWMBBgTubUvK4OSRLHQAX/LrXgEB6kXRuKMczse1X+PM7b
         Cg6Q5z1t6uFAWs4VaJwj9obQ0f1jbYsPp9xLCKUnmzfAN/tLs6UxVnduP+/lyOqC9EvC
         uizQ1Vp8CG0YIxvVtSOI2tv2INEVkNggbMiLcXYup5Q7t6YuALfrnEskkipuRq8zyrvN
         QfC5/UWA8/qmwtpCeuk3dq6dbWV98bJzLUbNi7d4CqR2DCiTc7PXl+hI9Qm1Azwqqolp
         FNNJkbFJemBPkdHMzEsC3lQ25v6NKDRmoGMkDE2XGr7T97bd6aWuGxdelj8lSRff1kxv
         W/HQ==
X-Gm-Message-State: ANoB5pkFcxtpnWMNAo0/PF+8UJXdaVm8XYgBOXH3ih0QsdGGxzhTaA/W
        QaTuJHh1R+rwuDuBpARMTk0VDxBlOQHXiFRAz6HUq7Hkc6g=
X-Google-Smtp-Source: AA0mqf6fGlst1FR8NT6KiHng8/DNQnV8NbOxLW9fUIuF+0EJ27Uf6gQC5wm6qEfGObH0fTgZdQgswmee/hZl2OKJhRg=
X-Received: by 2002:a05:6870:41c9:b0:142:6216:64bd with SMTP id
 z9-20020a05687041c900b00142621664bdmr37719869oac.232.1670331647842; Tue, 06
 Dec 2022 05:00:47 -0800 (PST)
MIME-Version: 1.0
References: <20221206103736.53909-1-karthik.188@gmail.com> <64522fbf-c006-700f-67b5-749093d6e962@iee.email>
In-Reply-To: <64522fbf-c006-700f-67b5-749093d6e962@iee.email>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Tue, 6 Dec 2022 14:00:21 +0100
Message-ID: <CAOLa=ZSUpCSUvB==LzTHE5Hz_zzV8xL8KUjj3qMg6WqyexpXhg@mail.gmail.com>
Subject: Re: [PATCH 0/2] check-attr: add support to work with revisions
To:     philipoakley@iee.email
Cc:     git@vger.kernel.org, toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Philip,

On Tue, Dec 6, 2022 at 12:20 PM Philip Oakley <philipoakley@iee.email> wrote:
>
> Won't this also need a man page update? I don't see any changes to
> git/Documentation/git-check-attr.txt.
>

You're right, I totally missed that, will add it to the v2 of the
series. Thanks!

- Karthik
