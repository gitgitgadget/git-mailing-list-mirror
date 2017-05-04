Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B7E2207FF
	for <e@80x24.org>; Thu,  4 May 2017 05:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752579AbdEDFfd (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 01:35:33 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33122 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752181AbdEDFfc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 01:35:32 -0400
Received: by mail-pg0-f68.google.com with SMTP id s62so740813pgc.0
        for <git@vger.kernel.org>; Wed, 03 May 2017 22:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=MNQommfWGr+Ibv8PkE40iDJVWs+UFLpIy5CcRrEQSns=;
        b=LWFsiJ07NLDkYGMggT3YTZoeO5LaqYVxR8jZQ7Cp6JXpxD6fvGGvogjuLzqPHIcxcQ
         B1GtqGS0lbemCxdNtYS5NiwBzA2NqgOK2xnnaPtUPbtH4a7a4N5OO1o8AGyvNlZi58GG
         eSjLwoW+es8JfT6mwmrld9gcMUkNAED1G7riRtf9Tdo8iHd99IvJNhX7ruu4rGazIeFz
         vMnWn+9P4ZGODdX4hrmIl4qGXDveUO+EGMdssra40Bk//L8iSdSCtj1KkIqTY8Y1gLzG
         OL4YkRP99buSOjzLwbop/9Pt++KHgxsXvbYssl8hKf2IQoaN+1Um7N2uWNqqVTuD5Q5R
         JC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=MNQommfWGr+Ibv8PkE40iDJVWs+UFLpIy5CcRrEQSns=;
        b=P4IsaoP7RbP4s20v1vI4fCAxxitKa1z3/30zY4M7GBQespFnqwDQKUqxAapV2xFVy5
         eL/bt7IQ6vhNfc28cJ6K8+2buBCBUEO95DQCafHlPjqr4P0DEy2GgnilSTgnJiPT6r00
         VTRs9UqsKu0ohEGOJZaoRnf4boDpxvIidprqkzeDVHKHDPN6dKYpRr29b2Rm7i0bu5af
         XKFXF3ZEvtcmeY9Vx35DvZDnz6F9d+sjf5ZqmKa97m3SwB0wy9U7Xef2eEZk3of9hJiZ
         TyARJREmtCLvyCVaObJp6Uepqv82ZAWTfZVyXcmg4bf26Yr+LS2t+o2clj2f/G7u+9+s
         B4WA==
X-Gm-Message-State: AN3rC/7S65c3eopFheYUnOdy7dF9Twoa/atl7MXPokeBit/siKqqpM2z
        XQzz6E2xyl4Qtw==
X-Received: by 10.99.116.82 with SMTP id e18mr15860422pgn.1.1493876131986;
        Wed, 03 May 2017 22:35:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:21be:aa3e:8063:4b3])
        by smtp.gmail.com with ESMTPSA id p3sm1487212pgd.36.2017.05.03.22.35.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 03 May 2017 22:35:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 04/21] wrapper.c: add warn_on_fopen_errors()
References: <20170420112609.26089-1-pclouds@gmail.com>
        <20170503101706.9223-1-pclouds@gmail.com>
        <20170503101706.9223-5-pclouds@gmail.com>
Date:   Wed, 03 May 2017 22:35:30 -0700
In-Reply-To: <20170503101706.9223-5-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Wed, 3 May 2017 17:16:49 +0700")
Message-ID: <xmqqh9119obh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  dir.c             |  3 +--
>  git-compat-util.h |  2 ++
>  wrapper.c         | 10 ++++++++++
>  3 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index f451bfa48c..8218a24962 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -745,8 +745,7 @@ static int add_excludes(const char *fname, const char *base, int baselen,
>  
>  	fd = open(fname, O_RDONLY);
>  	if (fd < 0 || fstat(fd, &st) < 0) {
> -		if (errno != ENOENT)
> -			warn_on_inaccessible(fname);
> +		warn_on_fopen_errors(fname);

At least in the original, a reader can guess that, because errno
cannot be NOENT if open(2) succeeded and fstat(2) failed, we call
warn_on_inaccessible() only when we fail to open.

This change makes it harder to see why this is OK when the failure
is not in open(2) but in fstat(2).

	fd = open(fname, O_RDONLY);
	if (fd < 0 || fstat(fd, &st) < 0) {
-		if (errno != ENOENT);
-			warn_on_inaccessible(fname);
-		if (0 <= fd)
+		if (fd < 0)
+			warn_on_fopen_errors(fname);
+		else
			close(fd);
		... and the remainder of the original ...

or something like that, perhaps?

> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -418,6 +418,16 @@ FILE *fopen_for_writing(const char *path)
>  	return ret;
>  }
>  
> +int warn_on_fopen_errors(const char *path)
> +{

Does this need to be returning "int", or should it be "void",
because it always warns when there is an issue, the caller does not
get to choose to give its own warning?

> +	if (errno != ENOENT && errno != ENOTDIR) {
> +		warn_on_inaccessible(path);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
>  int xmkstemp(char *template)
>  {
>  	int fd;
