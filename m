Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A13C761A6
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 16:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjCaQcM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 12:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjCaQbq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 12:31:46 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5539B22923
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 09:28:05 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id jl13so16670715qvb.10
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 09:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680280083;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntVIkKR5/D88c7LipTPKmcE6hBUHWeTs1H0MwED1dDs=;
        b=TYh1RWg7IHOqbaJnA86cmUrU6YWsLFsy5Qf7KTDBwUzB6wmK1E64WoRvMDZ77WV5pF
         tW7zbdYHQT9qFW8/ja6Pl/X9b45qPC/36NlZpz7KLi0OSHEWr8gKzumlwVYUN1daFVCj
         qx/BUwIDAVEqell1nBFLuRjn7Sf1Pu9L0Q12uumAfoW+WlhDw0DLwZAIh398ir7Uwo0G
         QXhpaFeaTolxt+9y+T8UILDYv4RAur2lgYqIlH6PG1xb/XGgqQ5K2dj10OsklWsFcbJ8
         5WSdpP15ae1eaWXj+VXOTjlsWDJ9wmNrqVaunzDsnpbyaMe2rwTaHYgnOiirpfXVyaB+
         zPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680280083;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntVIkKR5/D88c7LipTPKmcE6hBUHWeTs1H0MwED1dDs=;
        b=h2My4W22y6wEDD/aUDc2KRpQ02Sc+f12O928EGusHf+RPh3v4zIO6HBwGAamooYz95
         /TXZL01CRpbIVddbMe+HGfCyA/seFXqofJ+vGzIkN6zceCpk6XbwBKNWHUXPG3AgXSLa
         MxoiNgshOBeqgB07Gl3CxPFcwwLM98vwoUfjwHeybk3cr1J10yQEh3bqxDYxe06TShhb
         Qt2OqZVVVZi2IgZ/cXGk9J85rwQHI0on3g6K8aWI7wTIWZo5Sgaulh+pHJLbP5MFxLp/
         yjPWoqEeiLOypdPnH2GpnvlkyORtdLOzaTzCSr1brmLeGfUWjXl8tA1SgXIO+oOzQKRF
         kp4w==
X-Gm-Message-State: AAQBX9d3g+Yxc60GdVaNQHMKcH+1y3LtKqs1NYVTBIXfvnGvN8vMaSh5
        rRRnGUaWs8RqfmMVi9+ztdJHoAqA8so=
X-Google-Smtp-Source: AKy350b+AWhKdSuswVi1z40y97gn5Hzv4Hoz2lu2Amn6Dv+EQZJzfdiCXkTxpBUqxMgyKY19bbYv9A==
X-Received: by 2002:a62:19d8:0:b0:622:9e34:11f1 with SMTP id 207-20020a6219d8000000b006229e3411f1mr25321912pfz.17.1680279546029;
        Fri, 31 Mar 2023 09:19:06 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id u4-20020a62ed04000000b005a84ef49c63sm1968937pfh.214.2023.03.31.09.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 09:19:05 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] ref-filter: remove unused ref_format member
References: <xmqqjzyy2rdl.fsf@gitster.g>
        <20230331103708.18945-1-oystwa@gmail.com>
Date:   Fri, 31 Mar 2023 09:19:05 -0700
Message-ID: <xmqq4jq0hp1i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Øystein Walle <oystwa@gmail.com> writes:

> The follow-up series you link to seems to be a superset of the first series,
> which is what confused me. This is why I thought perhaps a subset of the latter
> series was accepted. But I see now that the dates match that of the first
> series, and you even applied it very soon after. Strange choice to include the
> first five patches in the follow-up series, then...

It probably happened because even by then the previous round v4 was
not in 'next' when the later iteration was prepared, and then the
topic perhaps died at around the time GSoC of the year finished.  As
long as the earlier and less ambitious attempt turns out to give us
a net positive benefit, these early steps may still advance through
'next' and down to a release.
