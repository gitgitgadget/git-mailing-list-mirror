Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E2D91F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932660AbeDWXXa (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:23:30 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46204 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932611AbeDWXX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 19:23:29 -0400
Received: by mail-pf0-f195.google.com with SMTP id h69so10585458pfe.13
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 16:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Bh+gRWFre8ld070lr/GtnW0Vlp5M3P6g5OcP1tw797k=;
        b=XdTibxMleuosQWi5hP0ct+SndpMKRqx5RRQjgHf+vY/s8fk8gJyHaZbCV5zjQBLKs1
         KstMV3kTbqweNud+u4UfolE5LLshPYQJs5aYtQpN7CIzWsYpqVnNlQ1LYM+vk0EsY//s
         IoZWUtp+FJokQlVf1fKQz1b3OBVIq6GNCrQTgeDM+lqcyqUc5Wm06GOvEHjl1EeNLxTW
         7xkRf7qWTd36fgT8jY2XZImr6jrl8SJuzj1Hnf7TJK5dGcUiY84vfiYSpz48IgKBQh/D
         oC+m6zuFCd7MhT2vid89E2KS0iFpdAZX20j54cVXnUV9dlSQ+NfII+stATzfBI4aS0p0
         XCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Bh+gRWFre8ld070lr/GtnW0Vlp5M3P6g5OcP1tw797k=;
        b=pYAVjojdf15iA3U6iBtbMLNHkCZNuHCz8Hi9xB/NT3aqqjOERLZZyTtne9AfTSzwZh
         Y8if+n7Z5I+FfaijK3CS4qW0R+lUgtZv95cK/2o/aI2I4jr+EjRGuIdoTpkXwB+iEFDS
         C1UEB/92p1ySyvgx9//v/ZP/HeZR9V7ORMLKh6Wwbe+T8oik4/fcS1ssJlouE4yzBH3B
         vBx0Bh66gsvfrRIFIRxrWqgRc7QdW5stjm6jmuS90/y6B/JxoBpt4tgKDCwpHeNkYKdJ
         AR5bqlVqBabMDQu7Qz31GQGwlgq3eS7N3cGFLueu5H1ZrFymV0eA9ZadSFY3vL+ozHTg
         xg8A==
X-Gm-Message-State: ALQs6tDdwu/+XmIQYmyzz2n5RLGX/I87iTEe6tRpYUg3Lbbf35pK3oiX
        09+v6iu8PENplL3wMdEqZbU=
X-Google-Smtp-Source: AIpwx49rDkBRknbEwWhjXTjWbxZ6O1yAi5zjTyKD6bFVSSoRieDM27UQKdT6EywbvvBMII9b252lmg==
X-Received: by 2002:a17:902:2a43:: with SMTP id i61-v6mr23017621plb.54.1524525808766;
        Mon, 23 Apr 2018 16:23:28 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g64sm32061814pfd.75.2018.04.23.16.23.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 16:23:28 -0700 (PDT)
Date:   Mon, 23 Apr 2018 16:23:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Dan Jacques <dnj@google.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH dj/runtime-prefix 0/2] Handle $IFS in $INSTLIBDIR
Message-ID: <20180423232326.GB25128@aiede.svl.corp.google.com>
References: <f0ad1ad4-67d8-21e2-fdd0-0a08328c1eaa@kdbg.org>
 <20171205212625.6616-1-dnj@google.com>
 <xmqq7eu0j1th.fsf@gitster.mtv.corp.google.com>
 <e0a22ee4-9503-760f-293c-be56fa46fa04@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0a22ee4-9503-760f-293c-be56fa46fa04@kdbg.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Sixt wrote:
> Am 05.12.2017 um 22:35 schrieb Junio C Hamano:
> > Dan Jacques <dnj@google.com> writes:

>>> Thanks for checking! The patch that you quoted above looks like it's from
>>> this "v4" thread; however, the patch that you are diffing against in your
>>> latest reply seems like it is from an earlier version.
>>>
>>> I believe that the $(pathsep) changes in your proposed patch are already
>>> present in v4,...
>>
>> You're of course right.  The patches I had in my tree are outdated.
>>
>> Will replace, even though I won't be merging them to 'pu' while we
>> wait for Ævar's perl build procedure update to stabilize.
>
> The updated series works for me now. Nevertheless, I suggest to squash
> in the following change to protect against IFS and globbing characters in
> $INSTLIBDIR.
>
> diff --git a/Makefile b/Makefile
> index 7ac4458f11..08c78a1a63 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2072,7 +2072,7 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES perl/perl.mak Makefile
>  	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
>  	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
>  	sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
> -	    -e 's=@@INSTLIBDIR@@='$$INSTLIBDIR'=g' \
> +	    -e 's=@@INSTLIBDIR@@='"$$INSTLIBDIR"'=g' \
>  	    -e 's=@@GITEXECDIR@@=$(gitexecdir_relative_SQ)=g' \
>  	    -e 's=@@PERLLIBDIR@@=$(perllibdir_relative_SQ)=g' \

I just ran into this.  Here's a pair of patches to fix it.

Thanks,
Jonathan Nieder (2):
  Makefile: remove unused substitution variable @@PERLLIBDIR@@
  Makefile: quote $INSTLIBDIR when passing it to sed

 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.17.0.441.gb46fe60e1d

