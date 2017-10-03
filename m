Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B56A32036B
	for <e@80x24.org>; Tue,  3 Oct 2017 22:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751255AbdJCWxU (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 18:53:20 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34565 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbdJCWxT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 18:53:19 -0400
Received: by mail-pg0-f66.google.com with SMTP id u27so11181073pgn.1
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 15:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nshmywg+uJmL+Eu9hD5czttHk+QNJZjShAlfjqPS2/c=;
        b=hS9y4iJUs9zm2aic8xfkQg6aSkS6KbYkVcmwUtJ614SlI+uakKIVa5gxnTGSCb9Dh1
         zD481UTVZU0ftZadhN/fBxAUudu748ThagTEeUlqCXUIiFoGbvFX4y9Jb+wj/op7ediF
         /cqQRJO9Nz/A7uW9R5pwn7PYzMQib5VmJy5dFaUEEGo7hWOfrTkok1+OK7qPvd1cMP+g
         LHxFrWRHW1qZEf4WPVMiL+MOhLGxAoRwN7ucJJYJriX5+HFGq6vNHdnb58FpX7XIL2np
         AvX80dxl3bXw+AajeV0kQ/cCwfbZR3kPSoqLQtT+ZQSKSbcbXMXLRZ1GLvR801cKi5pA
         Krew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nshmywg+uJmL+Eu9hD5czttHk+QNJZjShAlfjqPS2/c=;
        b=SUgfzzCz1bdA6JwlIk5CEk33gOQkNcVcAP3WMUCPqB7vAX13Sbjr4lRmvJdm7AhazW
         nnPbQUXjU1/PIcs0GP6blWq+/czKjDTqB8YpTYs2LH3Np+qXA3DnByGvt7q/FfBCbJGh
         CA+beqzZeRAkQmh0GyeQZI2ESFhM4f6B82/OkWz/Itid+jB3Iiq+foygHu1Jaa4x0Lcj
         PJNKobHxjB0JiTOUeei7MYzSeyRl6Gt+MBdAaMpzNG27cs2BeCUhIVFKpMcdZtqTYaCX
         a1VPvajzVnUJiQYKVwLrwagYOAMpFmS9uuG5Mr5ACF1oWzoQOJd+4aXrf9MWabDqaeqc
         S2ew==
X-Gm-Message-State: AHPjjUi6cpPc69xSRGVPXM9Pd+wW6v0Z+COoubMr8sL9TCMOu8ooh0ib
        7jMdpK9vwzZM2H4qASguouUuOViF
X-Google-Smtp-Source: AOwi7QCUAh2LLonY5xx1lb5+7k8w4SxxKF9HdTNn0+qnmZvuYqdzuzgYlkNloMqygPV+hYaPty90ew==
X-Received: by 10.98.102.82 with SMTP id a79mr19033298pfc.109.1507071199066;
        Tue, 03 Oct 2017 15:53:19 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:3463:ab6b:5863:927c])
        by smtp.gmail.com with ESMTPSA id w12sm23976199pfk.83.2017.10.03.15.53.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 03 Oct 2017 15:53:18 -0700 (PDT)
Date:   Tue, 3 Oct 2017 15:53:15 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.ath.cx>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] http-push: fix construction of hex value from path
Message-ID: <20171003225315.GE19555@aiede.mtv.corp.google.com>
References: <20171003195713.13395-1-t.gummerer@gmail.com>
 <20171003195713.13395-3-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171003195713.13395-3-t.gummerer@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thomas Gummerer wrote:

> The get_oid_hex_from_objpath takes care of creating a oid from a
> pathname.  It does this by memcpy'ing the first two bytes of the path to
> the "hex" string, then skipping the '/', and then copying the rest of the
> path to the "hex" string.  Currently it fails to increase the pointer to
> the hex string, so the second memcpy invocation just mashes over what
> was copied in the first one, and leaves the last two bytes in the string
> uninitialized.

Wow.  The fix is obviously correct.

> This breaks valgrind in t5540, although the test passes without
> valgrind:
[...]
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  http-push.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Would it be straightforward to add a correctness test for this?  It
seems like this code path didn't work at all and no one noticed.

This is the code path in http-push.c which says

 /*
  * NEEDSWORK: remote_ls() ignores info/refs on the remote side.  But it
  * should _only_ heed the information from that file, instead of trying to
  * determine the refs from the remote file system (badly: it does not even
  * know about packed-refs).
  */
 static void remote_ls(const char *path, int flags,

I think the problem is that when it fails, we end up thinking that
there are *fewer* objects than are actually present remotely so the
only ill effect is pushing too much.  So this should be observable in
server logs (i.e. it is testable) but it's not a catastrophic failure
which means it's harder to test than it would be otherwise.

Moreover, this is in the webdav-based "dumb http" push code path,
which I do not trust much at all.  I wonder if we could retire it
completely (or at least provide an option to turn it off).

> diff --git a/http-push.c b/http-push.c
> index e4c9b065ce..e9a01ec4da 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -1018,7 +1018,7 @@ static int get_oid_hex_from_objpath(const char *path, struct object_id *oid)
>  	memcpy(hex, path, 2);
>  	path += 2;
>  	path++; /* skip '/' */
> -	memcpy(hex, path, GIT_SHA1_HEXSZ - 2);
> +	memcpy(hex + 2, path, GIT_SHA1_HEXSZ - 2);
>  
>  	return get_oid_hex(hex, oid);

Thanks,
Jonathan
