Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB02B23B634
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 01:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790905988; cv=pass; b=FAftO1RX328m7tY0NwTvOOPRk3D0iPhaq7BxOdM6qkPhCwOXjLXUWIWgDuflabs2HX9BpVrjtWvqwVywFa9+pYR/6lQiDXTngXPa3iNAsD6CJx7hhdNPS4V+dVsnGH/jG1bL4cOTSKBEIAjrMZ/Qozbv8SzLaVynlFYYIP1BPE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790905988; c=relaxed/simple;
	bh=DN/cEsI+HI7NUAn40vnvoloWSopGLGiC+1j+N7yBgnc=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qq9mZjsD2bMhShWNuJCDBTIULD5Rew69P8amqIf2z0gxdy57ye25tWbV2sT8vt0lHj9ge6zxiRTJhIzi9Fx8fakVd1VSNNHn8VuAQ4j3Ibs5DhhuDf+EzGJ6n1+whLqODUDS3vgVSh6+U1iUXLzgn8wvnmkxGm7TATM44es5gQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kanamei.com; spf=pass smtp.mailfrom=kanamei.com; dkim=pass (2048-bit key) header.d=kanamei-com.20251104.gappssmtp.com header.i=@kanamei-com.20251104.gappssmtp.com header.b=E1iTinXT; arc=pass smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kanamei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kanamei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kanamei-com.20251104.gappssmtp.com header.i=@kanamei-com.20251104.gappssmtp.com header.b="E1iTinXT"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e46a15703so6675358eec.0
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 18:53:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790905986; cv=none;
        d=google.com; s=arc-20260327;
        b=bqXogM8mrk0bTdIV2XW6MAl7K9qL4hVUdcYU8wxZ6iaprnIgNCtUGL35hXqVS7TpSA
         6PMBnczMGVjE0wadfrlJcz95UAD44tJ4CaYSzLGhPVkCO8+/w4UvTfktu0y9xMNCOG/V
         lRZK+lPXhpUs3l1OmKudiybRydr8ZJ7ay3/KpacheP92u8n998k+fmAoK7bGQ4jU/Q23
         6dWmqI74cKqKTjiaPekRp865Metz+IS7KXCceRREFB57pgnf2q6ur92CmwF2hV9k6gXc
         bmH276hPHNgPjyvhlhwpbPeHK59COYl1EQFORMefXjIznK1EWHr5vsfYJHJGT1w2plcy
         omig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=DN/cEsI+HI7NUAn40vnvoloWSopGLGiC+1j+N7yBgnc=;
        fh=dS7ZYYEQ3xS9uUoit4NbHrS7bRskiJR+qpqNwgt9xSw=;
        b=SOvuBWEYX2l9t7aI9C7lqhJoStk/JYVovtE0961Jm2XUEc6mg1pw1TieoZa0mrepEH
         v4iyjTi07CAVzhYUxxzXaXtyZUFORniU4cgYGfhWBUb/9EEbYziX8f7kDtTSfEUgiAJF
         Joh8buBvR1aYNz46DhE0EnjpIEoNhkeNekbn4+E7wsCXUbeeE5pri6/mcbVig1r7SGp9
         5zyxPakld+EAvLUXKlpxqFkufKNPtFx7xKTWBV47DBNeMZcZE/2UUNG3y0Pp22elbR9d
         6gyIZGZG1mS+ZoHLnOYaFML54MdQ/sFTAvZeI+vMBxgS8WYRpz86YJDzXLiuoa0EY/KO
         1zwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kanamei-com.20251104.gappssmtp.com; s=20251104; t=1790905986; x=1791510786; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DN/cEsI+HI7NUAn40vnvoloWSopGLGiC+1j+N7yBgnc=;
        b=E1iTinXTEcyI3NWUlXn7ypvl69fVXJObx6f/6YGs4hdlbOCvsacSPon+Dw2w1VYTMo
         HiuNVlCAvK5DKt+DFOa1LPjc1nQfASLSrG07WSaoocHoN+djqJ7jD6zibrI7bWr4cOPj
         DdhobsS4fRUcVdGO0yAfDUrL2yZyR1uLVkhvKYtpa4phK0VdHDzuST2IAIHM+cPn94dU
         2MlNC1oF+y8OKWj32wbKxNg0uhX6X3QuAwm/pmt+p3ryCeTDyfivW6CYxZkl1qQRUg7X
         KSD2DZ57/oW0OKy4hnbzPOdICpr0GbOYWfoLmC/dbC7gRI8hVhwp1u69VkCO0pVdj5oe
         tymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790905986; x=1791510786;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DN/cEsI+HI7NUAn40vnvoloWSopGLGiC+1j+N7yBgnc=;
        b=P4f7HbXjDEJQZKpkoflP0clFOCSQ3m0gseyjUfCE7svwDUe4hEsl0jMFfhQ+KhGWzx
         uhYUt9Uu/XWMeE5omBKvV2XsChhcyIcvSOWX1OkIOgdA9t3rwQSjZj9Yond09YvLSGVG
         HPnvrqpkq+VNvsOsWev4k56nNTkqX4zIi/4WtxCy6/F2h7t6lcUvSt9lbXBRzTW0QO3m
         Ul5GYyiwZbf3r7OP6L4EWvGkyVhst9Jbf7Aj4hb1STGMhBJMMlq1R7OWCkpRMWmCzgX6
         UFOKGL3ldlmpbzcM6uK8rlmAHL0rxAcgrHsAFZpKui9rjsySUolthQk1gJR77EnZd+Pn
         WZ2w==
