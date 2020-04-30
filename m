Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C03DC83000
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 01:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 586CB2082E
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 01:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqavW+7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgD3Buy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 21:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgD3Buy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 21:50:54 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17ECC035494
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 18:50:53 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d3so1988045pgj.6
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 18:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VHM+ikZhxNHHc8aRjdmTgxp9Ur39B+i7Wwkk0cXOjlk=;
        b=qqavW+7+kXSt9SqzUOTVVSeyeW1fvNO6bxacUM2XRVDoU7b4fAfVn3ASw2agMxzceZ
         i/C70XMST9XVbMRRztJmMv3X7O8ZLfcinhkBY7vFdsgX0h5xd1jy0p+QgtobFVaGIe6N
         bBdZO8jS3JDWqh1Ct2qrQwL33d7Fqd6ze+rx2JmT28bvuiWo9a2MK8s6m6y8jMWDuI9a
         tuDTd4laEtbDrNksyuWnAcPUXUHtreyJsDQTbDK7DsG5AI5Km84xOA0QzKF0osC+XeFd
         mju099DxVrEBNY3QzKn4m9wrkV6RwGwkS/xi1H/oORGZdRBGQKA3sVDKZcjO58mEnG1e
         7PSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VHM+ikZhxNHHc8aRjdmTgxp9Ur39B+i7Wwkk0cXOjlk=;
        b=t9cqqPoWoOQu62dvGtylqTOiUDK7Uuqdt7fCE9bEQMfD1sE+dCchQrqj/oiP/GPGOj
         KL5Oyu7VB6Wz020XeXZTdPqTXvjGAy/+eP8UAZImrOVNxW8Jk5E1ua9SJTp/D/Z6T4PV
         kxP57U2sJGAkBK8OSgECcPq13X4oKsA9ox4EXXUn4oiLZj3zpUaYIwM5k93vbbnhIjWt
         NO0TJPF7sFZq31xqPA6K4zYkd2XUxt1XtEBetjEsDc3JloKr0RN2dxNfP1H+KBd7SN1E
         HVCI5zOz+tdHf8imNNH6VePMo2eC9edOkUNgaXIzHDMsVz58YKsi6DQa27JsJOZM3gID
         qWfA==
X-Gm-Message-State: AGi0PuaNXeem0Qny1X4x2SZN4LDBS4yUwZqkLQvJwQAnTnPNHIb1gZI0
        Yask2wKkvRaJkDuu5EOAzmu4daIy
X-Google-Smtp-Source: APiQypIdcR9X7gsyGziGZe0CfW8UZv3nzTvwYUReSzSiHJZThgk8rqW06FHwcRsUI150yWQULssSTw==
X-Received: by 2002:a63:5724:: with SMTP id l36mr1061645pgb.317.1588211453263;
        Wed, 29 Apr 2020 18:50:53 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id d13sm1796374pga.64.2020.04.29.18.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 18:50:52 -0700 (PDT)
Date:   Wed, 29 Apr 2020 18:50:49 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] bugreport: collect list of populated hooks
Message-ID: <20200430015049.GA115238@google.com>
References: <20200427233820.179891-1-emilyshaffer@google.com>
 <20200430012425.209122-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430012425.209122-1-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Emily Shaffer wrote:

> Since v2, switched to write_script, and modified the test to check for
> uninstalled hooks and sample hooks having correct behavior.

Looks almost ready.  Two nits.

[...]
> --- a/t/t0091-bugreport.sh
> +++ b/t/t0091-bugreport.sh
> @@ -57,5 +57,15 @@ test_expect_success 'can create leading directories outside of a git dir' '
>  	nongit git bugreport -o foo/bar/baz
>  '
>  
> +test_expect_success 'indicates populated hooks' '
> +	test_when_finished rm git-bugreport-hooks.txt &&
> +	test_when_finished rm -fr .git/hooks &&
> +	mkdir .git/hooks &&

This is subtle.  Since c09a69a83e3 (Disable hooks during tests,
2005-10-16), the repository in which the test runs has its "hooks"
directory renamed to "hooks-disabled", with rationale

    Individual tests for hooks would want to have their own tests when
    written.  Also we should not pick up from random templates the user
    happens to have.

That rationale is a bit strange because we explicitly passed
--template to "git init" even then, so we could be confident that the
built-in templates that do not enable any hooks would be in use.

Mailing list diving finds [1].  We didn't have f98f8cbac01 (Ship
sample hooks with .sample suffix, 2008-06-24) yet, which means that on
filesystems that do not record an executable bit, the sample hooks
were all enabled by default.  Nowadays that has been fixed and we
should be able to get rid of the "mv .git/hooks .git/hooks-disabled"
in the test setup.

When we do that, this "mkdir .git/hooks" will fail because the
directory already exists.  Ideas:

 A. Include a preparatory patch in this series that removes that "mv"
    command.  That way, this test can do

	test_when_finished "
		rm -fr .git/hooks &&
		mv .git/hooks-saved .git/hooks
	" &&
	mv .git/hooks .git/hooks-saved &&
	mkdir .git/hooks &&
	...

    or even better (because of increased realism)

	test_when_finished rm .git/hooks/applypatch-msg &&
	write_script .git/hooks/applypatch-msg <<-\EOF &&
	...

  B. Run "git init" ourselves so we know what we're getting:

  	test_when_finished "rm -fr .git && mv .git-saved .git" &&
	mv .git .git-saved &&
	git init &&
	...

> +	write_script .git/hooks/applypatch-msg &&

write_script looks for a script on its stdin.  test_eval_ redirects
stdin to come from /dev/null, so we happen to get an empty script, but
this is subtle.  How about something like

	write_script .git/hooks/applypatch-msg <<-\EOF &&
	echo >&2 "rejecting message in $1"
	exit 1
	EOF

or

	write_script .git/hooks/applypatch-msg </dev/null &&

?

> +	write_script .git/hooks/prepare-commit-msg.sample &&

Likewise.

> +	git bugreport -s hooks &&
> +	grep applypatch-msg git-bugreport-hooks.txt &&
> +	! grep prepare-commit-msg git-bugreport-hooks.txt
> +'

Thanks,
Jonathan
