From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git
Date: Wed, 05 Aug 2015 16:58:01 -0700
Message-ID: <xmqqk2t91e5y.fsf@gitster.dls.corp.google.com>
References: <xmqqoail1h2c.fsf@gitster.dls.corp.google.com>
	<1438816453.10324.0.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 01:58:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN8ZX-0002el-Pt
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 01:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226AbbHEX6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 19:58:06 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33815 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbbHEX6E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 19:58:04 -0400
Received: by pawu10 with SMTP id u10so47538777paw.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 16:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=wJBZwL0tzqQgSViGQ/OcUmbtr2MDhezgpU5p4JJcvtc=;
        b=R8MS6OtyrVMNuPO785UhgsN/36rAYJonJlV04TDf/A3vuK6jg4tO7AnSV20JMREk16
         JP/hq2uJIg9vEykvUjNBc38sYzZ3HvwWJyguBwWh7OHEfEoXGcoqVGOKc8szWrhFcCzm
         AnKJhO8ScXkVkk8zNsKGwN7TL+qFxrd37yWvFX5C3rkcbDe1EHyT7nF9lNTBG77QZI0N
         u6WXvq+vhtTRfGZaA1n55Lj7qO2Hh4peeMCFGxtQTS8qc6hy6L+OwI1I+8a5JEwz1SO9
         817ZC+zRRV/PHRv7wR01GJld4vtQeh8ra0ipMe7G8zSg7aQbIrwO2phNILbOptnQlHhy
         56wA==
X-Received: by 10.66.66.172 with SMTP id g12mr21716123pat.21.1438819084209;
        Wed, 05 Aug 2015 16:58:04 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:5cf0:2451:9503:37d])
        by smtp.gmail.com with ESMTPSA id kr1sm4135472pbc.93.2015.08.05.16.58.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 05 Aug 2015 16:58:02 -0700 (PDT)
In-Reply-To: <1438816453.10324.0.camel@twopensource.com> (David Turner's
	message of "Wed, 05 Aug 2015 19:14:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275409>

David Turner <dturner@twopensource.com> writes:

> On Wed, 2015-08-05 at 15:55 -0700, Junio C Hamano wrote:
>> * dt/untracked-subdir (2015-08-05) 2 commits
>>  - DONTMERGE: Waiting for an Ack from Duy
>>  - untracked-cache: fix subdirectory handling
>>  (this branch uses dt/untracked-sparse.)
>> 
>>  This seems to break some tests.
>
> All tests pass for me locally.  What's broken for you?


*** prove ***
t7063-status-untracked-cache.sh .. Dubious, test returned 1 (wstat 256, 0x100)
Failed 3/30 subtests

Test Summary Report
-------------------
t7063-status-untracked-cache.sh (Wstat: 256 Tests: 30 Failed: 3)
  Failed tests:  28-30
  Non-zero exit status: 1
Files=1, Tests=30, 27 wallclock secs ( 0.04 usr  0.01 sys +  0.15 cusr  0.67 csys =  0.87 CPU)
Result: FAIL

$ sh t7063-status-untracked-cache -i -v

ends like so:

...
node creation: 2
gitignore invalidation: 0
directory invalidation: 1
opendir: 3
EOF
        test_cmp ../trace.expect ../trace

strace: invalid option -- 'k'
usage: strace [-CdffhiqrtttTvVxxy] [-I n] [-e expr]...
              [-a column] [-o file] [-s strsize] [-P path]...
              -p pid... / [-D] [-E var=val]... [-u username] PROG [ARGS]
   or: strace -c[df] [-I n] [-e expr]... [-O overhead] [-S sortby]
              -p pid... / [-D] [-E var=val]... [-u username] PROG [ARGS]
-c -- count time, calls, and errors for each syscall and report summary
-C -- like -c but also print regular output
-d -- enable debug output to stderr
-D -- run tracer process as a detached grandchild, not as parent
-f -- follow forks, -ff -- with output into separate files
-i -- print instruction pointer at time of syscall
-q -- suppress messages about attaching, detaching, etc.
-r -- print relative timestamp, -t -- absolute timestamp, -tt -- with usecs
-T -- print time spent in each syscall
-v -- verbose mode: print unabbreviated argv, stat, termios, etc. args
-x -- print non-ascii strings in hex, -xx -- print all strings in hex
-y -- print paths associated with file descriptor arguments
-h -- print help message, -V -- print version
-a column -- alignment COLUMN for printing syscall results (default 40)
-b execve -- detach on this syscall
-e expr -- a qualifying expression: option=[!]all or option=[!]val1[,val2]...
   options: trace, abbrev, verbose, raw, signal, read, write
-I interruptible --
   1: no signals are blocked
   2: fatal signals are blocked while decoding syscall (default)
   3: fatal signals are always blocked (default if '-o FILE PROG')
   4: fatal signals and SIGTSTP (^Z) are always blocked
      (useful to make 'strace -o FILE PROG' not stop on ^Z)
-o file -- send trace output to FILE instead of stderr
-O overhead -- set overhead for tracing syscalls to OVERHEAD usecs
-p pid -- trace process with process id PID, may be repeated
-s strsize -- limit length of print strings to STRSIZE chars (default 32)
-S sortby -- sort syscall counts by: time, calls, name, nothing (default time)
-u username -- run command as username handling setuid and/or setgid
-E var=val -- put var=val in the environment for command
-E var -- remove var from the environment for command
-P path -- trace accesses to path
not ok 28 - test sparse status with untracked cache and subdir
