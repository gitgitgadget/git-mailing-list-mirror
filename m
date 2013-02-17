From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [BUG] Git clone of a bundle fails, but works (somewhat) when run with strace
Date: Sun, 17 Feb 2013 18:04:10 -0000
Organization: OPDS
Message-ID: <20C7ED1EA37C4EECA28070D1483C57B7@PhilipOakley>
References: <511E8D84.6060601@gmail.com> <kfmclb$4ro$2@ger.gmane.org><kfmide$4ro$3@ger.gmane.org> <20130216040109.GA31630@sigill.intra.peff.net> <kfqkak$ugv$1@ger.gmane.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>, "Alain Kalker" <a.c.kalker@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 19:04:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U78bf-0000rv-Gc
	for gcvg-git-2@plane.gmane.org; Sun, 17 Feb 2013 19:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599Ab3BQSEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 13:04:30 -0500
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:32092 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751536Ab3BQSEa (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Feb 2013 13:04:30 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgUFAGkbIVFZ8rgm/2dsb2JhbABFhkmFPLQYfRdzghoFAQEFCAEBGRURDQEBLAIDBQIBAxQBAQICAgUhAgIUAQQIEgYHFwYBEggCAQIDAYdvAxMIrEWHWw2JWoEjizaBBHtUCoI1MmEDjgqGR4J4iiaFFYMH
X-IronPort-AV: E=Sophos;i="4.84,682,1355097600"; 
   d="scan'208";a="62987452"
Received: from host-89-242-184-38.as13285.net (HELO PhilipOakley) ([89.242.184.38])
  by out1.ip07ir2.opaltelecom.net with SMTP; 17 Feb 2013 18:04:07 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216401>

From: "Alain Kalker" <a.c.kalker@gmail.com>
Sent: Sunday, February 17, 2013 1:01 PM
> On Fri, 15 Feb 2013 23:01:09 -0500, Jeff King wrote:
>
>> On Sat, Feb 16, 2013 at 12:03:58AM +0000, Alain Kalker wrote:
>>
>>> ---test.sh---
>>> #!/bin/sh
[...]
>>
>> but that warning makes sense. You did not create a bundle that 
>> contains
>> HEAD, therefore when we clone it, we do not know what to point HEAD 
>> to.
>> You probably wanted "git bundle create ../repo.bundle --all" which
>> includes both "master" and "HEAD".
>
> That explains it, thanks! Maybe this could be added as an example to 
> the
> documentation for `git bundle`? People looking at `man git-bundle` 
> hoping
> to use it as one possible way to make a backup of a Git repository 
> might
> not realize right away that --all is the way to specify all refs, like
> with `git log`.

I had posted a documentation patch back in Setemeber last year,
http://thread.gmane.org/gmane.comp.version-control.git/205887/focus=205897,
however Junio highlighted some additional concerns that I wasn't able to 
respond to at the time.

It may be worth resurrecting once the concerns have been addressed.

>
>>
>> It would be slightly more accurate to say "the remote HEAD does not
>> exist", rather than "refers to nonexistent ref".  It would perhaps be
>> nicer still for "git clone" to make a guess about the correct HEAD 
>> when
>> one is not present (especially in the single-branch case, it is easy 
>> to
>> make the right guess).
>>
>> Patches welcome. In the meantime, you can clone with "-b master" to 
>> tell
>> it explicitly, or you can "git checkout master" inside the 
>> newly-cloned
>> repository.
>
> Thanks again for your help, very welcome :-)
>
> Alain
>
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> -----
> No virus found in this message.
> Checked by AVG - www.avg.com
> Version: 2013.0.2899 / Virus Database: 2639/6108 - Release Date: 
> 02/16/13
> 
