Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE8AFA3741
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 21:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiJaVqT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 17:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJaVqL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 17:46:11 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4A5140DE
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 14:46:09 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id y14so32755634ejd.9
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 14:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t446J54c10YxxdW/5ljJ7GcBrMEU9MWWkb6tCnxNXAA=;
        b=MEf6X14IJvaSAkoW9C2cFmPyMEnW2YBe9kJcUb6uN8L5DOJTBdi685TNFnQ6le8RA2
         XFXUTgeCkTRCfw/GaHc5nKHe35g+sMqBl84K/09AcAtgkI7f54ra2bH+kQT4nZ2v/1DY
         j8bAIjo6p/s/l3wwcVV3ap0aQtrvWjhbA633Ba7JPzN/THyizsxhPbottHkIL8qBP/Lt
         jK/4wU6j667YKiD0qRxid8bnFq5DVPSVIu9qYFrmW9z1G1rSzTbTvPdXRXHQAjIAJiBr
         gkvCebgkLCnBUcCuYPccI0C5RF7J0kSFz8GnApLJwstOpcgL+xl4sguk2kLofaZa48k8
         BKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t446J54c10YxxdW/5ljJ7GcBrMEU9MWWkb6tCnxNXAA=;
        b=qrTjyjgEDM9qPgFgOslfZI3YJH6EFQJ/kr/GjqtQtSln46jErvv8tBBiGE0dT0IEG/
         UzJobEwYCbmD0IS8gfJnhbogKv44ATiEbe7T47m9gCCHduHTFcpqEC0D3rEXUzo5jl66
         1gD92k75WRcOKtX0A2ZLp+Hpy/194wbVx0kQmvzRhQ0lknJMMmg+4klcZYkxcDUgV99/
         8JgZFyKJwy9vMIKkxguRIRiaHC9IFMlkIbIXslOqyJXHVg0qVwcmzlH/Yi6z55f2o+l3
         9g2knniT5r6T00Wsa0bLOT2rS3Kae91JKDCh0KZme8eTrRc56JueoJnGmlA+aOk7QuDh
         I5VA==
X-Gm-Message-State: ACrzQf3ctS6U2pNN4PAlgqT4BFD5fwVnC/vluS1NnpLQwLD7JY2VSnP0
        6LB6NErvbfO2F1TE0qheFlx4LIHs7xI=
X-Google-Smtp-Source: AMsMyM6T1wQd66uK1aEABqM7CGpeULNt1C9xEaf+iYLjRpTNnHX2CwS1630ce0WOMqDp0R5EDko2tA==
X-Received: by 2002:a17:907:6e24:b0:791:905f:7881 with SMTP id sd36-20020a1709076e2400b00791905f7881mr15157184ejc.120.1667252767915;
        Mon, 31 Oct 2022 14:46:07 -0700 (PDT)
Received: from localhost (84-236-78-97.pool.digikabel.hu. [84.236.78.97])
        by smtp.gmail.com with ESMTPSA id bc5-20020a056402204500b00461c1804cdasm3695852edb.3.2022.10.31.14.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 14:46:07 -0700 (PDT)
Date:   Mon, 31 Oct 2022 22:45:54 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     man dog <dogman888888@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug report: git -L requires excessive memory.
Message-ID: <20221031214554.GA1714@szeder.dev>
References: <CAFOPqVXz2XwzX8vGU7wLuqb2ZuwTuOFAzBLRM_QPk+NJa=eC-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFOPqVXz2XwzX8vGU7wLuqb2ZuwTuOFAzBLRM_QPk+NJa=eC-g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 30, 2022 at 01:59:41AM +0900, man dog wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> git log -L /regex/,/regex/:myfile to a repo in which 2MB text file is
> committed about 2800 times.
> 
> What did you expect to happen? (Expected behavior)
> get the result.
> 
> What happened instead? (Actual behavior)
> fatal: Out of memory, malloc failed (tried to allocate 2346801 bytes)

Thanks for the report and the reproduction recipe.

This is not a buggy allocation (the size matches the size of the test
file + 1 byte), but the line-level log apparently leaks some memory
for each commit modifying the file in question, and in your case their
combined size is excessive because of the somewhat big file that is
modified in every commit.

'line-log.c' contains two "NEEDSWORK leaking like a sieve" comments,
but you managed to stumble upon yet another case (those two are in the
code path handling merge commits, but your history is linear).

