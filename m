From: =?UTF-8?Q?Florian_Sch=C3=BCller?= <florian.schueller@gmail.com>
Subject: Re: [PATCH] Gitk Inotify support
Date: Sat, 11 Jun 2016 16:06:36 +0200
Message-ID: <CAHdOBFpOm3hf4XPjpSZ0+8rVgyKj+e3qT0cecU4j9ms=+chnDg@mail.gmail.com>
References: <CAHdOBFrYWxfSXew5wHwcMym9=s+7cu2E9-MJJe29y+3zV89x7g@mail.gmail.com>
 <CAGZ79kbwrdW=XyPXBNcqBJU1dK8ZvfqyWbgtSt7mvT+m3LQB6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 11 16:07:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBjZ0-0002XR-1D
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jun 2016 16:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbcFKOG6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Jun 2016 10:06:58 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37260 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbcFKOG5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jun 2016 10:06:57 -0400
Received: by mail-wm0-f53.google.com with SMTP id k204so24984916wmk.0
        for <git@vger.kernel.org>; Sat, 11 Jun 2016 07:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KUgaZgPhJ96PFkLXlwAgUN+fdMiYg0xmabz6giyG2Qg=;
        b=jRbzF7PC6f6KLiSLcJxxgpcav/j68qxD0mjR89BbN9CCaN9chpLgE43LElRzx3z5qa
         fFuRfahieIza+qN+a4JmQ3lHlSVc7ZdWwlbbVNBtLK6HXx1eHDPmv0MDkkJlVoDOxKz5
         v9DqaX5rT0MuprR28igQFcnIZWYJOfb6g6QR0YfwS0tWFMvgA89cKBdGHIrwLrekacAL
         jpRbeaXETBqaEg3GLpWxJtcKzHCn+ru/uCMP8PPzLLswAUALbhIPo6CPBdwJZoM24O6+
         pJXJlMl2M0FXANRyvrKRUuXRrbFXGy2hX+Hq0dXPpULIx6DfG8jhNhEX8SNvAUz3g+eH
         hFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KUgaZgPhJ96PFkLXlwAgUN+fdMiYg0xmabz6giyG2Qg=;
        b=hS9wZXajmXTK9VuAyqubnIyj0nhdbYSZT65aMukY0b/qXtZhwfNlzb8agSQ64OrjvW
         04afk0hnmRTvU3HLR0jELmD+qrMP8VVgfzDVV/M7QGCSQLlNcbOk0PcgoHsJgZ36L/zl
         ujSOORSbd15FRmxCR08kIX4l9g7a6qK4DDZv3OTEDGqBqSURgfsQydqgtja6wZigCKZT
         7mlO4wHgys6oE6NVc0AWWe0KdldjZS53SogFmqg1NnFdvon8E2rabW1yPqZLv2ZgaNO4
         sdSOcJCTwibXU0rF7/6nxfAwbaFZox47yU0pYjD7teS0Ei8pM2i6XHk+U+iwYGy74vu0
         zmlw==
X-Gm-Message-State: ALyK8tJu/qPDFzDeOLY6MuTRbAGI64eM5InwzeCihDmfVgqz2htHnnE1VcZHTJs/JdhvQLxLt1Noyuata9YGTw==
X-Received: by 10.194.216.33 with SMTP id on1mr6504890wjc.153.1465654015559;
 Sat, 11 Jun 2016 07:06:55 -0700 (PDT)
Received: by 10.28.182.70 with HTTP; Sat, 11 Jun 2016 07:06:36 -0700 (PDT)
In-Reply-To: <CAGZ79kbwrdW=XyPXBNcqBJU1dK8ZvfqyWbgtSt7mvT+m3LQB6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297097>

=46rom 74d2f4c1ec560b358fb50b8b7fe8282e7e1457b0 Mon Sep 17 00:00:00 200=
1
=46rom: =3D?UTF-8?q?Florian=3D20Sch=3DC3=3DBCller?=3D <florian.schuelle=
r@gmail.com>
Date: Thu, 9 Jun 2016 22:54:43 +0200
Subject: [PATCH] first support for inotify
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Just automatically update gitk when working in a terminal on the same r=
epo

