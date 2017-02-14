Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 706021FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 21:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbdBNVbs (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 16:31:48 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:35666 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbdBNVbr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 16:31:47 -0500
Received: by mail-ot0-f193.google.com with SMTP id 65so19079920otq.2
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 13:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=b6vDAKkmwzTqqkr61gvHOw+SZzjbTsL/TlBPSq7YJ1A=;
        b=iFSrqcLMNYhKLySWOtMZsDuMPFyqvqC3MULh5fnocrttcJBY5T2HgJBVzqdHsWODUv
         SWCvWy57I7s/darGGF7reT6qucUMgW5Ajn8LqSfvqjhFGQjI12cnsTcw5RyPK3BzdLhx
         gH8ivujJyZWVw6yHJQCMndIZfpS/wH5LIJ4tnmHnflElkadzqGw3nkhIpp2C9s2RRmgp
         YPMRHhN8aDs+0kmW18ojlxw73dhr/L+RFLobYuLJbyPtvrh2jAv10kweqeRTSyKEZztm
         QV+vBcS4oBFYKn62tSpc1PUDclwfSb2OHUhOyAASmj4U898rzSuWQ6SDMuECqwOaQuKt
         1bHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=b6vDAKkmwzTqqkr61gvHOw+SZzjbTsL/TlBPSq7YJ1A=;
        b=RN/F4r3CiWTpOSjRvB4d/JGL9Kn85a23WBnpWS+kcpy+nl3W5M7NJbjlf9pQow+ujc
         s08zctYKndQQe2ku6R+KryP581V8wXnqYjmK4ncKv8eNWDDKjGjTJZ1Q1BLe9IyS4e4E
         baGVcxN/R/dZLfOE3J5NzyjMSDsPNCT0IahtNX7faCU2w39nLwpB2uA5tF7y30zeBvtQ
         g+xjaJBuG6J+0ubtji2kt0pNnWZTKIW9cuENNt1n5Fx1CXWpPXHj1Xpyc1HITxrR2xTG
         78ueomawAvcodrjppgMx9SLSBcKZxUvYZ4HJRLKw4rIwVsPlntp5BBrni7stdDMGjmik
         8OKA==
X-Gm-Message-State: AMke39kWvwoOoIVO0/eXaDfFJI4pHTpWwTdzYysp2U6KvA3VdE/jB2UemTy+vGO7ycXs1A==
X-Received: by 10.99.171.5 with SMTP id p5mr34415479pgf.182.1487107906399;
        Tue, 14 Feb 2017 13:31:46 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:2447:f72c:8fdf:75c6])
        by smtp.gmail.com with ESMTPSA id u29sm3050890pfl.17.2017.02.14.13.31.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 13:31:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     cornelius.weig@tngtech.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        bitte.keine.werbung.einwerfen@googlemail.com, j6t@kdbg.org
Subject: Re: [PATCH v2 2/2] completion: checkout: complete paths when ref given
References: <4f8a0aaa-4ce1-d4a6-d2e1-28aac7209c90@tngtech.com>
        <20170214212404.31469-1-cornelius.weig@tngtech.com>
        <20170214212404.31469-2-cornelius.weig@tngtech.com>
Date:   Tue, 14 Feb 2017 13:31:44 -0800
In-Reply-To: <20170214212404.31469-2-cornelius.weig@tngtech.com> (cornelius
        weig's message of "Tue, 14 Feb 2017 22:24:04 +0100")
Message-ID: <xmqq8tp88nnj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cornelius.weig@tngtech.com writes:

> From: Cornelius Weig <cornelius.weig@tngtech.com>
>
> Git-checkout completes words starting with '--' as options and other
> words as refs. Even after specifying a ref, further words not starting
> with '--' are completed as refs, which is invalid for git-checkout.
>
> This commit ensures that after specifying a ref, further non-option
> words are completed as paths. Four cases are considered:
>
>  - If the word contains a ':', do not treat it as reference and use
>    regular revlist completion.
>  - If no ref is found on the command line, complete non-options as refs
>    as before.
>  - If the ref is HEAD or @, complete only with modified files because
>    checking out unmodified files is a noop.
>    This case also applies if no ref is given, but '--' is present.

Please at least do not do this one; a completion that is or pretends
to be more clever than the end users will confuse them at best and
annoy them.  Maybe the user does not recall if she touched the path
or not, and just trying to be extra sure that it matches HEAD or
index by doing "git checkout [HEAD] path<TAB>".  Leave the "make it
a noop" to Git, but just allow her do so.

I personally feel that "git checkout <anything>... foo<TAB>" should
just fall back to the normal "path on the filesystem" without any
cleverness, instead of opening a tree object or peek into the index.

