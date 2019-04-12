Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E1D920248
	for <e@80x24.org>; Fri, 12 Apr 2019 01:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfDLBPo (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 21:15:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45377 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfDLBPo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 21:15:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so9677807wra.12
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 18:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=b/9uc+mLUWHKdnNYWSitcHpcmEZLhj5DBCWJPBd4Z6I=;
        b=AcRXNsAuuN+AALJknCYYElaS8WXv+bCzOxPdg45tKcnBhGGOImK7qvNsD6Uq3BPTc6
         B/To7JG+hZGHU0I5VjVVmGcrUcbtUeqdyDkB6ulzkHUp5vHGNqeKm0R3pT4Jf2ttg1w3
         wUV/UnNbJMLMQ+gO4ZaAGHhTevkyzqO0b9RTnDfgfTT+t85eo/CCjpIfyBy99J4FnHhG
         7Ji4DwYkaWmP9SFjS7PoNhW23kQkIiT+E2YgdcQaBMjdH51myFFC90T2mbjF/o/8qYiw
         wYfZnI+6k3YUA0bITNC4G3gFs5cIjwXwYsjRivFMc1jmFKueMWqGnkeAsDxjOdO5U11u
         GgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=b/9uc+mLUWHKdnNYWSitcHpcmEZLhj5DBCWJPBd4Z6I=;
        b=QDB1fb0RpwW1w2uM6EOiwgEioYm8xT/1SObP51gErtif87RgN5ATREqeg0luCq0nYJ
         EXeaRnyxj4MUVkektiVgjbl+eEPFr8pseTeFCmNzJNnyCk4mUwU0Z7YOY0QwAwIofZUt
         ZfjuwsX7YxBI6HDTv5UEblwqokqstfDgSZkaGanmtkP4AfzX38RrcrBk78obtu0AccNy
         zNRHGatUKHGbEBpy2gIWuyTFtQV9r124abM45/PO+RdVOitdEYZj607TICnFCdgSk/MC
         HOUNRbsl/9p2MnfubP6OBcT79T16P8/YlFTKNGPoknMEzYPyNIe1XVaGqMHYq9H2o5PH
         JcuQ==
X-Gm-Message-State: APjAAAXvmvtcPQUDUiDkxPre6BRslR5G9aDmOmhc+Vv9ua8PgOgInucm
        q309X4603cjPK5t+ABTmB6g=
X-Google-Smtp-Source: APXvYqytjS8RYW4LIiPVD9l3y0kJmzqe9evW/GOiujyS6oaHSm8a2VelWlgMndQ+IuX1vI5J1anjnw==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr25993793wrp.72.1555031742520;
        Thu, 11 Apr 2019 18:15:42 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id o4sm10740483wmo.20.2019.04.11.18.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 18:15:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Sven Strickroth <sven@cs-ware.de>, git@vger.kernel.org,
        peff@peff.net, johannes.schindelin@gmx.de
Subject: Re: [PATCH] Unbreak real_path on Windows for already absolute paths (with Visual Studio)
References: <6c7d4155-e554-dc9a-053e-f3a8c7cd4075@cs-ware.de>
        <0f629384-638f-bfb9-89da-ade335e364fd@web.de>
        <950ee9b8-786f-28cd-3e89-ad174fd857a4@cs-ware.de>
        <af640e82-ca1a-9c96-da47-62aaea1cc18e@web.de>
        <xmqqv9zn2kjs.fsf@gitster-ct.c.googlers.com>
        <d1cf10ec-ca57-09e3-cf00-3be87dec06ee@web.de>
Date:   Fri, 12 Apr 2019 10:15:41 +0900
In-Reply-To: <d1cf10ec-ca57-09e3-cf00-3be87dec06ee@web.de> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Wed, 10 Apr 2019 07:32:35
 +0200")
Message-ID: <xmqqftqo10si.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

> It seems that I haven't read all messages in my mailbox (or messages crossed).
>
> The V2 patch describes the problem well and looks OK for me.

Yeah, I just re-read the log message with a fresh pair of eyes, and
I think it is clear enough.

Thanks, both.
