From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 1/2] init-db.c: honor case on case preserving fs
Date: Sun, 2 Feb 2014 09:46:55 +0400
Message-ID: <CAHkcoth+4d1PsSaoUEFcLVbE-q7bhVBWut1WRyEKCOxSJ0tTwQ@mail.gmail.com>
References: <1391246067-30499-1-git-send-email-reubenhwk@gmail.com>
	<CAHkcotg3McjrnQ_rLi4YpLAauMQT6U0kjEp1eu+6jxbuRY5zrA@mail.gmail.com>
	<CAD_8n+TQ4i2Z5zePXCTqpdF8mpRrzzKjDUB-NxZ1PJAwek-y1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Reuben Hawkins <reubenhwk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 02 06:47:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9ptU-0000tt-Sg
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 06:47:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbaBBFq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 00:46:57 -0500
Received: from mail-qc0-f177.google.com ([209.85.216.177]:35470 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbaBBFq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 00:46:56 -0500
Received: by mail-qc0-f177.google.com with SMTP id i8so9248924qcq.8
        for <git@vger.kernel.org>; Sat, 01 Feb 2014 21:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=N2+1kdj/3/VBx09sITHsxV0t7uhgiYYH5usIZY5IPf0=;
        b=I3hYG9XGZe7IZyAO0ohvZYZwP5UwIBL4dJlYvLFHbqqDaRAeJ6k7eh84DRswO9MQDR
         PUlJAjNmymgXvnWQXkFELvvRLSWm2fDp3qM7ABkHZItFI1kgo3bfu8mYSgFl19fnYRW4
         JJ+ELm229anlxps2VjRDVWShI/klC2H3fTdjzJDu+BW/isjqCzOrJhYAiosLc7FNIbgC
         W6d/6TOfbIJzKOfV/JFVYkZ7YTpQxxvkl9LJIyxROwlqM7LsEzTr8G1KxYEKBQD9vdqK
         +LTVvbVeW0M5WcIyA2W7/QJo18ccrRXLeuc8Al7uzoeJJJCj0FyBVBH4A1lGOSB4Jrim
         y6sg==
X-Received: by 10.140.33.198 with SMTP id j64mr42649092qgj.14.1391320015742;
 Sat, 01 Feb 2014 21:46:55 -0800 (PST)
Received: by 10.96.213.101 with HTTP; Sat, 1 Feb 2014 21:46:55 -0800 (PST)
In-Reply-To: <CAD_8n+TQ4i2Z5zePXCTqpdF8mpRrzzKjDUB-NxZ1PJAwek-y1w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241353>

On 2/2/14, Reuben Hawkins <reubenhwk@gmail.com> wrote:
>>
> This is a separate issue which core.ignorecase is sweeping under the rug.
>  When you get this error message, do an 'ls' and you'll see there isn't an
> untracked file called 'FileName.txt'.  There is, however, a tracked file
> called 'Filename.txt'.  Because there aren't really any untracked files,
> the merge should be able to complete without overwriting anything.

I am afraid but it is exactly the same issue, because it never happens
on any case-sensitive system. IIRC, Git stats 'FileName.txt' to verify
whether it exists or not, and the file system tells that this file
exists, because it ignores case. So the option is called 'ignorecase'.

No one meant this option to be about whether the file system preserves
case or not, because Git does not care about it and assumes that on
any case-insensitive filesystem, the right case is in the index, which is
usually better, because otherwise people can often change filenames
inadvertently.

I don't know much about importers, but I have looked at the source code
of fast-import.c and I do not see ignore_case there, though it may affect
it indirectly through some functions that it uses. AFAIK, fast-import does
not rely on the filesystem, it should always work with ignorecase=false.


Dmitry