X-Gm-Message-State: AFq9FYLNVkY7Qv3AG/Yj+cEQ+h8edKWMhS40E5PioFVvuPPkIM29w5MD
	Z/BuP2a8cgd3kXYM2XIijjURWurO4qPmXtaBlpmnew3+PZUY8MBvNZBsZkMG9SZ9V+q2YBzeYEq
	DRD97jOake+NzGK/ttGJ26toBxMQIiyT2pVHA6in1VA==
X-Gm-Gg: AYBFou25WKTx4USETydZ61WvWXKRsBebvyn74q57nu2tRnl8kvEss71vE6Edp+hbPKF
	k++NW7fkscxTsNW9b7QRLNSva1zIoOol/EiUzXtvrsQEMnciSH8WVNMn7fLR3QR7wDSqxEpWY/z
	JCAYtBDc7vnvVb8YMz4w/hJtqFaTQeli9fg/pDgLrhCr/TUGQgHZHKryuKOR7l6YtjCimIgSf5b
	RulhjcHmXPH4dtM1v79Ff+X1GN8tAtfO4DM74LRaFn5aAY7xyjxKrPYeifkE7mBQd+RpZdvYTBm
	YL01Bui/+XtGUFr/L4n+IzBg1fwl0iRV784IUtykxXXTVQL53Vyb4rx6KQ==
X-Received: by 2002:a05:7301:259c:b0:34c:1ddd:baee with SMTP id
 5a478bee46e88-34f14f15b5bmr1368100eec.2.1790905985477; Thu, 01 Oct 2026
 18:53:05 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 1 Oct 2026 18:53:04 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 1 Oct 2026 18:53:04 -0700
In-Reply-To: <xmqq7bk173qm.fsf@gitster.g>
References: <20260929074222.11942-1-kazumasa.shigeta@kanamei.com>
 <20261001042155.33303-1-kazumasa.shigeta@kanamei.com> <xmqq7bk173qm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?6YeN55Sw5LiA6IGW?= <kazumasa.shigeta@kanamei.com>
Date: Thu, 1 Oct 2026 18:53:04 -0700
X-Gm-Features: AclHuK_XScEtxZ3F8elt13SVCqrGV7OSNfntVUuw9oPyDiCzPvR3HmS29KP-NjA
Message-ID: <CANUHOw2Q1Dg=e7zfAcRUBMyKt+cVW02V5MZV4x7vAyA6iJ=PWw@mail.gmail.com>
Subject: Re: [PATCH v2] stash: expose untracked modes in create
To: gitster@pobox.com
Cc: git@vger.kernel.org, shabbir.r.bhojani@gmail.com, 
	phillip.wood@dunelm.org.uk, ps@pks.im
Content-Type: text/plain; charset="UTF-8"

Hi Junio,

Sorry for the crossed replies. As you also pointed out, I should have
replied to Phillip before sending v2. After Patrick raised that point, I
was writing my response to Phillip, and I did not notice that your
messages had arrived while I was doing so. I ended up sending my reply
to Phillip before seeing your comments.

