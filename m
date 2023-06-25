Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5EAEB64DC
	for <git@archiver.kernel.org>; Sun, 25 Jun 2023 11:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjFYL2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jun 2023 07:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjFYL2T (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2023 07:28:19 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060B6F9
        for <git@vger.kernel.org>; Sun, 25 Jun 2023 04:28:18 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-6300736589fso20241686d6.2
        for <git@vger.kernel.org>; Sun, 25 Jun 2023 04:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687692497; x=1690284497;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8lJiLfXjyPsW0AJPfL5Jsi/gX8OlBOguGs4hx1GBxtg=;
        b=lqSqqKrzMKoVGkubzle2StUuFTSPzdg+tI0IoeQ5BM5uUtNOQeEZSm1XSWQxYveo8t
         qGH86KyIeGfTtQi1t9tDERfpO9P/e20GHzArpeXwkSYcwKELlhY/7L2b3GxVrTRJAwF0
         agZD+xF0qOep0w6GerJSDFaVp6J/T9aNpoCflHIkEPRU7HqrQ1uIZ2wgY0q/eb1gEdnE
         G5cX0kLlvLg+MGn7xnKam2G8ueaF4WS2G+H+p6C+AGGG6Nb/6ML8+mN4dm5ILwhLW+6z
         bsR8Dzv4hCrRIc3nfRbLTYHdTqrzPFDsvEmqinW3l2PvjmvJg/Fvivc8rAO2JYkrd4b1
         Qv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687692497; x=1690284497;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8lJiLfXjyPsW0AJPfL5Jsi/gX8OlBOguGs4hx1GBxtg=;
        b=a3EKv3culbpPB53ABNj7cFijFCnIMPLnE/1WtLumy4Z3ALewndhZqbETRw6WPMnhd9
         wl78n4dV+ki7c3mqgyr7MztD7+Kpyp6ThMUw433cddFSOWg2FfQ6ioEQgNF7hVUmof7n
         nJW0U9xhfrx2MB0Avcz0C8u46AB4U3RwzzXY95Wu+I8Y7/4QW0J8MoF7Gn/7Khl79KP0
         LnVLt5VFV+mirklPYNjMqYE9cdPcTeJrcgNEEJcdNWdcWGrwa+Zpv/deqjl7VOO5gliD
         TbPbmuoZVM2M+zc0UfrY3r+dT21xoU+IpCs68vRVlc8AWAF8h5Ixd31IjUABBRqNV/Ge
         oynw==
X-Gm-Message-State: AC+VfDwkUY6B8b3sdcOZqhpd+8yGPcPscILfDz2Xrwndzg3BUyNjG75a
        gI8l2c4DRFQ1NlHYsmWLfLFzKxR8nzFevg==
X-Google-Smtp-Source: ACHHUZ5gUs0Sn8f6RymPefg1HoroK1CConLDnvDlW5ddctw9PN5A5E5qPJOANX0CjjQeY1oj96aJUQ==
X-Received: by 2002:a05:6214:2262:b0:62d:eaa8:27d6 with SMTP id gs2-20020a056214226200b0062deaa827d6mr37462132qvb.25.1687692497001;
        Sun, 25 Jun 2023 04:28:17 -0700 (PDT)
Received: from ?IPV6:2600:4040:266e:4d00::387? ([2600:4040:266e:4d00::387])
        by smtp.gmail.com with ESMTPSA id mg7-20020a056214560700b006322ce05eddsm1949480qvb.61.2023.06.25.04.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 04:28:16 -0700 (PDT)
Message-ID: <b290eac3-e07b-aa0d-593e-c9f8abed8826@gmail.com>
Date:   Sun, 25 Jun 2023 07:28:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v0 0/4] Remove obsolete Cygwin support from git-gui
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, adam@dinwoodie.org, me@yadavpratyush.com,
        johannes.schindelin@gmx.de
References: <20230624212347.179656-1-mlevedahl@gmail.com>
 <xmqq8rc8781p.fsf@gitster.g> <xmqq4jmw77sk.fsf@gitster.g>
From:   Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <xmqq4jmw77sk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 6/24/23 19:35, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> patch 1 removes the obsolete Makefile code
>>> patch 2 removes all obsolete git-gui.sh code, wrapped in is_Cygwin...
>> As it has been quite a while since I had access to any Windows box
>> or Cygwin, but the earlier two patches look obviously correct to me.
> Ehh, in an early draft, I had "I cannot comment on patches #3 and
> #4" before that "but", but I ended up commenting on them anyway, and
> ended up with such a garbled construction.  I should have copyedited
> the above to "Even though it has been ... or Cygwin, the earlier...".
>
> Sorry for the noise.

No problem, I appreciate the review. The last two patches absolutely 
need the Cygwin / G4W folks to review.


Mark

