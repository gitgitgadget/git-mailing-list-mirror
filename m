Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80E371F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 23:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbeJMHT6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 03:19:58 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:34178 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbeJMHT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 03:19:57 -0400
Received: by mail-pg1-f180.google.com with SMTP id g12-v6so6528968pgs.1
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 16:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ALRyT0OYqEzmxgooaULgKLbAsfCh4CTxC8SwSXYyUaU=;
        b=LHvgNh3JZ59MWmJ1vp+QEalo0geiLyHjvruy6i9tuB9b7iY+PiK8NgBOjS4EYg0jX4
         ye34756wim5YBENFUWjKWNvGO59RPVZQGnHyxKvvy48ZTcjIigNryv3WGGvtv66TUAae
         MhLwbOI0qhOQV6NDB/2FfdaKqWiVbVLIZpjc+8RaDnx/mezcbByFfc7WFPji3TchM8bP
         kxUOqGMe6rQ6YDdxV7ZVwWftMapKlp4OxwVlnM/xrW9v9VSsdKZpCcsVxgHJhA/nVDdZ
         pPQRFOt8oY3sQiWhwDjCtZYrf2rSQl62JQhjlscDErsRYggTMeaqKA54H30TTPctxdYS
         Llhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ALRyT0OYqEzmxgooaULgKLbAsfCh4CTxC8SwSXYyUaU=;
        b=huWAsvtmxd6Wr72c6qvyZg189bZb/3ChPW7IzMB2TjDyVJ+elW+8usGUjO6XKeT9wv
         /zZmm8iNpcDVgXxyvb9cxcLGrRTm9JJc4SxSIuXADB9ZhU628ImiFfmRgFThtc2AkNSA
         FO8FnYCyDNQvFvNBoVsR8ySdn7a3llBtdQfDRCgf2yHua4M8idUz/vYXZC/9FIM4JPqF
         G28BrtXut5dP347o5PcgIX8ym7Gi5dgM47nsrgubxGzcFa+aaUNm/1B4JpzQrvMTHdtR
         cEj6DbnL61JD6LYR7LdzAXbu+I4fChktfeay8QZ+XV9DaCTxz4pjBGc+jt4l1aE7z1IM
         nyfQ==
X-Gm-Message-State: ABuFfohm0VcrPB9jgvg8/ZfrwuMX/RoNUuBZMDgECGTnES7XD15Iucot
        eX7uVHuV8JThEUOf91vgOq6owFqnYRLfGg==
X-Google-Smtp-Source: ACcGV60rrnl5tyJDOlkCLfMVLFcAOgpD3cO5yUehCjfEIY0aUJqKKIGRvj5W1GtfvzGRE3BoSBtrdw==
X-Received: by 2002:a63:f05:: with SMTP id e5-v6mr7027361pgl.84.1539387911032;
        Fri, 12 Oct 2018 16:45:11 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id 23-v6sm4215300pfy.156.2018.10.12.16.45.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 16:45:09 -0700 (PDT)
Date:   Fri, 12 Oct 2018 16:45:04 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] protocol: limit max protocol version per service
Message-ID: <20181012234504.GC12177@google.com>
References: <cover.1538516853.git.steadmon@google.com>
 <59357266bd86e8e0ace9217a97717129a6f76188.1538516853.git.steadmon@google.com>
 <CAGZ79kbD=P__8GU9rV87wREF_MbQA9i2ij6C2qXyaJfqHD3Szg@mail.gmail.com>
 <20181003213349.GA32105@google.com>
 <CAGZ79kZP7y3v8hrhKKP_FT7+uyUSWO5s8w13-c67QWdzme1-Qw@mail.gmail.com>
 <20181005001817.GB32105@google.com>
 <CAGZ79kbSF5XM72SOQH7XNyjeCLqQ+AuxOqMPTspjOgk-jEgrzw@mail.gmail.com>
 <20181010235303.GB12177@google.com>
 <20181012233207.GE52080@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012233207.GE52080@aiede.svl.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.10.12 16:32, Jonathan Nieder wrote:
> Josh Steadmon wrote:
> 
> > For now, I'm going to try adding an --allowed_versions flag for the
> > remote helpers, but if anyone has a better idea, let me know.
> 
> I forgot to mention: the stateless-connect remote helper capability is
> still experimental so you're free to change its interface (e.g. to
> change the syntax of the stateless-connect command it provides).

For v2 of this patch, I ended up using GIT_PROTOCOL to pass the version
string to the remote helpers.
