Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FBDC4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 22:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiK3WXd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 17:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiK3WXb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 17:23:31 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1332FC0E
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 14:23:30 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id a9so2049244pld.7
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 14:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIhoFUPwbvDrFDzo/lZyLHjoaJdkEH10M5dRzYrnYTM=;
        b=OC8godDzjDu5MtxMjoLLDxll5jE2O4Tsrg2c2wECoVMYiUes/cgCEpQXLcqLCJW3f7
         teFZYJrytId94zaZQTmSWqClFtFiMMBqs2pSR9VDXkfrwV2p5/ok7q4ZjQmvSmPrJcZ/
         PqU+2SIDY3ZzDVl8+YjZmAKTWZhF38SIj8EHnSBAvXPVKELPLnHLIryEWJ13i7h9aoL+
         4FBQr5rhqFMjP/Hs1uoqdVv4uIOE+vgMNzm7SaSalsyC+BSgPk69N2rf2xCizpFJYku7
         eIHz89UJPuhu2dM5ZHSYXt84aIH2eW9mVcXX+WA7upqut+Cz6eobQKoHBlDpi8N2IoeX
         BlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sIhoFUPwbvDrFDzo/lZyLHjoaJdkEH10M5dRzYrnYTM=;
        b=CZSB467U+1nkFq2zO06LLnbd1K6Z3fNhE70bW/R0PSm+hYZ5u0S8JjsnGuzlEkG/n+
         MEaIoDwKdfVdXvcYSQxzsh3MIL3xmJSH9vJnt+tcbwqR/CSgG7MADPGgRmSMZ/wELY46
         RezPNBzd7cxblP0lp68NCmjrMFPMBrNOdMANVzdiNmmEpxUoPo/Sgg/DoOUlEjAcPqc3
         wKAT6of55oIQ9+Ci56LA6eDvkUAKPcjAN+GzGzu+fa0He/SCDUZroqXB7BF6X5RB6IjF
         Ss4bh572CgiQM61jJ5prnnVWuKOz6wtcoHIruo4WMaqcWMd+ZLr013czBkkiaQnZwjzQ
         dXkg==
X-Gm-Message-State: ANoB5pmv1YVFwDVYJwMBlbngUVFM6YyWyzPoB8WnXveleUcM2nVPjZ4f
        j3S5tCwwohoPfE8NOxZTORU=
X-Google-Smtp-Source: AA0mqf7RkOPbUtjfcziugtxp6M/n8+/dvghRKl2nndGsbIUSnGXjOe+AiEGxjkERGcCUWYxMDOEY3A==
X-Received: by 2002:a17:90a:e28d:b0:219:26b6:e8d8 with SMTP id d13-20020a17090ae28d00b0021926b6e8d8mr22483781pjz.74.1669847009597;
        Wed, 30 Nov 2022 14:23:29 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e5c500b00186a2274382sm2033614plf.76.2022.11.30.14.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 14:23:28 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Smith <psmith@gnu.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] Makefiles: change search through $(MAKEFLAGS)
 for GNU make 4.4
References: <cover-v2-0.4-00000000000-20221129T140159Z-avarab@gmail.com>
        <cover-v3-0.1-00000000000-20221130T081835Z-avarab@gmail.com>
        <patch-v3-1.1-432518b2dd7-20221130T081835Z-avarab@gmail.com>
        <006f10e84c9108a7be7315fec753316ca743386c.camel@gnu.org>
Date:   Thu, 01 Dec 2022 07:23:28 +0900
In-Reply-To: <006f10e84c9108a7be7315fec753316ca743386c.camel@gnu.org> (Paul
        Smith's message of "Wed, 30 Nov 2022 11:29:44 -0500")
Message-ID: <xmqqpmd4ulnj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Smith <psmith@gnu.org> writes:

> On Wed, 2022-11-30 at 09:23 +0100, Ævar Arnfjörð Bjarmason wrote:
>> Since GNU make 4.4 the semantics of the $(MAKEFLAGS) variable has
>> changed in a backward-incompatible way, as its "NEWS" file notes:
>
> Hrm.  I did try to look through the other makefiles to find similar
> constructs and get them all, but apparently my grep fu was
> insufficient.  Bother.
>
> Thanks.

Thanks, both.  Will queue.
