Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F08561F453
	for <e@80x24.org>; Fri,  1 Feb 2019 21:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfBAVRT (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 16:17:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39142 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfBAVRS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 16:17:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so8559910wra.6
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 13:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/cex/8kkHxYlUO3LRfAFzJpNT+mVE9XojUvXMs/uXOw=;
        b=nKLz06iYA4JrQgZfqI/S7m3gEdoHyHKCzetbFTV+c+QVaQos9Xhgm5NpkV763X9gKq
         F79l2jPuJ2bGM1gyffDqW7WFF4eAFSH5XnAyh7EswL5ShCEUsT4WIivwhoa2ZQ0wA7G3
         VdXFWnkKMQ9c9gfo6weiT4P9pOepajb2E7005NqM8evKoTDw7CnF2yo4xA4qVNVj2qM6
         TRU0QSfbLGX/DFp7cMwOtaATlblyLX5XKhy10JxV1o5fwy35cUEUHOgF4D9t9UlyJ90V
         RXilqUGoTJjv4Psqv794okrLnb52Hzci6oGhjm7hhPA2Qz82PUigD1RpjA7CWCbpoT85
         En8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/cex/8kkHxYlUO3LRfAFzJpNT+mVE9XojUvXMs/uXOw=;
        b=ZqLweo6h40a7fq+yXQigYgrq9cz1gkugndWUGlzkrye4+u5A6gU76IjbkiFzwv3yMR
         NGP24n9pP+rZ+Hui6rH/X7RIO8nf3Br2u0/YexF6BUXd7hpm1NKyV5rEIa0xUE1emEKY
         6jm5BsG+HOWA+REyw6C0RprLEYi+LGsRrpB79q+izW7E9RSvTpURaNYEfqmbSiS4bFHv
         kzUiYvhXfSmZbWW8PRwxQ6iflsSh2sHUk1GrFCN4U391h8isC04Y0QZVfwpeZNBeuOkz
         25J6hhNEwBAgNSCp2wRlfBiOTP5KkxHfQoernMWdFO9rws9sIXceiH/SfxpOSj2pNWtT
         ymOg==
X-Gm-Message-State: AJcUukcpP99rZL2dhF8JNIlJ7m5pCxWj9qKdm47Oh5RcG3A3iLexkpfL
        mKtTA4XDG4CN7jA29iGKjKk=
X-Google-Smtp-Source: ALg8bN4+LxOt8EryG1UYN2af2GKjoxIWUxIx/14R5h/1yVOsQ9q8On7kp1ne4ue3/IHdw+QJiCdBKw==
X-Received: by 2002:a5d:6988:: with SMTP id g8mr38582806wru.33.1549055836550;
        Fri, 01 Feb 2019 13:17:16 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a14sm2013362wrr.13.2019.02.01.13.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 13:17:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dan McGregor <dan.mcgregor@usask.ca>
Cc:     git@vger.kernel.org, masayasuzuki@google.com
Subject: Re: [PATCH] http: cast result to FILE *
References: <20190201193004.88736-1-dan.mcgregor@usask.ca>
Date:   Fri, 01 Feb 2019 13:17:15 -0800
In-Reply-To: <20190201193004.88736-1-dan.mcgregor@usask.ca> (Dan McGregor's
        message of "Fri, 1 Feb 2019 13:30:04 -0600")
Message-ID: <xmqqr2crxl7o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dan McGregor <dan.mcgregor@usask.ca> writes:

> Commit 8dd2e88a92 ("http: support file handles for HTTP_KEEP_ERROR",
> 2019-01-10) introduced an implicit assumption that rewind, fileno, and
> fflush are functions. At least on FreeBSD fileno is not, and as such
> passing a void * failed.

I am not strongly opposed to this patch, but shouldn't you be filing
a bug report against FreeBSD instead?  The implementation is free to
define fileno(fh) as a macro, but it shouldn't force such a change
to conformant programs.

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=206146

> Explicitly cast result to a FILE * when using standard functions that
> may ultimately be macros.
>
> Signed-off-by: Dan McGregor <dan.mcgregor@usask.ca>
> ---
>  http.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/http.c b/http.c
> index 954bebf684..8b9476b151 100644
> --- a/http.c
> +++ b/http.c
> @@ -1996,12 +1996,12 @@ static int http_request_reauth(const char *url,
>  		strbuf_reset(result);
>  		break;
>  	case HTTP_REQUEST_FILE:
> -		if (fflush(result)) {
> +		if (fflush((FILE *)result)) {
>  			error_errno("unable to flush a file");
>  			return HTTP_START_FAILED;
>  		}
> -		rewind(result);
> -		if (ftruncate(fileno(result), 0) < 0) {
> +		rewind((FILE *)result);
> +		if (ftruncate(fileno((FILE *)result), 0) < 0) {
>  			error_errno("unable to truncate a file");
>  			return HTTP_START_FAILED;
>  		}
