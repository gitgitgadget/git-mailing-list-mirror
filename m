Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D44B1FA14
	for <e@80x24.org>; Mon, 17 Apr 2017 07:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932939AbdDQHFF (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 03:05:05 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:43125 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932744AbdDQHFE (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 Apr 2017 03:05:04 -0400
X-AuditID: 12074412-4bbff70000000b04-d5-58f4691e3127
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 7E.F7.02820.E1964F85; Mon, 17 Apr 2017 03:05:03 -0400 (EDT)
Received: from [192.168.69.190] (p5790773A.dip0.t-ipconnect.de [87.144.119.58])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3H750UV020036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 17 Apr 2017 03:05:01 -0400
Subject: Re: [PATCH] files_for_each_reflog_ent_reverse(): close stream and
 free strbuf on error
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
References: <a77dfa47-3153-3f8c-3c37-30147f93e61b@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <d26b6409-988e-386c-1fb3-914319ada8a6@alum.mit.edu>
Date:   Mon, 17 Apr 2017 09:05:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <a77dfa47-3153-3f8c-3c37-30147f93e61b@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqCuf+SXCYF2XkkXXlW4mi4beK8wW
        Z7b2Mzswe1y8pOzxeZOcx+1n21gCmKO4bFJSczLLUov07RK4MpZ9f85e8Ia/ovXrSpYGxmae
        LkZODgkBE4mdJ9czdjFycQgJ7GCSuH5lFzNIQkjgPJPEtbehILawQKLE7wtXWEBsEYFIiVnb
        p7FA1FhKtE27ClbPLKAm0b5pCiuIzSagK7Gop5kJxOYVsJc4frKdDcRmEVCVaLw/C6xXVCBE
        Ys7CB4wQNYISJ2c+AYtzClhJrLlwGWqmusSfeZegbHmJ5q2zmScw8s9C0jILSdksJGULGJlX
        Mcol5pTm6uYmZuYUpybrFicn5uWlFuma6eVmluilppRuYoQEqNAOxvUn5Q4xCnAwKvHwWhz7
        HCHEmlhWXJl7iFGSg0lJlFdM9UuEEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeFwlAOd6UxMqq
        1KJ8mJQ0B4uSOO/Pxep+QgLpiSWp2ampBalFMFkZDg4lCV7pDKBGwaLU9NSKtMycEoQ0Ewcn
        yHAeoOE+IDW8xQWJucWZ6RD5U4yKUuK83elACQGQREZpHlwvLIG8YhQHekWY1wOknQeYfOC6
        XwENZgIaHBEANrgkESEl1cA4h4vvQMN/C7MHBzauMc3wjH8aa6LSWnwsSqL+Q2OzysY3Kao5
        tosPz7snKLb1wlVRi2bJddWTdlUf6Jxync3mtbTzwsiSc8eXF4t8c/szrcRzz+amx7O3zZnl
        J/Lmp1rzwvlhjEtdFC88ZKza0ndi6+b6wmXu+6quzN7Kbz9raVh5Ye8i5uL/SizFGYmGWsxF
        xYkAj7APBPsCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/16/2017 06:55 PM, René Scharfe wrote:
> Exit the loop orderly through the cleanup code, instead of dashing out
> with logfp still open and sb leaking.
> 
> Found with Cppcheck.

Nice catch.

> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  refs/files-backend.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 50188e92f9..2889f21568 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3159,8 +3159,8 @@ static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
>  
>  	/* Jump to the end */
>  	if (fseek(logfp, 0, SEEK_END) < 0)
> -		return error("cannot seek back reflog for %s: %s",
> -			     refname, strerror(errno));
> +		ret = error("cannot seek back reflog for %s: %s",
> +			    refname, strerror(errno));
>  	pos = ftell(logfp);

It seems odd to call `ftell()` in the case that `fseek()` has failed,
but it should be harmless.

>  	while (!ret && 0 < pos) {
>  		int cnt;
> @@ -3170,13 +3170,17 @@ static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
>  
>  		/* Fill next block from the end */
>  		cnt = (sizeof(buf) < pos) ? sizeof(buf) : pos;
> -		if (fseek(logfp, pos - cnt, SEEK_SET))
> -			return error("cannot seek back reflog for %s: %s",
> -				     refname, strerror(errno));
> +		if (fseek(logfp, pos - cnt, SEEK_SET)) {
> +			ret = error("cannot seek back reflog for %s: %s",
> +				    refname, strerror(errno));
> +			break;
> +		}
>  		nread = fread(buf, cnt, 1, logfp);
> -		if (nread != 1)
> -			return error("cannot read %d bytes from reflog for %s: %s",
> -				     cnt, refname, strerror(errno));
> +		if (nread != 1) {
> +			ret = error("cannot read %d bytes from reflog for %s: %s",
> +				    cnt, refname, strerror(errno));
> +			break;
> +		}
>  		pos -= cnt;
>  
>  		scanp = endp = buf + cnt;
> 

Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>

Michael

