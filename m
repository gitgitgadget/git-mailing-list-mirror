From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: Peculiar behavior of git 1.5.6
Date: Thu, 4 Sep 2008 10:11:00 +0100
Message-ID: <57518fd10809040211q12d1f0ddk16f2d4273ee7d488@mail.gmail.com>
References: <48BF759B.9090309@lwfinger.net> <48BF97B3.5060309@viscovery.net>
	 <7vljy85mwx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Larry Finger" <Larry.Finger@lwfinger.net>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 11:12:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbAss-0001oa-W9
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 11:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbYIDJLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 05:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144AbYIDJLD
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 05:11:03 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:8175 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbYIDJLB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 05:11:01 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3188370wfd.4
        for <git@vger.kernel.org>; Thu, 04 Sep 2008 02:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=w+ZM1+wfmXa/G7+OJfgrYaCHosHiGo4EJ6FQC36cdek=;
        b=JIDknrCsiyQalBFxPFOjPhqCt8uOrlDxiZkHTfY403z8u2E/QYhAoi6bDLGy5zKdWQ
         ykyAGVNGrEppDVqqGHpjxYKjpD/ZrScrPw9ZmFVk/kR/N6NiHfCVqBr9d7oQojNtdyS7
         SqpaHV+RRysdFKmRbthaTgGYIagOg5DBhex70=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=TAKafEcfTto0xRCM82aAxvk6s6iVgRlyMmoxT10tYyM0HrG/Tw/0Wn/rQP3QWSeJ4Y
         ZWuLNV/Yr1V31duobhK33NzLfrITo6P1fQUGvjTUsi2r0WDwM7MWlAE8xueof4BB1ShJ
         gJ0X5vv1CyfQh0fJTaEkE7YU7pxcyhTSFqApM=
Received: by 10.142.215.5 with SMTP id n5mr3460016wfg.131.1220519460667;
        Thu, 04 Sep 2008 02:11:00 -0700 (PDT)
Received: by 10.142.70.18 with HTTP; Thu, 4 Sep 2008 02:11:00 -0700 (PDT)
In-Reply-To: <7vljy85mwx.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 2554a321099720c7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94910>

On Thu, Sep 4, 2008 at 9:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>
>> Larry Finger schrieb:
>>> On one of my systems, I found strange behavior for git-1.5.6.GIT. On the
>>> first pull of the linux-2.6 tree, I got a message that one file was not
>>> uptodate. When I investigated any possible differences with git-diff,
>>> there were none. A subsequent git-pull worked fine. I lost the console
>>> output for linux-2.6, but the same thing happened for Linville's
>>> wireless-testing, as shown below:
>>>
>>> finger@sonylap:~/wireless-testing> git --version
>>> git version 1.5.6.GIT
>>> finger@sonylap:~/wireless-testing> git pull
>>> error: Entry 'drivers/bluetooth/bt3c_cs.c' not uptodate. Cannot merge.
>>> fatal: merging of trees 294e21019bac11cb782e8d1893d02ce98ed816a4 and
>>> 810d24221c9c532475af90d1b7ba9ca381dc3696 failed
>>> Merge with strategy recursive failed.
>>> finger@sonylap:~/wireless-testing> git diff > tmp
>>> finger@sonylap:~/wireless-testing> cat tmp
>>> finger@sonylap:~/wireless-testing> git pull
>>> Removed Documentation/usb/auerswald.txt
>>> Auto-merged MAINTAINERS
>>> ...
>>>
>>> Is this a bug in git, an incompatibility between my version and that of
>>> the server at kernel.org, or something else?
>>
>> I guess you had touched the timestamp of drivers/bluetooth/bt3c_cs.c in
>> some way without modifying its contents, which made 'git pull' think it is
>> modified.
>>
>> The 'git diff' that you did next corrected this behind your back, so that
>> the subsequent 'git pull' did not see any modification anymore. (BTW, if
>> you had used 'git status' instead of 'git diff' you would have observed
>> the same behavior.)
>
> That still does not explain the symptom --- shouldn't "git pull" or
> underlying "git merge"  have first refreshed the index?
>
> 1.5.6 is before the C rewrite of git-merge, so it is somewhat surprising
> that if there were such bugs, but 1.5.6.GIT does not tell us much...
>

Incidentally - git stash pop/apply has the same problem.  Touching a
file, then applying the stash over the top will tell you "Cannot
restore on top of a dirty state", but will work fine after a "git
status"
