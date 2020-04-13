Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0110CC2BA19
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 11:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C42662072C
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 11:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QETl8KCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgDMLEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 07:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728620AbgDMLEl (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Apr 2020 07:04:41 -0400
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 07:04:41 EDT
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C106DC008749
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 03:58:18 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id cl8so2498983pjb.3
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 03:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q6Esur8ZU8J/6Qppmhph7bE0BgYvPh88IlfSSeP6cCY=;
        b=QETl8KCfDcQfp2pE2qyiL7SCZ+RLDanRrWnLb0FJnG4XT4rN/+xDKcia/FgibLI8OO
         TR+bAdR0nJOKZmudFxa+lpk+1J9ndEiMNFh8HoDYVxQiTZd7Qb0kdE5fKIIPUkiKoU1U
         j9xeKyvZ7eYo6sXwskkJSFr8d/h4ipUo+Zrbj1VRZogc7xtnoDGPjyBKLLmMYUilnT3K
         oB3P/1clQeZPrhLVMIbbCMw4QZq4DOPyWYq/uMzP75QtADImdpOzUKB47bsYcFclafkc
         1uiVuCbN0uALbzo/uih2KspXthCkQDor4ihBsTaddazF4GaUuKyaKovh8cm/bHXU5lPs
         4pMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q6Esur8ZU8J/6Qppmhph7bE0BgYvPh88IlfSSeP6cCY=;
        b=iFSS2bdrscJNKRHOkChr6y1T2HnERFchuke+4JGHUaElrRjL4/px4BtKaBx7m3tKk1
         u4zfs6CMZEp2GgkOg7y2Ete9OOh4rG3ZneJ8YGOfR/DqIU5uPplKzwYrJA6//syJcPi1
         N67t3b0LAmA3LXe0VXDpRHxma1K5WvqhBFca7Rre+q6Ajv5rASzlyRm+pR4k4rb1nqFJ
         onX3q/2zZNV40G/m8Ts+qfBhQL2pj+qC44F1rPRndqbZlVQUFzts06ZBCsya1BE/o+hR
         bRnKu3F11c2uK5oO+Xu10+VpWcdAefgjcUx93oCFau1p127C7boH4j+/ZHbEu/gNPn9d
         uChA==
X-Gm-Message-State: AGi0PuZ3shqZrNieOv3l4FguUx4NZaf3UQKxBGj4umLIWYU48pHJ3Bth
        a8pgvDFnD2K/TIbiohj8AdE=
X-Google-Smtp-Source: APiQypKGduNYKiKivj3LehRZxGG1nYSzyZD417g2K0D+9ZVoOOHpRF6f4FyxRvVLlOx+Ar0/tRTjNA==
X-Received: by 2002:a17:902:6ac9:: with SMTP id i9mr17422881plt.35.1586775498011;
        Mon, 13 Apr 2020 03:58:18 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.3])
        by smtp.gmail.com with ESMTPSA id f64sm8773742pfb.72.2020.04.13.03.58.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2020 03:58:17 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v10 2/8] receive-pack: add new proc-receive hook
Date:   Mon, 13 Apr 2020 18:58:09 +0800
Message-Id: <20200413105809.79988-1-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.24.1.15.g448c31058d.agit.4.5
In-Reply-To: <xmqq5ze4e6j2.fsf@gitster.c.googlers.com>
References: <xmqq5ze4e6j2.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> 于2020年4月13日周一 上午5:30写道：
>
> Jiang Xin <worldhello.net@gmail.com> writes:
> >     # Receive result from the hook.
> >     # OK, run this command successfully.
> >     H: PKT-LINE(<old-oid> <new-oid> <ref> ok)
> >     # NO, I reject it.
> >     H: PKT-LINE(<old-oid> <new-oid> <ref> ng <reason>)
> >     # Fall through, let 'receive-pack' to execute it.
> >     H: PKT-LINE(<old-oid> <new-oid> <ref> ft)
> >     # OK, but has an alternate reference.  The alternate reference name
> >     # and other status are given in key=value pairs after the null
> >     # character.
> >     H: PKT-LINE(<old-oid> <new-oid> <ref> ok\0ref=refs/pull/123/head
> >                 forced-update)
>
> The semantics of this one is fuzzy.  We made an update to a ref that
> is different from the one that was requested (presumably that is what
> is reported after "\0ref="), OK, but did we update the ref in the
> request, too, or did we leave the ref in the request intact?  Or, do
> we say "no\0ref=..." if we don't update the requested ref and
> instead update a different one?  Let's hold the answer at this point
> and keep thinking...

