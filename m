From: Arjun Sreedharan <arjun024@gmail.com>
Subject: Re: [PATCH] introduce git root
Date: Sun, 30 Nov 2014 10:05:37 +0530
Message-ID: <CAJFMrCEciWXhBb36MVeFPi7Y7D=9zQ2xGPpiyUz9y4_hOh_taw@mail.gmail.com>
References: <1417291211-32268-1-git-send-email-arjun024@gmail.com> <2AC7B765F56B4AA8A0DB76E8C670A889@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Nov 30 05:36:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuwEu-0005K6-Q7
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 05:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbaK3Ef7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2014 23:35:59 -0500
Received: from mail-qc0-f180.google.com ([209.85.216.180]:36050 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbaK3Ef6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2014 23:35:58 -0500
Received: by mail-qc0-f180.google.com with SMTP id i8so6221667qcq.39
        for <git@vger.kernel.org>; Sat, 29 Nov 2014 20:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Dl1rHDoGHm1Pruq0XnbqxK9Oo5WIePbnQfARYeKCTh0=;
        b=HTRhGHipXzjLtLKpTVlDuwBiMtYnHMhTHuHvGrutX+r9glvchRoytuS/Cx5YnyjlYP
         ef5xi7+T0UogOLElAnHRP4xsjHAJPP2GlbuQgGDTYBODQyMFGbkY+4LlJ165Afo1WhU0
         q6bqmDeyqko/MTmz3aYVhmPhYc+dJh4mbN7fsh9f3mgIt61e070Al64ZJgfmsyE9vLXE
         2JePwRMB1sj3EV7e3O+dfA1CYA2SNrszE4H4G8CVH1PtQ378CXeoirBqYyV8QgWW52Un
         udisiD3hhaKDZm6RcxXoltM0n4QT1sf6oBfV836Bem/u0D2U13lFpS31XDBKtHcuG0oB
         ej5A==
X-Received: by 10.224.38.71 with SMTP id a7mr11082988qae.24.1417322157957;
 Sat, 29 Nov 2014 20:35:57 -0800 (PST)
Received: by 10.140.239.147 with HTTP; Sat, 29 Nov 2014 20:35:37 -0800 (PST)
In-Reply-To: <2AC7B765F56B4AA8A0DB76E8C670A889@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260386>

On 30 November 2014 at 04:38, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Arjun Sreedharan" <arjun024@gmail.com>
>>
>> This introduces `git root` which outputs the root directory
>> (the directory that contains .git).
>> The same can be accomplished by `git rev-parse --show-toplevel`.
>> `git root` is much more intuitive and easy to remember.
>> All it does is set the arguments for rev-parse
>
>
> This may be better as an alias.
> I've added it to my aliases list.
>

I know that. I am suggesting this to be a built-in command, without having the
need to add as an alias.

>>
>> Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>
>> ---
>>
>>
>> Hi,
>> I don't know if I can just send a patch for a new "command" in git,
>> I probably shouldn't. Well, i thought it's anyway better explaining
>> this way than just asking for comments.
>>
>> With the kind of projects i have been involved with in the recent past, I
>> have had to deal with subprojects inside projects and for many reasons had
>> to find ways to find the root git folder and at times to "cd" to it.
>>
>> The obvious choice is to go for `git rev-parse --show-toplevel`. But, this
>> to me doesn't seem very _intuitive_ and `git root` does.
>> bzr has `bzr root`. hg has `hg root`. So, for programmers i am guessing
>> this pattern would also be _instinctive_, and i am thinking why not `git
>> root`?
>> Arjun Sreedharan
>>
>>
>>
>> Makefile       |  1 +
>> builtin.h      |  1 +
>> builtin/root.c | 10 ++++++++++
>> git.c          |  1 +
>> 4 files changed, 13 insertions(+)
>> create mode 100644 builtin/root.c
>>
>> diff --git a/Makefile b/Makefile
>> index 827006b..7f28d13 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -869,6 +869,7 @@ BUILTIN_OBJS += builtin/rev-list.o
>> BUILTIN_OBJS += builtin/rev-parse.o
>> BUILTIN_OBJS += builtin/revert.o
>> BUILTIN_OBJS += builtin/rm.o
>> +BUILTIN_OBJS += builtin/root.o
>> BUILTIN_OBJS += builtin/send-pack.o
>> BUILTIN_OBJS += builtin/shortlog.o
>> BUILTIN_OBJS += builtin/show-branch.o
>> diff --git a/builtin.h b/builtin.h
>> index b87df70..4672d72 100644
>> --- a/builtin.h
>> +++ b/builtin.h
>> @@ -112,6 +112,7 @@ extern int cmd_rev_list(int argc, const char **argv,
>> const char *prefix);
>> extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
>> extern int cmd_revert(int argc, const char **argv, const char *prefix);
>> extern int cmd_rm(int argc, const char **argv, const char *prefix);
>> +extern int cmd_root(int argc, const char **argv, const char *prefix);
>> extern int cmd_send_pack(int argc, const char **argv, const char *prefix);
>> extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
>> extern int cmd_show(int argc, const char **argv, const char *prefix);
>> diff --git a/builtin/root.c b/builtin/root.c
>> new file mode 100644
>> index 0000000..c2eeca3
>> --- /dev/null
>> +++ b/builtin/root.c
>> @@ -0,0 +1,10 @@
>> +#include "builtin.h"
>> +#include "argv-array.h"
>> +
>> +int cmd_root(int argc, const char **argv, const char *prefix)
>> +{
>> + struct argv_array root_args = ARGV_ARRAY_INIT;
>> +
>> + argv_array_pushl(&root_args, argv[0], "--show-toplevel", NULL);
>> + return cmd_rev_parse(root_args.argc, root_args.argv, prefix);
>> +}
>> diff --git a/git.c b/git.c
>> index 18fbf79..6a0be5f 100644
>> --- a/git.c
>> +++ b/git.c
>> @@ -461,6 +461,7 @@ static struct cmd_struct commands[] = {
>>  { "rev-parse", cmd_rev_parse },
>>  { "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
>>  { "rm", cmd_rm, RUN_SETUP },
>> + { "root", cmd_root, RUN_SETUP },
>>  { "send-pack", cmd_send_pack, RUN_SETUP },
>>  { "shortlog", cmd_shortlog, RUN_SETUP_GENTLY | USE_PAGER },
>>  { "show", cmd_show, RUN_SETUP },
>> --
>> 1.7.11.7
>>
>> --
>
> Philip
