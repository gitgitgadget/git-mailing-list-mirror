Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA56E1FD6A
	for <e@80x24.org>; Thu,  9 Feb 2017 23:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751690AbdBIXre (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 18:47:34 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34409 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbdBIXrc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 18:47:32 -0500
Received: by mail-pf0-f193.google.com with SMTP id o64so168589pfb.1
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 15:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VuDppIPVDX5vkrRzp7Tdiulx0gnF6w9BwLYNPWnmKIg=;
        b=MftpLlYeh5E/CyLjYbHIp0yEnfD33cRBdlD7i9+k4DZ1hOnabeIxg0/2gdjbvcrML9
         E0q6vOjz0i39GSHrr9jfWVyl4HPx5nh0rSGDa69KG/kdN3fnZC+xJ+WQNkkyBWAD54Dt
         o8nDydfuDAiIHXWCQYFLdGLmZUUh/nXz8cFG/FukrgGFWh4Dd6/ItnNIbgL67qgSpdg6
         2oDr2yJ22G8/letRDiN6l12HKFh+iuCVhb4YHSEvo/mgvadqIJhIGAZvnFgT252mEPyj
         3sOznS2y7ty0ZRZXOCWV4LDPyYrHTRl7vwFKtczOHfbtyzvLl9xz/O2ZiMWGkar+1rhA
         ZbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VuDppIPVDX5vkrRzp7Tdiulx0gnF6w9BwLYNPWnmKIg=;
        b=clWSWuxhQj37MrJ3tVcfUaJvTnFZse2cTW/aRNg8qH5acPITacivwe/pFut0IsE82C
         QhllwEg6ZCVNp7lZsbMEFh03bUZjijjCejP0bPDBaOiZhHHReGgP64RV1jMXl6eO5m+f
         1YSj1uKNRLK0IM6lsQyNI/MRIF10aiy27Y+Xj2j4dAYWQi5HOhA9ZOHdsFYzDoGffGXo
         PlymdRYKqsQVL23/QpB/9JEN5TpAYi3Q2SPG1rvSLu3ftnOdIfobigJq4yvyIhietIVN
         ZoJGH8HBSYyz0vTNLO/+FnH3K3l71yLBa2SEdEcCpOQSBK4/2uUFXuyXBrRvcVhBKHR2
         ovXA==
X-Gm-Message-State: AMke39ni3pjOIWjNQGcoEM29GT/2Jk6dFsoZIwv1iVeR8Swb9DUmOToEtU6D2mn/93UUaQ==
X-Received: by 10.84.231.142 with SMTP id g14mr7466163plk.13.1486683575305;
        Thu, 09 Feb 2017 15:39:35 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:704f:61dd:c9f4:9782])
        by smtp.gmail.com with ESMTPSA id z29sm31719456pgc.7.2017.02.09.15.39.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Feb 2017 15:39:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, luke@diamand.org
Subject: Re: [PATCH v2] git-p4: fix git-p4.pathEncoding for removed files
References: <CAE5ih7-=bD_ZoL5pFYfD2Qvy-XE24V_cgge0XoAvuoTK02EDfg@mail.gmail.com>
        <20170209150656.9070-1-larsxschneider@gmail.com>
Date:   Thu, 09 Feb 2017 15:39:33 -0800
In-Reply-To: <20170209150656.9070-1-larsxschneider@gmail.com> (Lars
        Schneider's message of "Thu, 9 Feb 2017 16:06:56 +0100")
Message-ID: <xmqqfujnlyru.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> unfortunately, I missed to send this v2. I agree with Luke's review and
> I moved the re-encode of the path name to the `streamOneP4File` and
> `streamOneP4Deletion` explicitly.
>
> Discussion:
> http://public-inbox.org/git/CAE5ih7-=bD_ZoL5pFYfD2Qvy-XE24V_cgge0XoAvuoTK02EDfg@mail.gmail.com/
>
> Thanks,
> Lars

Thanks.  Will replace but will not immediately merge to 'next' yet,
just in case Luke wants to tell me add his "Reviewed-by:".
