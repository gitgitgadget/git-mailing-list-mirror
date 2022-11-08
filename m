Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCE6C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 06:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbiKHGcj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 01:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiKHGci (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 01:32:38 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB954183B7
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 22:32:36 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id q71so12566597pgq.8
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 22:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCyev1T9FxZHQU0IEpzLO3loYplZLt2/YTdPT+WpDzQ=;
        b=bcatHbNcreQ4F8avV8dtkSBXgjX/oNUqKAU52xA6P76hMh7MR8+Kx4DnChyAcnmYrp
         IqtZc30UtatwvAOyt1IFcpaRSimMfDWHYh0lD5bykOiL9MJ6uUUP+XAsVvIvCF/CF1ai
         IsmvvZ7uJLgTMefA/CR+MDWqPJcxmuDSAsXR94cAxmwMrQrst5a/5eR+cNUgDGnWxyA0
         QCC0n8RIW0jKAjl2RfO6MeyCBFg+p4tBkruG2Mrc5i49zQU7OdTwxRvqH7jsTE8T4/oK
         KDbzxH+KI1r+XkW7nwgrVgnPmYTMW3WIZ5lt9ze66HYvuEtl2RQM4sDTPYiwKldlc8mm
         bzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCyev1T9FxZHQU0IEpzLO3loYplZLt2/YTdPT+WpDzQ=;
        b=KAa1ATXELTCCxV8thDLdi5Jpqpk0W0GPjKyG5CxIXyihjtEz12P50p/BdWlaTliP2t
         LsVYs3uUnXOMKUZ1+uRqHciV5Uhp7K3yxNwpP23/qpPClF/In7txifUDnFWSd6HfLqHq
         iAHcijxZfGDMgnTWT3o3zryCdHQ5FjhPB635VOeu+FGkfRpyWZEzsLJVIL6R/CqEMN/3
         Efwq6XXZDiEnYAhmuy0x1NVoUDZJNjBX6apQcUi24XvQKO7DtB/1wYjL2woa0qzw20o7
         5XMg1Z+tq+4pXF0WVBZ/8bj3OAFMzt4GUlUO0dlP77LBRnv1UckSUbE+NHdygvCKhI6D
         8Q9Q==
X-Gm-Message-State: ACrzQf1UyraPDRl6ptxiSnCdOG++Sfy0A5zz5+7nxNZBWmGVwNf3izzy
        S3eXCSVNYXNGK+eCPAo3XOyUWQaBXta46InN
X-Google-Smtp-Source: AMsMyM5tX2jubCXsolp/IfAuOByxEDiKZv7ewBiKa/QuRrkI1YNLdL2mw/+4cgLP1URTzocKd9jAeA==
X-Received: by 2002:a05:6a00:810:b0:56c:df84:1b2d with SMTP id m16-20020a056a00081000b0056cdf841b2dmr55087631pfk.66.1667889156190;
        Mon, 07 Nov 2022 22:32:36 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.50])
        by smtp.gmail.com with ESMTPSA id 20-20020a621914000000b00563ce1905f4sm5570711pfz.5.2022.11.07.22.32.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Nov 2022 22:32:35 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     avarab@gmail.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 1/3] notes.c: introduce "--blank-line" option
Date:   Tue,  8 Nov 2022 14:32:29 +0800
Message-Id: <20221108063229.13392-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.384.g2475ea0c04d
In-Reply-To: <221107.86v8nqvlla.gmgdl@evledraar.gmail.com>
References: <221107.86v8nqvlla.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ævar Arnfjörð Bjarmason" <avarab@gmail.com> writes:

> I think the right thin to do is to just drop the strbuf_grow() here
> altogether, since strbuf_insert() will handle it for us, but that would
> make sense before this change, so maybe in pre-cleanup?

Sorry for ignoring this line of code. I think you are right, and I will
make a separate pre-cleanup commit for this in next round.

Thanks.
