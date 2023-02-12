Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572ACC05027
	for <git@archiver.kernel.org>; Sun, 12 Feb 2023 23:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjBLXkh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Feb 2023 18:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjBLXkg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2023 18:40:36 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C08AF770
        for <git@vger.kernel.org>; Sun, 12 Feb 2023 15:40:35 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id b5so11822855plz.5
        for <git@vger.kernel.org>; Sun, 12 Feb 2023 15:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFWJufBo7frfJvGWBATR22ILodz8giOhzSZGXBdfqoc=;
        b=YICg14stG/geA6zjJpsMxYGJunVRpMmyJ2cgSikoUf13WfWTvkoPBqj4WYEDnFP2Ow
         ds61w2SUnc7hqXrqwM530Lzvob1rEY3vMEdBZA6bbA8C2Ne0vI4j0YqEA22+j8fBzFxs
         UdobDtEmKpGdAbdLkcU61q/qR05LVNq4HhXFCcqEmZhX19m8KHrvSEYLkwBGL2Vi4rGK
         UGZH/Ipypv9KbVzlsYGReiI+X/D210Ye5u9bPku6eBLeHEP4U5SXzpDuoz0olQToBCes
         2zPToc0KfNHnkSkYzEpL4VLiGDGXbfwG2x0jfg/91xEhXVRaXZdYSXu7KQS9lQ+IARZa
         W8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xFWJufBo7frfJvGWBATR22ILodz8giOhzSZGXBdfqoc=;
        b=cWiBDDWZpKcBRljTNVLuGomODB++hOuzIrUsFkoupZodslSN6lwTFk6lf4XZtFBEb6
         //Tm8ogRn6YjUQjQfam76qH7KYwsiKb+Divya+XpLWZDggHIGOXrLQ0dzS92FYsaDbUy
         swXltiuFAdl4rAAtW8n33G6xqKY+9Yovg6eFAUPkugg5xbL5aHxqsFwWLZBRiOk/yuGS
         FPCoJAN7zlO3KL8ySkCquRjdJ2Dv1XoMuipU+k1h7nfft9gxiHsI5rF47v5mIviWfFJ+
         mWiZKPD5D2I2cDyyCJ9PtBB3vPDbAjiKGSCgtB0r8hPrpKa0Ew+5Rp98R92M4zbHyi8H
         +iBA==
X-Gm-Message-State: AO0yUKVXM02XpUSG49d7SpTX4zLIPPfwLSbjEP6on8Eprs885/fkuoIw
        D4aD6jLHI7rGiY1RiGr2J3Q=
X-Google-Smtp-Source: AK7set/QLhkpjDC97CMPT85vq8hEDzfJODW74LTrxxDrYfz/msqkF3VeeqJeGu5PdobMmP8gKwXy2Q==
X-Received: by 2002:a17:902:e881:b0:195:e9d4:5380 with SMTP id w1-20020a170902e88100b00195e9d45380mr25332661plg.56.1676245234689;
        Sun, 12 Feb 2023 15:40:34 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id ji22-20020a170903325600b0019462aa090bsm3421454plb.284.2023.02.12.15.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 15:40:34 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Renato Ramos Ribeiro Araujo <renatorraraujo@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Suggestion and question about hooks
References: <Y+krdsIPhKIxFRHt@zosoarch>
Date:   Sun, 12 Feb 2023 15:40:33 -0800
In-Reply-To: <Y+krdsIPhKIxFRHt@zosoarch> (Renato Ramos Ribeiro Araujo's
        message of "Sun, 12 Feb 2023 15:09:58 -0300")
Message-ID: <xmqqzg9icv0u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Renato Ramos Ribeiro Araujo <renatorraraujo@gmail.com> writes:

> Why git does not have a hook 'post-push'?

You may want to look for "(five) valid reasons to have hook" in the
list archive.

It depends on what it does, but if it always runs after user does
"git push", or it always runs if "git push" finishes without an
error, then such a customization does not deserve to be a hook.

	$ cat >$HOME/bin/git-mypush <<-\EOF
	#!/bin/sh
	git push "$@" && {
		... write whatever your post-push would do here ...
	}
	EOF

would work just fine without any change to git itself.
