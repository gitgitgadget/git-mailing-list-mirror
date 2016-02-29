From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv19 00/11] Expose submodule parallelism to the user
Date: Mon, 29 Feb 2016 13:22:42 -0800
Message-ID: <CAGZ79kZmuY=-G6votRtX69odiuMq8BDYK8eCqW8q8GDub9p3WA@mail.gmail.com>
References: <CAPc5daWbkNXp8T4U2tiYftB4kSOjf9Cv1fgmbYbpuoKdJPRHGA@mail.gmail.com>
	<1456444119-6934-1-git-send-email-sbeller@google.com>
	<56D4AE8A.2050403@kdbg.org>
	<xmqq1t7v9qou.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY5nxDQ_o0L_MOYFOx4FPH1apW-TuB88UypuwDaLuKGNQ@mail.gmail.com>
	<xmqqwppn8ba4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 22:22:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaVHD-0001XS-TJ
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 22:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbcB2VWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 16:22:44 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:36288 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbcB2VWn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 16:22:43 -0500
Received: by mail-io0-f174.google.com with SMTP id l127so201101279iof.3
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 13:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ibqMW2SQ/xQpa/+/B1759f+tvLWAFISQXOpJ9zrFn3k=;
        b=jveXIH5J6jvLy7DXUpFcEdhXMBgGzoSojjMraDmQSpREgjBgN3j95KsgCUZP6bQc7J
         dtOhGSdOWhMRqEufdPtTvWwbMdmHdSKuOU4+ia36fLMzS7SlxrtmRzQerzrAg8J4Ko9H
         EWgkU2VlM2NdQhbLFKTUPHQMcNu+xQG3S87DdygD73AybbjOwTQTyzH7kuhfc1fqREy+
         tnkaqrinI8GVd+eCrhuKP1k4OvzrQtdsaCzkJKFJxbk8owjD1rypIwGYjIOK2VqwRe7Q
         fqoAeq/oPVA3l+k6+JIS0Msg/yYpmvQaIAGKvE0B6+XrtgClPEYMnriHm/B3UwcacbfG
         H3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ibqMW2SQ/xQpa/+/B1759f+tvLWAFISQXOpJ9zrFn3k=;
        b=Mu5EGKn3L/Uyy/zXiiVSi9R0QJMaV+UuRV/W0F8llXZhxXdJZ+LB+M2eQMqqdS0EO9
         QiICxS4Be4ciJ+1nUdlbIAyrnoDQ2LNbPTitllB6jSWiFuNc5U7xIY37DVGj8B7UsQ+r
         Y+gXYTvCqvOJ5HRQ9KpN8lcuVfKsYlhsCJt4LV9nQXRzA86Z2LAJDH3gmReUpUTv11ci
         bIPQizQ46QNA/4kmORXkACYMx3wZx+Re2ibUZENCYT9UQFAiypvne6KyNS4KZfUq7A0C
         svq/OET9adI6foyNHuUb1trJcYZv3CHDvHCOP54FdDAvklcaLL4Q1CH+n8/BjSdra1/7
         bnNw==
X-Gm-Message-State: AG10YORxY2AibX2/i9ksjI4pMkjYhbX0ceoBe4UVvVWt+r1Nfdf8kl4Zu1I54fgyONGJQusmagzvCgTqzz7lV5+t
X-Received: by 10.107.167.80 with SMTP id q77mr24980337ioe.110.1456780962235;
 Mon, 29 Feb 2016 13:22:42 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Mon, 29 Feb 2016 13:22:42 -0800 (PST)
In-Reply-To: <xmqqwppn8ba4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287904>

On Mon, Feb 29, 2016 at 1:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Maybe we want to remove the struct child_process from the
>> function signature of the callbacks and callbacks need to rely on
>> the data provided solely thru the pointer as passed around for
>> callback purposes, which the user is free to use for any kind
>> of data.
>
> I think that is the most sensible.

Ok I'll send the diff above as a patch.
>
>> As a rather quickfix for 2.8 (and 2.7) we could however just
>> breakup the finish_command function and call child_process_clear
>> after the callbacks have run.
>
> That would not fix the case where run_command() fails, clears child
> and then start failure callback, no?

For that I was about to propose (broken whitespace below):

commit a0dcfbf86b6b720529958a4043d3679ed6f340d0
Author: Stefan Beller <sbeller@google.com>
Date:   Mon Feb 29 13:20:38 2016 -0800

    run-command: factor cleanup out of start_command

    The default callback of the parallel processing infrastructure assumes
    start_command will not clear the child process upon failing to start a
    child process. However having access to the child's argument vector
    enables easy error reporting, so move cleaning the child into a wrapper
    for general use and the parallel processing infrastructure needs to take
    care of cleaning up the child itself

    Signed-off-by: Stefan Beller <sbeller@google.com>

diff --git a/run-command.c b/run-command.c
index 863dad5..b1d97d0 100644
--- a/run-command.c
+++ b/run-command.c
@@ -265,7 +265,7 @@ static int wait_or_whine(pid_t pid, const char
*argv0, int in_signal)
         return code;
 }

-int start_command(struct child_process *cmd)
+static int start_command_uncleaned(struct child_process *cmd)
 {
         int need_in, need_out, need_err;
         int fdin[2], fdout[2], fderr[2];
@@ -326,7 +326,6 @@ int start_command(struct child_process *cmd)
 fail_pipe:
                         error("cannot create %s pipe for %s: %s",
                                 str, cmd->argv[0], strerror(failed_errno));
-                        child_process_clear(cmd);
                         errno = failed_errno;
                         return -1;
                 }
@@ -510,7 +509,7 @@ fail_pipe:
                         close_pair(fderr);
                 else if (cmd->err)
                         close(cmd->err);
-                child_process_clear(cmd);
+
                 errno = failed_errno;
                 return -1;
         }
@@ -533,6 +532,14 @@ fail_pipe:
         return 0;
 }

+int start_command(struct child_process *cmd)
+{
+        int code = start_command_uncleaned(cmd);
+        if (code == -1)
+                child_process_clear(cmd);
+        return code;
+}
+
 int finish_command(struct child_process *cmd)
 {
         int ret = wait_or_whine(cmd->pid, cmd->argv[0], 0);
@@ -1047,11 +1054,12 @@ static int pp_start_one(struct parallel_processes *pp)
         pp->children[i].process.stdout_to_stderr = 1;
         pp->children[i].process.no_stdin = 1;

-        if (start_command(&pp->children[i].process)) {
+        if (start_command_uncleaned(&pp->children[i].process)) {
                 code = pp->start_failure(&pp->children[i].process,
                                          &pp->children[i].err,
                                          pp->data,
                                          &pp->children[i].data);
+                child_process_clear(&pp->children[i].process);
                 strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
                 strbuf_reset(&pp->children[i].err);
                 if (code)
