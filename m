From: Sergey Shelukhin <sergey@hortonworks.com>
Subject: Re: strange problems applying --no-prefix patch with -p0 and added files
Date: Fri, 26 Oct 2012 15:14:50 -0700
Message-ID: <CAHXxaiDE-GwufHHjGXOB=1O44dcfF0exuXtP-XpY8TyJ90914w@mail.gmail.com>
References: <CAHXxaiCELHomSPQoZWw+SdV61Y0gVb9MEdRv-gCOfkJG50xCeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 27 00:15:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRsBF-000808-Qy
	for gcvg-git-2@plane.gmane.org; Sat, 27 Oct 2012 00:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966724Ab2JZWOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 18:14:52 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55870 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755877Ab2JZWOv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 18:14:51 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so1970756lbo.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 15:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:x-gm-message-state;
        bh=TNO4rMRnvCaPkG17NRm/Ti01f2JARVdwtrNzd4+7bvo=;
        b=D4I9txvOSzYviV96+lzsZ3YF3bFnzbRsCOe/4SIgCNdstcDFbxxAKE709HMql2oga0
         7JFDp2lSmbAE2CUVy48I+mSvw9BfN6s0mmXngWw3rFI++0DHnUffXI+TUWNAAGq3+AyE
         z8f2RPJlEldThfptIbOFQO721pu68QKiGaRxEYdoFSrZndZNUc3MMWI/MQhmx1ERKwGZ
         p1lCNlTf9+A/ad4Rpr/+qnWrPTD+CBPOByQuVkfb9E8pqz5VFD2kUQnfgb2lb7hFBrC9
         ssPiuSTkNm0RhtMJYhknOOzfVuE4MBEiGONo+GY6mYNJcbhRQlhYyfct45AyDZ9cN6np
         f5+w==
Received: by 10.152.105.33 with SMTP id gj1mr21628967lab.49.1351289690154;
 Fri, 26 Oct 2012 15:14:50 -0700 (PDT)
Received: by 10.114.14.134 with HTTP; Fri, 26 Oct 2012 15:14:50 -0700 (PDT)
In-Reply-To: <CAHXxaiCELHomSPQoZWw+SdV61Y0gVb9MEdRv-gCOfkJG50xCeQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQmOPEB4rLC4+m/SUzqAjewWEJRbQLCrW4DmKTBpQmEae28OO9VtQhFNBdSdWfbJbCCftiTo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208494>

Hi. Any pointers? Is there some bug tracking system to file a bug to?
Thanks.

On Wed, Oct 24, 2012 at 1:54 PM, Sergey Shelukhin
<sergey@hortonworks.com> wrote:
> Hello.
> I am trying to apply a patch made via {git diff somehash^ somehash >
> ....} before (same version of Git, same machine). I have no-prefix
> enabled by default.
> If I try to apply the patch with -p0, it fails.
> If I go to a directory where all the changed files are ("src/" below)
> to "simulate" the prefix for -p1, it silently does nothing.
> Only if I make it a -p1 patch, it actually tries to do apply (and
> applies the new files that cause problems in -p0 alright too, if used
> with --reject).
>
> I am relatively new to git, so while researching I realized I might be
> using wrong ways to do things (e.g. not using cherry-pick), but this
> seems like a bug regardless.
>
> Here's the log of my interactions with git:
>
> reznor-mbp:git-hbase-089 sergey$ git version
> git version 1.7.10.2 (Apple Git-33)
> reznor-mbp:git-hbase-089 sergey$ git status
> # On branch 0.94
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #    HBASE-6371.patch
> nothing added to commit but untracked files present (use "git add" to track)
> reznor-mbp:git-hbase-089 sergey$ git apply -p0 HBASE-6371.patch
> fatal: git apply: bad git-diff - inconsistent new filename on line 128
> reznor-mbp:git-hbase-089 sergey$ sed -n 125,129p HBASE-6371.patch
> diff --git src/main/java/org/apache/
> hadoop/hbase/regionserver/CompactSelection.java
> src/main/java/org/apache/hadoop/hbase/regionserver/CompactSelection.java
> new file mode 100644
> index 0000000..a9ee0d4
> --- /dev/null
> +++ src/main/java/org/apache/hadoop/hbase/regionserver/CompactSelection.java
> reznor-mbp:git-hbase-089 sergey$ cd src
> reznor-mbp:src sergey$ git apply -p1 -v --whitespace=nowarn ../HBASE-6371.patch
> [ there's nothing here, e.g. no output ]
> reznor-mbp:src sergey$ git status
> # On branch 0.94
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #    ../HBASE-6371.patch
> nothing added to commit but untracked files present (use "git add" to track)
> reznor-mbp:src sergey$ cd ..
> reznor-mbp:git-hbase-089 sergey$ sed -E "s/(--git|---) src/\1 a\/src/"
> HBASE-6371.patch | sed -E "s/ src\// b\/src\//" >
> HBASE-6371-prefix.patch
> reznor-mbp:git-hbase-089 sergey$ git apply HBASE-6371-prefix.patch
> HBASE-6371-prefix.patch:169: trailing whitespace.
>  ...
> error: patch failed:
> src/main/java/org/apache/hadoop/hbase/HBaseConfiguration.java:64
> error: src/main/java/org/apache/hadoop/hbase/HBaseConfiguration.java:
> patch does not apply
> ....
