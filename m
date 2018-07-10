Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AFA81F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 21:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732255AbeGJVXa (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 17:23:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37083 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732187AbeGJVX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 17:23:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id q10-v6so16038507wrd.4
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 14:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uSJIy3NiWOEBAb/op2o7PZz+SP7SjNp6DkwQgfXOmuE=;
        b=iGC1j4vm9VyIEXQcjW8l53BClCd5dByPwPHVd+VmCmHfBzVTSWRWDkENSRHO7Z5wTQ
         5gp9okkkF0o3YUrQ7VlUHTjTz5IAO1hlqYZllGtiD6671NQmHunhaIdpux4ua5aXS5yv
         rdGcPRqQUFVmLfLP4mfPt9F99+E+83g0zTdc5xscf3aLYw9k+wV/y1GSvBYzcpR7C3Xe
         KQik6PVM9IwmBfwSb2qPwahg1m3HOS7jdzPH1uscu065hh0p4eFII4BUhT0EW90JkSmN
         VEvTwex6zQJ7noJaRqmEhxnbgQO8rI+uN6rGnTFfkr9IKlpgHNiUBBZrPOmYf3MlFzKn
         tCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uSJIy3NiWOEBAb/op2o7PZz+SP7SjNp6DkwQgfXOmuE=;
        b=makuax0VaZ5OajLLngMDSMx707Re98+UZnwYDcXRlWJ4PFZ8grfZpvKi242d1KojHa
         xFjgj+VjQI0XbfABPjuo72+JnVX3WFTcpLfcg6mVouOSb4h4wpXrd1BmhRAyLRpW4gQy
         tD4uYkjCzBMl8twlZQXj/8LILr3Zl7IhWTwVLuKJxtn4WiV3BdSDI2TjSio8LRunAL2Y
         UFdGgINGBZpvGMDCH2g+cDic47dhQc7WJuzQMIiaNp/iTZACzg7MPoet4joxjSHD8pTl
         H5J5RU2XdgyVtl5KWV7t06oJfsl1c9qLPr0/6wdlS6/scj5o3ZteAkCXak/0ZDqNvbqu
         eWWQ==
X-Gm-Message-State: AOUpUlFlbt4RthDpLEmmRBIfnJiyIDnyHnlWKIvT8R1rZaskxeLYG5TP
        xEF5IGtW/KTc9X4ruPz10ds=
X-Google-Smtp-Source: AAOMgpfQ62SK+/lOfLPNF9KkRicRKqVJAeMWPI5wkD6yue81fxqoYT1OL7ywGDakPsuW5L2E+NVxLg==
X-Received: by 2002:adf:f091:: with SMTP id n17-v6mr7721393wro.49.1531257752046;
        Tue, 10 Jul 2018 14:22:32 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l6-v6sm221856wmh.41.2018.07.10.14.22.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 14:22:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        "sandals\@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        "stolee\@gmail.com" <stolee@gmail.com>
Subject: Re: [PATCH v2] convert log_ref_write_fd() to use strbuf
References: <20180710182000.21404-1-benpeart@microsoft.com>
        <20180710210806.23384-1-benpeart@microsoft.com>
Date:   Tue, 10 Jul 2018 14:22:30 -0700
In-Reply-To: <20180710210806.23384-1-benpeart@microsoft.com> (Ben Peart's
        message of "Tue, 10 Jul 2018 21:08:22 +0000")
Message-ID: <xmqqefga6b1l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <Ben.Peart@microsoft.com> writes:

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index a9a066dcfb..054306d779 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1582,26 +1582,17 @@ static int log_ref_write_fd(int fd, const struct object_id *old_oid,
>  			    const struct object_id *new_oid,
>  			    const char *committer, const char *msg)
>  {
> -	int msglen, written;
> -	unsigned maxlen, len;
> -	char *logrec;
> -
> -	msglen = msg ? strlen(msg) : 0;
> -	maxlen = strlen(committer) + msglen + 100;
> -	logrec = xmalloc(maxlen);
> -	len = xsnprintf(logrec, maxlen, "%s %s %s\n",
> -			oid_to_hex(old_oid),
> -			oid_to_hex(new_oid),
> -			committer);
> -	if (msglen)
> -		len += copy_reflog_msg(logrec + len - 1, msg) - 1;
> -
> -	written = len <= maxlen ? write_in_full(fd, logrec, len) : -1;
> -	free(logrec);
> -	if (written < 0)
> -		return -1;
> +	struct strbuf sb = STRBUF_INIT;
> +	int ret = 0;
>  
> -	return 0;
> +	strbuf_addf(&sb, "%s %s %s", oid_to_hex(old_oid), oid_to_hex(new_oid), committer);
> +	if (msg && *msg)
> +		copy_reflog_msg(&sb, msg);
> +	strbuf_addch(&sb, '\n');
> +	if (write_in_full(fd, sb.buf, sb.len) < 0)
> +		ret = -1;
> +	strbuf_release(&sb);
> +	return ret;

Nicely plugged here.  Looks quite sensible.
