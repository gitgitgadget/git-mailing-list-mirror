Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 316AB1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 20:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeCOUdV (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 16:33:21 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34866 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752693AbeCOUdU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 16:33:20 -0400
Received: by mail-wm0-f51.google.com with SMTP id x7so12917951wmc.0
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 13:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8RYzQKFbx8YvZ6N8aFO3+lorjfBUo/X+496YS3Q4pso=;
        b=h6ni+RmD9V9FPA5s52Lvsb7VaIH+DjprIES/Y5PKwHCM9sam3OGwXclup/sa1aHzs1
         oqaqKdt4E167bNCf1lRed8jpcw9SI466JV8mU2AqiVkrkSkXVFv5edz2HoP/NQQrvDrk
         c1qf0KQ1NPOyqASIPOCzseuBf1Pccd+YpzqhOsGtlnz9QlGfelxUo67sMEGlfxm5lQVT
         OgEI2thdZx/KQTfDdVUxwdJFjCE/bVdHNcdk0Nq4nyrW5Y14R9HW/VtIf4YuikuWVRqN
         RdqXtoTutGrXzQ2FPvcI/Ougr1MKld3wlunbKapgNRmPzyo5N8tQoGtrlrwM/PEJ2jKi
         54oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8RYzQKFbx8YvZ6N8aFO3+lorjfBUo/X+496YS3Q4pso=;
        b=Zk01hn12YZBlwlooy6iqoi8nnipRxb52DN3gAtHT6w4cT7bxWJtbsI3KWn3doLoFov
         8vx0YDg4gEPmn48FtlPWcI3zSToa+hLciqOR6oG/6YcCOFdgGVmV916ltQ98tGFLdzZE
         /NlEw6ClrJ4jRKxeJt+XcJYYQ2sq96AxsixKlU8l3wyE7NmGFGfRK0zWNI9jmvIvHP7k
         naN1FmblkOPJ2aF/FxxwWe51aqgQ84V9AA0IM5MNllOjTOfI9ThF8t5ppgh88CT7FvH/
         8ioWSCDzwRqIblyZAXXTCmN8uybS9M8nZEG6qcfSxVPuGwdfBIk1gMSg2dR7OiqBFlEX
         6S7w==
X-Gm-Message-State: AElRT7FdDhxjE1B3Fd6UEbV7s/t4t+QefctB+FYsBl/vRy74BnM/LAEk
        205UST/OT5dYY1wy2FPCKWw=
X-Google-Smtp-Source: AG47ELuj5Y8vqw9X/BS8fjkip+fJPXIEFuBWD+kGnLik2E86S6TMT9qC025blAIaTAGSkQ3fs1zGhA==
X-Received: by 10.28.169.150 with SMTP id s144mr267899wme.40.1521145998502;
        Thu, 15 Mar 2018 13:33:18 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y75sm5086193wme.13.2018.03.15.13.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Mar 2018 13:33:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 2/3] builtin/branch: give more useful error messages when renaming
References: <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
        <20180310155416.21802-1-kaartic.sivaraam@gmail.com>
        <20180310155416.21802-3-kaartic.sivaraam@gmail.com>
Date:   Thu, 15 Mar 2018 13:33:17 -0700
In-Reply-To: <20180310155416.21802-3-kaartic.sivaraam@gmail.com> (Kaartic
        Sivaraam's message of "Sat, 10 Mar 2018 21:24:15 +0530")
Message-ID: <xmqqlget3wqa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> +static void get_error_msg(struct strbuf* error_msg,
> +			  const char* oldname, enum old_branch_validation_result old_branch_name_res,
> +			  const char* newname, enum branch_validation_result new_branch_name_res)
> +{
> +	const char* connector_string = "; ";
> +	unsigned append_connector = 0;
> +
> +	switch (old_branch_name_res) {
> +	case VALIDATION_1_FATAL_INVALID_OLD_BRANCH_NAME:
> +		strbuf_addf(error_msg,
> +			    _("old branch name '%s' is invalid"), oldname);
> +		append_connector = 1;
> +		break;
> +	case VALIDATION_1_FATAL_OLD_BRANCH_DOESNT_EXIST:
> +		strbuf_addf(error_msg,
> +			    _("branch '%s' doesn't exist"), oldname);
> +		append_connector = 1;
> +		break;
> +
> +	/* not necessary to handle nonfatal cases */
> +	case VALIDATION_1_PASS_OLD_BRANCH_EXISTS:
> +	case VALIDATION_1_WARN_BAD_OLD_BRANCH_NAME:
> +		break;
> +	}
> +
> +	switch (new_branch_name_res) {
> +	case VALIDATION_FATAL_BRANCH_EXISTS_NO_FORCE:
> +		strbuf_addf(error_msg, "%s",
> +			    (append_connector) ? connector_string : "");
> +		strbuf_addf(error_msg,
> +			    _("branch '%s' already exists"), newname);
> +		break;
> +	case VALIDATION_FATAL_CANNOT_FORCE_UPDATE_CURRENT_BRANCH:
> +		strbuf_addf(error_msg, "%s",
> +			    (append_connector) ? connector_string : "");
> +		strbuf_addstr(error_msg,
> +				_("cannot force update the current branch"));
> +		break;
> +	case VALIDATION_FATAL_INVALID_BRANCH_NAME:
> +		strbuf_addf(error_msg, "%s",
> +			    (append_connector) ? connector_string : "");
> +		strbuf_addf(error_msg,
> +			    _("new branch name '%s' is invalid"), newname);
> +		break;
> +
> +	/* not necessary to handle nonfatal cases */
> +	case VALIDATION_PASS_BRANCH_DOESNT_EXIST:
> +	case VALIDATION_PASS_BRANCH_EXISTS:
> +	case VALIDATION_WARN_BRANCH_EXISTS:
> +		break;
> +	}
> +}

Quite honestly, I am not sure if this amount of new code that
results in sentence lego is really worth it.  Is it so wrong for
"branch -m tset master" to complain that master already exists so no
branch can be renamed to it?
