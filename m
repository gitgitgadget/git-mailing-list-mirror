Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11F371FC3E
	for <e@80x24.org>; Mon,  1 May 2017 03:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164097AbdEADh1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 23:37:27 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35304 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753059AbdEADh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 23:37:27 -0400
Received: by mail-pf0-f173.google.com with SMTP id v14so70530655pfd.2
        for <git@vger.kernel.org>; Sun, 30 Apr 2017 20:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wo13xqcYNdyKQgF1Lm3JEzyrDD/v7oOvu02thFWgbN0=;
        b=QjLQFBIyawwoopmTo+iE3eoB9YEmUXQYRj3Wfsfz4592mnS0S2ECW4zOSirnFni5ss
         Q28hE6KwGAPDzvUYoreYo1/vnjalSDZaudPc4aEw23gA6azPsfNH2bsx3UY0nTBn79DC
         TxurNkeixypoRwtU1LZo4Sz1SqvLV54XM/IuZTMoCvDuNc+KuOjgi6vox+LgkHdSZ27r
         uDlzHGD0DxZXE7G6fCU+dWs4/8jZnv8kp++y32NVV0JL+PJcD4gbn3vV1U1S5HquN6/w
         lfrMshYmnQBToCjZXwWFqLNxvV5kr4ZR/cVG7rusvCiQ6t2UO6XAJVwgBdtLyOF6Nmfq
         5gXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wo13xqcYNdyKQgF1Lm3JEzyrDD/v7oOvu02thFWgbN0=;
        b=bhxgwKm/6lXe6YaFq+C9mD6klmQIiwP1DHWJkFMjdF3e/My5DkrzK3pSlsaDp4FR8E
         +Jwcx/TnrP1qQYwVVjr0vFaZHXXQ6FEZyohabaI0T7IcRwxUoa7B46ZMjlXmMBtVDArL
         vZ5ny+UL/e0ATKGR6xQj1XQJUk+No2KhSQw1XOvZOBAde3cwC8Nutw2yFaM4Z/0vFX/Y
         Mm2nrxIuMGQ1SE0U2W1GGJb5I35uV17oYfAmqVwCDzUhONb3E+YWHMXSetUw/k+25oOT
         d7TQyaydKSEqCC1ihv6zAkflNVFjN+x+MBOsZhi3LIYzRu8TQdWMlTDNQJp1Cp/4UWxa
         FZ6g==
X-Gm-Message-State: AN3rC/47jMHAuXLEnL9fq2VCEp03RN24YZUp4yIkKQ0SLwdhXbEJgDyz
        NPtzkbtGveTAKB40fWI=
X-Received: by 10.99.63.203 with SMTP id m194mr25686060pga.210.1493609846306;
        Sun, 30 Apr 2017 20:37:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:216d:aa3e:248d:bf63])
        by smtp.gmail.com with ESMTPSA id o62sm25498846pfj.87.2017.04.30.20.37.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 30 Apr 2017 20:37:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/6] submodule: improve submodule_has_commits
References: <20170428235402.162251-1-bmwill@google.com>
        <20170428235402.162251-6-bmwill@google.com>
Date:   Sun, 30 Apr 2017 20:37:24 -0700
In-Reply-To: <20170428235402.162251-6-bmwill@google.com> (Brandon Williams's
        message of "Fri, 28 Apr 2017 16:54:01 -0700")
Message-ID: <xmqqmvaxgscr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>  	oid_array_for_each_unique(commits, check_has_commit, &has_commit);
> +
> +	if (has_commit) {
> +		/*
> +		 * Even if the submodule is checked out and the commit is
> +		 * present, make sure it is reachable from a ref.
> +		 */
> +		struct child_process cp = CHILD_PROCESS_INIT;
> +		struct strbuf out = STRBUF_INIT;
> +
> +		argv_array_pushl(&cp.args, "rev-list", "-n", "1", NULL);
> +		oid_array_for_each_unique(commits, append_oid_to_argv, &cp.args);
> +		argv_array_pushl(&cp.args, "--not", "--all", NULL);
> +
> +		prepare_submodule_repo_env(&cp.env_array);
> +		cp.git_cmd = 1;
> +		cp.no_stdin = 1;
> +		cp.dir = path;
> +
> +		if (capture_command(&cp, &out, 1024) || out.len)
> +			has_commit = 0;
> +
> +		strbuf_release(&out);
> +	}
> +
>  	return has_commit;
>  }

The "check-has-commit" we see in the pre-context is "we contaminated
our in-core object store by tentatively borrowing from submodule's
object store---now do we see these commits in our in-core view?"
Which is a wrong thing to do from two separate point of view.  Even
though the commit in question may be visible in our contaminated
view, there is no guarantee that the commit exists in the object
store of the correct submodule.  And of course the commit may exist
but may not be anchored by any ref.

This patch fixes the latter, and if we remove that check-has-commit
call before it, we can fix the former at the same time.

There is value in leaving the check-has-commit code if we anticipate
that we would very often have to say "no, the submodule does not
have these commits"---a cheap but wrong check it does can be used as
an optimization.  If we do not have the commit object anywhere,
there is no chance we have it in the object store of the correct
submodule and have it reachable from a ref, so we can fail without
spawning rev-list which is expensive.


