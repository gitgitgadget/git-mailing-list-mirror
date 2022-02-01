Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012C8C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 19:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbiBATxb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 14:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbiBATxa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 14:53:30 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E27BC061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 11:53:30 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id s9so34067979wrb.6
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 11:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PLdqYaIAa6OsUPiLElEBXar+0pn9pC/Y0d3d5WyDF0c=;
        b=pvXop/eVDuTsphEbWq/TnTLxOVJ3aquHDlW7AdkWWiqhLmz52gtqMBGKSTHjKtdmIl
         8KnLkEraFOT8QhtL2QfHWjsuF7eS+33KpvhMBt/HAfxpnWP2W019x99CM5MAiwDT2OLs
         8pBS4DMVQp0S+/MWrrXvEA7uawVzXUYujJJmkoHzYFBPSSVuvhFRTzZOLx+ntP5yMeH1
         n9Jwmq2QhxghgSeR9KrqKFZUzZWxtQXhO7jWjiWuTiOEDfwNwf9/Tl0/irWO2bL8EBN8
         p8YZyECwKoM02vG0GC7pXp4tJqqexXzLQIzrYjFEAVkEP/1IBZU9WWyaBoHUTiT7Pumy
         BxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PLdqYaIAa6OsUPiLElEBXar+0pn9pC/Y0d3d5WyDF0c=;
        b=CjXXyWOCDSrczwja7BPMJLHM3+uAvBEa95T7JikciDEEMzP5cJOILUnU8uLXmijffx
         yNW7Rkc+bf5lkfhSxw2pJ9sFat7KGht2n84HVMafgmMMpZYk2/Y3FcoNK8x/UjWwqNcv
         EVU4I1z82xJjGWelUB8W6DtsWCYXr20WVelVnc9L1oZ2Vr8f1wTyU0tUF0Z43ZJF80/3
         JDWB0VqK2fPVIue4nVLOLdAcntkoaGMeW9MqqPQIjTzgUXRC2l4Yc4T3MKMB2qcO+T7P
         mFIaPcs7ayhLYH+u3jncU2iy4qltrSkpAMU8nqGmVXTqoNnojfcV4Xqdr1vx9AiVelv+
         CUdg==
X-Gm-Message-State: AOAM533eOjlW8asAs3QWxym9VEgKiYGLw8tLEEcjBwXjSKMHg5q3XIWs
        XgAzR/abnTj2YUJrkhxeLhU=
X-Google-Smtp-Source: ABdhPJwsDD4IWtiEmmo9X48+2r/y4bAK9T0duMsqgsyOLNEM06vemRzidvuSLlEuYWyuuZa8Eutxqg==
X-Received: by 2002:a05:6000:3c7:: with SMTP id b7mr22792289wrg.260.1643745208913;
        Tue, 01 Feb 2022 11:53:28 -0800 (PST)
Received: from gmail.com (91.141.53.66.wireless.dyn.drei.com. [91.141.53.66])
        by smtp.gmail.com with ESMTPSA id n15sm2999134wmr.26.2022.02.01.11.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 11:53:28 -0800 (PST)
Date:   Tue, 1 Feb 2022 20:53:25 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Thomas Koutcher <thomas.koutcher@online.fr>
Subject: Re: [PATCH RESEND] subtree: force merge commit
Message-ID: <20220201195325.e5u6zrxabbszzlji@gmail.com>
References: <xmqqpmqy12u0.fsf@gitster.g>
 <20220201172601.262718-1-aclopte@gmail.com>
 <xmqqtudics32.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtudics32.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 01, 2022 at 11:19:45AM -0800, Junio C Hamano wrote:
> Johannes Altmanninger <aclopte@gmail.com> writes:
> 
> > BTW is there a good way to tell "git send-email --in-reply-to"
> > to prefill "To:" and "Cc:" based on the message I'm replying to?
> 
> I do not think there is, and I do not think it is readily feasible.
> Given a message ID, how would you figure out these two values?
> Hardcode the URL of mailing list archive and the rules to find these
> values given a message ID?  What if you have a local mail archive
> that you'd rather use instead of going to the public internet?

The "b4" tool accepts message IDs and allows to configure how to look up
message contents. This is the default:

	[b4]
	# Where to look up threads by message id
	midmask = https://lore.kernel.org/r/%s

b4 has some powerful features but I think I just want something that reads an
email on stdin and outputs the appropriate "send-email --in-reply-to" command.
I'll probably parse the mail headers myself.
