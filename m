Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBAA2201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 19:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751650AbdBXTvx (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 14:51:53 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33545 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751635AbdBXTvf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 14:51:35 -0500
Received: by mail-pg0-f66.google.com with SMTP id 5so4152450pgj.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 11:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Jlk/2YPPs8+GkgqWc+zFV4yJDplap5OKfz1vDwKONCQ=;
        b=vKnphIHKJc1fjfNoBlZHSxvzZ4UITomwJPA7tyckkIHbB5j1qLRipJsgH81mY4zw9+
         gImDoDrgbHRCiJtxfisag9o/IKq5JqYCM5nyBQgobhM5ask9OA9aAFZ0jeIWNe28fkKM
         2UZqLw93lfe7Rq+s0MidOB321IPrhWR3aQ5lEtljbEdYrtaiYJiJs2kqgQPMm3VbGxym
         626xyjQ7po0SN6RZyK/uTmENcTtyOKat5n8PJH7isZ0UmYNIFvEL3ZNmXWNfbIB58/R8
         3pgj1WPxD4QWunamy2/WPKRGRiMFzWoneyjlfryBYEcRbx1VTykNG57ol8/fOde1QLhK
         tscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Jlk/2YPPs8+GkgqWc+zFV4yJDplap5OKfz1vDwKONCQ=;
        b=pec15S+LgkLGLZtCAHd0U++XkfHUccqhKyP01e7dT6Bb4nAQ4aFvOvgGVrxya9oeQx
         hWDZIehgILpGh7m0JA3qE78JA4UJp7y7eiqU+U6scrz6UoxX1IL+U5eDy8ZnHrVk2545
         m3su/wPkJ2IS34TUG7Ldfev63EG+pVwbzJIzsNvN5XwxkLXcQSvpMGtrbpao/74uIbFl
         SSQIxk5yCRqx21/+qMrYi+yvQ9HMUw4IsG4WMElACXxBe37uaeVSCDZdRzwlfCOqPDa1
         XsG1riYOsUFd4lfvnWx/00gvx/4I6ZoI/EDlNrd+yV4A3PmaCaohNWemOr1PyMSLZUyG
         C7xg==
X-Gm-Message-State: AMke39mQsdwoJL9VQ18TNE0TH5gxRVXDfB4B2d95KmSWVgAQTS+8yBusKft+D6cMcnStTA==
X-Received: by 10.84.130.100 with SMTP id 91mr6143287plc.167.1487965884435;
        Fri, 24 Feb 2017 11:51:24 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f06c:2e0c:850d:31b4])
        by smtp.gmail.com with ESMTPSA id f62sm16582590pfg.48.2017.02.24.11.51.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 11:51:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Christophe Macabiau <christophemacabiau@gmail.com>
Subject: Re: fatal error when diffing changed symlinks
References: <CAC0icTZ87yeYndPFyjD4nkJBcw5SC-bgUJYbEzYqH7YhSFZvuQ@mail.gmail.com>
        <xmqqshn34gsh.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 24 Feb 2017 11:51:22 -0800
In-Reply-To: <xmqqshn34gsh.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 24 Feb 2017 09:53:02 -0800")
Message-ID: <xmqqtw7j1i6d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> cd /tmp
>> mkdir a
>> cd a
>> git init
>> touch b
>> ln -s b c
>> git add .
>> git commit -m 'first'
>> touch d
>> rm c
>> ln -s d c
>> git difftool --dir-diff
>
> A slightly worse is that the upcoming Git will ship with a rewritten
> "difftool" that makes the above sequence segfault.

The culprit seems to be these lines in run_dir_diff():

		if (S_ISLNK(lmode)) {
			char *content = read_sha1_file(loid.hash, &type, &size);
			add_left_or_right(&symlinks2, src_path, content, 0);
			free(content);
		}

		if (S_ISLNK(rmode)) {
			char *content = read_sha1_file(roid.hash, &type, &size);
			add_left_or_right(&symlinks2, dst_path, content, 1);
			free(content);
		}

When viewing a working tree file, oid.hash could be 0{40} and
read_sha1_file() is not the right function to use to obtain the
contents.

Both of these two need to pay attention to 0{40}, I think, as the
user may be running "difftool -R --dir-diff" in which case the
working tree would appear in the left hand side instead.

I didn't follow the codepath for regular files closely, but the code
that follows the above excerpt does quite different things to lstate
and rstate, which makes me suspect that the code is not prepared to
see "-R"(everse) diff (and I further suspect that these issues were
inherited from the original scripted Porcelain).

