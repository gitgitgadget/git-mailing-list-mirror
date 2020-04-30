Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E03BC8300A
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 09:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 671492173E
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 09:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaXodGyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgD3JW0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726127AbgD3JW0 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Apr 2020 05:22:26 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D7FC035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 02:22:24 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s9so2259009qkm.6
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 02:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t+J++kcWoh6ia3r7B+YptHy8V39wO2ymBFelNNJlsyo=;
        b=AaXodGyjZ+zqE+YxxvsoMn+tleH3P+A1N3FAM8Q5suxVyJy1dAyp42s2+hDu/7OE5h
         cZ3C5kpj63KlemVfLzF9a0oBhl45+yzAgByDxkVUrl+plvJ+HsZnj+P6bQIY8NHZYKKr
         pZ3L6k9157nyemjtsnUo9XdBNNov5nN9LK0y4L0wBuLhAjRxbf3r15gV5CCDZMHo22i6
         QQKXCPthhL8HKTamZFmAgmflp9LIa7RaQ+AGcuKCcFnC+uBBREQph5CG+xmpin7AtfGV
         zOu68HNMajo3b9soKqvhS20RfpTuNRK5UuHgUwd0xFteMz1POw258V9yq2b8cgsomNgT
         r9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t+J++kcWoh6ia3r7B+YptHy8V39wO2ymBFelNNJlsyo=;
        b=GrHQ+g3/XZo4XXVXi9qYMV9FFYnlXB/ct+Hljcu4zLNjSiKb3WaZ4oUnpB1eyM3tfo
         H0fqjry+bwvx9c+Yp8EsGyT4UFQ/YkwmN/arr95OIbGaad7vSr3udOh3WWN7J5EBXbQi
         LRC7NBzIuPvCNjkDe6xJuKmjioTml2PoDiXXeJco1KO7rZDCBw9ceXrmOr/wYJU4GbYg
         AZdEg8byYBRdPZY9KmG8UP2MJUswqWMZWfxJq9C5csGW3tKClQ46/pFPJ5vYy6mhV139
         2fJWsv1P7sTNbwQqOeEHGITNwzFWQCN1OFfVANrzMGyNykukNRhgWGaWQFP5DZvYs8Ig
         0myw==
X-Gm-Message-State: AGi0PuYo2QPj963zgLKAbqkXvhDzV4UEwmLYWY4RXLVStgKSRh9qnqXR
        DN9JDvWwFRwzAX1ZQBDQz9Q=
X-Google-Smtp-Source: APiQypLWzx/c03OkfElY5dfjIDWuO4/lFJEs3jmBTmagswxG3tlNBDI2iGCeLI1DSoAFrJVytLlCVw==
X-Received: by 2002:ae9:eb52:: with SMTP id b79mr2607281qkg.300.1588238543673;
        Thu, 30 Apr 2020 02:22:23 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id g47sm1711787qte.54.2020.04.30.02.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 02:22:22 -0700 (PDT)
Date:   Thu, 30 Apr 2020 05:22:20 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] lib-submodule-update: pass OVERWRITING_FAIL
Message-ID: <20200430092220.GA25331@generichostname>
References: <cover.1588162842.git.liu.denton@gmail.com>
 <22eacd20a8213c3281974a6c103fd2d00c95efaa.1588162842.git.liu.denton@gmail.com>
 <xmqqpnbqw0vz.fsf@gitster.c.googlers.com>
 <20200430011056.GA3036@generichostname>
 <xmqqd07ptzbw.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd07ptzbw.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 08:41:23PM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> >> Here, $command may or may not be a git command and more importantly,
> >> it could be a shell function, right?  Then we need to take it into
> >> account that 
> >> 
> >> 	VAR=VAL shell_function args...
> >> 
> >> will not work, no?
> >> 
> >> Some shells do not make this a single-shot environment variable
> >> assignment that will not persist once the single function invocation
> >> returns.
> >
> > ...
> > which makes me suspect that these shells are not POSIX-compliant. What
> > are some examples of shells that behave this way?
> 
> I think the most relevant thread is the one that contains this
> message:
> 
>   https://public-inbox.org/git/7vljfzz0yd.fsf@alter.siamese.dyndns.org/
> 
> FWIW, shells that do not retain the assignment after a function
> returns are not POSIX compliant.

Hmm, interesting. Running an experiment:

	$ cat test.sh
	f () {
		echo $var
	}

	var=test f
	echo $var
	$ bash test.sh
	test

	$ bash --posix test.sh
	test
	test
	$ dash test.sh
	test


So it seems like there's a bug in dash. Guess it's time to file a bug
report...
