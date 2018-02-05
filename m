Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B1AA1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 20:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbeBEUQP (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 15:16:15 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53050 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbeBEUQI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 15:16:08 -0500
Received: by mail-wm0-f68.google.com with SMTP id g1so28491196wmg.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 12:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HTiJoCdIaV+lfRsDWP9DwJGRt/lETezZm+V/rOehkqg=;
        b=kj0ZavgNn3NzbbGOHvuHpjWd/CXWcQtIhKWeL8uUw3f9grj5nj86Hwh39IIJV/anfa
         kdrq4ceXTFZnthzTNrv/F7i6DDoecDlJDhTvjDB4zVOP8cd99mKSCyzb5Z3pdtpjHxkd
         JGScnfta0v/ZLDLiQ8Cx+cGpOQU/dfhCnG7wIqFHGK0N0mNH69hBRpYH6runqqgYKt4x
         9yK36fJds0SVRat+jK9ycVnpXXnC+qEPDO81dQ1+DGF8EJRefXaYKSttkeCZGIOonGl4
         IqKUkIpxLNkQxCX1u/Rctnh2vVjqtEI0F2Nod4LNti9Ze1xWOOcIXbUBf+Ot+JR1R/F9
         b33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HTiJoCdIaV+lfRsDWP9DwJGRt/lETezZm+V/rOehkqg=;
        b=n4NPdfKbF8bbYF1L9dadjxLg0g8FG50+fxlmDJD4G5qkVqyCC0kAU9LbXw4KhStOxR
         sLYxOWae5cWPKYeknE7DnhGUwtxrYgMY/3kJI20EFuADVtuueJHfiO0G5Ms6K1rpihEd
         425yyCPi7FpLenbgMKoUKNH2aGhtufC8nIF86zRWEyXagyoDv1B/epvtP32VnR8LgLww
         rUa6Vtz8vLAcfg74MByp9NCii3voEweYLQh8mPLCfhZZqdMz4rawthISI6898Y7NPtgI
         +7VnOdyybhfCMusd6WS/QLqxjduj2WjQ7z8ToCInm2vtV2YqOnXvcnXC8U9Vz/p2oGmL
         +0Zg==
X-Gm-Message-State: APf1xPA6YlD513Mm7/yOW9zrZ6O2/oB5ULqtmUrAay7dj0DDoQm14V6R
        cIyfweuU8eg8dI9CEalUHhx1hVwN
X-Google-Smtp-Source: AH8x2270DKKrKrcdyhwKFr/WhsG8KeQNFLKI5T8Cq33FYIYcPPCG28q8gBR53II7TkmJ484ZUDy8lw==
X-Received: by 10.28.193.196 with SMTP id r187mr44273wmf.111.1517861766988;
        Mon, 05 Feb 2018 12:16:06 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g13sm7631488wrh.51.2018.02.05.12.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 12:15:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/3] worktree: improve message when creating a new worktree
References: <20180121120208.12760-1-t.gummerer@gmail.com>
        <20180204221305.28300-1-t.gummerer@gmail.com>
        <20180204221305.28300-2-t.gummerer@gmail.com>
        <20180205021202.GA17847@duynguyen.dek-tpc.internal>
Date:   Mon, 05 Feb 2018 12:15:55 -0800
In-Reply-To: <20180205021202.GA17847@duynguyen.dek-tpc.internal> (Duy Nguyen's
        message of "Mon, 5 Feb 2018 09:12:02 +0700")
Message-ID: <xmqqlgg79oqs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Feb 04, 2018 at 10:13:03PM +0000, Thomas Gummerer wrote:
>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> index 7cef5b120b..d1549e441d 100644
>> --- a/builtin/worktree.c
>> +++ b/builtin/worktree.c
>> @@ -303,7 +303,7 @@ static int add_worktree(const char *path, const char *refname,
>>  	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
>>  	write_file(sb.buf, "../..");
>>  
>> -	fprintf_ln(stderr, _("Preparing %s (identifier %s)"), path, name);
>> +	fprintf(stderr, _("Preparing %s (identifier %s)"), path, name);
>>  
>>  	argv_array_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
>>  	argv_array_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
>> @@ -320,10 +320,19 @@ static int add_worktree(const char *path, const char *refname,
>>  	if (ret)
>>  		goto done;
>>  
>> +	fprintf(stderr, _(", setting HEAD to %s"),
>
> As a former translator, I'm not thrilled to see a sentence broken into
> two pieces like this. I'm not a Japanese translator, but I think this
> sentence is translated differently when the translator sees the whole
> line "Preparing ..., setting ...".
>
> Since the code between the first fprintf and this one should not take
> long to execute, perhaps we can just delete the first printf and print
> a whole [*] sentence here?

Yeah, also it is a bit troubling that "Preparing" is an incomplete line,
and when update-ref/symblic-ref call fails, will stay to be incomplete.

> I think the purpose of "Preparing..." in the first place is to show
> something when git is busy checkout out the worktree. As long as we
> print it before git-reset, we should be good.
>
>> +		find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
>> +
>> +	strbuf_reset(&sb);
>> +	pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
>> +	if (sb.len > 0)
>> +		fprintf(stderr, " %s", sb.buf);
>
> [*] Yes I know it's not "whole" because of this piece. But this one is
> more or less a separate sentence already so it's probably ok.

Doing all the additional fprintf/fputc at the same place (instead of
across update-ref/symbolic-ref) would make it easier to follow and
also allow it to make "whole" even with that piece.  Prepare the
abbreviated commit->object.oid.hash and FMT_ONELINE in the same
strbuf and say that the HEAD is there.  I think it also makes sense
to split it into two sentences, so from that point of view, just
dropping the change in the "Preparing" hunk and then saying "HEAD is
now at '9876fdea title of the commit'" after update/symbolic-ref may
also be a good change.  That automatically removes the "what hapepns
to the rest of the incomplete line when run_command() fails?" issue.

> Is it a bit too long to print everything in one line though?
> CMIT_FMT_ONELINE could already fill 70 columns easily.
>
>> +	fputc('\n', stderr);
>> +
>>  	if (opts->checkout) {
>>  		cp.argv = NULL;
>>  		argv_array_clear(&cp.args);
>> -		argv_array_pushl(&cp.args, "reset", "--hard", NULL);
>> +		argv_array_pushl(&cp.args, "reset", "--hard", "--quiet", NULL);
>>  		cp.env = child_env.argv;
>>  		ret = run_command(&cp);
>>  		if (ret)
>> -- 
>> 2.16.1.101.gde0f0111ea
>> 
