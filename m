From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: [PATCH 5/11] git-applypatch: Usage string clean-up, emit usage
 string at incorrect invocation
Date: Thu, 15 Dec 2005 21:30:03 +0100
Message-ID: <43A1D24B.5070603@gmail.com>
References: <11345130302438-git-send-email-freku045@student.liu.se> <11345130311492-git-send-email-freku045@student.liu.se> <7vfyow45l2.fsf@assigned-by-dhcp.cox.net> <20051214144542.0a509e3e.tihirvon@gmail.com> <20051215195528.GA14388@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Timo Hirvonen <tihirvon@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 21:33:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmzkV-0007BH-9Y
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 21:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbVLOUai (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 15:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbVLOUai
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 15:30:38 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:36422 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751011AbVLOUah (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Dec 2005 15:30:37 -0500
Received: by zproxy.gmail.com with SMTP id 34so457356nzf
        for <git@vger.kernel.org>; Thu, 15 Dec 2005 12:30:37 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=orjJhomuNcxDMzBiYNJFXQTDS/xiPOKiRQHKlSDwCDL007CYqT6/QYsOKTnp0BJ4NCzCeDPtp/U0oO9eO4ydEOlPnIPHL769od70nbcO0FOMC7Tws18nXetPX6Mb9opDBPBPlkQABswWLivjSia1vrY2TF4+g1uLgGuznEN6FHQ=
Received: by 10.65.75.3 with SMTP id c3mr750670qbl;
        Thu, 15 Dec 2005 12:30:37 -0800 (PST)
Received: from ?10.0.0.13? ( [151.56.82.23])
        by mx.gmail.com with ESMTP id f14sm188804qba.2005.12.15.12.30.34;
        Thu, 15 Dec 2005 12:30:36 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0.6-7.2.20060mdk (X11/20050322)
X-Accept-Language: it, it-it, en-us, en
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20051215195528.GA14388@c165.ib.student.liu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13710>

Fredrik Kuivinen wrote:
> On Wed, Dec 14, 2005 at 02:45:42PM +0200, Timo Hirvonen wrote:
> 
>>On Tue, 13 Dec 2005 21:20:57 -0800
>>Junio C Hamano <junkio@cox.net> wrote:
>>
>>
>>>freku045@student.liu.se writes:
>>>
>>>
>>>> . git-sh-setup
>>>> 
>>>>+[[ "$#" = "3" || "$#" = "4" ]] || usage
>>>>+
>>>
>>>I do not see much advantage to use [[...]] construct here.
>>
>>[[ ]] is bashishm. Does not work with ash.
>>
>>
>>test $# -ge 3 && test $# -le 4 || usage
>>
>>You don't need to quote $# because it is always defined (and always
>>non-negative integer).  You can't unset or set it.
> 
> 

This patch seems not working for me:

$ git-applymbox -k 0001-JUST-A-TEST.txt
1 patch(es) to process.
Usage: /home/marco/bin/git-applypatch <msg> <patch> <info> [<signoff>]


where

$ cat 0001-JUST-A-TEST.txt
 From nobody Mon Sep 17 00:00:00 2001
Subject: [PATCH] JUST A TEST
From: Marco Costalba <mcostalba@gmail.com>
Date: 1134677832 +0100

---

  git-applypatch.sh |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

ee8ea125fd2b0598e26e1556210abb9d0edc459a
diff --git a/git-applypatch.sh b/git-applypatch.sh
index e8ba34a..26b4cba 100755
--- a/git-applypatch.sh
+++ b/git-applypatch.sh
@@ -10,7 +10,7 @@
  ##     $3 - "info" file with Author, email and subject
  ##     $4 - optional file containing signoff to add
  ##
-
+## JUST A TEST
  USAGE='<msg> <patch> <info> [<signoff>]'
  . git-sh-setup

--
0.99.9.GIT


The offending patch is

Author: Junio C Hamano <junkio@cox.net>
Date:   14/12/2005 03:19:12
Parent: git-repack: Usage string clean-up, emit usage at incorrec...

    applypatch: no need to do non-portable [[ ... ]]


    ... when old, proven, case would do.

    Signed-off-by: Junio C Hamano <junkio@cox.net>

--- a/git-applypatch.sh
+++ b/git-applypatch.sh
@@ -14,7 +14,7 @@
  USAGE='<msg> <patch> <info> [<signoff>]'
  . git-sh-setup

-[[ "$#" = "3" || "$#" = "4" ]] || usage
+case "$#" in 3|4) usage ;; esac

  final=.dotest/final-commit
  ##


reverting the patch everything works fine.

Marco
