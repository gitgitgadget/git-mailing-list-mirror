Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 147A720A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 04:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbeLKEJl (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 23:09:41 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:36086 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbeLKEJk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 23:09:40 -0500
Received: by mail-wm1-f46.google.com with SMTP id a18so722452wmj.1
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 20:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bhWV4fZJbaIBTLSTpkLx4J/yPshF9yDVM9Y0/29UbW8=;
        b=VcMDvbOrpX4+tfnhoI+ZEBwujmpdqIbmQ0/eR3UGoTZhR6k7DaMbLqNSa1ccRa6aSO
         GnpJ0d/gZnQeMxIw7SiGJm+8yPnNHAcfsIAlaGyVBjeo4SfNN3gDon7jk+3HiiJuuB2X
         UnBVN/xAQpA062e85fgR7JJBR7bV7V8fSARkeOne3V1+fj4YdXVcbuGZZ+IIcZtOLRK3
         Q640mjVba0hPFuD5lmOf4nxP4PMHFNjxMN/k/4X5NiaqdFzA4q1i1Mh62qO2hmpTWX5V
         skd6TwK5BbKw4ls1jKEhvLDkTAl+95LvDvZrGNnmTzkUkdCC+8RtMEC0SwmU45iuDLUf
         OHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bhWV4fZJbaIBTLSTpkLx4J/yPshF9yDVM9Y0/29UbW8=;
        b=RvG0m9FEATqV0Bsqev9EUw5lI1F1OcknCjI+1TJxngm5L5KwEnWI+74fYU+WQFNu9A
         x64a+TUdPNpH5NnLZoyisB8Ijpht4SA50PINSQJzITQ9FU7hbxaH106viMnY9ePlsMsJ
         IdRD5r94sFbsa7HMD7eHTu92CJE8iY4yZTUP0VOUm3GsBKNyW7by0Pi7OnOuAcGUYD1v
         t3WCPZD+rOtHyw6yumM/QyhRuvFDCW4bjCZ5n2vjctXu2Qsxi2MAzWuJL+YmZ/RQQ/yL
         mA08vlmCUm6oYg0neluEOFaRyl8qJr+O+V9NpjT6+B8pkCuJ0o7znA4e8tRjPHecPI8l
         x2Iw==
X-Gm-Message-State: AA+aEWYR0xKhwyzM5CcpZ4HyjFXPmpxXf8jjAILEuEpL+2Su0VfHGC4T
        qa8Nyd/jOpFa5HlJYHxtVlw=
X-Google-Smtp-Source: AFSGD/U432BWUv8++0A1bB3otWpTr5UgZEEyJ2ERWzwPj7uae+5p2TMyMaqPFN37bRYeYU7jJtt7QA==
X-Received: by 2002:a1c:5604:: with SMTP id k4mr734390wmb.107.1544501378580;
        Mon, 10 Dec 2018 20:09:38 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y12sm667960wmi.7.2018.12.10.20.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 20:09:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     John Passaro <john.a.passaro@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: silent_exec_failure when calling gpg
References: <CAJdN7Kj5RaAsTstx_G14a_bR5Y92M3rtWAiMNPnQWgmz4JgEOg@mail.gmail.com>
        <xmqqlg4wlocc.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 11 Dec 2018 13:09:37 +0900
In-Reply-To: <xmqqlg4wlocc.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 11 Dec 2018 12:44:03 +0900")
Message-ID: <xmqqh8fkln5q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> John Passaro <john.a.passaro@gmail.com> writes:
>
>> I've noticed that in v2.19.1, when using git to pretty print
>> information about the signature, if git cannot find gpg (e.g. "git
>> config gpg.program nogpg"), it prints an error to stderr:
>>
>> $ git show -s --pretty=%G?
>> fatal: cannot run nogpg: No such file or directory
>> N
>
> I think the uninteded behaviour change was in 17809a98 ("Merge
> branch 'jk/run-command-notdot'", 2018-10-30).

Perhaps something like this.  There needs an additional test added
for this codepath, which I haven't done yet, though.

 run-command.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/run-command.c b/run-command.c
index d679cc267c..e2bc18a083 100644
--- a/run-command.c
+++ b/run-command.c
@@ -728,6 +728,8 @@ int start_command(struct child_process *cmd)
 	if (prepare_cmd(&argv, cmd) < 0) {
 		failed_errno = errno;
 		cmd->pid = -1;
+		if (!cmd->silent_exec_failure)
+			error_errno("cannot run %s", cmd->argv[0]);
 		goto end_of_spawn;
 	}
 
