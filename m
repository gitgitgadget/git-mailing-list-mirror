Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD49AC433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 13:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbiADNaE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 08:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbiADNaD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 08:30:03 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F1CC061784
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 05:30:02 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so3135351pji.3
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 05:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qGKExv8xI+YwIPghSFpDjv1fko6i6xoDezRKE6CrG+0=;
        b=CHLMz4cCe61hsx4v4Aeqe0EmIInm1W6E7xmurAvGGRSDmAr4ze2I/UahG1Kx+ZSxW4
         P3Gk4d4kmJbyXQ1oEbgnsGMCrKWE7ulZDBcpflp01hkZX+xzdj8jIrpruwwxa4WRvjba
         gtIZQ5KDh3T8dj2E54f2eEz1CqAph0EEto2mZvw3qPK/KXyOBh3Wzv6sy9jhAGBJWX5T
         69j2krp7a9R8f9CXNWInrNAyu9lwNHvhCEoNTUsuvMYp78gqpLeisujCvhuwPaM9YAXk
         v1U5ngxj30CL++g0UexkxnE9uA6E1xgqpwMYXuWZqwxdue0U4yp5z5CK0UV85b5urqtv
         IaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qGKExv8xI+YwIPghSFpDjv1fko6i6xoDezRKE6CrG+0=;
        b=RC+8NytpqaLnCaEr1iPeHuM196kB37eg7BIrDmnMX1U+OxeGmdYyIFpU3SQe1nTChM
         ba+pq2Ww7eplqxhXaUl73w2Ca3MAcY9DMrVsUL9ueYR2+aKJTWXpTpRKhV3cjlf9/U7i
         7vN1OOiHNEoW487yPIgn51nQbHOdGBmIBgSIQSJonpOPph5BjN0ZI6N5RjX8Z6i/VL8w
         vn8rSmbo4Wa/KPfo4l//SjXccvnHS4jmhJ4CP2BBfkvyUlN/PMtwqL69ZdcmzPFXseED
         QNIb6/iVGbFR/9yNw0UbAtUUhiMqUbuRuIVEE+ocK3PwDMMWfga790gotFhn/OFLXhJk
         roww==
X-Gm-Message-State: AOAM532WDiOm2lxYNPujHs/7OwiOneCvZLdBu9myAaJZ5lK42OXEnJZy
        pDL2zW5QmJ8VdmCF5IstYdBEQild7j8=
X-Google-Smtp-Source: ABdhPJwUGNT/IAIP8rCek/3a0fHPW7LTGEZSe0lMG1IiY3lg0trsq/Xh3aNCQN7DtRXLO36P0Mkw7w==
X-Received: by 2002:a17:902:6906:b0:149:7087:355c with SMTP id j6-20020a170902690600b001497087355cmr41434530plk.153.1641303002036;
        Tue, 04 Jan 2022 05:30:02 -0800 (PST)
Received: from LAPTOP-FJDAS7G4.localdomain ([157.40.90.253])
        by smtp.gmail.com with ESMTPSA id q4sm14313568pfj.84.2022.01.04.05.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 05:30:01 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 1/1] push: make 'set-upstream' have dafault arguments
Date:   Tue,  4 Jan 2022 18:58:39 +0530
Message-Id: <20220104132839.1209-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <xmqqy23wduxp.fsf@gitster.g>
References: <xmqqy23wduxp.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> That means if the user says push.default==nothing, we should error
> out "git push -u" as before, but that is not what the change to
> setup_default_push_refspecs() function does, is it?

Yeah. You're right. The current change does not throw error for
push.default=nothing. Because I thought that for all values of
`push.default` (except matching), 'git push -u' should create a
new branch with the same name as the current local branch. Now, It
seems that I was wrong.

> So, I am not sure if many of the above changes are sensible.  The
> first one certainly does not sound like sensible.

Actually, I didn't think deeply while commiting the changes. Today,
I think about it deeply and I realized the following points.

* if push.default='simple' or unspecified then it should not create
  a new branch on the remote. So, my proposed change of 'git push -u'
  for push.default='simple' is badly affecting the reason why
  push.default='simple' was built for.

* if push.default='nothing', It should throw error if no <refspec> is
  provided. Again, my proposed change is hurting it.

* For push.default=upstream, If an upstream is already defined then
  'git push -u' should only set that branch as the upstream of the
  local branch. This already works in git. But if an upstream is not
  provied, it should throw error. So, I am not sure whether 'git push
  -u' (with no upstream information) should create a new branch with
  the same name or not. What do you think about that?

* For push.default=matching, 'git push -u' should set all the existing
  matching branches as upstream of their respective matching local
  branches. It also already works. Same for 'push.default'=current also.

So, to put all in a nutshell, I think that the current behaviour of
'git push -u' is okay. It also seems that he/she who built the
setup_default_push_refspecs() was aware of this.

Sorry for the patch request and thanks for reviewing.

> Doesn't $i show in the output as-is here?  Quote the test title in
> double-quotes, while using single-qoutes around the test body.

Yeah. I observed this while testing. But had no idea why this happend
( as I am very beginner in shell scripting). I was waiting for the review
comment for it.

Thanks again for reviewing my patch request.
