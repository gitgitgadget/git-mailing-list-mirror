From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: [PATCH v3 0/5] push: update remote tags only with force
Date: Thu, 15 Nov 2012 08:48:52 +0100
Message-ID: <CAB9Jk9DK9AWBe_cf6=-v0pyD9xdhSoYPsKmRnUOwjuAm=hewfA@mail.gmail.com>
References: <1352693288-7396-1-git-send-email-chris@rorvick.com>
	<7v4nktdwtp.fsf@alter.siamese.dyndns.org>
	<CAEUsAPYvrR6WsVWCvwoEWA21gzL6Sib0sTyx-c_2tH=8ni69yQ@mail.gmail.com>
	<CAEUsAPZtF-L5J_g1L5d44BKveoAnJ81PatX94fFS4FM=iW33KA@mail.gmail.com>
	<7v390ccoak.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9DAwaLw2bTqj5x_zxRcFqn7s=nmGi=Jc_SD38vFoszBZg@mail.gmail.com>
	<7vmwykay4n.fsf@alter.siamese.dyndns.org>
	<7v8va3afrt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Chris Rorvick <chris@rorvick.com>, git <git@vger.kernel.org>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 08:49:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYuCB-0002MN-6F
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 08:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423584Ab2KOHsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 02:48:54 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33111 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423581Ab2KOHsx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 02:48:53 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so973298pbc.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 23:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5FpnGZw8pSMDoqQNrAoeHCsHHESE2OuNXP8CxCCPWqE=;
        b=LYrQXj+mGLWGLu1hMdi46+T8tq872dci0mg5dIOhJgmcvc242vbqZS8THvVga7itjy
         57MVfiBMrOwncOtt2nIouFBYkYK2TB306Bk+30YOTlm3Olz6nqKK9IlryMri6Uuzd48S
         DaE5kmx0axKLfbIjzvqpo/ifDXtv0DmgbZ2qI/WQ5Ioqs/D/co9UbNCm8HZ2QIq/u5hL
         4vqT785A00Fk55IYKt8da5XIISByFu5vtcsj0pSqd1xDjQkQ7NS3u757rHO7E87j9k1C
         CtYpkCvEuQ59MK77NYxQBcx2Nr+ieSEK+5OHIoTLzKjmluiDZG+/LPJMCzOSo97dCD82
         mldw==
Received: by 10.66.76.98 with SMTP id j2mr771041paw.65.1352965732669; Wed, 14
 Nov 2012 23:48:52 -0800 (PST)
Received: by 10.67.3.101 with HTTP; Wed, 14 Nov 2012 23:48:52 -0800 (PST)
In-Reply-To: <7v8va3afrt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209802>

Hi Junio,

> I am *not* convinced that the "refs/tags/ is the only special
> hierarchy whose contents should not move" is a bad limitation we
> should avoid, but if it indeed is a bad limitation, the above is one
> possible way to think about avoiding it.

What other hierarchy besides branches and tags is there? Do you have
in mind some other that should not move?

-Angelo

On 15 November 2012 01:09, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> Addendum.
>
>> In any case, I thought this series was about users who run "push"
>> voluntarily stopping themselves from pushing updates to tags that
>> may happen to fast-forward, so if we were to go with the
>> configuration route, the suggestion would be more like
>>
>>     [push]
>>       updateNeedsForce = refs/tags/:refs/frotz/
>>
>> or perhaps
>>
>>     [remote "origin"]
>>       updateNeedsForce = refs/tags/:refs/frotz/
>>
>> if we want to configure it per-remote, to specify that you would
>> need to say "--force" to update the refs in the listed hierarchies.
>>
>> Then your patch series could become just the matter of declaring
>> that the value of push.updateNeedsForce, when unspecified, defaults
>> to "refs/tags/".
>
> The above is not a "you should do it this way" suggestion, by the
> way.
>
> I was just explaining what I meant by "it may be a good feature, but
> may not necessarily be limited to refs/tags" in my earlier message
> in a different way "... and a possible design that lifts the
> limitation may go like this".
>
> I am *not* convinced that the "refs/tags/ is the only special
> hierarchy whose contents should not move" is a bad limitation we
> should avoid, but if it indeed is a bad limitation, the above is one
> possible way to think about avoiding it.
>
> Thanks.
