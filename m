Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEBAC05027
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 17:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjBCRaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 12:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbjBCRaN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 12:30:13 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB29A6424
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 09:30:11 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id jh15so5925242plb.8
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 09:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcAyryaMs9am6RSf4fsd0jjVoEeZkpHw63TaJXWqiM4=;
        b=aUeC6CMVj2HQ3TjhFd0M3q5Rb2o8fDHmWiDV6dQWFz9aYVA/kyHGmk14LX5aIjSAYM
         ypv6qIqTXROx0jiQNGqPkMFYRrKvCCql+PA6xvP6u0e6JNFAI7dYG989MgolMtlz9L06
         XafV59CB0Ks5RLAbJkfgZzWuA3LEqryK55ioMMnyLG0Q3RkA40Dld3hdWvScKVilbYbK
         dZLCYeBZY8W5qu0NeeORwtzXzEqfyuytL5VSLkBpeST2eNt8jUzMmMModAxy4G/Jc1qd
         AAGDb+otTmje0ujSkNJXMcJB46EjAUEpIpu25aoM2hC8CJJotlZqdgvZHwqwhQ7hMW9C
         Ccbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcAyryaMs9am6RSf4fsd0jjVoEeZkpHw63TaJXWqiM4=;
        b=LI0B8Nzf2DQlV2lik5kvJaQq33uO0aMTvgX9zZuA9iZQGsUMe5mNAbqpzgNe8ZCcWb
         HxC3OeL/85LtnMOhC/cY491lLTJkX4N4EEPXnkl4500xCtKdFV7yJeblJuIviEbRr8Zx
         3j1rTQWXg6Ra6agbeCMAlJSJCzKSfOCE4Ww+jsRqxZBVL1pOlbHxE1Nu8pr0+kDQjJrl
         TRsVf62TjRRyll1ExHh4l83TfEnH2HqzH4ooNif3B4vGk/0X36UA0TTIIULUEv66vstL
         bIMrnG7nigTiOfrz3/sEG1GdCggaUvGCXfoOaN3NtVZ6PwM+Q5JecgQxXot0F4u73vVU
         0voA==
X-Gm-Message-State: AO0yUKWER/jS+9A9q2IfUiJDxWvYJo93BW8INHVotuioZnQ2sVRkDTmS
        87jxKH8aT6p+fmW7zLImTLs=
X-Google-Smtp-Source: AK7set+RiIqoYP0SmA+v8ZFNpeYQqfyamPJuqkuGIV+Kd48JFqbYe/BOChmSJx8Xx409et6oLU6//w==
X-Received: by 2002:a17:902:e305:b0:192:50cd:97e2 with SMTP id q5-20020a170902e30500b0019250cd97e2mr8967872plc.26.1675445411263;
        Fri, 03 Feb 2023 09:30:11 -0800 (PST)
Received: from fivlite-virtual-machine.localdomain ([49.37.146.182])
        by smtp.gmail.com with ESMTPSA id k23-20020a170902761700b00188ea79fae0sm1883057pll.48.2023.02.03.09.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:30:10 -0800 (PST)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     gitster@pobox.com
Cc:     five231003@gmail.com, git@vger.kernel.org
Subject: Re: [GSoC][PATCH] merge: use reverse_commit_list() for list reversal
Date:   Fri,  3 Feb 2023 23:00:06 +0530
Message-Id: <20230203173006.123249-1-five231003@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <xmqq1qn7sm49.fsf@gitster.g>
References: <xmqq1qn7sm49.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I submitted the patch, I didn't realize that reverse_commit_list() helper
function had such behavior. It was very different from what I had expected.
Maybe I should have been more careful and looked into the details before
submitting the patch.

Thanks for your explanation, it was valuable. Especially on the part where you
explained about the try_merge_strategy() function, it helped me gain more
insight on the whole situation. Sorry for this patch, I will be more careful next time.

P.S. Please ignore the empty email, it was me trying to figure out git-send-email
and how could to reply to specific lines of the email by referencing them. The
email got sent by accident.
