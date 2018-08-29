Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00C701F404
	for <e@80x24.org>; Wed, 29 Aug 2018 17:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbeH2VOz (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 17:14:55 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38524 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeH2VOz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 17:14:55 -0400
Received: by mail-wm0-f43.google.com with SMTP id t25-v6so6278265wmi.3
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 10:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MTlFzq05H/Gz6vh7JQvU/ue3Og+C+1JBer5YAzvbqwI=;
        b=U2APBUNcqXjrrkv8AAgmyUVxlI4TqYV3fByrftx0Ss5Pk4qBfUSFPl095szvZwYV8n
         Hqau3TqjW4ES214mlVD70Zz5+Kj43Jv1gBUDaVHyO67AKJ/m/zwnHEewSlxmXyrBKqvE
         gwP1Fn1uDA1osM3LwKDrobQiTy5zLX5SnCJUqAtXbhoOvC0XOBtuhRI334/5dGyX6w0g
         8Tfd4pK/oT1gG6yzeK2d8szPn3ehNBq2KlozUFqe0qPc0jyXMD8pB6aLDZ/jxl249zKZ
         Rg9rzOtWkprrtHStsAztAdXK54PdxZ2/ZbgoO5dzz1xhhU6UVbcwbbqO+9zYeZv7evbp
         IZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MTlFzq05H/Gz6vh7JQvU/ue3Og+C+1JBer5YAzvbqwI=;
        b=DVaCLlgIY3+Gb+BZRl6JHy+91lW4oGETbo6w7SguK4hTleQzzNo8P+oSuTi0WscGxq
         PFSjZ0oZ9hPdkIve7fiGk9Gr4opwxDZKljoUmGa7xCdsV5IPxkA2/fV1+ixJGi0CyR2I
         oBvVdPH3AoAM+Y4TlqwobTHLKbAhLdCkgUHl/GGugnX8zEGFDAJ03YU/gC6GDUoZdTxg
         2OWbZNQVlFWCdoIyoohAz9O0y++Qw0BbmezkPQ1a8EtfOSCGTarBgpIGETvV8dnmVXgH
         euB3mNtM85rsk/Ibd40MTZRDkRMkNyn+k1zMCOQSkNviShkSdNS3B++mWrj6WcrRwJO3
         jykQ==
X-Gm-Message-State: APzg51AqNdgPtAO+brD/ns1DLpuTXymiRkwoiHaZ9NnX3sxodluxHzZl
        lcPZ2XoW4htZHG9j7cqTuR0=
X-Google-Smtp-Source: ANB0VdaJBFASEC9pFCRi3QcYnjkONswDZQPDp4wnyYS4xQn/Szr7zswqM98pqyvoYvAynZOZTK8QMw==
X-Received: by 2002:a1c:f60c:: with SMTP id w12-v6mr4698975wmc.80.1535563019873;
        Wed, 29 Aug 2018 10:16:59 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 144-v6sm7702216wma.19.2018.08.29.10.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 10:16:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] submodule.c: warn about missing submodule git directories
References: <20180827221257.149257-1-sbeller@google.com>
        <20180827221257.149257-2-sbeller@google.com>
        <xmqqtvnefhgx.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kYApAdFzC82LZNjYDzL5uWxtXHbvqUyjZ9OF+b=pGNbUA@mail.gmail.com>
Date:   Wed, 29 Aug 2018 10:16:58 -0700
In-Reply-To: <CAGZ79kYApAdFzC82LZNjYDzL5uWxtXHbvqUyjZ9OF+b=pGNbUA@mail.gmail.com>
        (Stefan Beller's message of "Tue, 28 Aug 2018 14:49:19 -0700")
Message-ID: <xmqq1sahcctx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Not quite, as this is ...
>
> Looking at the test in the previous patch, I would think a reasonable workflow
> in the test is ...
> 
>> The MOVE_HEAD_FORCE codepath that follows this hunk is, eh, already
>> forcing to correct the situation, so there is no need to touch that,
>> which makes sense, if I understand correctly.
>
> No, that is not executed for now as it depends on 'old_head'.

All explanation worth having in the log message to help future
readers, don't you think?

Thanks.
