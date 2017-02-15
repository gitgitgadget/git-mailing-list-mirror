Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 839542013A
	for <e@80x24.org>; Wed, 15 Feb 2017 18:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752565AbdBOSWO (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 13:22:14 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34056 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752520AbdBOSWN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 13:22:13 -0500
Received: by mail-pf0-f196.google.com with SMTP id o64so8298481pfb.1
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 10:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=R2/NZcq8Wjaa5Q/P4IuqcagM2iq1Z6vA7rymzzpoFXs=;
        b=c5O0cKIwS2PdclmEcMV30OL6hgZVlERON4MaoKWLDKlCJoraZSztfg3jdqLqFMdlY/
         yI+qMHxIQ2z1vpw3quyCkm7zQZp5GKjUcaJ78dOSJbvAMIkNDJaW0Dltjt7RmiTsojkF
         exuYUVIiuasuPz4qfAarEffIQ8mINB5E8quF9bYS1OCqF7uRr7Erc79iUusnOQfPaPsK
         Hb8+dfPonDb27fenJvDwPsfC7VZAjGflpLZxMpDBJq2p2UgDUthWg7W9iFPexwWzv4+k
         fosew8AdC0cZzFxvTDx2jEsHaCZdkqHaqhXa/+kAgBTNHlB296GF8DYPix7ofEMFvGsO
         1xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=R2/NZcq8Wjaa5Q/P4IuqcagM2iq1Z6vA7rymzzpoFXs=;
        b=MNdcox6yBdyBOf0G1ayr4ngQVtWImiZ5nXJ0oaTalWahEMwS4+jerMBvPUAwNQGlQ2
         sEsO3O/Lv3c5ZygLrwpbyXFJEFbtcjd8SuwIJEEdfW3mER8KEv1KIeCyIt8++lSI7OS1
         QyJ/uyASl/HPvugFhqjoemxIgzY6alirKf5YtJMdiLm8ZGrfkiiNGXqTVMyHkcXSglLi
         ky0TjumJudbCOlQF3eDpLATqMQuav4q771phqBGyIsBDi0QteAgo9K5JOjDmErL2nOpb
         2uzEDpgIA0lkHGkbAXIXQP/8wg1lFN6Y2ZY+Sa/p98XD+kAvPu2MKDw+lRkNN0zfyzUK
         5grw==
X-Gm-Message-State: AMke39k6JmEbYcvrKw/aHhwtTkSvihtlJ/W5fqxzghzFLrT+2z+3+GT9sfrQ+1G6ZssAAQ==
X-Received: by 10.98.138.155 with SMTP id o27mr39179867pfk.113.1487182922547;
        Wed, 15 Feb 2017 10:22:02 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3551:31c7:1fe1:8b9b])
        by smtp.gmail.com with ESMTPSA id c11sm8893911pfk.14.2017.02.15.10.22.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 10:22:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH 04/14] connect_work_tree_and_git_dir: safely create leading directories
References: <20170215003423.20245-1-sbeller@google.com>
        <20170215003423.20245-5-sbeller@google.com>
Date:   Wed, 15 Feb 2017 10:22:00 -0800
In-Reply-To: <20170215003423.20245-5-sbeller@google.com> (Stefan Beller's
        message of "Tue, 14 Feb 2017 16:34:13 -0800")
Message-ID: <xmqqh93v48mv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> In a later patch we'll use connect_work_tree_and_git_dir when the
> directory for the gitlink file doesn't exist yet. Safely create
> the directory first.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>

Among the existing two callers, the "absorb" logic in submodule.c
has safe-create-leading-directory (SCLD) immediately before the call
to this function, which can now be lost with this change.  The other
one in cmd_mv() has the target directory as the result of moving the
original directory, and I do not think there is any corresponding
call that can be lost from there after this change, but it is not an
error to call SCLD on a path that already exists, so all is OK.

Is it sensible to let the code continue with just an fprintf() (not
even warning() or error()) when SCLD fails?

> ---
>  dir.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/dir.c b/dir.c
> index 4541f9e146..69ca3d1411 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2735,6 +2735,8 @@ void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
>  
>  	/* Update gitfile */
>  	strbuf_addf(&file_name, "%s/.git", work_tree);
> +	if (safe_create_leading_directories_const(file_name.buf))
> +		fprintf(stderr, "could not create directories for %s\n", file_name.buf);

>  	write_file(file_name.buf, "gitdir: %s",
>  		   relative_path(git_dir, work_tree, &rel_path));
