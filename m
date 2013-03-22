From: John Szakmeister <john@szakmeister.net>
Subject: Re: Bug: git web--browse doesn't recognise browser on OS X
Date: Fri, 22 Mar 2013 13:36:04 -0400
Message-ID: <CAEBDL5VNodcTGBOvQjyL30qiXhshxhnUH-Vd9xy9=RxZQgH-Yw@mail.gmail.com>
References: <CAMxBVSs6dJFnK78E2Da7t4V9ndJFRVDZEd1fR5QuCFz=u2Bnpw@mail.gmail.com>
	<CAMxBVStw-b3J_Fm9x=h3==9ebdLUkpjBSQ9-W4+zJ9N20ojfxg@mail.gmail.com>
	<CAP8UFD2oR5tnYuw7Nbe-CzGx7fw-OpAFW+reN+1Nroh1jXjfsQ@mail.gmail.com>
	<CAMxBVStVXZGGrjHzN7kukVP6_ZGo0miyJaE2FVYPVV4Jb5U82w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>
To: Timo Sand <timo.j.sand@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 18:36:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ5tM-0005Br-Av
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 18:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161118Ab3CVRgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 13:36:08 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:64293 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161069Ab3CVRgH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 13:36:07 -0400
Received: by mail-wg0-f53.google.com with SMTP id eg6so3476431wgb.32
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 10:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=f/nomRSv4vEAqarSDDCC6fF7woK1vtaqKSdv8zGv6cM=;
        b=ItoRBSdfii/saLXqWaFgrDa6jhQBYTZNayilp8n2vDIfUlq/NZ9HLNIoj0rHauXI8O
         DydVMIGK6NBQpzvQCImGi5jxhEfFdX0Hvu9+mBEA120tZokwYbiuCcLY3nGB2s1Dm4i/
         09kT3p2k12AVl0w5LWmyLR0fP/xz5yCHwSgOCWj26Rx2JXSckFkki4CG8vHLv3SnuEke
         en/eVilpizYyTsvNBIk7EsLlAhKqkj6AJN2imqtjMCgHXKyaVy6Q+3DXHNqNU2Od9teO
         kNwHAKN6NQCA67g6H37vWx1/ImOGJk8ni9FM/hLLVw4hn1FFhoCixbqCF4SR1D6i/KjF
         FOfA==
X-Received: by 10.194.92.231 with SMTP id cp7mr4738029wjb.19.1363973764925;
 Fri, 22 Mar 2013 10:36:04 -0700 (PDT)
Received: by 10.180.82.8 with HTTP; Fri, 22 Mar 2013 10:36:04 -0700 (PDT)
In-Reply-To: <CAMxBVStVXZGGrjHzN7kukVP6_ZGo0miyJaE2FVYPVV4Jb5U82w@mail.gmail.com>
X-Google-Sender-Auth: POOvNnHXJaBLtFgQrZFwhneLeWE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218825>

On Fri, Mar 22, 2013 at 12:19 PM, Timo Sand <timo.j.sand@gmail.com> wrote:
> Hi,
>
> well my use case is actually that I'm trying to use the gem
> 'gem-browse' which uses 'git web--browse'
> I'm not using Apple Terminal, I'm using iTerm2 and there doesn't seem
> to be a SECURITYSESSIONID set, at least echo didn't find any. But
> neither did I find it on Apple Terminal either.

I noticed this the other day, but I think SECURITYSESSIONID only gets
set when Screen Sharing is enabled.  I had Screen Sharing enabled,
launched iTerm2 and saw the variable.  I closed iTerm2, turned off
Screen Sharing, and relaunched iTerm2 to find the variable missing.
As a result, I'm not SECURITYSESSIONID is a good mechanism for
determining whether the terminal is associated a GUI or not.
Unfortunately, I don't know of a better way.

> What troubles me is that this issue has only arisen recently, earlier
> this worked fine for me

The following patch fixes the issue by recognizing iTerm2 as a GUI terminal.

-John

>From 5d282325f9374b25609a8704661c252304b4d18a Mon Sep 17 00:00:00 2001
Date: Fri, 22 Mar 2013 13:23:07 -0400
Subject: [PATCH] git-web--browse: recognize iTerm as a GUI terminal on OS X

Signed-off-by: John Szakmeister <john@szakmeister.net>
---
 git-web--browse.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-web--browse.sh b/git-web--browse.sh
index 1e82726..1ff5379 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -120,6 +120,7 @@ if test -z "$browser" ; then
 	fi
 	# SECURITYSESSIONID indicates an OS X GUI login session
 	if test -n "$SECURITYSESSIONID" \
+		-o "$TERM_PROGRAM" = "iTerm.app" \
 		-o "$TERM_PROGRAM" = "Apple_Terminal" ; then
 		browser_candidates="open $browser_candidates"
 	fi
-- 
1.8.1.1
