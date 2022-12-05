Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B246C4321E
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 03:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiLED0K (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Dec 2022 22:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiLED0I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2022 22:26:08 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571AF11A3C
        for <git@vger.kernel.org>; Sun,  4 Dec 2022 19:26:03 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id g1so2064434pfk.2
        for <git@vger.kernel.org>; Sun, 04 Dec 2022 19:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asgBX/Y/jXj9I/9dJ2a2R1Gtk0ZD8To/wf9CEAF3Gjk=;
        b=FQaNQzikplTjpdj3N0ntjxsY0X3A+NjMfXI4C+7DhW+QM0hc5mIw1iwTlTrIre9kLE
         L8HiO1NnUJ/3FpdqWzrNrjD9dFWVXa/PKCn3wI9CbCRNFeDR0r0UHBjE7wX7dBsMJouQ
         0CqT0SHZvTpM7ZIh//2GzmsH6vO/AvC6B7SL1WL3UOX7qMoES9bHfyAlJdOw+5wQ05fN
         0GenaKq5DE51/D8bkaMB4+JsbHg2rAO8VOb9kXNFbPLDUHesCV1j2ZgF6G1o4oQQtPdB
         hNyQkIE7xgsgJ4/VFlHujIHAQZ7fbRls/RdH2KitHRpwfGHwNK5B0LFTOvhgyxdWhiSo
         FNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=asgBX/Y/jXj9I/9dJ2a2R1Gtk0ZD8To/wf9CEAF3Gjk=;
        b=7xcQZSOcfCech1vWIXJ5v+RDKDtlQrYaknrkSBu02qwh5kTiSjMaTQFMHkgUrW2GXx
         FbkoOs2qUibbdQDAyfeDTOnwYgwbMBYb2R2tuS/ShdgVFGq0ZA+h72QCAzDrF3uQpWWw
         WXb9OyOV85ded3H59pkhdYY8db5vmnpIGXo9rfneoUwCsBfBNT+ruQcLFYH/O3lyOF4z
         S2AEYWMo0s+aIr+9WlO9QkUc12FSPy1bw5xD6+uQj1DuCj2hSHh7bbDMdzUbpVSX2ZN5
         M+VeO702JAIFH7lc7FpwO/T7sB6qmQSy1zJn0/pbywER55hPFEM97S4NvPJ8TB1lEmXZ
         ZZYQ==
X-Gm-Message-State: ANoB5pndZCojxQNxowsstvdgwwb/YvZ9/OJMDfwkj0yVmxb3YqAgLXi/
        E/j86Juvz74K7xecxHfBCfzOtDlncRyX8g==
X-Google-Smtp-Source: AA0mqf6rg3gml7LtVz+2IA8E1FTka/ZRzENuEtqOugeFPK7gQ9O77WlpsqSJjscD2xFkUkc5S8wuFA==
X-Received: by 2002:a63:1054:0:b0:42b:9219:d14e with SMTP id 20-20020a631054000000b0042b9219d14emr54721608pgq.176.1670210762694;
        Sun, 04 Dec 2022 19:26:02 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id pw9-20020a17090b278900b00210c84b8ae5sm8127199pjb.35.2022.12.04.19.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 19:26:02 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2022, #01; Thu, 1)
References: <xmqqr0xjs46r.fsf@gitster.g>
        <c489ad32-1308-06c9-0c92-6e39d1f82a4b@gmail.com>
        <e0c876db-a230-dfa4-f4e1-5296ffe62c37@github.com>
Date:   Mon, 05 Dec 2022 12:26:01 +0900
In-Reply-To: <e0c876db-a230-dfa4-f4e1-5296ffe62c37@github.com> (Victoria Dye's
        message of "Fri, 2 Dec 2022 12:11:16 -0800")
Message-ID: <xmqq359usf92.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> Rubén Justo wrote:
>> On 01-dic-2022 21:23:40, Junio C Hamano wrote:
>>> * rj/branch-copy-and-rename (2022-11-17) 2 commits
>>>  - branch: clear target branch configuration before copying or renaming
>>>  - branch: force-copy a branch to itself via @{-1} is a no-op
>>> ...
>> We can drop the first commit (branch: clear target branch configuration
>> before copying or renaming) as it needs a better approach.  But we can
>> keep the other (branch: force-copy a branch to itself via @{-1} is a
>> no-op), there were no complaints about it, I think.
>
> Agreed. I think "branch: clear target branch configuration before copying or
> renaming" is probably worth revisiting at some point, but "branch:
> force-copy a branch to itself via @{-1} is a no-op" looks fine to be as-is.

OK, let's discard the tip one and mark the other one to be merged to
'next'.

Thanks, both.
