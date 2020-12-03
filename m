Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD62C04EC2
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 13:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C9FD206D8
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 13:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbgLCNwj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 08:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbgLCNwi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 08:52:38 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8948EC061A4E
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 05:51:58 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id k4so1309258qtj.10
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 05:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=12CwWdQGrAy9yT7VSA96p/Gxp/Qs3HQiaToSzEPM1VI=;
        b=lweisILhPzB8W024w2qH0HVrsvjGYJBI3a2hnmxCCfKPabBCYhmkn4qqKeC8mdI2Nh
         nWo0NRlbeQ7DeOE6SDbQrqRtd/NVGIqzTFAQ+Kv08iv/tlObdDhbFgyKyNvqvC2PwfST
         T8NiYBK314wsBge4bxwe2i+RPz/ttvrnuk9Y9CIQ6zY1728h3Z60SIWLz+PImBgFNfeC
         UIz9hWI5TwxYcSvtgTDA6J1OEOOa0caC/BvrT0sen+pI3JH3NW9qMeeiUL3cpb9j+I2x
         xXU5hSJhxrpx6cW0UfxBD1aVUR3d0VkCE1orEboGpTAM3h1FJ+mGA/UV3K6AqvSFMryv
         Ny8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=12CwWdQGrAy9yT7VSA96p/Gxp/Qs3HQiaToSzEPM1VI=;
        b=XtPUFMnoBX9ePZrJFdoNLUfvVKibL7ctVr77ixsxiY6CFtmpnKMh5PvuYM2h+NkdLW
         q7cs1zCy+2R6dssZfE6pyz6ZYyVZJzYzPD8mvLPAjBw7L4+CEJ7Lq79XKtoo7hFdrGr8
         diPK1sSO4F25RD3RowO+TRyn2p7E7DO8ExcEnLhu+1Q2mjGLQqOLy1q7jDA644qfe9Ls
         aGWTbWd2cIiRSh1dEpr+1Ubi6vf4Q0XsBWm+XYtJSC86+vTrfSTOKAY0qO1Obu+2CAg2
         AQuKiaPxhJ67D99IDu1OreQFbPQnto0lyRmEyt1N2Ff9WBKod3VzcAuvcCBBNVbCWIiz
         +/tQ==
X-Gm-Message-State: AOAM531PG/hDT2ucm/qzpb1+pAg/HE8Lnlp+ngTtTSZY4m5BBdL1ZTlz
        qi1oxECKMcVWkNmzY4q5il7D4aNmyndt5A==
X-Google-Smtp-Source: ABdhPJxqIMyn816lqHGMRuHv+SDvU5+OeMyIKVnzpP3HRgOOAuaTFVbKBQ5YI9hUziy+weSUdZgYfw==
X-Received: by 2002:ac8:578d:: with SMTP id v13mr3243018qta.247.1607003517713;
        Thu, 03 Dec 2020 05:51:57 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id t126sm1391176qkc.76.2020.12.03.05.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 05:51:56 -0800 (PST)
Subject: Re: [PATCH] Makefile: mark git-maintenance as a builtin
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
References: <X8b9IyU6E92efYaO@coredump.intra.peff.net>
 <xmqqa6uvlt6w.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ddbbd576-fb5e-f913-a7fd-e1590d40fc8c@gmail.com>
Date:   Thu, 3 Dec 2020 08:51:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <xmqqa6uvlt6w.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/2/2020 5:49 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> We normally get the list of builtin commands by expanding BUILTIN_OBJS.
>> But for commands which are embedded inside another's source file (e.g.,
>> cmd_show() in builtin/log.c), the Makefile needs to be told explicitly
>> about them.

TIL! Thanks for noticing.

>> Since cmd_maintenance() is inside buitin/gc.c, it should be listed
>> explicitly in the BUILT_INS list in the Makefile. Not doing so isn't
>> _too_ tragic, as it simply means we will not make a git-maintenance
>> symlink in libexec/git-core. Since we encourage people to use the "git
>> foo" form, even in scripts which have put libexec into their PATH,
>> nobody seems to have noticed.
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>> I don't really care that much. I just happened to notice there is a
>> git-maintenance pattern in .gitignore which will not ever trigger.
>>
>> I could actually see an argument that this is not worth doing for new
>> commands. The dashed forms of the other commands have worked for a long
>> time, so losing them would be a regression. But since git-maintenance
>> would never have worked, presumably everybody who cares is using the
>> recommended "git maintenance" form already.
> 
> I do not care too deeply, but being inconsistent means users have to
> remember which ones can still be used in the dashed form when they
> use the PATH=$(git --exec-path):$PATH escape hatch, and which ones
> cannot.  It strongly discourages folks from writing new scripts with
> dashed form "git" commands, which might be a good thing, but it goes
> against our commitment to keep dashed form working, so...

As long as we continue to support the dashed form, we should be
consistent with other builtins. Sorry for not noticing that this
would be different than previous builtins I've added.

This patch LGTM.

Thanks,
-Stolee