Open points for now:
 - release watches for deleted directories seems to
   cause problems in tcl-inotify (so I don't)
   I'm not sure how often that happens in ".git/"
 - I only call "updatecommits" and I don't know if there is a usecase
   where I should be calling "reloadcommits"

Signed-off-by: Florian Sch=C3=BCller <florian.schueller@gmail.com>
---
 gitk | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/gitk b/gitk
index 805a1c7..58e3dca 100755
--- a/gitk
+++ b/gitk
@@ -8,6 +8,12 @@ exec wish "$0" -- "$@"
 # either version 2, or (at your option) any later version.

 package require Tk
+try {
+    package require inotify
+    set have_inotify true
+} on error {em} {
+    set have_inotify false
+}

 proc hasworktree {} {
     return [expr {[exec git rev-parse --is-bare-repository] =3D=3D "fa=
lse" &&
@@ -12363,6 +12369,53 @@ if {$i >=3D [llength $argv] && $revtreeargs ne=
 {}} {
     }
 }

+proc inotify_handler { fd } {
+    set events [inotify_watch read]
+    set watch_info [inotify_watch info]
+    set update_view false
+
+    foreach {event} $events {
+        set current_watchid [dict get $event watchid]
+        set flags [dict get $event flags]
+        set event_filename [dict get $event filename]
+
+        foreach {path watchid watch_flags} $watch_info {
+            if {$watchid eq $current_watchid} {
+                set watch_path $path
+            }
+        }
+
+        set full_filename [file join $watch_path $event_filename]
+
+        if {$flags eq "nD"} {
+            set wd [inotify_watch add $full_filename "nwds"]
+        }
+        if {![string match *.lock $event_filename]} {
+            set update_view true
+        }
+    }
+
+    #reloadcommits or updatecommits - depending on file and operation?
+    if {$update_view} {
+        updatecommits
+    }
+}
+
+proc watch_recursive { dir } {
+    inotify_watch add $dir "nwaCmMds"
+
+    foreach i [glob -nocomplain -dir $dir *] {
+        if {[file type $i] eq {directory}} {
+            watch_recursive $i
+        }
+    }
+}
+
+if { $have_inotify } {
+    set fd [inotify create "inotify_watch" "::inotify_handler"]
+    watch_recursive $gitdir
+}
+
 set nullid "0000000000000000000000000000000000000000"
 set nullid2 "0000000000000000000000000000000000000001"
 set nullfile "/dev/null"
--=20
2.7.4

On Thu, Jun 9, 2016 at 11:24 PM, Stefan Beller <sbeller@google.com> wro=
te:
> On Thu, Jun 9, 2016 at 2:12 PM, Florian Sch=C3=BCller
> <florian.schueller@gmail.com> wrote:
>> Hi
>> Is this correct to send possible gitk patches here? or should I send
>> them to Paul Mackerras somehow?
>
> I cc'd Paul for you :)
>
>>
>> Anyway I just wanted that gitk automatically updates while I'm worki=
ng
>> in my terminal
>
> Thanks for coming up with a patch. Welcome to the Git community!
>
>>
>> Are you interrested?
>>
>
> Also see the section that talks about signing off the patch and how t=
o
> send the patch
> inline. :)
>
>
>> From 785ed6bc1b4a3b9019d3503b066afb2a025a2bc1 Mon Sep 17 00:00:00 20=
01
>> From: =3D?UTF-8?q?Florian=3D20Sch=3DC3=3DBCller?=3D <florian.schuell=
er@gmail.com>
>> Date: Thu, 9 Jun 2016 22:54:43 +0200
>> Subject: [PATCH] first support for inotify
>
> Here you should describe your change, i.e. what problem is solved in =
this patch,
> what are the alternatives, why is this way the best? Also the sign of=
f
> goes here.
>
>>
> ---
>>  gitk | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++
>>  1 file changed, 59 insertions(+)
>>
> diff --git a/gitk b/gitk
>> index 805a1c7..6e2ead2 100755
>> --- a/gitk
>> +++ b/gitk
>> @@ -8,6 +8,12 @@ exec wish "$0" -- "$@"
>>  # either version 2, or (at your option) any later version.
>>
>>  package require Tk
>> +try {
>> +    package require inotify
>> +    set we_have_inotify true
>> +} on error {em} {
>> +    set we_have_inotify false
>> +}
>
> There are quite a few "have_*" variables, so I would drop the leading=
 "we_"
>
>>
>>  proc hasworktree {} {
>>      return [expr {[exec git rev-parse --is-bare-repository] =3D=3D =
"false" &&
>> @@ -12363,6 +12369,59 @@ if {$i >=3D [llength $argv] && $revtreeargs=
 ne {}} {
>>      }
>>  }
>>
>> +proc inotify_handler { fd } {
>> +    set events [inotify_watch read]
>> +    set watch_info [inotify_watch info]
>> +    set update_view false
>> +
>> +    foreach {event} $events {
>> +        set current_watchid [dict get $event watchid]
>> +        set flags [dict get $event flags]
>> +        set event_filename [dict get $event filename]
>> +
>> +        foreach {path watchid watch_flags} $watch_info {
>> +            if {$watchid eq $current_watchid} {
>> +                set watch_path $path
>> +            }
>> +        }
>> +
>> +        set full_filename [file join $watch_path $event_filename]
>> +
>> +#        remove does not seem to work
>> +#        if {$flags eq "s"} {
>> +#            puts "Remove watch $full_filename"
>> +#            set wd [inotify_watch remove $full_filename]
>> +#        }
>
> Why do we want to carry commented code? I'd drop that.
>
>> +
>> +        if {$flags eq "nD"} {
>> +            set wd [inotify_watch add $full_filename "nwds"]
>> +        }
>> +        if {![string match *.lock $event_filename]} {
>> +            set update_view true
>> +        }
>> +    }
>> +
>> +    #reloadcommits or updatecommits - depending on file and operati=
on?
>> +    if {$update_view} {
>> +        updatecommits
>> +    }
>> +}
>> +
>> +proc watch_recursive { dir } {
>> +    inotify_watch add $dir "nwaCmMds"
>> +
>> +    foreach i [glob -nocomplain -dir $dir *] {
>> +        if {[file type $i] eq {directory}} {
>> +            watch_recursive $i
>> +        }
>> +    }
>> +}
>> +
>> +if { $we_have_inotify } {
>> +    set fd [inotify create "inotify_watch" "::inotify_handler"]
>> +    watch_recursive $gitdir
>> +}
>> +
>>  set nullid "0000000000000000000000000000000000000000"
>>  set nullid2 "0000000000000000000000000000000000000001"
>>  set nullfile "/dev/null"
>> --
>> 2.7.4
>>
>
> Thanks,
> Stefan
