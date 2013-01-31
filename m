From: Scott Yan <scottyan19@gmail.com>
Subject: Re: How to identify the users?
Date: Thu, 31 Jan 2013 14:53:03 +0800
Message-ID: <CACkbei+_dJowH-odL+UCS3hQwOwFZ7B5_6sxw=ZZg1V4=upSKg@mail.gmail.com>
References: <CACkbei+Jby13B7rsEb3iLQM2ZSFDgrkgvrYC5M7u4yatppvLxA@mail.gmail.com>
	<1359612481-ner-5936@calvin>
	<510A0ACF.5060501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 07:53:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0o1Y-0002ne-P0
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 07:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264Ab3AaGxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 01:53:06 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:58414 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab3AaGxF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 01:53:05 -0500
Received: by mail-lb0-f171.google.com with SMTP id gg13so2997843lbb.2
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 22:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=DNO0Mn6C+xBWNQl4MRf7AnZQLl6bM1q6OyXcB34uXHA=;
        b=FMf6pMrkJbKPCE0dkN7vpstfaaPm4R87qKiVYkGo5KAfjKWC4zFEEJWGox3Ma4Mo1h
         QvmS3Ufjuv7Tvmvpd9NZrCe8PwAPpRp/Bg6rqyhV/A73eoncaGZnDSpZZ5CausaCNBOV
         xKn/QpTOEkOhkzeYAOfUkmzArldD9p+NGgR5+8vXbHdo1qnI7xE1t2lQTpeYoOY2k4Ev
         6yT6T9YHwPLDZueWFY11ighE+M4iNCKtXUh0MZuuVw0VSX7RrHXu19ZIgY+rjY89U0i5
         sW8Uzkxk/+4LPRMXr1bCqAas7h8G8kcnMkf2HhmnSsz1HFmI06FCqVnDtTaBscvyBENV
         gS7A==
X-Received: by 10.112.82.202 with SMTP id k10mr2993864lby.22.1359615183309;
 Wed, 30 Jan 2013 22:53:03 -0800 (PST)
Received: by 10.112.13.207 with HTTP; Wed, 30 Jan 2013 22:53:03 -0800 (PST)
In-Reply-To: <510A0ACF.5060501@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215101>

Thanks to all.

Tomas:
I can't find reflog setting of git-http-backend
doc(http://www.kernel.org/pub/software/scm/git/docs/git-http-backend.html),
I tried this setting:
git config core.logAllRefUpdates true

and after some test push, the output is as below:
>git log -g master
commit d34e61baa28eabf46ba5e9f6a2feb24cc683ed39
Reflog: master@{0} (Scott Yan <scottyan19@gmail.com>)
Reflog message: push
Author: Scott Yan <scottyan19@gmail.com>
Date:   Thu Jan 31 14:19:30 2013 +0800

this log shows when pushed, but still can't tell Who, because the
author info may be fake.
I don't know if I made some mistake.


Sitaram:

It seems I must host my central repo on Gitolite first...
I don't know Gitolite much, but you are right, maybe I should use
Gitolite as my git server.
I'll find more documents about gitolite these days,
can you give me some suggestion which tutorial should I read?  Thanks!
ps: my OS is windows.

Regards,
Scott Yan

On Thu, Jan 31, 2013 at 2:10 PM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> On 01/31/2013 11:38 AM, Tomas Carnecky wrote:
>> On Thu, 31 Jan 2013 13:52:32 +0800, Scott Yan <scottyan19@gmail.com> wrote:
>>> Hello everyone:
>>>
>>> The user info of git client (user name and email) is set by the users
>>> themselves, so , how to avoid userA pretend to be userB?
>>>
>>> Git server could authentication the user, but it do nothing about the
>>> user info of commit message.
>>>
>>> For example:
>>> There are 20 people of my team, and everyone can push to the public
>>> repository(git server),
>>> If I found some backdoor code in my project, and the commit record
>>> shows it was committed by userA, so I ask userA: why do you do this?
>>> but he told me: no, this is not my code, I have never committed such
>>> thing.  ----and yes, everyone could change his user info to userA very
>>> easily .
>>>
>>> so... what should I do to avoid such situations?
>>
>> gitolite keeps a log of which SSH user pushed which commits. The smart-http
>> backend does the same if you have reflog enabled on the server (see the
>> ENVIRONMENT section in man git-http-backend). So unless someone can steal
>> userA's credentials (http password, ssh key) you'll be able to detect who it
>> really was.
>
> See also my rant on this topic:
>
> https://github.com/sitaramc/gitolite/blob/master/src/VREF/EMAIL-CHECK#L37
