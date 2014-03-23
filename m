From: Per Cederqvist <cederp@opera.com>
Subject: Re: [GUILT 04/28] Allow "guilt import-commit" to run from a dir which
 contains spaces.
Date: Sun, 23 Mar 2014 22:13:53 +0100
Message-ID: <CAP=KgsTVfJ-P9OvpHOHf8kOtf+nZAwY94Dr4FcPDnwr23XP7+Q@mail.gmail.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
	<1395387126-13681-5-git-send-email-cederp@opera.com>
	<20140323170409.GG1661@meili.valhalla.31bits.net>
	<CAP=KgsSBcsG1kMfyc=MbUDCuC+4W9Boa2Fwf-FSg6XNxaCAt8g@mail.gmail.com>
	<20140323200739.GJ1661@meili.valhalla.31bits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Sun Mar 23 22:14:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRpit-0005l4-4G
	for gcvg-git-2@plane.gmane.org; Sun, 23 Mar 2014 22:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbaCWVNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2014 17:13:54 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:51384 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbaCWVNy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2014 17:13:54 -0400
Received: by mail-ie0-f174.google.com with SMTP id rp18so4632604iec.19
        for <git@vger.kernel.org>; Sun, 23 Mar 2014 14:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=y9AEHH9ptAgzze5DZKhwq7XVKkaYh9Ya8ZawLB5p2Ho=;
        b=gV1kbc9XoltQLOk5ZpwZapu/F9avkpKDBrDlznqivUW7BksVMHTgLxmq8GFKOUZ9QR
         +ERnju5V8pV7kTq6i/DY/o5eJuUEeLKBDsUccX6zxLrX0JkE9t1RijBBwqoSCdvvQ0zM
         I+stCETjhyf7+AU7LUyT8G7NlJOiZ/Gvc5VNzZDXA0FXkTaIGWD3/vhbUPY0VGZ4ipMc
         TCk8JNSWOiLXmkj0s6Mcv8T7qeqqEM4kafixDN+LBk5At90g8GGBuxLSFPPPX9Q9YnaA
         hOz53phFiBsa1emymKprFavPmMr0LZyRo4oTfr5s8XxsKsQ6jIHUocfkgVGfBLdDSU9z
         7dQA==
X-Gm-Message-State: ALoCoQlAJL0LffqSKBWkv1YxZUkUyLjSe99IxAQOyqG8N/WOi3flhDLVw1RpShruFemuM0kEq4MS
X-Received: by 10.50.225.134 with SMTP id rk6mr8251707igc.31.1395609233610;
 Sun, 23 Mar 2014 14:13:53 -0700 (PDT)
Received: by 10.42.44.198 with HTTP; Sun, 23 Mar 2014 14:13:53 -0700 (PDT)
In-Reply-To: <20140323200739.GJ1661@meili.valhalla.31bits.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244807>

On Sun, Mar 23, 2014 at 9:07 PM, Jeff Sipek <jeffpc@josefsipek.net> wrote:
> On Sun, Mar 23, 2014 at 08:57:08PM +0100, Per Cederqvist wrote:
>> On Sun, Mar 23, 2014 at 6:04 PM, Jeff Sipek <jeffpc@josefsipek.net> wrote:
>>
>> > On Fri, Mar 21, 2014 at 08:31:42AM +0100, Per Cederqvist wrote:
>> >
>> >> Signed-off-by: Per Cederqvist <cederp@opera.com>
>> >> ---
>> >>  guilt-import-commit | 6 +++---
>> >>  1 file changed, 3 insertions(+), 3 deletions(-)
>> >>
>> >> diff --git a/guilt-import-commit b/guilt-import-commit
>> >> index 20dcee2..9488ded 100755
>> >> --- a/guilt-import-commit
>> >> +++ b/guilt-import-commit
>> >> @@ -23,7 +23,7 @@ if ! must_commit_first; then
>> >>  fi
>> >>
>> >>  disp "About to begin conversion..." >&2
>> >> -disp "Current head: `cat $GIT_DIR/refs/heads/\`git_branch\``" >&2
>> >> +disp "Current head: `cat \"$GIT_DIR\"/refs/heads/\`git_branch\``" >&2
>> >
>> > I wonder if it'd be better to use 'git rev-parse' here instead of looking at
>> > the refs directly.
>> >
>> > IOW,
>> >
>> > disp "Current head: `git rev-parse \`git_branch\``" >&2
>>
>> That is probably a good idea. I only made the minimum change
>> required to get the test suite to pass.
>
> I totally understand.
>
>> > Maybe even $() instead of the inner `` to clean it up some more.
>>
>> Yes, given that that construct is already used in several places
>> it is apparently portable enough for guilt. (I guess nobody uses
>> /bin/sh on Solaris to run guilt. It doesn't support the $(...)
>> construct.)
>
> Hrm?  I'm using OpenIndiana (OpenSolaris derivative) and my /bin/sh seems to
> be a symlink to ksh93.  What version of Solaris are you seeing this behavior
> on?

Solaris 10:

Last login: Sun Mar 23 20:53:28 2014 from c80-217-121-12.
Sun Microsystems Inc.   SunOS 5.10      Generic January 2005
You have mail.
500 ceder@bacon> uname -a
SunOS bacon 5.10 Generic_147147-26 sun4u sparc SUNW,Sun-Fire-15000
501 ceder@bacon> /bin/sh
$ echo `id`
uid=105(ceder) gid=20105(ceder)
$ echo $(id)
syntax error: `(' unexpected

/bin/sh is a symlink to /sbin/sh.

On Solaris 10, you are supposed to use /usr/xpg4/bin/sh if you want
a competent standards-compliant shell. /bin/sh is provided as a very
backward-compatible shell.

> Jeff.

    /ceder
> --
> The reasonable man adapts himself to the world; the unreasonable one
> persists in trying to adapt the world to himself. Therefore all progress
> depends on the unreasonable man.
>                 - George Bernard Shaw