Before making a decision, we must consider some limitations or backward
compatibility issues.  See the limitations from following code snippet
of "send-pack.c" and "transport.c":

* "receive-pack" should not send status other than "ok" and "ng" to "send-pack".
  We must keep this for backward compatibility.

    # File: send-pack.c
    #
    152 static int receive_status(struct packet_reader *reader, struct ref *refs)
    153 {
    159     while (1) {
    160         const char *refname;
    161         char *msg;
    162         if (packet_reader_read(reader) != PACKET_READ_NORMAL)
    163             break;
    164         if (!starts_with(reader->line, "ok ") && !starts_with(reader->line, "ng ")) {
    165             error("invalid ref status from remote: %s", reader->line);
    166             ret = -1;
    167             break;
    168         }

* Do not report unknown reference to "send-pack". Each returned reference
  must be included in `remote_refs`.

    175         /* first try searching at our hint, falling back to all refs */
    176         if (hint)
    177             hint = find_ref_by_name(hint, refname);
    178         if (!hint)
    179             hint = find_ref_by_name(refs, refname);
    180       Â  if (!hint) {
    181             warning("remote reported status on unknown ref: %s",
    182                     refname);

* Do not report unexpected reference to "send-pack".

    185         if (hint->status != REF_STATUS_EXPECTING_REPORT) {
    186             warning("remote reported status on unexpected ref: %s",
    187                     refname);
    188             continue;
    189         }

* Client will complain if a expecting command not is not received from
  the report.

    # File: transport.c
    #
    531 static int print_one_push_status(struct ref *ref, const char *dest, int count,
    532                                  int porcelain, int summary_width)
    540     switch(ref->status) {
    584     case REF_STATUS_EXPECTING_REPORT:
    585         print_ref_status('!', "[remote failure]", ref,
    586                          ref->deletion ? NULL : ref->peer_ref,
    587                          "remote failed to report status",
    588                          porcelain, summary_width);


So we should not invent new status between "receive-pack" and "send-pack".
It is reasonable to to extend the report function from 'receive-pack'
to 'send-pack' (not the report from 'proc-receive' to 'receive-pack')
by adding a null character and multiple key-value pairs as extended
status after the "ok" and "ng" message.

For example, the following git-push command:

    git push origin HEAD:refs/for/master/topic

The refspec points to a pseudo reference "refs/for/master/topic", which
does not exist on the server, so the old-oid of the command to
"receive-pack" must be a zero-oid. The command for 'proc-receive' is:

    <zero-oid> <new-oid> refs/for/master/topic

If "proc-receive" find this `git-push` command is associated with an already
exist pull request (such as "refs/pull/123/head"), it will update this
reference instead of creating a new one.

For this case, we can extend the report line (from "receive-pack" to
"send-pack”) like this:

    ok refs/for/master/topic\0ref=refs/pull/123/head old-oid=<hash> [forced-push]

This extended report line is backward compatible. Old version of git
client will show message like this:

    To upstream.git
     * [new branch]          HEAD -> refs/for/master/topic

New version of git has the knowledge of how to handle the extended-status
after the null character, will print the following message:

    To upstream.git
     + 1234567...7654321     HEAD -> refs/pull/124/head (forced update)


Actually, both 'ok' and 'ng' status have the knowledge of '<msg>', even
though the '<msg>' is ignored by the 'ok' status. After the extension,
both of them can take key-value pairs as extended-status, like:

    ok <reference> [msg]\0key=value ...
    ng <reference> [msg]\0key=value ...

We can use '<msg>' and the extended status to fit our needs in the future.

As for the design of status report from 'proc-receive' to 'receive-pack',
we should follow the same rules:

1. Never report status for non-exists commands.

2. Do not forget to report some of the commands.

3. After receive report for commands from 'proc-receive', we should have
   enough information to generate report to 'send-pack' from these commands.

For the above example, when user push to 'refs/for/master/topic',
'proc-receive' may report to 'receive-pack' like this:

    PKT-LINE(<old-oid> <new-oid> <ref> ok\0ref=refs/pull/123/head forced-update)

'send-pack' will save the key-value pairs into the cooresponding `ref->remote_status`.
If the report line has a different '<old-oid>' or '<new-oid>' for the '<ref>',
'send-pack' will substitude the oids of the ref, and append new key-value
pairs (old-oid=<hash> and new-oid=<hash>) to `ref->remote_status`.

> >     H: ... ...
> >     H: flush-pkt
> >
> > After receiving a command, the hook will execute the command, and may
> > create/update different reference.  For example, a command for a pseudo
> > reference "refs/for/master/topic" may create/update different reference
> > such as "refs/pull/123/head".  The alternate reference name and other
> > status are given in key-value pairs as extended status of the report
> > line.
> >
> > The list of commands returned from "proc-receive" will replace the
> > relevant commands that are sent from user to "receive-pack", and
> > "receive-pack" will continue to run the "execute_commands" function and
> > other routines.  Finally, the result of the execution of these commands
> > will be reported to end user.
>
> It is not clear if there needs to be any correspondence between the
> sequence of input commands and the sequence of output commands.  I
> am guessing that there is not any and the hook is allowed to do
> anything as it wants to.  For example:
>
>  - it is OK to execute them all and report them, but in a totally
>    random order.
>
>  - it is OK to ignore all input and report no update (not even
>    "ng").
>
>  - it is OK to be asked to update one ref, but update and report
>    updates to two refs that are not related to the requested ref.
>
> Is my understanding correct?
>
> Or does the design tie the set of input and output ref updates
> closely together, i.e. one input corresponds to one output and they
> are in order, so all the hook is allowed to do is
>
>  - to execute and update as it is told, and report "ok",
>
>  - to reject and report "ng", or
>
>  - to update *another* ref without updating the requested one, with
>    "ok\0ref=..." mechanism.
>
> I am not sure which one is more sensible, though.
>
> If we choose to use the "anything goes" approach, I do not think
> there is no need for the "ok\nref=..." mechanism---we can just give
> two output records, one "ok" for the original request, and a new
> "ok" that reports the "we updated this one instead".

I saw you have noticed the code for replacing the commands of 'receive-pack'
by comparing ref name.

> > +             } else if (strcmp("ok", status)) {
> > +                     strbuf_addf(errmsg, "proc-receive has bad status '%s' for '%s'\n",
> > +                                 status, reader->line);
> > +                     code = -1;
> > +                     /* Skip marking it as RUN_PROC_RECEIVE_RETURNED */
>
> But then shouldn't we be complaining if msg is not NULL here,
> instead of silently ignoring?  Also we didn't see what happened to
> the promised "ok\0ref=..." stuff here, or the passthru "ft".
> Puzzled...

I implement "ft" and "\0key=value..." features in patch 6/8, and it
depends another refactoring commit.  I can squash it to this commit
in next reroll, and rearrange the refactoring commmit and test cases.


> > +                     continue;
> > +             }
> > +             oidcpy(&hint->old_oid, &old_oid);
> > +             oidcpy(&hint->new_oid, &new_oid);
> > +             hint->run_proc_receive |= RUN_PROC_RECEIVE_RETURNED;
>
> Or, is this last one the catch all for "ft" (in other words, the
> hook does not have to say "ft", but as long as it says two non-SP
> letters that are not "ok" nor "ng", it is taken as "ft")?

"ft" is implemented in patch 6/8.  This code is used to help to find
missing reported references.

>
> > +     }
> > +
> > +     for (cmd = commands; cmd; cmd = cmd->next)
> > +             if (cmd->run_proc_receive && !cmd->error_string &&
> > +                 !(cmd->run_proc_receive & RUN_PROC_RECEIVE_RETURNED)) {
> > +                 cmd->error_string = "no report from proc-receive";
> > +                 code = -1;
> > +             }
> > +
> > +     return code;
> > +}
>
> OK, so this sort-of answers my earlier question.  But not quite...
>
> The output records and the input requests are tied by "<ref>" each
> input record wanted to udpate.  The order does not matter, but not
> having a corresponding report in the hook's output is like the hook
> reporting a "ng" failure.  It also means that the hook can update
> two refs in response to one request, but it is awkward.
>

Right sort order of the output commnands has better performace.
The hook can only update commands marked with 'run_proc_receive'.

"update two refs", do you mean duplicate report line from 'proc-receive'? 
If 'proc-receive' really want to update several references for one
command, it must report all of the updates in one report line by adding
message, or adding additional key-value pairs.

> > +static int run_proc_receive_hook(struct command *commands,
> > +                              const struct string_list *push_options)
> > +{
> > +     struct child_process proc = CHILD_PROCESS_INIT;
> > +     struct async muxer;
> > +     struct command *cmd;
> > +     const char *argv[2];
> > +     struct packet_reader reader;
> > +     struct strbuf cap = STRBUF_INIT;
> > +     struct strbuf errmsg = STRBUF_INIT;
> > +     int pr_use_push_options = 0;
> > +     int version = 0;
> > +     int code;
> > +
> > +     argv[0] = find_hook("proc-receive");
> > +     if (!argv[0]) {
> > +             rp_error("cannot find hook 'proc-receive'");
> > +             return -1;
> > +     }
> > +     argv[1] = NULL;
> > +
> > +     proc.argv = argv;
> > +     proc.in = -1;
> > +     proc.out = -1;
> > +     proc.trace2_hook_name = "proc-receive";
> > +
>
> Isn't this a brand new protocol between receive-pack and a hook?  I
> am puzzled why we want a choice between using and not using
> sideband.  It's not like you are maintaining compatibility with
> ancient version of Git that talked with proc-receive hook but
> without sideband, because it did not know how to multiplex sideband
> communication.  Shouldn't we just always assume that the sideband is
> available?

The sideband message stream (stderr of 'proc-receive') will be sent
directly to the client.  If the client is a very old version of git,
is is still safe?

> Or are we just letting the hook directly answer the push client and
> that is why this thing needs to know if we are using sideband
> between us and the client?  I kind of expected that you'd keep the
> two communication channels on both sides isolated so that the side
> that talks with the hook does not need to know how we are talking
> with the client.

In test cases for 'proc-receive', I output some debug info on stderr
of 'proc-receive' hook.  If the client (very old version of git)
does not support sideband, it's ok.

> > +     if (use_sideband) {
> > +             memset(&muxer, 0, sizeof(muxer));
> > +             muxer.proc = copy_to_sideband;
> > +             muxer.in = -1;
> > +             code = start_async(&muxer);
> > +             if (code)
> > +                     return code;
> > +             proc.err = muxer.in;
> > +     } else {
> > +             proc.err = 0;
> > +     }
> > +
> > +     code = start_command(&proc);
> > +     if (code) {
> > +             if (use_sideband)
> > +                     finish_async(&muxer);
> > +             return code;
> > +     }
> > +
> > +     sigchain_push(SIGPIPE, SIG_IGN);
> > +
> > +     /* Version negotiaton */
> > +     packet_reader_init(&reader, proc.out, NULL, 0,
> > +                        PACKET_READ_CHOMP_NEWLINE |
> > +                        PACKET_READ_DIE_ON_ERR_PACKET);
> > ...
> > @@ -1497,6 +1731,20 @@ static void execute_commands(struct command *commands,
> >
> >       reject_updates_to_hidden(commands);
> >
> > +     /* Try to find commands that have special prefix in their reference names,
>
> Style?

Will fix.
>
> > +      * and mark them to run an external "proc-receive" hook later.
> > +      */
