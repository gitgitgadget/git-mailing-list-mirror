From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] Gitk Inotify support
Date: Thu, 9 Jun 2016 14:24:44 -0700
Message-ID: <CAGZ79kbwrdW=XyPXBNcqBJU1dK8ZvfqyWbgtSt7mvT+m3LQB6g@mail.gmail.com>
References: <CAHdOBFrYWxfSXew5wHwcMym9=s+7cu2E9-MJJe29y+3zV89x7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?Q?Florian_Sch=C3=BCller?= <florian.schueller@gmail.com>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 23:27:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB7Rb-0000wQ-Ip
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 23:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705AbcFIVYr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2016 17:24:47 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:36517 "EHLO
	mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701AbcFIVYq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2016 17:24:46 -0400
Received: by mail-qt0-f171.google.com with SMTP id 37so13964047qtc.3
        for <git@vger.kernel.org>; Thu, 09 Jun 2016 14:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=29fFMZ8ZbI+4SM1I8DtcP81kK8di/YULdN3+NrWNnVs=;
        b=mEr5bQejEva4yEv9fB5DP2C0LtulqL0Svfl4ncy9GWoiBFH2QsEPbb3rUb4qWY3XdM
         tutzEhsMMV9Nz5SfuHuJLf4vJNUhl4/tVmiX8aZG3+fqimAXev2BPdwTS8AwKbJwcTjv
         Nt0OnEmSSkTyhegR4yYmwm3vFRGDOEzVmvYE3tUPQA0BxiuelTBSNuLrmR7kvsg9mluK
         at3T7NVGliqecm1JKkCuntGlHK8ph7sEVfZl8PN4UCqS8P2vK0Hy2XlaObM2KRb9UU3z
         SU+DnBoPZYio8kpglStcRk45OOiwRc+U6WNKV+FRRoA6vwsfA5g5Dprh+xnZ28hp6W6A
         kyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=29fFMZ8ZbI+4SM1I8DtcP81kK8di/YULdN3+NrWNnVs=;
        b=jyVcF+rUuotdj8hvOhdGcrDDy0dzP0Yg62leqEwqD3i5jjDlI0h+nfyEpXolR5mjF4
         8mOoPevadWIQoHWN6lWACO9SR0hPWY4u4abNEwyw2duO4xLMx1bcZLix2ytQ+E3mzCqp
         cu7DFBjxdHNrW4NA44MPrGQ+GGCPxpblDn5WNhxGT7WWQOvCKxEbIBsMvqvZ8e9pwRRW
         s5HnOJATo/E7PhfHmjiSweZsx0AcXSn7PStuJ+aeAvvwnTBYMwoekRnJbs/iXMlumqwE
         tusNLDh8sRJLm3vi98/yPSjsnYQDf3bbfuoLvqW9doAQnN6nw5xBnBFAwNX+I7aA5Bzj
         GAsw==
X-Gm-Message-State: ALyK8tLSOxdZ/ohskstHG4ISOAR/bUB/tElI6jD8GHPaCusy5JYRsFUxaqp+rKjif8F3tcekVe66KWuc7qQiKZO/
X-Received: by 10.237.41.5 with SMTP id s5mr12268156qtd.71.1465507484855; Thu,
 09 Jun 2016 14:24:44 -0700 (PDT)
Received: by 10.237.42.226 with HTTP; Thu, 9 Jun 2016 14:24:44 -0700 (PDT)
In-Reply-To: <CAHdOBFrYWxfSXew5wHwcMym9=s+7cu2E9-MJJe29y+3zV89x7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296929>

On Thu, Jun 9, 2016 at 2:12 PM, Florian Sch=C3=BCller
<florian.schueller@gmail.com> wrote:
> Hi
> Is this correct to send possible gitk patches here? or should I send
> them to Paul Mackerras somehow?

I cc'd Paul for you :)

>
> Anyway I just wanted that gitk automatically updates while I'm workin=
g
> in my terminal

Thanks for coming up with a patch. Welcome to the Git community!

>
> Are you interrested?
>

Also see the section that talks about signing off the patch and how to
send the patch
inline. :)


> From 785ed6bc1b4a3b9019d3503b066afb2a025a2bc1 Mon Sep 17 00:00:00 200=
1
> From: =3D?UTF-8?q?Florian=3D20Sch=3DC3=3DBCller?=3D <florian.schuelle=
r@gmail.com>
> Date: Thu, 9 Jun 2016 22:54:43 +0200
> Subject: [PATCH] first support for inotify

Here you should describe your change, i.e. what problem is solved in th=
is patch,
what are the alternatives, why is this way the best? Also the sign off
goes here.

>
---
>  gitk | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+
>  1 file changed, 59 insertions(+)
>
diff --git a/gitk b/gitk
> index 805a1c7..6e2ead2 100755
> --- a/gitk
> +++ b/gitk
> @@ -8,6 +8,12 @@ exec wish "$0" -- "$@"
>  # either version 2, or (at your option) any later version.
>
>  package require Tk
> +try {
> +    package require inotify
> +    set we_have_inotify true
> +} on error {em} {
> +    set we_have_inotify false
> +}

There are quite a few "have_*" variables, so I would drop the leading "=
we_"

>
>  proc hasworktree {} {
>      return [expr {[exec git rev-parse --is-bare-repository] =3D=3D "=
false" &&
> @@ -12363,6 +12369,59 @@ if {$i >=3D [llength $argv] && $revtreeargs =
ne {}} {
>      }
>  }
>
> +proc inotify_handler { fd } {
> +    set events [inotify_watch read]
> +    set watch_info [inotify_watch info]
> +    set update_view false
> +
> +    foreach {event} $events {
> +        set current_watchid [dict get $event watchid]
> +        set flags [dict get $event flags]
> +        set event_filename [dict get $event filename]
> +
> +        foreach {path watchid watch_flags} $watch_info {
> +            if {$watchid eq $current_watchid} {
> +                set watch_path $path
> +            }
> +        }
> +
> +        set full_filename [file join $watch_path $event_filename]
> +
> +#        remove does not seem to work
> +#        if {$flags eq "s"} {
> +#            puts "Remove watch $full_filename"
> +#            set wd [inotify_watch remove $full_filename]
> +#        }

Why do we want to carry commented code? I'd drop that.

> +
> +        if {$flags eq "nD"} {
> +            set wd [inotify_watch add $full_filename "nwds"]
> +        }
> +        if {![string match *.lock $event_filename]} {
> +            set update_view true
> +        }
> +    }
> +
> +    #reloadcommits or updatecommits - depending on file and operatio=
n?
> +    if {$update_view} {
> +        updatecommits
> +    }
> +}
> +
> +proc watch_recursive { dir } {
> +    inotify_watch add $dir "nwaCmMds"
> +
> +    foreach i [glob -nocomplain -dir $dir *] {
> +        if {[file type $i] eq {directory}} {
> +            watch_recursive $i
> +        }
> +    }
> +}
> +
> +if { $we_have_inotify } {
> +    set fd [inotify create "inotify_watch" "::inotify_handler"]
> +    watch_recursive $gitdir
> +}
> +
>  set nullid "0000000000000000000000000000000000000000"
>  set nullid2 "0000000000000000000000000000000000000001"
>  set nullfile "/dev/null"
> --
> 2.7.4
>

Thanks,
Stefan
