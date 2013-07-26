From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [PATCH] send-email: squelch warning from Net::SMTP::SSL
Date: Fri, 26 Jul 2013 10:29:40 +0100
Message-ID: <kstfht$p0e$1@ger.gmane.org>
References: <1373019511-13232-1-git-send-email-artagnon@gmail.com> <20130705104557.GL9161@serenity.lan> <CALkWK0nWvmuxfZJF_Mk2MmJNxz4+=46m_pBtzjSZprLxABhNeA@mail.gmail.com> <vpqbo6hw8e9.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 26 11:55:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2ejv-000660-N1
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 11:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757776Ab3GZJzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 05:55:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:34402 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756079Ab3GZJzG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 05:55:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1V2ejn-0005yW-RR
	for git@vger.kernel.org; Fri, 26 Jul 2013 11:55:03 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Jul 2013 11:55:03 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Jul 2013 11:55:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: brent.tribalogic.net
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
In-Reply-To: <vpqbo6hw8e9.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231177>

'Twas brillig, and Matthieu Moy at 05/07/13 12:31 did gyre and gimble:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
> 
>> John Keeping wrote:
>>> I don't think this is really "fix", it's more plastering over the
>>> problem.
>>
>> It defaulted to SSL_VERIFY_NONE before Net::SMTP::SSL was updated, and
>> the behavior hasn't changed now.  The new version simply asks us to be
>> explicit about SSL_VERIFY_NONE, so we are aware about it.
> 
> "We" as "the Git developers", yes. But your change makes sure users are
> _not_ aware about it. There's a long history of software ignoring SSL
> certificates by default, I don't think we should cast in stone that we
> don't want SSL certificate verification.

For what it's worth, after upgrading here, I got this error at the
server side:

Jul 26 10:15:41 foo.example.com postfix/smtpd[7736]: warning: TLS
library problem: 7736:error:14094418:SSL routines:SSL3_READ_BYTES:tlsv1
alert unknown ca:s3_pkt.c:1256:SSL alert number 48:


This is because my postfix doesn't have a ca bundle configured but all
other mail clients have been fine before.

With the original patch here I could continue.

I'd really love to see an option to set this to none in the .gitconfig,
but agree with the principle that it should be one by default and the
setting should over ride that.

All the best

Col

PS I'm mainly posting this such that people searching the intertubes for
the postfix error above and git-send-email will match at least this
message and find the fix/workaround :)

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited http://www.tribalogic.net/
Open Source:
  Mageia Contributor http://www.mageia.org/
  PulseAudio Hacker http://www.pulseaudio.org/
  Trac Hacker http://trac.edgewall.org/
