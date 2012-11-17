From: Aske Olsson <askeolsson@gmail.com>
Subject: Re: [PATCH] Add support for a 'pre-push' hook
Date: Sat, 17 Nov 2012 10:00:01 +0100
Message-ID: <CAJwKrPbP--_zT4=xaYKwD1SbkO+bhT73EbgVzgT0oPA2FBCfTw@mail.gmail.com>
References: <CAJwKrPYwCE4ExmK09PURMfjYezn6vdCH_BBXU4WCwrnotyV9CA@mail.gmail.com>
	<vpq625547ne.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Nov 17 10:00:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZeGB-0007vN-HS
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 10:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999Ab2KQJAD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2012 04:00:03 -0500
Received: from mail-ea0-f174.google.com ([209.85.215.174]:37392 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948Ab2KQJAC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 04:00:02 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so1364544eaa.19
        for <git@vger.kernel.org>; Sat, 17 Nov 2012 01:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fpMI6aXWm4hZrc/zdTxeeOUmJ2ZtUpVh81o33xmrHbs=;
        b=zZGg7GzDiKGpw0etF/T9j6cscHMsTaDzOlM2yJaZs6dR+JMvHuWe+21qxKH9W2D/HR
         JgyQXKvb30QMZrmgFUVRvOKWviXN6EyZls09HCaA6eAdM5D4J8Orzayd8/3WPx6mSx2K
         8/Tc29PUDO4b6GsIGJJkaI1wDPH8S9Y7Qc0bhxKRuUlIewfSaDTfSG7O858A8q54VKXf
         lukAn63F1LRRT+u5hccSbYDMLCt9PMz2kjOjZvPsj5MFJ4XWoF/aB/z5UXL/ZAneR9pl
         ceofzKzGs5r2G4kIUIzcl/ti5TlGzCN8KSFDJYWL9q7VTPScC/ZjP9KS1+RCQNUl4RGO
         04lQ==
Received: by 10.14.215.69 with SMTP id d45mr5424641eep.16.1353142801262; Sat,
 17 Nov 2012 01:00:01 -0800 (PST)
Received: by 10.14.187.131 with HTTP; Sat, 17 Nov 2012 01:00:01 -0800 (PST)
In-Reply-To: <vpq625547ne.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209934>

On Fri, Nov 16, 2012 at 9:25 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Aske Olsson <askeolsson@gmail.com> writes:
>
>> +--no-verify::
>> + This option bypasses the pre-push hook.
>> + See also linkgit:githooks[5].
>> +
>>  -q::
>>  --quiet::
>>   Suppress all output, including the listing of updated refs,
>
> Here, and below: you seem to have whitespace damage. Somebody replaced
> tabs with spaces I guess. Using git send-email helps avoiding this.

I had some firewall problems at work, so ended up sending from gmail.
Will fix ;)

>> +D=`pwd`
>
> Unused variable, left from previous hacking I guess.

Yep!

> I'd add a "touch hook-ran" in the script, a "rm -f hook-ran" before
> launching git-push, and test the file existance after the hook to make
> sure it was ran.

Yea' that would probably be a good idea!

> I don't think you need to re-create the repos for each tests. Tests are
> good, but they're better when they're fast so avoiding useless
> operations is good.
>
> We try to write tests so that one test failure does not imply failures
> of the next tests (i.e. stopping in the middle should not not leave
> garbage that would prevent the next test from running), but do not
> necessarily write 100% self-contained tests.

Ok, I'll speed it up.

>> + echo one >foo && git add foo && git commit -m one &&
>
> test_commit ?

Cool, I'll use that!

> It would be cool to actually check that the push was not performed
> (verify that the target repo is still pointing to the old revision).
> Otherwise, an implementation that would call run_hook after pushing
> would pass the tests.
[...]
>
> These two tests are not testing much. The hook is not executable, so it
> shouldn't be ran, but you do not check whether the hook is ran or not.
> At least make the "exit 0" an "exit 1" in the hook.

All very good points, thanks. I'll get back to hacking.

-Aske
