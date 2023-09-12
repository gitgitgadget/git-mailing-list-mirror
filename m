Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748A0EE3F08
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 17:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjILRc1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 13:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjILRc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 13:32:26 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BA710D9
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 10:32:22 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76ef653af2eso363464485a.0
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 10:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694539941; x=1695144741; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfN7ksgK8L+FcANc5zKOKn45yfSx1YgGbAM8DCz0UdY=;
        b=khnFjUUvFwLf55puNmo/PQrKrzJhwfTkpGxncQDJDcfrDOXNYy6ly++tMTRDtvbiuH
         jTbYzqSihmN7RPVVbuN9XwwalnRp58EhQOBgIKxpiNL0lmkl17Bd9DnCMYBsjakNQIoR
         aCqYjAoQeP/59WUNlpKTktn1moyyJRTASwCpA1NrOk9nBxeGQEjxQEg6wimKUDzhnor7
         1iTRynLV37rWAs9VlxV+h24IB8+ELvxTb+U5vhJpPWZ6S+h5jA47IWfBnuy9JIQlMSUr
         pfNLC1TjyVEUycGAyk1SBnJ5giVE2qhJcSyAsA3hsALKYxMTfvmPwg5+FjZsBrKBr9UU
         Smmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694539941; x=1695144741;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfN7ksgK8L+FcANc5zKOKn45yfSx1YgGbAM8DCz0UdY=;
        b=Q5is+e01WxEDOe0+qpIzKbedE5KUBXHXaAVhj+h325CfA8eU93C4oHaaer200xUqKz
         EMLi7YbeGI9ssyF02M9Kb8uAPGxWzVkROd3ci9gDbqfYRKcnBUr2NtWONLel+Lv6m6JL
         kaXmdgnNCgAQ6QDSqZCJZ1R8JouoGD6SsKE9UWn8IZaQFsmnRr9MzRVyGIK28/PS6zec
         PP6/IhzDtXyEn2eLXZZxqnvxxLuPGI5qVIkVnA/NPxTImMB8E7JjMnptoYlrvvGm4e/Z
         xI6tSSm5f/3PTeAUThY96MrugfJFNQaG6rnwCelt6joMdTrNp3u2FXF3RhMzjjfDwuHg
         p/+g==
X-Gm-Message-State: AOJu0Yw3GMAkjGhr9KOVI5RF+vmS9pswsQb0sVKxSa5cweDECnGhDhrN
        +cEBaaMwDP8jhbPnxASNc2DmVKMZguU=
X-Google-Smtp-Source: AGHT+IFPzAO0sEvaJHw2HfpYJU0JRZRWHB5BK9uKCI/Ql8fFEHfQ+JT8FidDTws80E/JzCdwo1iIMA==
X-Received: by 2002:a05:620a:21d9:b0:76e:f272:1dd7 with SMTP id h25-20020a05620a21d900b0076ef2721dd7mr102156qka.24.1694539941471;
        Tue, 12 Sep 2023 10:32:21 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:e8c7:303c:b6ab:a53b:5695? ([2606:6d00:15:e8c7:303c:b6ab:a53b:5695])
        by smtp.gmail.com with ESMTPSA id k7-20020a05620a142700b0076c89639526sm3319763qkj.93.2023.09.12.10.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 10:32:19 -0700 (PDT)
Subject: Re: What's cooking in git.git (Sep 2023, #04; Tue, 12)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqpm2npbwy.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <2579735c-d0cd-d159-8cdb-3348c808b9ef@gmail.com>
Date:   Tue, 12 Sep 2023 13:32:17 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqpm2npbwy.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2023-09-12 à 12:57, Junio C Hamano a écrit :
 
> * pb/completion-aliases-doc (2023-09-11) 1 commit
>  - completion: improve doc for complex aliases
> 
>  Clarify how "alias.foo = : git cmd ; aliased-command-string" should
>  be spelled with necessary whitespaces around punctuation marks to
>  work.
> 
>  Will merge to 'next'.
>  source: <pull.1585.git.1694274592854.gitgitgadget@gmail.com> 

Thanks, I just sent a v2 so let's make sure this is what you merge:
<pull.1585.v2.git.1694538135853.gitgitgadget@gmail.com>
 
> * pb/complete-commit-trailers (2023-09-07) 1 commit
>   (merged to 'next' on 2023-09-08 at 842587016d)
>  + completion: commit: complete configured trailer tokens
> 
>  The command-line complation support (in contrib/) learned to
>  complete "git commit --trailer=" for possible trailer keys.
> 
>  Will merge to 'master'.
>  source: <pull.1583.git.1694108551683.gitgitgadget@gmail.com>
> 

I've incorporate Martin's suggestions so let's wait to merge my v2 
instead:
<pull.1583.v2.git.1694539827.gitgitgadget@gmail.com>
