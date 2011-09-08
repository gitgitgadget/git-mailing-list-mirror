From: Georgi Chorbadzhiyski <gf@unixsol.org>
Subject: Re: [PATCH] send-mail: Add option to sleep between sending each email.
Date: Thu, 08 Sep 2011 12:11:20 +0300
Organization: Unix Solutions Ltd. (http://unixsol.org)
Message-ID: <4E6886B8.8080902@unixsol.org>
References: <1315428191-9769-1-git-send-email-gf@unixsol.org> <CALkWK0kH+pD6ymtt9oWLhT0Bftp4EvtrwTtNVw6mjX0aObb-BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 08 11:11:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1adt-0006yt-1D
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 11:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488Ab1IHJLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 05:11:24 -0400
Received: from ns.unixsol.org ([193.110.159.2]:60416 "EHLO ns.unixsol.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932278Ab1IHJLX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 05:11:23 -0400
Received: from [10.0.1.78] ([::ffff:10.0.1.78])
  (AUTH: CRAM-MD5 gf, SSL: TLSv1/SSLv3,256bits,AES256-SHA)
  by ns.unixsol.org with esmtp; Thu, 08 Sep 2011 12:11:21 +0300
  id 00140B8E.4E6886B9.00006A19
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110712 Thunderbird/5.0
In-Reply-To: <CALkWK0kH+pD6ymtt9oWLhT0Bftp4EvtrwTtNVw6mjX0aObb-BQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180955>

Around 09/08/2011 11:43 AM, Ramkumar Ramachandra scribbled:
> Hi Georgi,
> 
> Georgi Chorbadzhiyski writes:
>> Sometimes when sending lots of changes it is not nice
>> to send emails as fast as possible. Of course you can
>> confirm each email after waiting couple of seconds but
>> this is not optimal. This patch adds --sleep option
>> to git-send-mail and corresponding sendmail.sleep config
>> variable to control how much seconds to wait between
>> sending each email. The default is 0 (not wait at all).
> 
> I use git-send-email a lot, and I ask it to print out the list of all
> emails once before confirming.  After confirming, I just switch back
> to Emacs and continue work- in the many instances, I've never actually
> needed to slow the process down.  If anything, I wished it could
> concurrently send many emails and do things /faster/ *.   I'm a little
> curious about why you want to slow it down- is your SMTP server
> configured to block you because it suspects that you're trying to
> spam?
> 
> Thanks.
> 
> * I first need to see if SMTP servers today can take in emails at this
> speed without suspecting spam.

It is not the mail server, it is workaround mainly for web archives and
MUAs that look at received dates when sorting threads.

When they receive a lot of email in one thread very quickly (and out of
order) they do not thread correctly.

See for example this: http://mailman.videolan.org/pipermail/dvblast-devel/2011-August/thread.html
The thread named: [dvblast-devel] [PATCH 0/4] Post git migration changes
See how 1,3,4/4 are not detected to be part of the thread even when
all headers are set correctly by git-send-email.

Probably my mail server send them out of order and that is why I have
the idea to introduce some small delay between sending each email. Easier
on the MTA, works around the possibility to send emails out of order
the flip side is that it takes more time.

-- 
Georgi Chorbadzhiyski
http://georgi.unixsol.org/
