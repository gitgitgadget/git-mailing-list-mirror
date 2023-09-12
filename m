Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCE8EE3F31
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 21:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbjILVN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 17:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjILVN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 17:13:56 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A4510CA
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 14:13:52 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4124e1909edso38096971cf.1
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 14:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694553231; x=1695158031; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hjatRwNDS/6C2t2zrpFtLT4+tOnakJzIYB+SoMzUQFY=;
        b=XR/P5VKxWGcIP4mv9HRThVzhfVD0WHqKrBZtpY1LUCXLyKQpcPsTI9trEpdOqsolv7
         oRSufMSDFxJwi425UIFNKQsQdfdQ6jHKE7WqmcDTffjU36Bwftaobkwf9kfjugsepga2
         tI1i2a3cqloZOtX/CsEP1AOf1bv3vmTjDvPMTK3eLB2b/wyYxR3CAOprb7RKfEvkXAgT
         Pvy9kZ7WUmL+TFtK1GLo4pjsNLbz0zVH4xLF1gJDx+RiTgHxtnfzYBf6rzbGAmlAVhiu
         n9jfh8nqPbvhu+5FVHSPI2WKc2/2YHHm4GhgPVPTc9PoRzEW9QZ4BFOwx1nLdzuWj9qu
         2zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694553231; x=1695158031;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjatRwNDS/6C2t2zrpFtLT4+tOnakJzIYB+SoMzUQFY=;
        b=beG5p6UlXU/r6B18qZ/pwZnaZ5k8DQEoVPDy2+TNz/A3MJAtrY3N3XHV7YzjZu5/2c
         vZ3EXlU2M53ai0y2MHmCtFbEAfwqo4hQwvbsWHIIABGS5XRsmP67X6MLhM3JP1dEbUAt
         8cR3Iy7n6oeOvL4MM/uOOHCP4MLboI/8zGM1NYLOAn1rfKIHt9Ezet9BeUTB2V6DdGfr
         DBrkHRjOBsAo6BVIeGWQ+rWTiIse8Va4lQ71/vqLzBojeaAtITeZuQdQ8hhc1UXtnyq6
         deFZxnl2mmExOgJJthBo/kE+JuYXcVJQoa2pOyjSaE8aU5zjVi3UgyyqAvuUikMQOGNN
         bDEA==
X-Gm-Message-State: AOJu0YzhYKmiQqF0UdvzeGFqOVB3Z4ubk/BUK6cjfSAd0KeuxZVmY8UD
        QFzzgWdivkZBB143rqlHOF8Ng/B/fBE=
X-Google-Smtp-Source: AGHT+IHtcpU9udSnmyqvpEIGdeAEsbsEDWu5+/jQ9hPPtBptEb23XUoA45vlDTwFcEwsdztQ3UMJCQ==
X-Received: by 2002:a05:622a:284:b0:3ff:c677:a033 with SMTP id z4-20020a05622a028400b003ffc677a033mr498168qtw.29.1694553231074;
        Tue, 12 Sep 2023 14:13:51 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:e8c7:b4dd:4c10:38bd:37d5? ([2606:6d00:15:e8c7:b4dd:4c10:38bd:37d5])
        by smtp.gmail.com with ESMTPSA id a20-20020ac84d94000000b0040ff121e011sm3572268qtw.2.2023.09.12.14.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 14:13:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: What's cooking in git.git (Sep 2023, #04; Tue, 12)
Date:   Tue, 12 Sep 2023 17:13:49 -0400
Message-Id: <1B0BBA4A-7060-430E-A9ED-04470D9502DE@gmail.com>
References: <xmqq34zjnqi8.fsf@gitster.g>
Cc:     git@vger.kernel.org
In-Reply-To: <xmqq34zjnqi8.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (17C54)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> Le 12 sept. 2023 =C3=A0 15:25, Junio C Hamano <gitster@pobox.com> a =C3=A9=
crit :
>=20
>>> * pb/complete-commit-trailers (2023-09-07) 1 commit
>>>  (merged to 'next' on 2023-09-08 at 842587016d)
>>> + completion: commit: complete configured trailer tokens
>>>=20
>>> The command-line complation support (in contrib/) learned to
>>> complete "git commit --trailer=3D" for possible trailer keys.
>>>=20
>>> Will merge to 'master'.
>>> source: <pull.1583.git.1694108551683.gitgitgadget@gmail.com>
>>>=20
>>=20
>> I've incorporate Martin's suggestions so let's wait to merge my v2=20
>> instead:
>> <pull.1583.v2.git.1694539827.gitgitgadget@gmail.com>
>=20
> It is too late for a replacement v2 once it is in 'next', though.

Yes of course, this v2 has a second commit on top of top of v1 since v1 was a=
lready in next. Maybe my wording was unclear ?=20
Or do you prefer a new thread for such fix ups ?

Thanks,
Philippe.=20=
