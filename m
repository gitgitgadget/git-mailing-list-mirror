Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 722DC1FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 18:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752967AbdBMSeL (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 13:34:11 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33191 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752952AbdBMSeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 13:34:09 -0500
Received: by mail-oi0-f66.google.com with SMTP id j15so364182oih.0
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 10:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=YPpweIFdr8JNafeVUWUHOBw8Hp2cFvcDp/wbtve1PBU=;
        b=mG15etk394TpM+mYm0jNL3H+JrqLNug7Wgr//zY3VEtmfzmAbWqyk4xUrS2eNzDcho
         uQqm1YvOi5sPr4KrgvklyRIbIV8YZf0Uidt3lksSyR6fs0gjP3lq/rajh25CTaslhQtp
         +n3SAsGnNI6avZFPJm5svwPs77+pKjXRMRRSSP2sruYKzr7CziWgFj9Np7VGNbQuSdV3
         Woh4LvU7N85V+LNv6RAAAP9uyzfTVloR3KCGbkAub+mlThWSEE9fc3YxWRNuF7JnWWdc
         vQuAJ5Dt3qQVusPdN9NqOc/WoyF22ATZDylksGa58LtLKajclPUkLIhXuNbHSGbVES/j
         SD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=YPpweIFdr8JNafeVUWUHOBw8Hp2cFvcDp/wbtve1PBU=;
        b=PTHFvgtba0tG+q6o39V/Sh1hi7gCCrSigILLZJyt+mlwvU3FpOyPA1bjOQOe4lR2Fj
         OL64AgV1sck3Nb+1+Xob/EEWpr7+JK/1FgtfaLi7Ltv9c4lr32vbCptxQKZjEssXHkZP
         wTos49n6GE2OpIWn7e6L8phVreiaRnPgtiy6zPGw80bi11REj1YY16zsg4Es8zWgxk5l
         MY3x0u+Izc1EHFddhTe2coINh5J9Ogdz3IFH8SW4tVBaI/QZZFs6mZEk+BB4/U9OHyZ7
         9hEXaCzzd6NbMqyzBzERzWSL3cN3lRvQ/i35BbzSheiG/Wl4yFymu41yN+s3Sq7yhCpZ
         Z1Xw==
X-Gm-Message-State: AMke39mj42o4Xami0C1+xlcMQQdU4Fc4VNGl2hHGdFnrNMQR11hYEUxwz5XBXKbH9/zA6Q==
X-Received: by 10.84.224.131 with SMTP id s3mr31553751plj.162.1487010848207;
        Mon, 13 Feb 2017 10:34:08 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d0e0:42a7:601f:5154])
        by smtp.gmail.com with ESMTPSA id d78sm22310582pfb.43.2017.02.13.10.34.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 10:34:07 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clean: use warning_errno() when appropriate
References: <20170213092702.10462-1-pclouds@gmail.com>
Date:   Mon, 13 Feb 2017 10:34:06 -0800
In-Reply-To: <20170213092702.10462-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 13 Feb 2017 16:27:02 +0700")
Message-ID: <xmqqwpcudjoh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> All these warning() calls are preceded by a system call. Report the
> actual error to help the user understand why we fail to remove
> something.

I think this patch is probably correct in the current code, but I
say this only after following what quote_path_relative() and
relative_path() that is called from it.  These warnings are preceded
by a call to a system library function, but it is not apparent that
they are immediately preceded without anything else that could have
failed in between.

    Side note.  There are many calls into strbuf API in these two
    functions.  Any calls to xmalloc() and friends made by strbuf
    functions may see ENOMEM from underlying malloc() and recover by
    releasing cached resources, by which time the original errno is
    unrecoverable.  So the above "probably correct" is not strictly
    true.

If we care deeply enough that we want to reliably show the errno we
got from the preceding call to a system library function even after
whatever comes in between, I think you'd need the usual saved_errno
trick.  Is that worth it?---I do not offhand have an opinion.

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  builtin/clean.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/clean.c b/builtin/clean.c
> index d6bc3aaaea..dc1168747e 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -175,7 +175,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
>  		res = dry_run ? 0 : rmdir(path->buf);
>  		if (res) {
>  			quote_path_relative(path->buf, prefix, &quoted);
> -			warning(_(msg_warn_remove_failed), quoted.buf);
> +			warning_errno(_(msg_warn_remove_failed), quoted.buf);
>  			*dir_gone = 0;
>  		}
>  		return res;
> @@ -209,7 +209,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
>  				string_list_append(&dels, quoted.buf);
>  			} else {
>  				quote_path_relative(path->buf, prefix, &quoted);
> -				warning(_(msg_warn_remove_failed), quoted.buf);
> +				warning_errno(_(msg_warn_remove_failed), quoted.buf);
>  				*dir_gone = 0;
>  				ret = 1;
>  			}
> @@ -231,7 +231,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
>  			*dir_gone = 1;
>  		else {
>  			quote_path_relative(path->buf, prefix, &quoted);
> -			warning(_(msg_warn_remove_failed), quoted.buf);
> +			warning_errno(_(msg_warn_remove_failed), quoted.buf);
>  			*dir_gone = 0;
>  			ret = 1;
>  		}
> @@ -982,7 +982,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  			res = dry_run ? 0 : unlink(abs_path.buf);
>  			if (res) {
>  				qname = quote_path_relative(item->string, NULL, &buf);
> -				warning(_(msg_warn_remove_failed), qname);
> +				warning_errno(_(msg_warn_remove_failed), qname);
>  				errors++;
>  			} else if (!quiet) {
>  				qname = quote_path_relative(item->string, NULL, &buf);
