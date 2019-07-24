Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BCA41F461
	for <e@80x24.org>; Wed, 24 Jul 2019 01:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfGXBEs (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 21:04:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34616 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfGXBEs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 21:04:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so21298706plt.1
        for <git@vger.kernel.org>; Tue, 23 Jul 2019 18:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IBun3pQMvt6NsGOZ1Pa1/W5QjNNVUCqY7Pz/yk8Giqo=;
        b=gitOCAzDn/MZ66JU0zilcZReHlCRmHwZWxqhN1t+vRe5tCv9LVAzkEM1dq1hR6wdB/
         2341GqiyjRC26RwGhzS76TAzBOErLZrA7GJa+8asz4JBPIWTUW1VnJ1yntEPUSpWjX/m
         B7BJeMkH/YBYPs0Q5Te7sENpJX+Uhzx4RSNjho4dFOslZvUR8WAUi6czRK+qdP54XTnJ
         wD7Pyse2MKB3fY6CGnN/7JZKdIqes4bwEvccNpokYp04H3DTYrw1TAgzc35pzqWgecvx
         Kr75gOVAtiMG9g6wlGOZt0dDaTZwCdQ1Yy0H+8JT+eeuWozgH5vv70TD/AV64671OGHR
         ZUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IBun3pQMvt6NsGOZ1Pa1/W5QjNNVUCqY7Pz/yk8Giqo=;
        b=fvcJoWrOvkNbj4Me7MFhOFbDu5JxMUCUy7r2KCr5e2Wc8P1j9XYZeLha6O2JMYaNWj
         H4Bjz7LkbEBrvYOIcRZ781gLep0R3rLBb0ZvSc4kkxtFHolhLdGsB9AaEYX99VAZfYf+
         JvlSjBmQJ+zgKT1Z9QDSm1IFYrn/U+s/3853shUb+0fjOT0IUjbufU+dXsMKXsekM3Ii
         kRRy3sLAzKwMxvGsk19PopCDWCLDm5H9ody55Z5OL7WxP5XZS4+uB3W9rFkia0jq52KD
         TypXZxoRtZ8AeBOkLdLpv0pPX4zw9ghHA/ComQICQ2W0HvvXfCQYcf5rvYKZhh091rdo
         6xMg==
X-Gm-Message-State: APjAAAXoq0N6QTTq5Q/8masVpFS029XQCXWkrj09v/5uP/a1F+hXQUNi
        jjRcyBjgeH04TPswyPe20eorTQxF
X-Google-Smtp-Source: APXvYqxyL1Qv8ocG2VnjzZTi2Q62xzu0pzgQz3uUXick1fZwqiZX61T91XmhK3i4WyQO+pqPGKOugA==
X-Received: by 2002:a17:902:3103:: with SMTP id w3mr84707643plb.84.1563930287755;
        Tue, 23 Jul 2019 18:04:47 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id p20sm25049334pgi.81.2019.07.23.18.04.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 18:04:47 -0700 (PDT)
Date:   Tue, 23 Jul 2019 18:04:45 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Matt Turner <mattst88@gmail.com>
Cc:     git@vger.kernel.org,
        David Oberhollenzer <david.oberhollenzer@sigma-star.at>,
        Rene Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] archive: Store checksum correctly
Message-ID: <20190724010445.GA164908@google.com>
References: <20190723025736.23036-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190723025736.23036-1-mattst88@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(cc: René Scharfe, "git archive" expert)
Matt Turner wrote:

> tar2sqfs (part of https://github.com/topics/tar2sqfs) rejects tarballs
> made with git archive with the message
>
>     invalid tar header checksum!
>
> tar2sqfs recomputes the tarball's checksum to verify it. Its checksum
> implementation agrees with GNU tar, which contains a comment that states
>
>     Fill in the checksum field.  It's formatted differently from the
>     other fields: it has [6] digits, a null, then a space ...
>
> Correcting this allows tar2sqfs to correctly process the tarballs made
> by git archive.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  archive-tar.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Nice.  Is this something that can be covered in tests as well?  (See
t500* for existing "git archive" tests, and see test_lazy_prereq in case
you'd like the test to use an external tool like tar2sqfs that not all
users may have.)

Thanks,
Jonathan

(patch left unsnipped for reference)

> diff --git a/archive-tar.c b/archive-tar.c
> index 3e53aac1e6..f9a157bfd1 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -215,7 +215,9 @@ static void prepare_header(struct archiver_args *args,
>  	memcpy(header->magic, "ustar", 6);
>  	memcpy(header->version, "00", 2);
>  
> -	xsnprintf(header->chksum, sizeof(header->chksum), "%07o", ustar_header_chksum(header));
> +	xsnprintf(header->chksum, sizeof(header->chksum), "%06o", ustar_header_chksum(header));
> +	header->chksum[6] = '\0';
> +	header->chksum[7] = ' ';
>  }
>  
>  static void write_extended_header(struct archiver_args *args,
