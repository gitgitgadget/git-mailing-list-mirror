Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E81EC433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 23:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbiADXcR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 18:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbiADXcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 18:32:16 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103FDC061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 15:32:16 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id w27so30410463qkj.7
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 15:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ui1HS3oPWS+gn63oyrRXawV4xIXhZc5fTjeYXNjjW44=;
        b=qzQfVXbsR2Oy//IjYvihozo30eq1erbsUpRKIDF0Xx/0KU1hkRhSWUf40sg9NeQdQM
         1je/wRpXxsHPbqr69KKCLSmmjlpHDBDgffA+QnGWHfpOt8BTKz34SBZQ70RxnDDIiANu
         cVpaOPx/+46ql84+DKrCN3hOotmzm2MimlOFaQ8Z30Th+pzQVGo97nsNhszC9V2R8eBI
         HLuRY8NRiwA0pXVD9LL0qeYxfjxXKuEETyOjzIfO6tCcdyyfyjNbzTmNAIz4VE8uxa1/
         LPkFSO3l8mSCbeAW8c6BFpkjmgAqKBYxlD4hFXg1Na97bTpG8aBZQCoSWa0uF5CvE3ft
         Sxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ui1HS3oPWS+gn63oyrRXawV4xIXhZc5fTjeYXNjjW44=;
        b=6+TcPbh5iDolRHTfmIQkxNbq941XIkmJFEd6uVCFRQRl1Jj5BU3eGGhmSh2tVXIb4r
         VEvwrGjTBT80wo/iLQ0EuPr1xqgolx5bTmDdm9k5Ef/mGlz3mMstGe98kP1AaVw/WlIM
         EEgMFGy1LmpGi47z+ukcC08xoEp+2gW6joFtysq7ap/3lnLeWLk/gHNiqtTdEJd1v55Z
         mHUZqk74rXYxQtEU3YG4hD8QZAOO8cDJnCPIybwJVqU/T0az1/hevsjKeXXr46vVX0z9
         99wUEfDJyuaQnjg9a7dsjoaC10psU/Sv0RzM0EpAS754cVzVvDVfIZuoCxiDHG9PfU55
         S+wA==
X-Gm-Message-State: AOAM533gbNbnUinkA59vicxrXIsa6YlqFqtcuiVoVkegVWQD2VlDmSpH
        AsT9LTq05+xsaqOgxQvmvkKMey0Ljws=
X-Google-Smtp-Source: ABdhPJy+iiDJidArDQqB/IPYQJPgsbnqmh18uuRhNkecK6eCXxMfP/yvc9FjYN3TiqAgKK7Votu8xA==
X-Received: by 2002:a05:620a:21cc:: with SMTP id h12mr36566574qka.319.1641339134864;
        Tue, 04 Jan 2022 15:32:14 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id h4sm155775qkp.54.2022.01.04.15.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 15:32:14 -0800 (PST)
Subject: Re: [PATCH 0/1] Fix bug in pull --rebase not recognizing
 rebase.autostash
To:     John Cai <johncai86@gmail.com>, git@vger.kernel.org
References: <20220104214522.10692-1-johncai86@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <19ce4f49-1b68-0cac-1936-12d451244ab1@gmail.com>
Date:   Tue, 4 Jan 2022 18:32:13 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220104214522.10692-1-johncai86@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John,

Le 2022-01-04 à 16:45, John Cai a écrit :
> NOTE: this is my first patch I'm submitting through git send-email. Please let
> me know if there is some convention that I'm missing. thank you in advance :)

Usually, for one-patch series as this one, it's preferred in this project to not
send a separate cover letter, but instead to include the cover letter material below
the three dash line. You can do that manually when using 'git send-email --annotate',
or you can use the 'git notes' command along with git format-patch's '--notes'
arguments to include it automatically.

Cheers,
Philippe.
