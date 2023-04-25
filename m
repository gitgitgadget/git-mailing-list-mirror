Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435A7C6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 17:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbjDYRFH convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 25 Apr 2023 13:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjDYRFF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 13:05:05 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA335BB2
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 10:05:03 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-74de7635180so596865085a.3
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 10:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682442303; x=1685034303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSRnO3rVOopwaGvEhLSjfvBbrohp5YN3YVr3tgjaAg4=;
        b=VbxZoT525jIoYJ44+Bg2ZBVXK4GEVvOnZoar4YZv0aSPBoWkF+rOkA+96JIstJ1jES
         tvT4qhKD1Zxvh3MNW1HEfZuxDjqIT7kKcx7rYCAnDCskcZKtdti5yF3RSaEYmK3WXC38
         VjzFGeERCVw0KwHPKPgxGoXTK6ZXegGEmtzYkGpQh0PTHYrBv5QNZUYDGOLaxEQ9VGXk
         uFXCvqbpUrcRw8AmSxqishWE23cnHP1E+oeYe1VdkqwJ7yDBLg1MzX2JG1QxoryjBL8N
         H83Z865K0Kw0VaDfInhDZrpwwrcVuH0qBUD8PvtliP9zzLkqziZMEBcHsvIQy+0j2bkV
         uZtw==
X-Gm-Message-State: AAQBX9cwljNqoqWeoLTAxkRQwDzvR0XZCSTwMRUk7YtCz6ib5IHizN13
        0Qkb6QGEEpYlT+CpOao/xVBKwej1DvzcZXdZStA42pb4
X-Google-Smtp-Source: AKy350bZU9bSyAs3Bvq/nfRr0nzZ+N/PCYIFyNF7SlMew/2T3llg9dYHxsaO8KrfRSqHsUCrUmrOeOekTtC732fOtQs=
X-Received: by 2002:a05:6214:2b0e:b0:5f1:89ba:c0b4 with SMTP id
 jx14-20020a0562142b0e00b005f189bac0b4mr32418628qvb.48.1682442302665; Tue, 25
 Apr 2023 10:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh6t57x0y.fsf@gitster.g> <20230425162631.13684-1-maxim.cournoyer@gmail.com>
 <20230425162631.13684-2-maxim.cournoyer@gmail.com>
In-Reply-To: <20230425162631.13684-2-maxim.cournoyer@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 25 Apr 2023 13:04:50 -0400
Message-ID: <CAPig+cQ+6m35cTXr20-BNyHRsQQq2nTNERCH8N9NMsUP8Ct7mA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] send-email: extract execute_cmd from recipients_cmd
To:     Maxim Cournoyer <maxim.cournoyer@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2023 at 12:46 PM Maxim Cournoyer
<maxim.cournoyer@gmail.com> wrote:
> diff --git a/git-send-email.perl b/git-send-email.perl
> @@ -2,6 +2,7 @@
>  # Copyright 2002,2005 Greg Kroah-Hartman <greg@kroah.com>
>  # Copyright 2005 Ryan Anderson <ryan@michonline.com>
> +# Copyright 2023 Maxim Cournoyer <maxim.cournoyer@gmail.com>

Let's avoid this change, please. Many people have worked on this file
over the years -- often making changes far more substantial than those
made by this patch series -- who have not staked such a claim.
