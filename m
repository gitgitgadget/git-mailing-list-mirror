Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6785C54EE9
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 18:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiIMSis (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 14:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiIMSiR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 14:38:17 -0400
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DFE659F4
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 11:03:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1663092231; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=R3Ouv1s3cstw23C8VTIRVp22ELzz0cwNd5Lh9rp6sQPe7yXubD2nH41gNCP+oreiXU/lq0GgfTTtTcdX2oFoyeZIH2q+AGwBLC5gLQquC9kvrIWsTggQY6ev2KoNL3SJXmyQsdmRWbEYofLkZOj6zE/QcGfi54LasukHIY2DXjA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1663092231; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=r3JbfV9UQvkc3jziKt490JLxzHOcTbsd7dwEmLzuJzc=; 
        b=W+svQ3wp20AgmDp2asL4dObSkC33Xa8X6e1uUK4o8Pso8M9RU4sQktWeHT542vxT2vzsojKZhLdnk11usrKFYmq3ZD0gh6U04oaKFWR97dxDyVJHT+JMqxbaXwOfeaEJFnkORLAVMmNvMb5frmHH8pm3yJOD2jZyfhOoW+y10So=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=business@elijahpepe.com;
        dmarc=pass header.from=<business@elijahpepe.com>
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1663092229142258.62982715368844; Tue, 13 Sep 2022 11:03:49 -0700 (PDT)
Date:   Tue, 13 Sep 2022 11:03:49 -0700
From:   Elijah Conners <business@elijahpepe.com>
To:     "Han-Wen Nienhuys" <hanwen@google.com>
Cc:     "Junio C Hamano" <gitster@pobox.com>, "git" <git@vger.kernel.org>
Message-ID: <18338058407.117ce7158612837.8515739237320978792@elijahpepe.com>
In-Reply-To: <CAFQ2z_OR8uLe3rs0r09a3fvSQUE2H4WQTquddUwEeahoiRWimA@mail.gmail.com>
References: <183353220fe.d7826593472673.3445243727369286065@elijahpepe.com>
 <xmqqbkrjb75g.fsf@gitster.g> <18337ea407a.10c144c52599576.4708941661785569426@elijahpepe.com> <CAFQ2z_OR8uLe3rs0r09a3fvSQUE2H4WQTquddUwEeahoiRWimA@mail.gmail.com>
Subject: Re: [PATCH] reftable: pass pq_entry by address
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:
 > it might be a bit slower, but "dangerous"? How so?
In this context, dangerous is the wrong word, but in some cases large objects on the stack can cause stack overflows. In this case, slower is the right word here.
