Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27651C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 22:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbiLLWJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 17:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiLLWJu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 17:09:50 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802CD1581F
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 14:09:49 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id js9so1316355pjb.2
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 14:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3GV9GcPk3F5pYi1mzl4oCEY92TCF1JYwsF41gRbG2E=;
        b=DTH6hjapZhl8IlxtykvDZGWNQT/C4MkTamgyq0xMSoNro2rJymWjZwdsvtF3gn8CID
         moVnhVrKk7ZMxkq9/bmjoA3BPh0WswEr9HHYb6Qukewnc+OyUYhAHpnN+XsT40eXYP7Q
         ja8uyDTV+H3FGV5tzQXBD6132qZxKeeophzzO1j3gwHnDoAx3Qtfawq/qJSMYdszQ/RU
         laR6QJk8SvcwNcHoCZNG8NHFIWL72CBf9G6+dOGVi+aKJEGoxGc0CP5jR2rvQBnOSYeY
         7HMcNiYIC/dEsV/Iv59wZjhFZzMhf21i/ffpTzkDv79PXsMTWMC1mxDBgba2knrw9uMP
         PgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G3GV9GcPk3F5pYi1mzl4oCEY92TCF1JYwsF41gRbG2E=;
        b=5FXQTyPQS7YEcxNQlIB7W7lSqzcDR5uWDnsAliTXjq+V8tJCPDBFTvRVmKWG9qBlH+
         EUhIjEbOmp/QTOvL8B+1JIoAAKr0bVuaWXiZW/ViPah31TH8o/rWFc0TQ1QesF5kOLiq
         RxADG2oqumoYQb5lno/icnADuroNc253fz81COshXTgkFXJHdR6yo3I4f7MJsoRK92O5
         EEmRA0udYhWWt6f6vOMnz5T/8Z/TnJu5P8LVAMQNa4tDWzqFBmISfO2oYj3LYa/td9/+
         LaOu/M3rI+wAKt/hFJdtMEWXriW18OgRkWAwiBvUwFgy9vGtG2gqbnpQ08ucszAQyxWN
         djWw==
X-Gm-Message-State: ANoB5pkZ/QmD2R++fssfqL0BT8dlcMyOzyMWtgt/wdz2rwG0dDb3BzyB
        xBoN1ZJh1z/PJZvdGuya2Y8=
X-Google-Smtp-Source: AA0mqf6oylQxL7gH+vqxxnKMs8M/rQkziEP7Mvc7S3pqO20dAIOYlfP5LpDY8KAOrDmWHM6vXGWYxA==
X-Received: by 2002:a05:6a21:1787:b0:aa:c42:bab with SMTP id nx7-20020a056a21178700b000aa0c420babmr18503878pzb.59.1670882988892;
        Mon, 12 Dec 2022 14:09:48 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d22-20020a63fd16000000b00439c6a4e1ccsm5564397pgh.62.2022.12.12.14.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 14:09:48 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Toon Claes <toon@to1.studio>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] cat-file: quote-format name in error when using -z
References: <20221209150048.2400648-1-toon@iotcl.com>
        <20221209150048.2400648-2-toon@iotcl.com>
        <93d61412-3786-b2b3-3fe8-4574336b08fb@dunelm.org.uk>
        <xmqq5yekyvrh.fsf@gitster.g>
        <ddae1940-f58f-e410-7606-d0bcf8d06cd3@dunelm.org.uk>
        <xmqq8rjdv5um.fsf@gitster.g> <87cz8ohklt.fsf@to1.studio>
Date:   Tue, 13 Dec 2022 07:09:48 +0900
In-Reply-To: <87cz8ohklt.fsf@to1.studio> (Toon Claes's message of "Mon, 12 Dec
        2022 12:34:46 +0100")
Message-ID: <xmqq5yegs28j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Toon Claes <toon@to1.studio> writes:

> Ah thanks! I will include in the next version, when we reach a consensus
> on when or what to cquote.

I think we already have consensus on when---"-z" may benefit,
otherwise we should not quote.  I am not sure what you mean by "what
to cquote"---are there things other than input object names that may
be ambiguous and require quoting?
