Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF6EE75458
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 17:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjJCR74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 13:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjJCR74 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 13:59:56 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE30A8E
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 10:59:50 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5042bfb4fe9so1441189e87.1
        for <git@vger.kernel.org>; Tue, 03 Oct 2023 10:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696355989; x=1696960789; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HrKjZVJDxWbJYfdq88/aPAcxVhD/bZnulhf4svRHIIg=;
        b=jHKUch3K0BYHufDABxyLehPcK7P8yzM388LRun/EcUKSHIj7JOJcSYHN2vfzNg/Z/S
         ZQG0Xtn57esNp72RXNXTRt9SrJtczCH06Bczz9pswyC/yWmlqvCo0iEBB04u8sfthIS8
         nBtD3MZOS3Bw0orxHGDIlXzOmzbU+RdZxgka8yCAdTK+KjbSNRECEsihcxisCcMXwqTb
         waUgHlrp4dLxPjFzqmr+1YYBQk8yv+BWthcTlftkSAGwglE9XC6Oda+Qpya4kSPYE441
         QtwjXoe1Iu+dF0TsrCwx4chdsSRmdNusCilocI45jzoTq6gw2I5ZVgVgoStQT8ZUfGR1
         enxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696355989; x=1696960789;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrKjZVJDxWbJYfdq88/aPAcxVhD/bZnulhf4svRHIIg=;
        b=XVnJltdmj3eGKmksGEidqPJ35LcKfYUV8BigCAaohDnOP00d+fs90b3i//0mM6CJSP
         ZO1OPkamKW9rxdAKrIs6aK9d5MBLGPo+RAgmShv/2INpczpvmD0sWkIEDKdgUnNcCBXI
         Oz8FX9R5i0mT/Scn4VfgffoAaRGir2WVgWJ9ASh2cLqcu/relT3gXUVcWLEcihUiUh/E
         5tOUyzUQfLaeaeY8aIGRpzzieB7d8SnoDkrP1/k+l03ZbVqg4tMgQOs9FXxpikEvImgu
         v28StvEkP9j6TEKXRBE3nfUHNvkQ3ZURnjwdJrtiIdTiuWProh1g5KaoWFBW7A71KA4v
         Lrog==
X-Gm-Message-State: AOJu0YxaPsEWnMXan46QXXvA/ALbzXEgo1D6Mtnc3nDk4mxZRV4wuE20
        wnp4fJ9Y9KtKNho0wb6iUK5o4dLyjbw=
X-Google-Smtp-Source: AGHT+IE488jtqghu2p/vPi+L0xm4KVh3FDPd4nSf9ha9O82s5WmducC6lq5mGQNxOWWK8HkzF5Y4jA==
X-Received: by 2002:a05:6512:32cb:b0:500:9a67:d40e with SMTP id f11-20020a05651232cb00b005009a67d40emr16052273lfg.60.1696355988332;
        Tue, 03 Oct 2023 10:59:48 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id x5-20020ac24885000000b005030c533843sm269489lfc.154.2023.10.03.10.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 10:59:47 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2023, #01; Mon, 2)
References: <xmqqedic35u4.fsf@gitster.g> <871qecgpg1.fsf@osv.gnss.ru>
        <xmqq34yr3btn.fsf@gitster.g>
Date:   Tue, 03 Oct 2023 20:59:46 +0300
In-Reply-To: <xmqq34yr3btn.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        03 Oct 2023 09:33:40 -0700")
Message-ID: <874jj7lh7x.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> I believe I've addressed this in details in my reply here:
>> <87o7hok8dx.fsf@osv.gnss.ru>, and got no further objections from you
>> since then, so I figure I'd ask to finally let the patch in.
>
> You need to know that no response does not mean no objection.  You
> repeated why the less useful combination is what you want, but that
> does not mean the combination deserves to squat on short-and-sweet
> 'd' and prevent others from coming up with a better use for it.

Yep, but I've asked what's better use for -d than "get me diff"? Do you
really have an idea?

Thanks,
-- Sergey Organov
