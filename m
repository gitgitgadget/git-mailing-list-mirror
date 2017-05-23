Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A38E720281
	for <e@80x24.org>; Tue, 23 May 2017 12:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967454AbdEWMwj (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 08:52:39 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35232 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967449AbdEWMwd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 08:52:33 -0400
Received: by mail-pf0-f194.google.com with SMTP id u26so27455957pfd.2
        for <git@vger.kernel.org>; Tue, 23 May 2017 05:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=g0TgH2lr6DkjIglE7PwpE+l2AxeBgO2sMIE9LIN2gIE=;
        b=JbhtX/Ok52TNI676//mrJVVK3kxEWzal+XGOrhfEWMK/f3bBiLVHvhm9isg/Jk0W0a
         1k70UPhsMu8NLHL9bdEbr0CDZIyl1IZ+m2b2zNOP28abTToXJ3VVNmeR8UBhgd2sZNnw
         ezRgdrlUibzTdxKZDlybSO47LfrXiEZsoPW8SK0wAJ9znlnV4VUJpQTDc7MR0OUSvPL/
         CqBtoRHfazhIGSf7dOqjxfx0HFnFTvM6F3Seg9vr0bRcD+1DvWDchQ5MtgpCn7I6E1Je
         6PgxftDuLxhCpJi3kdib1T7UTFfd4w+32nA1CKWmLaTcxqM2IHe58SWjDM8wdrX1tj16
         Eg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=g0TgH2lr6DkjIglE7PwpE+l2AxeBgO2sMIE9LIN2gIE=;
        b=krAIssTdEXfncbIfHnTFtrO6eVOic6SHwDO8eklhbPjQ9X2Etchub4YYZ3LYucGczk
         YpxYVeY2brTvuO9hA7zX8aYTCpgJ2IE3nvneR/iGdAsTQ81x0GWSmKhPN+qqBS/t4X14
         E5AXTk1TsIa+xIwcTGGxjneaw5KFXDHaxxf3SY/CYpJ2VMwr1w4/kfvjJ/2CtI5jsHTc
         JP2zbUe4WbtLN6MbnTTyXcpdf0JZhm1qFbfRUEoj4KRJWbPSELaTC5glpbjBlNQvEywF
         PrmqZx2qmKOLPR2mwZl5RjdtvWwwfl/Po/HVMmx4RnWWdt6IxMDico+AxqJtY+I0S4fN
         q4TQ==
X-Gm-Message-State: AODbwcBvPQRMLyHKBozrLsgy5NwdNxpN4S3t1n+5Q+aDkZE3LGBIwS2Z
        xQssVhLpearvUA==
X-Received: by 10.98.112.134 with SMTP id l128mr31566399pfc.161.1495543948092;
        Tue, 23 May 2017 05:52:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b9c2:d2d1:97c0:9dab])
        by smtp.gmail.com with ESMTPSA id v9sm1883612pfa.43.2017.05.23.05.52.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 05:52:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 6/6] clean: teach clean -d to preserve ignored paths
References: <20170523091829.1746-1-sxlijin@gmail.com>
        <20170518082154.28643-1-sxlijin@gmail.com>
        <20170523091829.1746-7-sxlijin@gmail.com>
Date:   Tue, 23 May 2017 21:52:26 +0900
In-Reply-To: <20170523091829.1746-7-sxlijin@gmail.com> (Samuel Lijin's message
        of "Tue, 23 May 2017 05:18:29 -0400")
Message-ID: <xmqqshjvka5x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

> @@ -931,6 +961,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  		       prefix, argv);
>  
>  	fill_directory(&dir, &pathspec);
> +	correct_untracked_entries(&dir);
>  
>  	for (i = 0; i < dir.nr; i++) {
>  		struct dir_entry *ent = dir.entries[i];

You used to set SHOW_IGNORED_TOO and KEEP_UNTRACKED_CONTENTS in
dir.flags early in the function, and then free dir.entries[] and
dir.ignored[] after we are done.  They are gone in this version.

Intended?

> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> index 3a2d709c2..7b36954d6 100755
> --- a/t/t7300-clean.sh
> +++ b/t/t7300-clean.sh
> @@ -653,7 +653,7 @@ test_expect_success 'git clean -d respects pathspecs (pathspec is prefix of dir)
>  	test_path_is_dir foobar
>  '
>  
> -test_expect_failure 'git clean -d skips untracked dirs containing ignored files' '
> +test_expect_success 'git clean -d skips untracked dirs containing ignored files' '
>  	echo /foo/bar >.gitignore &&
>  	echo ignoreme >>.gitignore &&
>  	rm -rf foo &&
