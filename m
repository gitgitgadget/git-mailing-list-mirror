Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6831C38145
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 21:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiIHVpT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 17:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiIHVpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 17:45:16 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55A52B60C
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 14:45:10 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p18so19196230plr.8
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 14:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=fXrYnfnGzPwIo3pfA+Nqv1giscPe533jjv7Y4M4TA6U=;
        b=CHkpwULPJmYXOnMT/U8Qkau02wQTXUCrYC7LP3z7kXdJJRDnxr71G9hNU7w0tYzY7P
         D5KjpCpke0rMFd+8IKpI7hDsxEMb58IQaYdDPKixhF3YJxO8eaxlsbJOUNAHplSF4t1b
         X/AIgL/Dp0LSnmJtTB23We7tYACbwf/rHH8SoJVgJDonzVic2NZAgsnq+gyMG2PDwzuy
         O9TunNTPOB+efpy+5HH/bhMOCIKcrwHIAUCBp7krALDKffeDsXBVp2fnZFTv7DuhN9Fh
         +Pn9IZS/niyiZ+HB36kPyJdzxRJJHjkN1Sh8d6wB5XDkSZyYGdmrliHHYofoO9ZZPFIz
         p6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=fXrYnfnGzPwIo3pfA+Nqv1giscPe533jjv7Y4M4TA6U=;
        b=l9CrxV448q4oi2jJMJWoG7VR3o+8lXiphpgFsfRh+96OfBpDZf4b5pmYtprF2Z7TOh
         eX7MlCjI1BGqY8kz1kb3wfacqT/1aIM2sBJIQ3RRl9Hc6T4fuXxTDpIhhPi9UdBAccrV
         mPa3S9nPawxnfwlB1dFmCpcW8NuuzhayFJi/BvR7XBtVb3Dv3DC7iPHSmK7RY8Gb2n3n
         V+SqOSMKkrOBD+Ook1wy5syB1NzeYMo7mpOfj6T61oUYDTrPb7N+vgfZr7ox1F5OvRMD
         0jicj9YNScunoYmxyw/6lzYOPs/rZw3RLXc/SvgAhJNgHqJzp9AUOCKVbMEv2X8QXL4j
         gzPg==
X-Gm-Message-State: ACgBeo3Mwkymte0ARjtdsfej3iWpFMsEQ7mg5hUjsoCXHPpsQ9nbwA5m
        zbO7gtFCAeIqiXoiKbfc7FM=
X-Google-Smtp-Source: AA6agR5VTE33nvAtboAkE936Y6O7QAt1NgUGFvf//JD27cFXTz2OFS4Scnz+9DcY2+gsf0tIZ+oQ/g==
X-Received: by 2002:a17:902:bd84:b0:174:e086:c734 with SMTP id q4-20020a170902bd8400b00174e086c734mr10815006pls.46.1662673509280;
        Thu, 08 Sep 2022 14:45:09 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id ij13-20020a170902ab4d00b0016eede528b4sm3208plb.61.2022.09.08.14.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 14:45:08 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] branch: error codes for "edit_description"
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
        <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
        <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
        <67253834-8bfa-c249-6594-6418d6ae6805@gmail.com>
        <de06f80c-4778-7e43-3a88-d7aeae788e0d@gmail.com>
Date:   Thu, 08 Sep 2022 14:45:08 -0700
In-Reply-To: <de06f80c-4778-7e43-3a88-d7aeae788e0d@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Thu, 8 Sep 2022 22:57:12 +0200")
Message-ID: <xmqq7d2do80r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> Stick to the convention of exit with 1 on error.  May break some
> third party tool that expects -1 on "No branch named 'bla'" or
> "No commit on branch 'bla' yet." errors.
>
> Test added to avoid regresion on this behaviour.
> ---
>
> Junio, here is the patch for the change you suggested [1].  My concern is
> this might break some third party tool or script.  If no one thinks this
> is an issue, I can squash it with the patch I'm responding to.
>
>
> [1] https://lore.kernel.org/git/xmqq7d2fszhk.fsf@gitster.g/
>
>  builtin/branch.c  | 6 +++---
>  t/t3200-branch.sh | 8 ++++++++
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index b1f6519cd9..01b6364f58 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -810,11 +810,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  			else
>  				ret = error(_("No branch named '%s'."),
>  					     branch_name);
> -		} else if (edit_branch_description(branch_name))
> -			ret = 1;
> +		} else
> +			ret = edit_branch_description(branch_name);
>  
>  		strbuf_release(&branch_ref);
> -		return ret;
> +		return -ret;

If edit_branch_description() returns -1 on failure, this would
consistently exit with 1 on failure, so it does make sense.  

It is bad to exit with a value outside 0..255 for portability
reasons, but we wrap exit() to chomp off the higher bits, so in
practice it may be fine to exit(-1) but still the above is a good
clean-up, I would think.

