From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: [PATCH] Receive-pack: include entire SHA1 in nonce
Date: Thu, 25 Sep 2014 14:03:32 -0400
Message-ID: <84433534-D6A9-4FD3-BA53-DCD610B64251@gernhardtsoftware.com>
References: <1411657340-62950-1-git-send-email-brian@gernhardtsoftware.com> <xmqqk34rbqu0.fsf@gitster.dls.corp.google.com> <xmqqa95nbn7g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 20:03:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXDOG-0002Dw-Jg
	for gcvg-git-2@plane.gmane.org; Thu, 25 Sep 2014 20:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbaIYSDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2014 14:03:36 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:50017 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbaIYSDf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Sep 2014 14:03:35 -0400
Received: from [10.10.10.10] (cpe-142-105-190-134.rochester.res.rr.com [142.105.190.134])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 02C731621F2C;
	Thu, 25 Sep 2014 18:03:33 +0000 (UTC)
In-Reply-To: <xmqqa95nbn7g.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257487>

On Sep 25, 2014, at 1:54 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
>> I am not happy with this version, either, though, because now we
>> have an uninitialized piece of memory at the end of sha1[20] of the
>> caller, which is given to sha1_to_hex() to produce garbage.  It is
>> discarded by %.*s format so there is no negative net effect, but I
>> suspect that the compiler would not see that through.
> 
> ... and if we want to fix that, we would end up with a set of
> changes, somewhat ugly like this.
> 
> Which might be an improvement, but let's start with your "sizeof(arg)
> is the size of a pointer, even when the definition of arg[] is
> spelled with bra-ket, a dummy maintainer!" fix.
> 
> I'd like to have your sign-off.  I'd also prefer to retitle it as
> something like "hmac_sha1: copy the entire SHA-1 hash out", as it is
> deliberate that we do not include the entire SHA-1 in nonce.

It's been long enough since I've done any crypto, so I didn't really know what the algorithm should look like.  Mostly I remember "doing it right is hard", so don't feel too bad.  Making the commit message accurate is perfectly fine, and all the patches you've posted look right at first glance (and to make test as well), so I'm fine with a 

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>

attached to whatever commit is actually appropriate instead of the minimum to make my compiler happy.  :-)

~~ Brian
