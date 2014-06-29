From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Trouble merging renamed but identical files - CONFLICT (rename/rename)
Date: Sun, 29 Jun 2014 16:09:19 -0400
Message-ID: <CABURp0qZVMGMQ8X4P0P1OGF9gNqu__=Uk+Lr7GyBbscm5wL1=w@mail.gmail.com>
References: <CABURp0rFCxxpiQhRYXmN5eBnKhyyOeuFSTj0V1tGZJSNea5iEA@mail.gmail.com>
 <66A60DA77398CD439FA676CEF593977D52477A@exchange.1.internal.pdinc.us>
 <CEAC9BE9F83B4CD0AFD73BBAC8A54232@black> <CABURp0okCDbwLOL3Osj2WtfQ_Qj3v=1FrAV28gJjPy1yzQU7Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Jason Pyeron <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Sun Jun 29 22:09:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1LQ5-0004a5-S3
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 22:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442AbaF2UJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2014 16:09:41 -0400
Received: from mail-vc0-f182.google.com ([209.85.220.182]:64376 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033AbaF2UJk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2014 16:09:40 -0400
Received: by mail-vc0-f182.google.com with SMTP id il7so6690595vcb.41
        for <git@vger.kernel.org>; Sun, 29 Jun 2014 13:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+eVvfOTCsmO9hoOBaL//B1a+uzqbapt+2I/WI8LdYRY=;
        b=As+KyXSYqdRfYlb1clKQFExFe8shV82DO68o1TIrPhhgRi+fUW/ODX6vbl82nMwPn9
         VIlQ9IONtZUkvzh4+PWjf6w/7bzFq6FYTPcTC6HTqroAu0WpAQTz6gaE3qr/WKX6adV8
         UUPz2Y+vmBjG4pkzOsqHSv+l2RLrPoWg6dRGG/mor2IpoI6kUhmO3hA64ecxw2vySo/w
         Bk+9B9Vso+yxOMuMoxqaHKNsz3MW/nD6kEqvQvDHrLJUtXC6PRsm0NtNo5p27iDBKLjG
         OiQpiUNRuwIqxIziUjhMFrRBSo5Qk6flJ7Z5NJvfwgh0EYA7U+Q2lDhX4vgL4s8mhzit
         7NBQ==
X-Received: by 10.221.27.8 with SMTP id ro8mr34078689vcb.30.1404072579531;
 Sun, 29 Jun 2014 13:09:39 -0700 (PDT)
Received: by 10.58.67.168 with HTTP; Sun, 29 Jun 2014 13:09:19 -0700 (PDT)
In-Reply-To: <CABURp0okCDbwLOL3Osj2WtfQ_Qj3v=1FrAV28gJjPy1yzQU7Vg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252645>

On Sun, Jun 29, 2014 at 11:31 AM, Phil Hord <phil.hord@gmail.com> wrote:
> On Fri, Jun 27, 2014 at 8:42 PM, Jason Pyeron <jpyeron@pdinc.us> wrote:
>> Sorry for the http://pastebin.com/1R68v6jt (changes the merge to
>> 1ca13ed2271d60ba93d40bcc8db17ced8545f172, and manually reconciles the merge),
>> but it was too long to be readable in the email.

Ok, I think I understand the issue you are trying to solve now.

Git (rather famously[1]) does not record renames or copies.  It is
expected instead that renames and copies will be detected when it is
important after the fact. This allows us to ignore rename detection
and resolution when creating project history; in the future, better
rename/copy detection will "just work" on existing repositories and
the repos themselves will not need to be adjusted.

What you are encountering now seems to be a shortcoming of Git's
current rename/copy detection.  But you are trying to overcome today's
shortcoming by adjusting your project history to accommodate it.
Instead you should just do the merge like you normally would without
regard to how 'git blame' shows the result.

Maybe there is a bug here still, but it is probably in git-blame.

[1] https://git.wiki.kernel.org/index.php/GitFaq#Why_does_Git_not_.22track.22_renames.3F
