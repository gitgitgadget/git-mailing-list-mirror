From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] git-svn: forward -q to git-rebase
Date: Tue, 12 Jun 2012 22:39:06 +0200
Message-ID: <CABPQNSZN7zzF4rki38x3PHXT2DZhOjUtUVGNx2mY-wnQtCj-pA@mail.gmail.com>
References: <1339515815-10752-1-git-send-email-kusmabite@gmail.com>
 <7vd354jwss.fsf@alter.siamese.dyndns.org> <CABPQNSYxq1cSYKi+fGajoASL6x7e6VCaSDoWNmYuEHSgt8NFBA@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, normalperson@yhbt.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 22:39:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeXsU-0008LZ-R2
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 22:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880Ab2FLUjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 16:39:48 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40755 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182Ab2FLUjr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 16:39:47 -0400
Received: by pbbrp8 with SMTP id rp8so1309476pbb.19
        for <git@vger.kernel.org>; Tue, 12 Jun 2012 13:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=dtcsKXZPg4fcaspb/ifXJBv5ouEP3cBdLk4TWaEEYdY=;
        b=gSMYTm4SLA9/op47MwLz/Vg5nq4KYtYY2FklvzYX8acMhPVKpKYyy5enmsR1FJWLCT
         yWVrlj8SdM+16YefkYbdEYY926xcBJ/L98xd2nQCmu8/Ad+SJJKR2uR29OOlfW86JqgC
         s8VBqpOWhJkz9FaY2UajbD8Ny1CpKMCqmYrRN7rxi7pvyhP82seXe5q4wwpBImv/+n5D
         dgDlNhvJgAHWMR/fWHf42IY/K0nPFvIMrUGICVu9m1DHINqdp5Kx9wguPcaHambB7FuV
         EmmxhKKq8RVmhExsrBzTStDWrwRs20VumcRKrMfoUHnpNjh1N+X39Q3UXNoK/NhDddU4
         83Cw==
Received: by 10.68.226.97 with SMTP id rr1mr3103644pbc.64.1339533586360; Tue,
 12 Jun 2012 13:39:46 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Tue, 12 Jun 2012 13:39:06 -0700 (PDT)
In-Reply-To: <CABPQNSYxq1cSYKi+fGajoASL6x7e6VCaSDoWNmYuEHSgt8NFBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199851>

On Tue, Jun 12, 2012 at 10:23 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Tue, Jun 12, 2012 at 6:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>>
>>> When calling "git svn rebase -q", we still get the message
>>> "Current branch BRANCHNAME is up to date." from git-rebase, which
>>> isn't quite as quiet as we could be.
>>>
>>> Fix this by forwarding the -q flag to git-rebase.
>>>
>>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>>> ---
>>>
>>> I just set up a cronjob that did a "git svn rebase -q", and noticed
>>> it triggered cron to send me an e-mail every time.
>>>
>>> Since I'm not really interested in getting an e-mail every time the
>>> script does nothing, but I'd like the option to get an e-mail whenever
>>> it does something useful, perhaps something like this can benefit
>>> other people as well?
>>
>> If it matches what you would get from "git pull -q" run in a
>> cronjob, I would say that is a sensible change to make.
>
> Seems like it to me in my tests, yeah.

Hm, but not the same as "git pull --rebase -q", as git-pull.sh doesn't
forward $verbosity to "git rebase" either. It DOES pass it to "git
merge", though... Which puzzles me a bit.
