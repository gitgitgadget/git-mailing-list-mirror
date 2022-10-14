Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F85C4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 09:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiJNJLq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 05:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiJNJLp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 05:11:45 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C266318499B
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 02:11:44 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sc25so9076780ejc.12
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 02:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zyb0A+25SjUrpaC/pTzE9aBbFIQy2rmCQvzFVmCFmpw=;
        b=ZmHY0tzbHyRFxeWAF8ba6AC8YnF0gQrLltJLhk4JgO+v3ZJuYfboJR5j1xT+7zETin
         /SSdcZYOp+5CLY+ntEBMRzoZA/AFMEyjlmN0/b8x4fIxnMWJKO88osCYpq+9YCHf604a
         9+bZgnrPOEevLK0Pcr2ZFuNuaTvt3jxkK5Wlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zyb0A+25SjUrpaC/pTzE9aBbFIQy2rmCQvzFVmCFmpw=;
        b=cbntVkvTumFSHDKUrtolL3sFx5OhLDoCqQYCtGCQTEAIaXH+mWzotQ+WjIoClSWqGG
         lf1VNbBHKSQqFvoLfC6E/NITsAnHJP+cjb61Xluc/i7Ry+gy6BfVu5OXozxhwgk2xH3z
         /ujia++ugAq2P+AJQwX3MTg1g1lvpGmdTkQm757YlO7NWK7oTbHRDJDxCvnvmNfUWErm
         3gxnqGv/ENqcd245eE+NRVHMuiiddWw/pRo7iiz2od4ESwLWpES/Ae0fE4Zt43FDLNDJ
         RCKsng+7O0oH6ds/bjSk3pDlh32wGi8S9ZQUUnl+ozc8eF6/7TaGxR6D1foRgbhxSXBw
         IwPw==
X-Gm-Message-State: ACrzQf0ho3XZH5Q8niFoEKMvendxjmCwULIraj50SaUhWkyU25K6hmin
        Jm/e6YlfAS7J9sSHgMPg3AKsCr870qd+Rugmrut0Fnfhq6/Aymwm
X-Google-Smtp-Source: AMsMyM5bU1ePRcnMa/i0t+PSO/tifq7HQbAYHAUac/4aQRt7MtdWMpcoy2dC5IIxHVCV+rfbsII/gtXaZhHNWcUQ3Eg=
X-Received: by 2002:a17:906:9b8b:b0:78d:8276:ff47 with SMTP id
 dd11-20020a1709069b8b00b0078d8276ff47mr2880264ejc.430.1665738703254; Fri, 14
 Oct 2022 02:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1381.git.1665590389045.gitgitgadget@gmail.com>
 <pull.1381.v2.git.1665734440009.gitgitgadget@gmail.com> <CAPig+cSPWsiKBU6hgvP_BO7n23nLf7Q-59ZbO4fSL0idcw2qzA@mail.gmail.com>
In-Reply-To: <CAPig+cSPWsiKBU6hgvP_BO7n23nLf7Q-59ZbO4fSL0idcw2qzA@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Fri, 14 Oct 2022 11:11:31 +0200
Message-ID: <CAPMMpogj50aWGdvs_gAJJvft+TOQXKvZm7+Y5yDgrCavjNvABA@mail.gmail.com>
Subject: Re: [PATCH v2] RFC: mergetool: new config guiDefault supports
 auto-toggling gui by DISPLAY
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2022 at 10:24 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> backticks
> selected automatically
> spaces
> test

Ack on all these, my apologies, and thank you!
