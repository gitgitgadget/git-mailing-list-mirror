Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FA8C77B7A
	for <git@archiver.kernel.org>; Sun, 11 Jun 2023 15:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjFKPPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 11:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjFKPPD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 11:15:03 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDD319A
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 08:15:02 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-62de0ed7462so5536006d6.1
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 08:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686496501; x=1689088501;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZDi1GVyJgGRdOe5YOG80/O+FRp3WxjlEWAgnQkrvqA=;
        b=bgyl16ooWUZP4BmuAvypx++ajU6XhgDeQAfpncfJ53TNc0xATBstNl0kOGw9Pu+QLX
         u9u6BA5vFXvWhGvKOYaHI6tmxzFYtaGZzKQe8Ek5Q7KrwF8zRBMA+jM1PwptkeCBqBeD
         fPt2iCMlkC/1e11QpHwe9ea8lqhQYDgUgDd2Bw8/PnMmXZ/Ypf39bmwHyft28ovNBAjF
         qgxi5v+NpckkrYEyyH4unJ/g7XhzsYJF04FhMyJV7XImssF9SeuJTn9ydAPAx4zhZ1Og
         GU1ShSy7L/1/DiLdViApw0ZYINEBjMlsKUWTkozfRctx1I7S1EJCn52Lbe3ebJUV4JCe
         XIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686496501; x=1689088501;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZDi1GVyJgGRdOe5YOG80/O+FRp3WxjlEWAgnQkrvqA=;
        b=Nz5fvRzzqpqwsHdSdNQYByu5AWrZkjNH96Y2O0Y2QYJiRzs51EOkZRZWZQITgo4dIg
         cEQP4bwpyA0ms0L0R7AjXwfw+8utdV1W+BQTXjGgtfv7DnfxBmdWunIe+BYz/Qh/iN5A
         qaEj8oo1rdmSQ+0BPRuATInA8hcXq80hDL8YSbg4JR/gkYfRtAS6AzK7MCLOpXp5VBV7
         iFuKX597QQJEiLjCBvaiC6iOPn7MDXuUMJOaOOcA4RUYQtd+Bi+VIM+eqrammkcriZyT
         v7JG3Aze7nOEV/mQIHnYRZ4woa3vtuc4RL07s6CvBjGO5xukAeNxtf7bje1CI6XzC/7L
         HbHQ==
X-Gm-Message-State: AC+VfDywjKnIDYIfsisd+jFkrjdmfiXfRoLNC1TczbOUR+Gk9m45ypMd
        XapxmIVtTbcei9wVKmh6EgzZuFeT2ug=
X-Google-Smtp-Source: ACHHUZ7AiGdihk4Zdw6KzyS6IRQKOIdUKoqCzxHc/11JkMUfe5QN9eB8TTMVnmSr+rVtfuNIL9gseg==
X-Received: by 2002:a05:6214:5009:b0:62d:eb51:b783 with SMTP id jo9-20020a056214500900b0062deb51b783mr861923qvb.26.1686496501504;
        Sun, 11 Jun 2023 08:15:01 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id o20-20020a0cf4d4000000b0061b63237be3sm2560281qvm.131.2023.06.11.08.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 08:15:01 -0700 (PDT)
Subject: Re: What's cooking in git.git (Jun 2023, #02; Tue, 6)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq5y814aw8.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <5cd3a92c-0f7c-5bf5-7706-753ad00441d2@gmail.com>
Date:   Sun, 11 Jun 2023 11:15:00 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq5y814aw8.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2023-06-05 à 21:50, Junio C Hamano a écrit :
> * pb/complete-and-document-auto-merge-and-friends (2023-05-23) 6 commits
>  - completion: complete AUTO_MERGE
>  - Documentation: document AUTO_MERGE
>  - git-merge.txt: modernize word choice in "True merge" section
>  - completion: complete REVERT_HEAD and BISECT_HEAD
>  - revisions.txt: document more special refs
>  - revisions.txt: use description list for special refs
> 
>  Document more pseudo-refs and teach the command line completion
>  machinery to complete AUTO_MERGE.
> 
>  Kicked back to 'seen' and replaced.
>  Needs review/ack.
>  source: <pull.1515.v2.git.1684783741.gitgitgadget@gmail.com>

Elijah reviewed the new version in [1], to which you responded in [2].
So from what I understand we are just waiting for 'next' to be rebuilt,
not for additional reviews, right?

Thanks,
Philippe.

[1] CABPp-BH+vT_dEKUwn1M2D-FuCtF=hRM8OAFj9m1x6rkV97oEDA@mail.gmail.com/
[2] https://lore.kernel.org/git/xmqqwn0nab9n.fsf@gitster.g/
