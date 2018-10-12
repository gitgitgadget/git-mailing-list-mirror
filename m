Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BE221F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 23:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbeJMH2X (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 03:28:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46185 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbeJMH2X (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 03:28:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id r64-v6so6917272pfb.13
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 16:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VzsTaGPWu4XOUJJhbACzfXfOXGuLKQPoKPquwy86ezw=;
        b=JRVY+GdSzor0rTgdZ6BqTN3aLIvczRlTCAawJTa35kGmLK4kVSih9Ax8s/xlpB1md5
         akje5MHbWUXksqDRk/2s2QmSnXiWOe+164cURF7MlsusxyZgaLhbWjKl4BRMUTH16AFv
         H91Xm/RhzQtYNiYdtk8Upd1sIR6PcdaBRdcHEyXWscZlCSRQVJvF/GFKA0U0fFVlvMMM
         m1rZPsit3Z3W/EXyelBDM6SR644RJnjjSh/zwnxzZYZ6Q9wKJxDuu7ZbLfmjPNXdp50u
         Pqo6TGEAif4ldy58MYLKeXOfrmmuaPrDIguuZwsCEkQk/wfgWO7dOf+lDEM/nwqjZL28
         yRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VzsTaGPWu4XOUJJhbACzfXfOXGuLKQPoKPquwy86ezw=;
        b=HRzcGLeBCvfnqHgxHCGyix//kTf6kPzs1D0d0leGvHQ81vOOZnBHNAdYahpieKSqkx
         elusAWjTgxQbsM5ePwf+2azLWJnSka3bzLyXKbg1WN4IgMBFdkrcGZnU0WTJmFywxESk
         8wCL4OeXFLJEADikwWc0TLXJcMwD1d70FRYBs9oeyar8i/vz9CXCYgKILUcIV4Lgi6M/
         537OgK/3qDDrNfHglnpjtR66C132gEteM97N+uFV/wQjTjHS2gY4mVXxq7nK487WcLDJ
         ELUyBh5qJNyLXqNTYNy9FmWXOtrMErVcKCOEyTXXp73VHhxpExwTzRN06WXuiIe5fUY2
         atLg==
X-Gm-Message-State: ABuFfoiy8UnUUpCD1M+kVTNjSwNRHKEgFaoYnivBRaU9QYOVqMnZ2+/5
        1BHxgVhjmuPCtixcTUuMC28=
X-Google-Smtp-Source: ACcGV61lq4A50SEw9jtkZkEFpPuKvidNkIEXMK5KWW+OnNjVmoWjoefR+l/tCIODH6zkaGxQM0a56Q==
X-Received: by 2002:a62:2542:: with SMTP id l63-v6mr8308370pfl.64.1539388415789;
        Fri, 12 Oct 2018 16:53:35 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id e131-v6sm4155895pfc.52.2018.10.12.16.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 16:53:35 -0700 (PDT)
Date:   Fri, 12 Oct 2018 16:53:33 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] protocol: limit max protocol version per service
Message-ID: <20181012235333.GF52080@aiede.svl.corp.google.com>
References: <cover.1538516853.git.steadmon@google.com>
 <59357266bd86e8e0ace9217a97717129a6f76188.1538516853.git.steadmon@google.com>
 <CAGZ79kbD=P__8GU9rV87wREF_MbQA9i2ij6C2qXyaJfqHD3Szg@mail.gmail.com>
 <20181003213349.GA32105@google.com>
 <CAGZ79kZP7y3v8hrhKKP_FT7+uyUSWO5s8w13-c67QWdzme1-Qw@mail.gmail.com>
 <20181005001817.GB32105@google.com>
 <CAGZ79kbSF5XM72SOQH7XNyjeCLqQ+AuxOqMPTspjOgk-jEgrzw@mail.gmail.com>
 <20181010235303.GB12177@google.com>
 <20181012233207.GE52080@aiede.svl.corp.google.com>
 <20181012234504.GC12177@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012234504.GC12177@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon wrote:
> On 2018.10.12 16:32, Jonathan Nieder wrote:
>> Josh Steadmon wrote:

>>> For now, I'm going to try adding an --allowed_versions flag for the
>>> remote helpers, but if anyone has a better idea, let me know.
>>
>> I forgot to mention: the stateless-connect remote helper capability is
>> still experimental so you're free to change its interface (e.g. to
>> change the syntax of the stateless-connect command it provides).
>
> For v2 of this patch, I ended up using GIT_PROTOCOL to pass the version
> string to the remote helpers.

Makes sense.  Thanks. :)
