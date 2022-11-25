Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9128EC4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 04:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiKYEtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 23:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKYEs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 23:48:58 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7A3275D3
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 20:48:56 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id k7so2991623pll.6
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 20:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCIZ3QlPojaNjfdw2tJUnQCWapEpMqKwnv3qwO8NRmU=;
        b=XTiXivvBAfX+AX1j1VZ8/O/nKnvHhuqxbOgSIITQEDZOhFotTuNbWNRVHQICswt1PQ
         RnbEdO09acYF2JRPFusviUgE9wWm9iiczHwoSWwy+05dbnG1vr+fHaejji3AImLt1SS5
         9VHophKEbJvKeYtFj3TjdS82yMIsxf952g7h8EdUAEmiIwDyckGvZumBAfO7AdQdduYy
         XHOq440N3b5MNTvidtiaHI92ewJu9SwxbCsBOsj3rnDfGzzUC68RhrYjkVhik/gQ+MTf
         r0KLbC4+g9w7YWUqbUsuNxsZ86GXAMy2usmUkBZIe9DykyEcZwF8k2Gcz0dxHhgyHxW9
         /kGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCIZ3QlPojaNjfdw2tJUnQCWapEpMqKwnv3qwO8NRmU=;
        b=UCq/6ImIF29uR7pCOtHZZjXw87GZUzPYIu8eSRyR02N79fH/m/f4GwY8aUaD5XjPr4
         I2H6mBB5rz+sY2n4n+1gouS+hTWMeuQcygnMqeISzVWos3df796S3ul4MraCujkVZRsz
         MplK8fk/Od72RVqCZBs12kTWoxeqX9qkziOAhoTSmKLg4CguEca6ynAWkjnp1OaIsrf+
         7nijC4GLZxYgwR4ldVoMsIMTZYL2vSJvTZgVSV+LZILUTEMeRy8muHkDgX4Lu1E+s/ry
         8sVshCwtAPbs6ACsF6lZfjEF5O+9vXrFhjJwpRLTxxY1pYcaSF4CeIChQdPWhoVo0szS
         IMtw==
X-Gm-Message-State: ANoB5pnqof1/JfEV50/cjlwstPIBSFEBZrsOT7UsNCzrE779b2OMsx4g
        e7cOlgPjCfF9oy4FU23TOUKOWQiGzeT7tQ==
X-Google-Smtp-Source: AA0mqf5666FFuUh/G8brMuplSjzh/LbnN0K3RkxnOw+HSykRlF//+CiuknuX+6A6OxiuUhZ0bgmvuw==
X-Received: by 2002:a17:90a:71c8:b0:218:494d:e9d2 with SMTP id m8-20020a17090a71c800b00218494de9d2mr45143006pjs.50.1669351736255;
        Thu, 24 Nov 2022 20:48:56 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id s18-20020a17090aa11200b00218a4795b0dsm1964013pjp.34.2022.11.24.20.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 20:48:55 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v3 2/4] ci: show error message of "p4 -V"
References: <20221124090545.4790-1-worldhello.net@gmail.com>
        <20221124153934.12470-3-worldhello.net@gmail.com>
        <221124.86wn7knx1x.gmgdl@evledraar.gmail.com>
Date:   Fri, 25 Nov 2022 13:48:55 +0900
Message-ID: <xmqq8rjzhc5k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>>  if type p4d >/dev/null 2>&1 && type p4 >/dev/null 2>&1
>>  then
>>  	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
>> -	p4d -V | grep Rev.
>> +	p4d -V | grep Rev. || { echo >&2 "p4d: bad version"; p4d -V; exit 1; }
>>  	echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
>> -	p4 -V | grep Rev.
>> +	p4 -V | grep Rev. || { echo >&2 "p4: bad version"; p4 -V; exit 1; }
>>  else
>>  	echo >&2 "WARNING: perforce wasn't installed, see above for clues why"
>>  fi
>
> I think it makes sense to detect this, but the specific remedy makes no
> sense to me.
> ...
> So we want to show that it segfaults, but how it is useful once that
> command fails to pretend that it's a "bad version?" The issue is that
> the command can't show the version at all.
>
> 	$ { echo >&2 "p4d: bad version"; ./p4d -V; exit 1; }
> 	p4d: bad version
> 	Segmentation fault
> 	exit
> ...
> But I don't see the point of that effort, we won't look at these trace
> logs unless something fails, so just including the raw output seems most
> sensible.

Yup, makes sense.

Thanks, both, for working on this topic.
