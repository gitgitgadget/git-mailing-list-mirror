From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH v2] blame: add support for --[no-]progress option
Date: Sun, 22 Nov 2015 14:28:33 -0600
Message-ID: <CAOc6etZzE030LBUVKZSEHsjbbCQJr_UbfCYKxBOWdjkqDdZYDg@mail.gmail.com>
References: <1448208133-29430-1-git-send-email-eantoranz@gmail.com>
	<56521E79.4080709@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	"Max A.K." <max@max630.net>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Nov 22 21:29:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0bG3-0005oJ-2p
	for gcvg-git-2@plane.gmane.org; Sun, 22 Nov 2015 21:29:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504AbbKVU2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2015 15:28:34 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34146 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbbKVU2e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2015 15:28:34 -0500
Received: by padhx2 with SMTP id hx2so169844714pad.1
        for <git@vger.kernel.org>; Sun, 22 Nov 2015 12:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aLhBnJMD/M2z1XZOMu1WIuS4tkcWK9VRJJch0Ehs3Ow=;
        b=iEZmrXsNxYnMjyMr0Q0belwNJ269VflBupVUYfCipACOm50dKnP1+hWSoQyYQ5Eifn
         W57aKfV25PKrbEyqDK5/Jh82jYG7sPGrNPvOkzgD3K4MWlwZTw7mHh0c7+8chea9eaBz
         2Q8LzQ4a/ziWV4OqPh/wlUYj+1c3WaEmw39A2dYl2GzzNd/KlJkpRwC5OIaHGZUSakHe
         Rkh6AlNHpMsOJM516M3nn/frCy7JVolb7pUYUN7KVZbZ4cRfb5ng/Jziis1N+2sYqqGb
         Yu8OCbcMeR2lHgK72bHT7G7dKSDeWta+GFHN+IUQkH+7c95cDeMTGec7e0R6MofzhvXX
         qjcw==
X-Received: by 10.98.75.83 with SMTP id y80mr11884045pfa.77.1448224113782;
 Sun, 22 Nov 2015 12:28:33 -0800 (PST)
Received: by 10.66.89.42 with HTTP; Sun, 22 Nov 2015 12:28:33 -0800 (PST)
In-Reply-To: <56521E79.4080709@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281569>

Hey, Johannes!

An oversight! git-annotate.txt took me to blame-options.txt.... and I
didn't notice it's also pointed to from git-blame.txt. Let's wait for
some comments about the coding (or blessings) so that I can send
another patch.

Thanks!

On Sun, Nov 22, 2015 at 1:58 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 22.11.2015 um 17:02 schrieb Edmundo Carmona Antoranz:
>>
>> Will also affect annotate
>>
>> Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
>> ---
>>   Documentation/blame-options.txt |  7 +++++++
>>   Documentation/git-blame.txt     |  9 ++++++++-
>>   builtin/blame.c                 | 25 +++++++++++++++++++++++--
>>   3 files changed, 38 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/blame-options.txt
>> b/Documentation/blame-options.txt
>> index 760eab7..43f4f08 100644
>> --- a/Documentation/blame-options.txt
>> +++ b/Documentation/blame-options.txt
>> @@ -69,6 +69,13 @@ include::line-range-format.txt[]
>>         iso format is used. For supported values, see the discussion
>>         of the --date option at linkgit:git-log[1].
>>
>> +--[no-]progress::
>> +       Progress status is reported on the standard error stream
>> +       by default when it is attached to a terminal. This flag
>> +       enables progress reporting even if not attached to a
>> +       terminal.
>> +
>> +
>>   -M|<num>|::
>>         Detect moved or copied lines within a file. When a commit
>>         moves or copies a block of lines (e.g. the original file
>> diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
>> index e6e947c..2e63397 100644
>> --- a/Documentation/git-blame.txt
>> +++ b/Documentation/git-blame.txt
>> @@ -10,7 +10,8 @@ SYNOPSIS
>>   [verse]
>>   'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w]
>> [--incremental]
>>             [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C]
>> [--since=<date>]
>> -           [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>]
>> [--] <file>
>> +           [--[no-]progress] [--abbrev=<n>] [<rev> | --contents <file> |
>> --reverse <rev>]
>> +           [--] <file>
>
>
> You add the option to to the synopsis of git-blame.txt, but not to
> git-annotate.txt.
>
>>
>>   DESCRIPTION
>>   -----------
>> @@ -88,6 +89,12 @@ include::blame-options.txt[]
>>         abbreviated object name, use <n>+1 digits. Note that 1 column
>>         is used for a caret to mark the boundary commit.
>>
>> +--[no-]progress::
>> +       Progress status is reported on the standard error stream
>> +       by default when it is attached to a terminal. This flag
>> +       enables progress reporting even if not attached to a
>> +       terminal.
>> +
>
>
> Any particular reason you add this text twice? As can be seen on the hunk
> header, git-blame.txt includes blame-options.txt.
>
> -- Hannes
>
