Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 274CB1FEB3
	for <e@80x24.org>; Wed,  4 Jan 2017 01:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965549AbdADBHu (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 20:07:50 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36376 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbdADBHs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 20:07:48 -0500
Received: by mail-lf0-f68.google.com with SMTP id t196so27096821lff.3
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 17:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/GzsCFhaB4tgcZcRdijgTeabFc8RvEwks12DJzXtRhU=;
        b=N4L96TSPT+UA/RXcbQumI5Go2G5lIFfq5VYjZNLRvv2fXmCkgDrh3oe+qfAjYZOLiI
         uVIuppbMJGe6TgHAepU0QoMQWEa7Fotn8Pg8BH9UeEsX+xhCXZ6VcQvWCq6VBNLHWTOJ
         rbcOa5O455a764Bv2FZnuSzkcb2WaeBCsnzgQmc1LKlmf6wZA7Uw69Po3IVKRkKoplxj
         HprxiuOlatB+8bGADf3KmuKEuKi/MkZb2s24pwDNRWQAQ86kYmXkyyZzYA/zoeyqFUCT
         +b98pcLfm1hOKL95luFWap6CAm4xIX7N5i7M0hmI5TGXeWaDd1pVdY03xL6th3M4NX/s
         LKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/GzsCFhaB4tgcZcRdijgTeabFc8RvEwks12DJzXtRhU=;
        b=RFuGLwShaw3WZWmtspnbYQurNOODDWiXcU9pczbjnJdOtm3AfpGmHJKlJBgEbDTRfL
         oD3kdJvtWJZGyLXocWsGO8OrtZ8M9xgIS7s727oecx+9HcAZFh4bIAd6mhG5LNMNAMX/
         s4FhTtP6/QjPI9k+Xr9c3sbMOvL94eFVLFxiJCDti4CYI2NJkZxDetzfyiqdQPdW8BLf
         DZ5yi9DYBmF4F81G5Xm5hkQBCMG1q8y1s5kJANK/omqTp9q0vy+kT9ZsNOp3VWx9Vcn3
         OHmu4yR/BXl1Vg9JNLj/bugS/3LRG4hwjR/W0zU7rKjA3ucxweeRQ3/6owyey8ChVUcT
         biKA==
X-Gm-Message-State: AIkVDXLdLkMx24VrIhKMOcmBA1Q4MbcXG2flRm3SCWPVLow9jthwCqkXWZpyfEyh9ZCmIbaQWyOoLn9Cd9dQhA==
X-Received: by 10.46.14.9 with SMTP id 9mr21508134ljo.59.1483492066861; Tue,
 03 Jan 2017 17:07:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.79 with HTTP; Tue, 3 Jan 2017 17:07:26 -0800 (PST)
In-Reply-To: <20170103190923.11882-5-bmwill@google.com>
References: <1481566615-75299-1-git-send-email-bmwill@google.com>
 <20170103190923.11882-1-bmwill@google.com> <20170103190923.11882-5-bmwill@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 3 Jan 2017 17:07:26 -0800
Message-ID: <CA+P7+xrgt+aTF4ibJ139=WihwHwG_m01bjAaF5-VW=Rk8u1ykA@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] real_path: have callers use real_pathdup and strbuf_realpath
To:     Brandon Williams <bmwill@google.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 3, 2017 at 11:09 AM, Brandon Williams <bmwill@google.com> wrote:
> Migrate callers of real_path() who duplicate the retern value to use
> real_pathdup or strbuf_realpath.

Nit: s/retern/return
