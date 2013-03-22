From: Timo Sand <timo.j.sand@gmail.com>
Subject: Re: Bug: git web--browse doesn't recognise browser on OS X
Date: Fri, 22 Mar 2013 16:19:05 +0000
Message-ID: <CAMxBVStVXZGGrjHzN7kukVP6_ZGo0miyJaE2FVYPVV4Jb5U82w@mail.gmail.com>
References: <CAMxBVSs6dJFnK78E2Da7t4V9ndJFRVDZEd1fR5QuCFz=u2Bnpw@mail.gmail.com>
 <CAMxBVStw-b3J_Fm9x=h3==9ebdLUkpjBSQ9-W4+zJ9N20ojfxg@mail.gmail.com> <CAP8UFD2oR5tnYuw7Nbe-CzGx7fw-OpAFW+reN+1Nroh1jXjfsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 17:19:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ4h7-0002qI-I1
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 17:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933756Ab3CVQT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 12:19:26 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:36941 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933641Ab3CVQT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 12:19:26 -0400
Received: by mail-qc0-f181.google.com with SMTP id a22so1984298qcs.12
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 09:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=5N70fLBwf4gniPzNm9Q8dWYK5oeCiKBZInSdcd02M4w=;
        b=DK+TsbSMCdjEnVvq5oT4/tcwI3pfFHvcseBcf8BkBY7OR07DEvcQyb1RjB4ItkZZ6j
         85t460t/h1ya8DfJNTwoTejf7byZFVw6dG93wxtjDSmGgJN4IAcgQ9IJGVwxGx/4R02H
         XHPmz84RJcG2Ltnc6RLeoNKkrU8xeNEOpBF1y2hCN9iJMMH9mq/OfNc6m6uDJfY5+GMV
         IsDG6VWdY4FZtUs7njBYVn9xnsKCzcVXJNBsRwVNbd73GOkgXmnbOklo8AdmaCT1JqWC
         MM0dDxoyR1e8ZG1RblDj+ojGb6EsB0GOWxtc0ZtgEYpP4dDEMFN2Q7NdQ7JvZcaIrmeg
         +lTg==
X-Received: by 10.224.149.69 with SMTP id s5mr444035qav.56.1363969165415; Fri,
 22 Mar 2013 09:19:25 -0700 (PDT)
Received: by 10.49.116.68 with HTTP; Fri, 22 Mar 2013 09:19:05 -0700 (PDT)
In-Reply-To: <CAP8UFD2oR5tnYuw7Nbe-CzGx7fw-OpAFW+reN+1Nroh1jXjfsQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218817>

Hi,

well my use case is actually that I'm trying to use the gem
'gem-browse' which uses 'git web--browse'
I'm not using Apple Terminal, I'm using iTerm2 and there doesn't seem
to be a SECURITYSESSIONID set, at least echo didn't find any. But
neither did I find it on Apple Terminal either.

What troubles me is that this issue has only arisen recently, earlier
this worked fine for me

On 15 March 2013 11:19, Christian Couder <christian.couder@gmail.com> wrote:
> Hi,
>
> On Thu, Mar 14, 2013 at 12:39 PM, Timo Sand <timo.j.sand@gmail.com> wrote:
>> Hi
>>
>> I tried to open a website by runnin 'git web--browse http://google.com'
>> and it replied 'No known browser available'.
>
> First git web--browse is a plumbing shell script to display
> documentation on a web browser when you type something like "git help
> -w log".
> It is not really supposed to be used directly by the user. On OS X it
> might be simpler to just type "open http://google.com".
>
> That said there is the following in it to make it work on OS X:
>
> # SECURITYSESSIONID indicates an OS X GUI login session
> if test -n "$SECURITYSESSIONID" \
> -o "$TERM_PROGRAM" = "Apple_Terminal" ; then
> browser_candidates="open $browser_candidates"
> fi
>
> So I guess that you don't have SECURITYSESSIONID set in your terminal
> and you are not using Apple Terminal.
>
> As I am not using OS X, I have no idea how to improve the script in this case.
>
>> I also tried with '--browser=chrome' and '--browser=google-chrome' but
>> the responded with 'The browser chrome is not available as 'chrome'.'
>
> Could you try something like: "chromium http://google.com" or
> "chromium-browser http://google.com"
> If it works, then using 'git web--browse' with '--browser=chromium' or
> '--browser=chromium-browser' should work.
>
> Otherwise did you try "chrome http://google.com" and "google-chrome
> http://google.com"?
>
>> I expected the command to open a new tab in my browser in each of the 3 tries.
>> This has worked for my system before.
>>
>> OS X 10.8.2, git 1.8.2, Google Chrome 27.0.1438.7 dev
>
> Thanks,
> Christian.



-- 
Timo Sand
timo.j.sand+sig@gmail.com
