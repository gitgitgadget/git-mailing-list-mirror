From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Bug: git web--browse doesn't recognise browser on OS X
Date: Fri, 15 Mar 2013 12:19:39 +0100
Message-ID: <CAP8UFD2oR5tnYuw7Nbe-CzGx7fw-OpAFW+reN+1Nroh1jXjfsQ@mail.gmail.com>
References: <CAMxBVSs6dJFnK78E2Da7t4V9ndJFRVDZEd1fR5QuCFz=u2Bnpw@mail.gmail.com>
	<CAMxBVStw-b3J_Fm9x=h3==9ebdLUkpjBSQ9-W4+zJ9N20ojfxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Timo Sand <timo.j.sand@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 15 12:20:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGSgC-00080b-LV
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 12:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127Ab3COLTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Mar 2013 07:19:41 -0400
Received: from mail-vb0-f52.google.com ([209.85.212.52]:49901 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561Ab3COLTk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 07:19:40 -0400
Received: by mail-vb0-f52.google.com with SMTP id fa15so1774317vbb.25
        for <git@vger.kernel.org>; Fri, 15 Mar 2013 04:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=VzZqgUgWQ7qMlKYESNsh0Aaf9391bPvhjDL8zko1X/g=;
        b=iv2jNUKUG82bhoem44ozQ09CNMe0/7kE/iVkRZjigB+kwq+5OqYDnksakTNHEDyino
         xwZzFv+UNN5gIQ42YufewYjcwidqOJ/q9p+JveAtGeIxkqLDUrxVzLphsmtBJo/49S59
         t7z36QreVogUY0IpRvXUYDoeu1DUViZ+74SUMQlmgbSCBN+8tKeWs3rFbN8X9KRW1FFp
         YIgPnBaiQTH9tejsWLDJA2wl0dI7nPH1DXFgXSI6DDy616JrlBFFZZPfbCUDVqBqF9hm
         Wx91pC73w1eXwouGOmOGErCLMYW1iBQPM6Ec70MdhxJxMn4KwAZW7hHzWeP3B5VhgG30
         PGeg==
X-Received: by 10.58.116.244 with SMTP id jz20mr6506363veb.27.1363346380042;
 Fri, 15 Mar 2013 04:19:40 -0700 (PDT)
Received: by 10.58.120.97 with HTTP; Fri, 15 Mar 2013 04:19:39 -0700 (PDT)
In-Reply-To: <CAMxBVStw-b3J_Fm9x=h3==9ebdLUkpjBSQ9-W4+zJ9N20ojfxg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218236>

Hi,

On Thu, Mar 14, 2013 at 12:39 PM, Timo Sand <timo.j.sand@gmail.com> wrote:
> Hi
>
> I tried to open a website by runnin 'git web--browse http://google.com'
> and it replied 'No known browser available'.

First git web--browse is a plumbing shell script to display
documentation on a web browser when you type something like "git help
-w log".
It is not really supposed to be used directly by the user. On OS X it
might be simpler to just type "open http://google.com".

That said there is the following in it to make it work on OS X:

# SECURITYSESSIONID indicates an OS X GUI login session
if test -n "$SECURITYSESSIONID" \
-o "$TERM_PROGRAM" = "Apple_Terminal" ; then
browser_candidates="open $browser_candidates"
fi

So I guess that you don't have SECURITYSESSIONID set in your terminal
and you are not using Apple Terminal.

As I am not using OS X, I have no idea how to improve the script in this case.

> I also tried with '--browser=chrome' and '--browser=google-chrome' but
> the responded with 'The browser chrome is not available as 'chrome'.'

Could you try something like: "chromium http://google.com" or
"chromium-browser http://google.com"
If it works, then using 'git web--browse' with '--browser=chromium' or
'--browser=chromium-browser' should work.

Otherwise did you try "chrome http://google.com" and "google-chrome
http://google.com"?

> I expected the command to open a new tab in my browser in each of the 3 tries.
> This has worked for my system before.
>
> OS X 10.8.2, git 1.8.2, Google Chrome 27.0.1438.7 dev

Thanks,
Christian.
