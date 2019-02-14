Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BB211F453
	for <e@80x24.org>; Thu, 14 Feb 2019 21:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392553AbfBNVUm (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 16:20:42 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45225 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387702AbfBNVUl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 16:20:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id w17so8068122wrn.12
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 13:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0nh7CI0aEsXxaksuxBU9Xpl6ZDdzlPgGIvN6ROgoDpo=;
        b=NbdUyTGOFLZi9bq2QLnXEdZlg2gFOz7nvrbXz6CZklXM98k4WKAjItLsEw1zd9AtkQ
         qyvbB5x9UCeKwGq6/32ffOCHwRkc87VeNrz2GGfkAz/4y5jNNrXd3FlrvH1y4/cIUnQ/
         P+iOJNjazOf6KzsTfyhftNeE/72OCMBPMERF8cNtnqf/+sagxu17clNQymrcJWhGrNA3
         P51J+gf9YgnJx2bkf7yuPWKIrBxKmPPwVexlRpxWkt0msnbw0kasWUYnBtDQXNtiRUZP
         CXH5AdcvMA55fhEuI4qQCbske4K9Fm8EaYx8MG6dWg4z26D/+vjElWe6HSC0UYkSlVGX
         ThpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0nh7CI0aEsXxaksuxBU9Xpl6ZDdzlPgGIvN6ROgoDpo=;
        b=PbvtqN0z+6RmF+ZS2FFprKkNC+qGztAXyK3zJoAAm/gvuwSLVMBc2IJQX1OOevx2D4
         /ZfXSKyKBeNDGSJyl0vbapaZfMngJ4New1ZBVtBgkIB7IYorAj9iK/0bZDHju/MSZ3AM
         pQVOwyEeHJoivOqnHRiqA81Yxc/wPebPTe4q/J76/lEsN3yyUC+8mlD1uakJ0z2mVttF
         hVnPkZhrCJLvxbGXSenMo/UUuph5kkIX+IBibZrVOVfZXyBW52C9qk4ZxcwlhJG0Ko8C
         XPJaEc4fdxo+TPHF3H289QEgIiegg0F2wgmFHmg2G4FhA/vsQHY48bj/ApDX575w4Y5c
         rQgQ==
X-Gm-Message-State: AHQUAuYadOetOqDDWgvJXrTge+KkKJwJ0BTmhYabBo9omPzt9NhK/0V/
        VnjMcn0O7zaYSruxOlkN9H0=
X-Google-Smtp-Source: AHgI3IZmrUtHfBRk0tFzUQeM4pp4QTj8SMIKJJUDMLh/nl7lQpEb0nSGNXpSrAASHnozu935SpcOoQ==
X-Received: by 2002:a5d:4ac2:: with SMTP id y2mr4053046wrs.98.1550179239634;
        Thu, 14 Feb 2019 13:20:39 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a184sm4573923wmh.37.2019.02.14.13.20.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 13:20:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        peff@peff.net, Jonathan Nieder <jrnieder@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] t/lib-httpd: pass GIT_TEST_SIDEBAND_ALL through Apache
References: <20190214063513.32041-1-tmz@pobox.com>
        <20190214201711.130216-1-jonathantanmy@google.com>
        <20190214204725.GK16125@zaya.teonanacatl.net>
Date:   Thu, 14 Feb 2019 13:20:38 -0800
In-Reply-To: <20190214204725.GK16125@zaya.teonanacatl.net> (Todd Zullinger's
        message of "Thu, 14 Feb 2019 15:47:25 -0500")
Message-ID: <xmqqr2ca6p95.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> Jonathan Tan wrote:
>>> 07c3c2aa16 ("tests: define GIT_TEST_SIDEBAND_ALL", 2019-01-16) added
>>> GIT_TEST_SIDEBAND_ALL to the apache.conf PassEnv list.  Avoid warnings
>>> from Apache when the variable is unset, as we do for GIT_VALGRIND* and
>>> GIT_TRACE, from f628825481 ("t/lib-httpd: handle running under
>>> --valgrind", 2012-07-24) and 89c57ab3f0 ("t: pass GIT_TRACE through
>>> Apache", 2015-03-13), respectively.
>>> 
>>> Signed-off-by: Todd Zullinger <tmz@pobox.com>
>>> ---
>>> I missed this with rc0, but poking through build logs I noticed a number
>>> of 'AH01506: PassEnv variable GIT_TEST_SIDEBAND_ALL was undefined'
>>> warnings.
>>> 
>>> I think exporting this in lib-httpd.sh like we do for GIT_VALGRIND* and
>>> GIT_TRACE is the way to go, as opposed to in test-lib.sh, as we do for
>>> things like GNUPGHOME.  But I could easily be wrong about that.
>> 
>> Thanks for looking into this. I think this is the right way to do it
>> too.
>> 
>> Previous discussion here [1] but I don't think any patches came out of
>> that.
>> 
>> [1] https://public-inbox.org/git/20190129232732.GB218214@google.com/
>
> Hah.  Somehow I missed that thread and Jeff's reply barely
> 24 hours before I sent this.  Hopefully this saves Jonathan
> Nieder a few minutes of patch prep & testing.

Thanks, will queue in the meantime, and let's aim for -rc2.
