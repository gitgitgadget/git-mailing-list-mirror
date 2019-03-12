Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 520FA20248
	for <e@80x24.org>; Tue, 12 Mar 2019 07:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfCLH2A (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 03:28:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39926 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfCLH2A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 03:28:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id t124so1409526wma.4
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 00:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=92kEq9JVhF51WAqPheQUNv1Y95CnOXC2MEOUkZCghpM=;
        b=O0oVFSoe4K/YrFdWDJN42GzYRh7VCXTeY/N1tDb6BsuLvBlUDGB3mhLfCdRWAosleB
         AQRuZkpKJtP2fFZ54KSvLMnHwChG6yD6G6pAKS/iTU2zqF6eKTmS1x0iMbR08VNJRBoc
         EzhPGvGkxW9DQg42wN8yr7iCWrw8byq200RtBBUKcQ5fP3VkLvkS01lCI4ojSnA549TG
         CElqhPxO8Stmsn2zgPsAG9LWU0hvmVKVrxVqNfhDtdqwdYMqN3CIRmSYndBzQy8yuIIX
         bY57bXdCZbU1qZt3u6lxpGq08QSbBfC6NP2QXRRlbIszJEvCV2+YxZ6aNZ3D58Vlva9Z
         SRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=92kEq9JVhF51WAqPheQUNv1Y95CnOXC2MEOUkZCghpM=;
        b=bLndUwibuuxzd9VYDjGW2OmGqPrgTfVAo6DfaSI72KQxmOXCkIhG+GUmhVemRuvkmF
         BJQt3FaaVP8gM14dLuDXKKAWbeBdie/rNwGpyx6JZOQIevNFsSNzImULp56hSrJ81Sct
         uSwnLm/NkpCH8vtcNsCqvUtAjU48C0goWPFQwZNQTtarJiPTQy3O6WhexVlldgXC9JcO
         MDN5Cao4W0eXKuOSYXYwFzLyDh1DNv/rRyG8uLLIRnCHCwkLuI71AZdfgzIjsP6sHGmi
         b+fsW8Rpf4fxb11d67WaJ32kQMw468Ivw9Ue1gkC77gmzDK31eYdm9ZqsESls1x019Ue
         RG1g==
X-Gm-Message-State: APjAAAUvJMWsg3tVDQaokIMZAu0tA7ubIoPLD9epqV+dO6v96ZF4/zzE
        72UgiyEQLcNtbI7U8yUJrZEp0hN4/EU=
X-Google-Smtp-Source: APXvYqw/2NbBjUbXiiV+9dxi/YjaZs9BdtbtR6b0XwVvWMCd/tDJDweew8TK6jjwAi+H8NM36Vy6pQ==
X-Received: by 2002:a1c:c3c3:: with SMTP id t186mr1293891wmf.8.1552375678594;
        Tue, 12 Mar 2019 00:27:58 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id f68sm5205900wmg.5.2019.03.12.00.27.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 00:27:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Duy Nguyen <pclouds@gmail.com>,
        Jeffrey Walton <noloader@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: disabling sha1dc unaligned access, was Re: One failed self test on Fedora 29
References: <CAH8yC8k_Zyi89uxTWTrjN65UAAc1L+jLho+P7O7UyvE-LvZuzA@mail.gmail.com>
        <20190308174343.GX31362@zaya.teonanacatl.net>
        <CAH8yC8mg3vjPoof5SDemQ_YiL+7e1ak535U2nFnPbaWJ8xSWOA@mail.gmail.com>
        <CAH8yC8kn=EmEm_UPrnpwaofv97S42Se6FC+hWcm0EHCX-4rewQ@mail.gmail.com>
        <xmqq1s3emapy.fsf@gitster-ct.c.googlers.com>
        <20190311033755.GB7087@sigill.intra.peff.net>
        <CACsJy8CdqbOKu7SHMt_Pz1EtRz08HGpwWHUHoZbUiow_pPh=+A@mail.gmail.com>
        <8cf2fa6c-d742-a2a6-cde7-66cef87b04e8@virtuell-zuhause.de>
        <20190311182328.GB16865@sigill.intra.peff.net>
Date:   Tue, 12 Mar 2019 16:27:57 +0900
In-Reply-To: <20190311182328.GB16865@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 11 Mar 2019 14:23:29 -0400")
Message-ID: <xmqqa7i0h7r6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The problem to me is not that the steps that a developer has to do, but
> rather that we are dependent on the upstream project to make a simple
> fix (which they may not agree to do, or may take a long time to do).

Yeah.  In practice, I think the recommended way to work for a
depending project like us is to keep a fork in a separate repository
we control of the submodule project, and allow our fork to be
slightly ahead of the upstream while feeding our change to them.

