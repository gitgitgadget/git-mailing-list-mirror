Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B0781F424
	for <e@80x24.org>; Tue, 24 Apr 2018 02:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932684AbeDXCSi (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 22:18:38 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34573 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932670AbeDXCSh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 22:18:37 -0400
Received: by mail-pf0-f193.google.com with SMTP id a14so397408pfi.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 19:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zh/vTCvoU/XeFgWdraWYbYHIw4VYogzrWRIJ7dxSVUg=;
        b=mGiL0mjUS33dlWDpDv3GRnHYXdViMulTYtR+zDvvlwVS4U1u0unWl8BjGoGzaKOa7R
         b+xfa0BxTJPSyPF2V4N6hGX1nkA4BriAniu+coO+Vm1TtBHeTxhVmbe7ixLLi3p+DlMd
         QD1lsDklGJzY9iydw8Ky9Q+mWUlGdIG48WroVp8gJuxNeIq6cgEHxAozLg0s7Tn/9VwA
         L6HQ5g2R2wjm5JL3ywTJ0r+TAKmQV5QkvnaKWSD0Aq+2wDF3FGlQOJYbDQp8FLWVj8g5
         6jMbqwDc8uTrUJZUSMOnZDEntQWThLCjwB12BdCgcp8PSf+w1Jfw9KjW8yOzfDmU/eFp
         vaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zh/vTCvoU/XeFgWdraWYbYHIw4VYogzrWRIJ7dxSVUg=;
        b=PEU2P/gyFJkv4mtOfxC4/s2vdRJXiaf2RLTC2VOJ1CaFQomU1rJROZkQhhIRA7f0jY
         XoguPA/uaJLHSu8LUPfNF8nkh5LFjefHYhmLamn8SuoNzyZsJ2uajIVDMdaOJMkNC0U/
         7fTsgGvt06gdOmYMFd/jdj26N/mzwmANjQdKGjJlaO6A7oXlMoyqxmmBx96J51lXqr+m
         ch09eLi6iNKys5/Ji3GwwMyN++xucMGpS3iierCyRaqqSS+Wrx+NPIO0NSy0Bg9d4Gae
         4KXXMKSUz8qdX2X+DqE4DFSxO5PVUbopqqbPxXJNiCz+qkxtpJOc1hkR9AfpAJc2JAju
         Mq6g==
X-Gm-Message-State: ALQs6tAlZvoIVPLVX4wD7gukn1HgYhpmbqlCdWWpXcJe+fkhWCVH0+Fp
        11mAm5ag2xYsedGs/cNRD9Q=
X-Google-Smtp-Source: AIpwx4+3RJ6lmoedAoGu7cGFmnScJ2Z9Xa1R6JgIBU1lI+2TxVbIKqxxb6uRYiBX8no9nbJMN/KXNQ==
X-Received: by 10.99.116.74 with SMTP id e10mr18606171pgn.169.1524536316529;
        Mon, 23 Apr 2018 19:18:36 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id p71sm21025225pfl.170.2018.04.23.19.18.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 19:18:35 -0700 (PDT)
Date:   Mon, 23 Apr 2018 19:18:34 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Dan Jacques <dnj@google.com>,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 2/2 v2] Makefile: quote $INSTLIBDIR when passing it to sed
Message-ID: <20180424021834.GE25128@aiede.svl.corp.google.com>
References: <f0ad1ad4-67d8-21e2-fdd0-0a08328c1eaa@kdbg.org>
 <20171205212625.6616-1-dnj@google.com>
 <xmqq7eu0j1th.fsf@gitster.mtv.corp.google.com>
 <e0a22ee4-9503-760f-293c-be56fa46fa04@kdbg.org>
 <20180423232326.GB25128@aiede.svl.corp.google.com>
 <20180423232535.GD25128@aiede.svl.corp.google.com>
 <xmqqin8h8lx7.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqin8h8lx7.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

f6a0ad4b (Makefile: generate Perl header from template file,
2018-04-10) moved some code for generating the 'use lib' lines at the
top of perl scripts from the $(SCRIPT_PERL_GEN) rule to a separate
GIT-PERL-HEADER rule.

This rule first populates INSTLIBDIR and then substitutes it into the
GIT-PERL-HEADER using sed:

	INSTLIBDIR=... something ...
	sed -e 's=@@INSTLIBDIR@@='$$INSTLIBDIR'=g' $< > $@

Because $INSTLIBDIR is not surrounded by double quotes, the shell
splits it at each space, causing errors if INSTLIBDIR contains a
space:

 sed: 1: "s=@@INSTLIBDIR@@=/usr/l ...": unescaped newline inside substitute pattern

Add back the missing double-quotes to make it work again.

Improved-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> +++ b/Makefile
>> @@ -2108,7 +2108,7 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
>>  	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
>>  	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
>>  	sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
>> -	    -e 's=@@INSTLIBDIR@@='$$INSTLIBDIR'=g' \
>> +	    -e 's=@@INSTLIBDIR@@='"$$INSTLIBDIR"'=g' \
>
> Good find.  FWIW, I'd find it a lot easier to read if the whole
> thing were enclosed inside a single pair of dq.

Thanks. I agree, so here's an updated version doing that.

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 2327ccb906..5e25441861 100644
--- a/Makefile
+++ b/Makefile
@@ -2116,7 +2116,7 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
 	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
 	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
 	sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
-	    -e 's=@@INSTLIBDIR@@='$$INSTLIBDIR'=g' \
+	    -e "s=@@INSTLIBDIR@@=$$INSTLIBDIR=g" \
 	    -e 's=@@PERLLIBDIR@@='$(perllibdir_SQ)'=g' \
 	    -e 's=@@PERLLIBDIR_REL@@=$(perllibdir_relative_SQ)=g' \
 	    -e 's=@@GITEXECDIR_REL@@=$(gitexecdir_relative_SQ)=g' \
-- 
2.17.0.441.gb46fe60e1d

