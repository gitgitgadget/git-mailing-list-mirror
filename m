Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B687C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4842E2087D
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598543735;
	bh=duulDI+GaHieaWVmoXsugjjfvc9qU+xBfRofLKzQUHI=;
	h=Date:From:To:Subject:List-ID:From;
	b=mlJJDOWUdS4EJaA31nSqL+y0rLnhTSpkOj9otZMUBUuSMhZs9e1ywTh7z69dyS7X4
	 D7mwRU473vpy6RLNAs0LlvCHLkB0Pz2sqzkWMYJ1OhZLXYV404VwOCTeiW/AVdcaIL
	 3RR9/g1cOkFwZ+sCCVhyCb0sGxayBNhpf0dRt4Ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgH0Pze (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgH0Pzd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 11:55:33 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB4EC061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 08:55:33 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id o2so2821849qvk.6
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 08:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=Cixj2Bnlr+FCgGlpmaAuOPSHIL5bFBWb0PxebL+DGNk=;
        b=KJ8updw+60PndwZyTF33nTz5G97kYDsRHg/yoUvZw4RlorA9UStWtSjkWRbSdxAHxd
         iLGUq+SFdlv5z18MwVeqtdzj2Us6yCFQU+JTj4CijJIX0SuDGmP6/jd7HfOF1445geqN
         xmTlRQoozuHPreotaOJ1TVZkU/GTok0eWX9nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition;
        bh=Cixj2Bnlr+FCgGlpmaAuOPSHIL5bFBWb0PxebL+DGNk=;
        b=DJptORPzxueLoUX0yT0frQ7faUbyTQgMBkgekIpwfbcWzjXqL7ygvUZZd7ZeIrZaDp
         L1lqrzEdGcFh8DX9kw8DLrtiEm3XZYJCKvyZ1qRh6X5zCDcaVzKku6IfbinvcO5FjCph
         e8Ji44g3cVZR8o9ChIogHepUPFx3mtLikbV9giQQ0aueaX82Ag2wJM6Ljx0GsyND6qhC
         cTgsHMBYB2kEYTU6eRTfcTIPpuyYgzFXZmNSjkL6ROhHu/5tAwJzqNx5Dcdl3+qT+5S9
         H/ybXqGCQUs3TM/Sry+UV5Jp53fG1O5kn2fb6sE+aGN9iRbEwhrhrMpHFIJ42UXq6XbI
         t2xg==
X-Gm-Message-State: AOAM531PHyVzpF9oKQvdGB8t8YxWlSBEZbe3Q7rK1K2cuY1qOFFqK9Ax
        rWSo+agHTz+jEFd4lGLMVi6TPz50+f1hi3K1
X-Google-Smtp-Source: ABdhPJxhr1QbTtQPV9QHmy2wNSFncchnmapP2qSvFDZJ3dO1eOW10rWKAxpXqWM6iIXVyeMFSP8BTw==
X-Received: by 2002:ad4:46e7:: with SMTP id h7mr18854149qvw.153.1598543731927;
        Thu, 27 Aug 2020 08:55:31 -0700 (PDT)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id x29sm1960681qtv.80.2020.08.27.08.55.31
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 08:55:31 -0700 (PDT)
Date:   Thu, 27 Aug 2020 11:55:29 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Subject: Cleaning up files reported by size-garbage
Message-ID: <20200827155529.3vtmrec7nn3mqgpl@chatter.i7.local>
Mail-Followup-To: git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello:

Running git count-objects -v reports garbage files:

$ git count-objects -v
warning: garbage found: ./objects/pack/tmp_pack_XSv8MO
warning: garbage found: ./objects/pack/tmp_pack_2uOuMg
warning: garbage found: ./objects/pack/tmp_pack_KzP1ja
count: 19
size: 84
in-pack: 172456
packs: 6
size-pack: 63907
prune-packable: 0
garbage: 3
size-garbage: 1911

Is there a way to tell git to clean those up? I'm not finding anything 
and would rather avoid having to parse stderr in these cases.

Best,
-K
