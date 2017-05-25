Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4738209FD
	for <e@80x24.org>; Thu, 25 May 2017 23:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165955AbdEYXQO (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 19:16:14 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35256 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030469AbdEYXQL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 19:16:11 -0400
Received: by mail-pf0-f196.google.com with SMTP id u26so41970401pfd.2
        for <git@vger.kernel.org>; Thu, 25 May 2017 16:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qC4hetbzLR5JtkQqY3XGQM1Dy+5Px2TfPHiLt/c+eco=;
        b=aMBXZo5z6+LvyhB5hcy9JjiR9+oqqi9rTM2IbOgEKhCRthBbjOyMjgGOpY1XJLuSSu
         zV/F+mzdU+BAQ++CDiQuHOeC0SmbVGuAEyfxfVFGv4HGPjJhFi1bUABMInemL4wG+ezv
         syhzPHsbAwsyhjJEUOv8WKZNJqnjJttVBFK3x47Yjbzk4GY6xR3XJ7ueTfOq/XHy4aSc
         oi/3gjKJvt64pUPUjvZLuTlzelzoaxlWqF6WK8dTUUucroz9HXC7IyQmdMQyn4CP64X4
         BAvd9snlRr9PNGizAWpxPa66fRkR0EsJMDdagg12TbOVNHXhu9JVatW2JFpa86OwQ90B
         zOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qC4hetbzLR5JtkQqY3XGQM1Dy+5Px2TfPHiLt/c+eco=;
        b=Za7EbHvCCCBceXsAS9MrFnp6oks7NczYBhW89MX8j5y/VgBcmdOrbpoUJG/PkQXwmm
         rxo0hBBdoaE24mfW9/Pi4J4WAlK9iiNINoj+NEa5J27uRpF+48NVJHKFX1G/J9uf8oOq
         LrqEvNL0EBWElHqgxu4/K2/89QpYvl92uHeE5kY9+nvJxj6d9LLxHgOUNBqnBSVS+Xy0
         MWfMOXgtf53y0NpjXRAgyQAGbIt+LPljqz9te1NuM1TuERTvlfKrEu6fvZe6psOw482k
         s0l1x53pPSIweALi+zR1U9bTyY1WNvsUqWk4E05GGYuoHa07+bQWWinR3EgSt9poPZ0S
         Qrdw==
X-Gm-Message-State: AODbwcAGHkOblhCoQU1GSkHaAxKjUF0Hjjy64ZSSoI0NYBqhM0fBdvUQ
        Bsn4zjGQbJsg0w==
X-Received: by 10.98.69.193 with SMTP id n62mr48448878pfi.216.1495754170997;
        Thu, 25 May 2017 16:16:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:546a:ce73:1719:5041])
        by smtp.gmail.com with ESMTPSA id 74sm11634594pga.58.2017.05.25.16.16.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 May 2017 16:16:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        stefan.naewe@atlas-elektronik.com, git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] Windows: do not treat a path with backslashes as a remote's nick name
References: <cover.1495261020.git.j6t@kdbg.org>
        <122838f4-5f6b-6921-9242-2724bb6d8c95@atlas-elektronik.com>
        <alpine.DEB.2.21.1.1705221600100.3610@virtualbox>
        <1542d54f-d530-b60d-3270-d9b4e94c814d@kdbg.org>
        <alpine.DEB.2.21.1.1705231245300.3610@virtualbox>
        <xmqqinkrjkfb.fsf@gitster.mtv.corp.google.com>
        <c36ae9af-b566-5bb3-ad70-ee7f0051ca9a@kdbg.org>
        <10ee6b91-cd54-d43a-4cfb-d3baa2af7e7a@kdbg.org>
Date:   Fri, 26 May 2017 08:16:09 +0900
In-Reply-To: <10ee6b91-cd54-d43a-4cfb-d3baa2af7e7a@kdbg.org> (Johannes Sixt's
        message of "Thu, 25 May 2017 14:00:13 +0200")
Message-ID: <xmqq37bseddy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>>> So in short:
>>>
>>>   (1) Hannes's patches are good, but they solve a problem that is
>>>       different from what their log messages say; the log message
>>>       needs to be updated;
>
> I do not resend patch 1/2 as it is unchanged in all regards. This 2/2
> changes the justification; patch text is unchanged.

Thanks.  I think this is explained better.  Complaints against
fopen() warnings sounded as if we should avoid attempting to open a
file that may result in _any_ failure, which I felt was misleading,
but it is not a huge issue.

So how do we want to proceed on the point (2), i.e. updating the
"warn on _unexpected_ errors from fopen" series to make it aware of
the EINVAL we can expect on Windows?  My primary question is if all
EINVAL we could ever see on Windows after open/fopen returns an
error is because the pathname the caller gave is not liked by the
filesystem (hence we also know that the path does not exist).

If that is the case, then the "workaround" patch I sent would be an
OK approach (even though I do not know what to write after #ifdef
and I suspect that is not "WINDOWS". We would want to cover the one
you use, the one Dscho releases and possibly the cygwin build).

If we can see EINVAL after open/fopen error that is _not_ expected
and indicates a failure that is worth reporting to the user (just
like we want to report e.g. I/O or permission errors), I think
Windows folks are in a better position than I am to decide between
that approach and a patch at lower level (e.g. teach open/fopen not
to give EINVAL and instead give ENOENT when appropriate).


>  remote.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/remote.c b/remote.c
> index ad6c5424ed..1949882c10 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -645,7 +645,12 @@ static int valid_remote_nick(const char *name)
>  {
>  	if (!name[0] || is_dot_or_dotdot(name))
>  		return 0;
> -	return !strchr(name, '/'); /* no slash */
> +
> +	/* remote nicknames cannot contain slashes */
> +	while (*name)
> +		if (is_dir_sep(*name++))
> +			return 0;
> +	return 1;
>  }
>  
>  const char *remote_for_branch(struct branch *branch, int *explicit)
