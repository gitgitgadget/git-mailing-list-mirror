From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 3/3] Add support for GIT_ONE_FILESYSTEM
Date: Wed, 31 Mar 2010 02:54:24 +0200
Message-ID: <40aa078e1003301754u3a1e5e9je7bb2aa2dc04f6a1@mail.gmail.com>
References: <1268855753-25840-1-git-send-email-lars@pixar.com>
	 <1268855753-25840-4-git-send-email-lars@pixar.com>
	 <20100328092253.GA17563@coredump.intra.peff.net>
	 <7vr5n44crq.fsf@alter.siamese.dyndns.org>
	 <alpine.LFD.2.00.1003301537150.3707@i5.linux-foundation.org>
	 <20100330230211.GC608@coredump.intra.peff.net>
	 <alpine.LFD.2.00.1003301610151.3707@i5.linux-foundation.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	"Lars R. Damerow" <lars@pixar.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 31 02:54:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwmCX-0006wT-QZ
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 02:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756888Ab0CaAy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 20:54:28 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63733 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756560Ab0CaAy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 20:54:26 -0400
Received: by wyb39 with SMTP id 39so1975275wyb.19
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 17:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:received:message-id:subject:from:to:cc:content-type;
        bh=PUBCN4FTjuG9cjy9Npa5g8evq5wZmo1BpAXNOzdRpG0=;
        b=m+81GYFgUzg5ut2phgJaBaRACyDE4llNd9wILJOv+D4mQP4Cagub+od0yIuah3vYog
         iVulBULjYznZyZzllwJ7te3LlPaqKyxTHOIX4PS946bqmCrnkUGGyhjztoEq1NGaKk2U
         085F0XT8ptZMN1dlA0vqdsqXgoxrlbC/ajaPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=GElCrTkmZEwOqnLOMKFWVnyDBUXOv/btB3Gny/4kUrbKGwUFx9iIloPrH/uNhYkDtB
         VyOjJ6kx68RVnPoT7r0sppp9D3oOepD9rNrMuo67rh/DMKVYzMuy8VEl93771aeRwVmN
         /ghYSH47jPiRgPR0sHkjaWw20a0rVKW3GhZwY=
Received: by 10.216.11.20 with HTTP; Tue, 30 Mar 2010 17:54:24 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003301610151.3707@i5.linux-foundation.org>
Received: by 10.216.87.66 with SMTP id x44mr691537wee.96.1269996864773; Tue, 
	30 Mar 2010 17:54:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143630>

On Wed, Mar 31, 2010 at 1:12 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Tue, 30 Mar 2010, Jeff King wrote:
>>
>> Fashionably late, of course. I agree with your reasoning that it is
>> a more sane default. The only thing that would make me hesitate on it
>> now is that it is a behavior change. I suspect the group we would be
>> breaking is small or even zero, though.
>
> Well, I have to admit that I'm a _tiny_ bit nervous that some odd OS or
> filesystem has special magic st_dev rules so that it changes randomly even
> within a filesystem, but that would be very non-posix (think of the
> confusion it would cause standard UNIX tools like 'find -xdev' etc), so
> it's more a worry of "I have no idea what st_dev means on Windows" than
> anything really solid.
>

st_dev means "Drive number of the disk containing the file (same as
st_rdev)."[1], and mounting file systems as subdirs of other file
systems is rare (but possible) on Windows.

However, in our (f)stat implementation, st_dev means 0 -- but this
might be possible to improve on.

[1]: http://msdn.microsoft.com/en-us/library/14h5k7ff(VS.71).aspx

-- 
Erik "kusma" Faye-Lund