The patch below plugs this leak.

  ---  >8  ---

diff --git a/line-log.c b/line-log.c
index 51d93310a4..b6ea82ac6b 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1195,6 +1195,9 @@ static int process_ranges_ordinary_commit(struct rev_info *rev, struct commit *c
 	if (parent)
 		add_line_range(rev, parent, parent_range);
 	free_line_log_data(parent_range);
+	for (int i = 0; i < queue.nr; i++)
+		diff_free_filepair(queue.queue[i]);
+	free(queue.queue);
 	return changed;
 }
 
  ---  8<  ---

> What's different between what you expected and what actually happened?
> The function requires too much memory.
> -n option should work for -L function.

Line-level log does work with '-n', but the file is so big and is
modified so many times between commits that do touch the specified
line range, that by the time it gets to the 10th commit to show it has
already leaked over 4GB memory.  Had you specified an even smaller
number of commits to show it might have worked:

  $ for i in {1..7} ; do /usr/bin/time -f "n: $i  maxRSS: %M" git log -L /func_007\(/,/}$/:test.txt -n $i >/dev/null || break ; done
  n: 1  maxRSS: 531192
  n: 2  maxRSS: 989504
  n: 3  maxRSS: 1447900
  n: 4  maxRSS: 1906408
  n: 5  maxRSS: 2364740
  n: 6  maxRSS: 2823148
  n: 7  maxRSS: 3282360

In you reproduction recipe the given line range is modified every 100
commit and there are 3000 commits in total, so I estimate the total
memory usage to be somewhere around 13.5GB.  With the patch above it
tops out at around 260MB.


> Anything else you want to add:
> I made a script to reproduce this. Please run the script below.
> Results in each environments are in its header.
> A workaround which is given in other BBS is included also.
> 
> 
> 
> 
> #!/bin/bash
> #
> # Bug report: git -L requires excessive memory.
> # Run this script to reproduce
> #
> # MINGW32(git version 2.38.1.windows.1) fatal: Out of memory, malloc
> failed (tried to allocate 2346801 bytes)
> # MINGW64(git version 2.38.1.windows.1) requires  8.6GB
> # Linux64(git version 2.20.1          ) requires 13.1GB
> #
> 
> git --version
> 
> if [ ! -d .git ]; then
>   git init
>   c=${1:-3000}
>   for (( i=0;i<c;i++)); do
>     gawk -v r="$i" '
>       BEGIN{
>         for (i=0;i<100;i++) {
>           if (r>=i) {
>             printf("function func_%03d(){ // revised at %d\n",i,
> int((r-i)/100)*100+i%100)
>             printf("  // contents of function\n")
>             printf("}\n")
>             make_subfuncs(i);
>           }
>         }
>         exit
>       }
>       function make_subfuncs(i,    j){
>         for (j=0;j<300;j++) {
>           printf("function func_%03d_sub%03d(){\n",i,j)
>           printf("  // contents of sub functions are NOT revised.\n")
>           printf("}\n")
>         }
>       }' > test.txt
>     git add test.txt
>     git commit -m "revision $i"
>   done
>   git gc
> fi
> 
> git log -L /func_007\(/,/}$/:test.txt # this command requires excessive memory.
> git log -L /func_007\(/,/}$/:test.txt -n 10 # -n option doesn't work also.
> #git log -L /func_007\(/,/}$/:test.txt HEAD~10..HEAD~0 # this works.

Perhaps I misunderstood, but I got the impression that you think that
'HEAD~10..HEAD~0' and '-n 10' do the same.

They are not: 'HEAD~10..HEAD~0' means to process only the last ten
commits, so it can't leak all that much, and that's why it worked.
'-n 10', however, means to _show_ only ten commits, but process as
many commits as necessary to find those ten.  In your case, with the
line range being modified every 100 commit, that amounts to processing
over 1000 commits.

> #
> # This can be a workaround
> #
> step=50
> num=`git log | grep -c commit`
> for ((i=0;i<$num;i+=$step)); do
>   end=$((i+$step))
>   range=HEAD~$end..HEAD~$i
>   if [ $end -ge $num ]; then
>     range=HEAD~$i
>   fi
> #  echo $range
>   git --no-pager log -L /func_007\(/,/}$/:test.txt $range
> done
> 
> 
> 
> 
> [System Info]
> [Enabled Hooks]