Thank you for the detailed review. I will go through your comments
carefully before following up.

I am not very quick at writing these emails, so it takes me quite a
while to respond. Sorry about that. I will do my best to understand the
points properly and improve the next round.

Thanks,
Kazumasa Shigeta

On Thu, 01 Oct 2026 10:03:13 -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Kazumasa Shigeta <kazumasa.shigeta@kanamei.com> writes:
>
> > `git stash create` always passes zero for the include_untracked parameter
> > of do_create_stash(), even though that helper already supports untracked
> > and ignored files and stash push/save expose those modes as
> > -u/--include-untracked and -a/--all.
>
> There may be no lies in what the above says, but we would prefer to
> hear what the user visible implication of "passing 0" is more than
> what mechanically is happening inside a program. For example:
>
> "git stash create", "git stash push", and "git stash save" are
> commands that create a new stash entry. The latter two are also
> responsible for storing the resulting stash entry to the reflog
> of the "refs/stash" ref, but have options to control what is
> included in the stash entry. Among these options, "create" only
> supports the equivalent of "-m <message." to record in the stash
> entry. Most notably, "-u" and "-a" options are missing.
>
> > Teach create to accept the same options and pass the existing mode
> > through. Unlike push/save, create continues to only create objects: it
> > does not update refs/stash, reset the index, or clean the working tree.
>
> Sure. It is a very concise and good description of what we want to
> do.
>
> > Use parse_options() for the new options and stop parsing at the first
> > non-option message word. This keeps option-like tokens after the message
> > as message text, while leading option-like arguments now follow Git's
> > normal option parsing. In particular, unknown or malformed leading
> > options are rejected instead of silently becoming a message, short
> > options may be combined, and `--` can be used when a message itself
> > begins with a dash.
>
> Why do we need to go into such a detail in the log message? What is
> the above paragraph designed to convey to the reader? Again, it may
> not be telling any lies, but it misses the point by being inconsiderate
> to your readers. What you need to tell them is _WHY_ you chose to
> use parse_options() in such a way. What were you trying to achieve?
>
> I am guessing that something along this line ...
>
> "git stash create" traditionally treated the rest of the command
> line as a message. For example,
>
> $ git stash create adding -u option
>
> has always been a request to create a stash entry with the
> string "adding -u option" as its message. We should not make it
> trigger the "-u" (include untracked) behavior for backward
> compatibility, by using parse_options() with stop-at-the-non-option
> mode to forbid it from reordering the command line arguments.
>
> ... was what you wanted to say, but I am not sure.
>
> How much of all these verbiage was written by AI by the way? You'd
> need to spend effort to make it readable to humans.
>
> > Keep create's existing no-change behavior: detect the usual no-change
> > case before do_create_stash() refreshes and writes the index, and return
> > success without printing an object name. If do_create_stash() still
> > reports its internal "nothing to create" result, map that to create's
> > public success status.
>
> You already said that with "does not update, reset, or clean".
>
> > This follows the stash subcommand exit-status convention established by
> > 786fc390465f (stash: reserve exit status 1 for conflicts, 2026-09-03):
> > subcommands return 0 on success, negative values on failure, and status 1
> > when applying a stash results in conflicts. cmd_stash() maps negative
> > subcommand failures to 128.
>
> Again, there may not be lies in here, but if you did not make a
> breaking change to the established convention, is it worth saying?
>
> > 9ca6326dff29 (stash: refactor stash_create, 2017-02-19) added the
> > internal include-untracked path while intentionally leaving the user
> > interface for "git stash create" unchanged. Reuse that machinery and
> > the existing INCLUDE_ALL_FILES mode rather than adding a separate stash
> > creation path.
> >
> > Add coverage for short and long aliases, combined short options, the
> > untracked/ignored boundary including an ignored-only worktree, option
> > parsing and dash-leading messages, no-change behavior, and preservation
> > of refs/stash, the index state, and the working tree.
>
> Again, adding tests for comprehensive coverage is not something to
> boast about. Is it worth saying?
>
> Aren't -p/-S/-k/-q and pathspec support all about the creating half
> of "git stash push" that are not available to "git stash create",
> not just "-u" and "-a"? Why are we singling out only these two? It
> may be more worthwhile to explain the rationale behind such a design
> decision.
