Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D74C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 08:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344201AbiCXISh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 04:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348818AbiCXISd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 04:18:33 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1689BADC
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 01:17:01 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c62so4689951edf.5
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 01:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=tVznHFDOKRGT5XlwiNANNxRu8b2hNp0g28ESuOpbn28=;
        b=k+DIkjftdddyFtJGJnD9LJNYhjXq88cogjxVmsnG/HUiR4fI8GItgHxIlvDEtnBRVh
         xwVd+P5lyU5iCtrNGKfEIIHlDJ9gX/pQFJZTlFc6YEiqbD+7bxM6jJnB3dsbNL4LnW9K
         v6fo2WKCUEyHOOoWzq58QMAy9R9Z4kSHrXDr+h0hie0woicQcfeBddlnkoimhO30dYr5
         sR6NXwhNJcZEOh6OA5/7Zzrk6Hk4uSV7yFw8Z1J5/aHvdKblE8nTjXwrhk0dHy0J/+vx
         Vyty7tdhen8vtaCycTciT9sRsqJEEsL06xvyu0ODuRfemV95GdRIK3axMlELUlpt/lxA
         Ep4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=tVznHFDOKRGT5XlwiNANNxRu8b2hNp0g28ESuOpbn28=;
        b=lUcR1lFQNkGNDrANRej4iVYlFRb4OUo4YYrwwOz2FHCWOmHAWXvCUqFZcXKZtaJXlg
         P/BEMDK2h9zcMcv2dpOV4SARZIHwVxO33SqOuCjpZib4SOKXOhOq2OYpgSAov8xI8RzO
         gdAwtmGauVsgom1P5PEzLh6vnfqo8Do2ZYWOt9C4fpKPpAE4fqahpv+hbhdZxoz2LUF1
         Ln0Kt0emmHdCn1eM3KjiPnpcg877LhSjV4JOa1eIHbWN29JzYhLVxOIZ4BnmrWE7kX6u
         V3tGjJyHMroQk7WH+FqEAxjCDclhYgoM++jtDiZxOW5nkTS2j7oJ1apBqcUU4jA1GdjC
         L/1g==
X-Gm-Message-State: AOAM533b1/gM8irfMKAJh/cRr+pg+yw579Hk5fhnNH96ef9paek4ethr
        R8tJxFPyy4dhAvIPE9l6yl97b0ZaocYRABoaawl8cKT4Bmk=
X-Google-Smtp-Source: ABdhPJz4+nUp/oDGazZ1pUEL+7BeICE5opOJX0CyaToZTqdXdEh3dPpq4QDvNl8A6Ph1GmTZrERryViUX6I6jHpKCHI=
X-Received: by 2002:a50:9b4f:0:b0:419:49af:429c with SMTP id
 a15-20020a509b4f000000b0041949af429cmr5350753edj.276.1648109819810; Thu, 24
 Mar 2022 01:16:59 -0700 (PDT)
MIME-Version: 1.0
From:   Jonathan Bressat <git.jonathan.bressat@gmail.com>
Date:   Thu, 24 Mar 2022 09:16:48 +0100
Message-ID: <CANteD_wDSRmwLQiYV1x133WEtVaRK__c584E3CbXN1tPOquitg@mail.gmail.com>
Subject: contrib/vscode/: debugging with vscode and gdb
To:     git@vger.kernel.org
Cc:     Cogoni Guillaume <cogoni.guillaume@gmail.com>,
        Jonathan Bressat <git.jonathan.bressat@gmail.com>,
        matthieu.moy@univ-lyon1.fr
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello
In contrib/vscode/ the script init.sh create launch.json with the
option "external console" to true but actually this option make gdb
didn't work so we passed to false and then it works.
Is there any reasons why it is set to true, do we not use this properly ?
Then would it be nice to correct it in contrib/vscode and to talk
about it in that doc : https://git-scm.com/docs/MyFirstContribution ?

Thanks,

Guillaume COGONI and
Jonathan BRESSAT
