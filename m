Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E4AC433EF
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 13:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67C7D60F46
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 13:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbhKMNLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Nov 2021 08:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbhKMNLj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Nov 2021 08:11:39 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD73C061766
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 05:08:47 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id x7so8939655pjn.0
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 05:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PteV8FVraenmc8zqr2YvjGsuIcX0FEe5XOw4Ful5vnA=;
        b=I39Th3Z/rC9JfBdVOPqtDJ+s/2gZlL8ufBQSSW7NRuY69BAGN22tH7xfyTOI0KQkXh
         81vrNH70ljlzQ+AJf1pyIN9u9jg9UqH0g7nW5UxiBeyMF4dpkrlzv0Wa3be0zY9XmqJL
         krnQoYCGmUIuV/as0C1azT0oCwo4xyxpPrd4V/ProKnuFAaCJ7XPrFjG9S0vSHOWv+Ab
         IsT+OgtVjUEaNLJ4vw1S7/1atJL9TZpEsHlHwMKSFVJTcAerEP/h5AYdBzx0Lf+w8njM
         wRBjft6IdNsgmP6ouilH5FN5bH7V7eccuO1nx/rIfAuEkVBlBIghtCAv9aHJ4MdBGPWN
         F39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PteV8FVraenmc8zqr2YvjGsuIcX0FEe5XOw4Ful5vnA=;
        b=7BaDJyd5Y0L02uQMXRsHKPspU/HJr1Bxg3YdAxtmwEwta9/+JlL0LBSDvGIxIB6g/v
         L0vt0Q/fCoLM7vIOgBGSJ/p061gEqTUwk5vpdNNBMrKHg5UPgakkXJmErwDYrwWMib0p
         XN5e94l1u3lRfLxT2OsZe61qIbmn3VZQejhsDNGgevKLaOF7j70nKukHwmLH+smtGDRX
         dQv/r5GWn9+ueC53zR5QIgo9khxFEfW+MjKE5JeqjQu0ySwFRirZ1gm5RiRLoUeZlylG
         pBhxMYzP+V+3sLgJs0q5cWaMa+dv9LUJ4grKaZU3UpMBby/Il+7vx/taJ+1VeeQakuWP
         GuWQ==
X-Gm-Message-State: AOAM531Zy0y8PKmYHZNPmOIo4DpOwvM2dybJrQROPiEpe/7BPLeg5YzO
        EuA302TSIgLFylTbf4iSGWw=
X-Google-Smtp-Source: ABdhPJyEbR41tkVgvwLn3mIbYcavM56vXsoszXIi4wnod6xrHvFstfmqgCOaJQ/5tWQQWc41mdU9ZA==
X-Received: by 2002:a17:902:6905:b0:142:9e19:702e with SMTP id j5-20020a170902690500b001429e19702emr17691478plk.34.1636808926514;
        Sat, 13 Nov 2021 05:08:46 -0800 (PST)
Received: from ?IPV6:2405:201:4018:300c:9885:5ab1:360a:7fbf? ([2405:201:4018:300c:9885:5ab1:360a:7fbf])
        by smtp.gmail.com with ESMTPSA id oj11sm10930316pjb.46.2021.11.13.05.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Nov 2021 05:08:46 -0800 (PST)
Message-ID: <2b2386b9-045d-a0b8-6dbc-8a9d0c446bea@gmail.com>
Date:   Sat, 13 Nov 2021 18:38:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] MyFirstContribution.txt: fix undeclared variable i in
 sample code
Content-Language: en-IN
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     git@vger.kernel.org
References: <20211113122833.174330-1-gotlouemail@gmail.com>
 <20211113130508.zziheannky6dcilj@gmail.com>
From:   Saksham Mittal <gotlouemail@gmail.com>
In-Reply-To: <20211113130508.zziheannky6dcilj@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> It is declared, there is an "int i;" a few lines up.

Oh, man, I never even saw that! The patch is completely unnecessary
then. Sorry for that!

Saksham
