Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F8611F859
	for <e@80x24.org>; Fri, 12 Aug 2016 17:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbcHLRHN (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 13:07:13 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:33950 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbcHLRHM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 13:07:12 -0400
Received: by mail-io0-f177.google.com with SMTP id q83so30252728iod.1
        for <git@vger.kernel.org>; Fri, 12 Aug 2016 10:07:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mVe6EKJqyDqWYAOyDyd93zQ/ejYtAFzNS4FyxIDP7Qg=;
        b=ZtCXUaVZ+t4Os0uR8tAVIlw+9zgn2R5ikGpJwPAhwIBWKKbx/Kr367Zc0BHhFg77MC
         HD5K6OkwxQNvlCJE9IO5sCtquuN2WVzrutyI99wecwlNp+Ojx1AZ/cGrEDSZ+qsd5DQK
         VPsoqbiXw7WdwSvLdu81Z0ZZBDJ4LrkBuPnAeqEyaZvW/j36ZNnep6QdG166hZi3PLJ7
         06smXogBdtCe0WcxE+MoJWL9bga2/F0qYncwvT7nv9s/XcT2XEeHYQIsiZcHr3eLZ0Zc
         kiP3gQXeEIs0lh326ya8XXZdhj8vOIlasOJGIypXOn+LiGIs1ii+xOwg+1r/LuZD+7B2
         vukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mVe6EKJqyDqWYAOyDyd93zQ/ejYtAFzNS4FyxIDP7Qg=;
        b=UNLIZy/tVGDoS75EkUpEoDDlpHZ/AquGGiJFs5+8q7fX7YDVj7wlthe8UEmPMZHF4R
         IbhG8qC4klVbWW0NEG5koelpN48koBWX2k3d3YqcoFvSfwhPPVLDFekrZiQ3YMAGA4oF
         TL3iKdV3HSblsxXmTqRy1+sqcONRUZkoe75rMMgyOMzy+V3WpzpDKd5ZQQdHrcDVOWtl
         1tbgw2Tdh5nvvlTLMG2ycMzMcLNn9uo+YLYu7B+7HLgz7bYGYFg+/FRnKKZ2oISDBDob
         K2Yp+BrZZnyrd1dWfxZAPaxG3bHGMsFSepz9gt5s5y7hoNWLqxzND1db/SiBKzcmDjnB
         OP1w==
X-Gm-Message-State: AEkooutD+oxQDEb4yE/H74uVMfdGrZu0VJuSNASNnxWfw1R7BruPsxLdgfK2Dd8uFT/HXM52iWRMMD1HDpjbEUzT
X-Received: by 10.107.144.10 with SMTP id s10mr18561101iod.165.1471021631521;
 Fri, 12 Aug 2016 10:07:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 12 Aug 2016 10:07:11 -0700 (PDT)
In-Reply-To: <509A907F-B1B5-4244-B1C7-F1190296208D@gmail.com>
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
 <20160810130411.12419-1-larsxschneider@gmail.com> <20160810130411.12419-15-larsxschneider@gmail.com>
 <CAGZ79kboxgBRHSa2s7CKZ1Uo=13WT=rT8VHCNJNj_Q9jQzZAYw@mail.gmail.com> <509A907F-B1B5-4244-B1C7-F1190296208D@gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 12 Aug 2016 10:07:11 -0700
Message-ID: <CAGZ79kYL5ajdyJK8Yimy2O3b=x=46D2VuNgm2aZ5nD703y1A3Q@mail.gmail.com>
Subject: Re: [PATCH v5 14/15] convert: add filter.<driver>.process option
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Martin-Louis Bright <mlbright@gmail.com>,
	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, ben@wijen.net
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 12, 2016 at 9:59 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
> The welcome message is necessary to distinguish the long running
> filter protocol (v2) from the current one-shot filter protocol (v1).
> This is becomes important if a users tries to use a v1 clean/smudge
> filter with the v2 git config settings.

Oh I see, that's why we're at v2 now.
How do you distinguish between v1 and v2? Does the welcome message
need to follow a certain pattern to be recognized to make it v2+ ?

>
> Thanks a lot for the review,
> Lars

Sorry for repeating the questions (it seems I missed
a lot of the prior discussion), but I think these questions
may help future readers of the commit message,

Thanks,
Stefan
