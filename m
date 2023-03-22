Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C968FC6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 11:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjCVLDd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 07:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjCVLDb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 07:03:31 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B7129159
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 04:03:23 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eg48so71014754edb.13
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 04:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679483002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erOlIZ0LZHKCav7mGsgO9k1BZ//yiN1h++FBNjmlTcs=;
        b=h9yXDAT+Jo28rSSvNT4ZbCxk+yGWgag/XK91Jl1jqGxmSRGlsaAh80O1sCoPZkzSaT
         sBi2GrFeRd3sQKuyZcR30xkNVAp1WKqzIvJGkLF9M3XX2WnGn8yTuYlyo//6IiamF4Dg
         U986Sgw3XgyeIbkFtC6yEllAzyquR4Zn/IcfMstpyNzOFzbuSjHjH1He3JO698ZfzOA6
         UwYocFzcOtnkLAtE00ebj3FmmEmZELgVd1SfI0QYAGgLtKY0wY8Pqozr+Gulg8CcBhLT
         IglhYiYHEoG5aPxWFj0EbOODdhLbt19ukMnBr6BBagF+oeNNM6JmS5492eiMzhCTodXq
         KAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679483002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=erOlIZ0LZHKCav7mGsgO9k1BZ//yiN1h++FBNjmlTcs=;
        b=dJT3YIIkTdUETLnH+52RBYuwcWrckXd9B+Tp33gTKWbPO5nl7LWn9UB28tOpHFayHp
         W9W5HJNmbQXIF3Rz1wPtwfTzr4XmNVPMX0jI7Nkde92xPLrmlC8DG9aD8pvKzMi12enu
         ypb2F+q53IjEdYofQvwO+tVMKcwrPvirn71MxBy9rcfkqYwlTPt5Gb7l+fbJzZbTdKqO
         wHBZ5Ylz45n535Nwj7TjKJf6KpJO6R9xnPALfeyUuU/cPd9mg+KMrikttELbBb0QJWPy
         nLFcH6Qr/4CUoQqu3rbpwoWextKpU7sDxy8CC+faxRklLUhkaSeWBEdODuq04J6Wr8zU
         CEuA==
X-Gm-Message-State: AO0yUKWfhfnMugn6w+WsAloKME+0orAnn9aKRb3UJ/Agkmscv6z8cUB/
        xPr3BgW4SVn+MuN2BMBhSA0=
X-Google-Smtp-Source: AK7set8uaJ0TkXpc3S7dWfRQtFePUS/zUGbDWy2FkP77xyagxAajwrynLGQhZAVrZBpanG02esQhpw==
X-Received: by 2002:a17:906:26c4:b0:92b:4f8e:dddb with SMTP id u4-20020a17090626c400b0092b4f8edddbmr7313325ejc.34.1679483001965;
        Wed, 22 Mar 2023 04:03:21 -0700 (PDT)
Received: from localhost.localdomain (adsl-178-39-131-155.adslplus.ch. [178.39.131.155])
        by smtp.gmail.com with ESMTPSA id gt6-20020a170906f20600b0092a3b199db8sm6912201ejb.186.2023.03.22.04.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 04:03:21 -0700 (PDT)
From:   Ridil culous <reallyridilculous@gmail.com>
To:     rsbecker@nexbridge.com
Cc:     git@vger.kernel.org, reallyridilculous@gmail.com
Subject: Re: Feature Request: Allow to stash push and pop file modification times to avoid rebuilds
Date:   Wed, 22 Mar 2023 12:03:09 +0100
Message-Id: <20230322110309.760-1-reallyridilculous@gmail.com>
X-Mailer: git-send-email 2.40.0.windows.1
In-Reply-To: <000a01d95c38$0acfba10$206f2e30$@nexbridge.com>
References: <000a01d95c38$0acfba10$206f2e30$@nexbridge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I encounter this use case many times a day and believe build consistency wo=
uldn't be screwed for it:=0D
=0D
- There's an existing build based on committed and uncommitted changes=0D
- stash push the uncommitted changes=0D
- rebase or pull=0D
- stash pop the changes and only restore filedates for files without merges=
; set the current timestamp for all others=0D
- build again=0D
=0D
Sometimes i save and manually restore filedates from headers which are part=
 of a precompiled header to save a quarter of an hour build time if it's no=
t too many files.=0D
I woulnd't need this if git rebase would not refuse to rebase when there ar=
e unstaged changes like git pull does.=0D
Am i doing it wrong and there's an easier way to avoid this problem when us=
ing rebase?=0D
