From: Michel Lespinasse <walken@google.com>
Subject: Re: [PATCH 3/3] builtin/checkout: DWIM with -f -b
Date: Sun, 20 Jun 2010 21:09:35 -0700
Message-ID: <AANLkTikvTtmz_uai5SNO0Co8PWLgK7rIdl7cCqHosViY@mail.gmail.com>
References: <1277051592-4552-1-git-send-email-rctay89@gmail.com>
	<1277051592-4552-2-git-send-email-rctay89@gmail.com>
	<1277051592-4552-3-git-send-email-rctay89@gmail.com>
	<1277051592-4552-4-git-send-email-rctay89@gmail.com>
	<7vvd9dtt54.fsf@alter.siamese.dyndns.org>
	<20100620201137.GA8502@coredump.intra.peff.net>
	<7vpqzltnp3.fsf@alter.siamese.dyndns.org>
	<20100620211605.GA2559@sigill.intra.peff.net>
	<AANLkTildfbJvt15cObc52LvOQRvasL4WYsJq3126bBGd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 21 06:11:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQYLu-0001ji-AP
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 06:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843Ab0FUEJj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jun 2010 00:09:39 -0400
Received: from smtp-out.google.com ([216.239.44.51]:63344 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767Ab0FUEJj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jun 2010 00:09:39 -0400
Received: from wpaz37.hot.corp.google.com (wpaz37.hot.corp.google.com [172.24.198.101])
	by smtp-out.google.com with ESMTP id o5L49bvd000944
	for <git@vger.kernel.org>; Sun, 20 Jun 2010 21:09:37 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1277093377; bh=bXSWORvUz/gwvQK7Mo6uWoXNTH8=;
	h=MIME-Version:In-Reply-To:References:Date:Message-ID:Subject:From:
	 To:Cc:Content-Type:Content-Transfer-Encoding;
	b=Tx7raJaeuMUBJbd2Fpq5zvDINnPoYjkA8uHe3F/LiaqhiZrcsW+7KTE6xKAUkyzmX
	 0tZS0Z0+4n0Iw/mW8uguw==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to:
	cc:content-type:content-transfer-encoding:x-system-of-record;
	b=rjjTrlY3tKVeDQEDuiQCJ+RPHikWmpCNQG+/SJBuyul4XMaYPVK/KmTfLXxHPuDaT
	2Rq1EYR7Hbo+JCtNBgwZA==
Received: from qwj8 (qwj8.prod.google.com [10.241.195.72])
	by wpaz37.hot.corp.google.com with ESMTP id o5L49Zbp001696
	for <git@vger.kernel.org>; Sun, 20 Jun 2010 21:09:36 -0700
Received: by qwj8 with SMTP id 8so67349qwj.19
        for <git@vger.kernel.org>; Sun, 20 Jun 2010 21:09:35 -0700 (PDT)
Received: by 10.224.26.207 with SMTP id f15mr2752477qac.315.1277093375716; 
	Sun, 20 Jun 2010 21:09:35 -0700 (PDT)
Received: by 10.229.78.11 with HTTP; Sun, 20 Jun 2010 21:09:35 -0700 (PDT)
In-Reply-To: <AANLkTildfbJvt15cObc52LvOQRvasL4WYsJq3126bBGd@mail.gmail.com>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149412>

On Sun, Jun 20, 2010 at 7:58 PM, Michel Lespinasse <walken@google.com> =
wrote:
> On Sun, Jun 20, 2010 at 2:16 PM, Jeff King <peff@peff.net> wrote:
>> I'm certainly sympathetic, but as I understand it, with this new pat=
ch
>> you are doing the equivalent of:
>>
>> =A0git branch -f jch master
>> =A0git checkout -f jch
>>
>> which is different than what you wrote above. =A0For your workflow, =
I
>> doubt it matters, but it is potentially destructive.
>
> I am frequently trying to do this as well, so I would love the
> checkout -f -b option.
>
> However, I think that the desired behavior for checkout -f -b is that
> it should be equivalent to:
> git branch -f jch master
> git checkout jch =A0 (without the -f here)

Rhaaa, that actually wouldn't work as the git checkout command would
fail if there are changes in the index & working tree. What I want
here is actually for git checkout -f -b jch to be equivalent to:

git branch -D jch  (ignore error if jch branch does not exist)
git checkout -b jch

> rationale: git checkout -b normally preserves the index & the working
> tree; adding the -f flag to a command that would otherwise succeed
> should not change its behavior.

At least the rationale still holds :)

--=20
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
