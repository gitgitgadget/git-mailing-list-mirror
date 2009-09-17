From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 3/4] reset: add option "--merge-safe" to "git reset"
Date: Thu, 17 Sep 2009 14:12:50 +0200
Message-ID: <c07716ae0909170512k3c2ec7m21e69e9acfdfd81f@mail.gmail.com>
References: <20090917040835.4048.51057.chriscool@tuxfamily.org>
	 <20090917041440.4048.16353.chriscool@tuxfamily.org>
	 <7vk4zykv7o.fsf@alter.siamese.dyndns.org>
	 <4AB1D957.20902@viscovery.net>
	 <7vr5u6jbgk.fsf@alter.siamese.dyndns.org>
	 <4AB1E41F.6050304@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 14:13:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoFr5-0003sb-M7
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 14:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757772AbZIQMMt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Sep 2009 08:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757701AbZIQMMt
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 08:12:49 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:35710 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757696AbZIQMMs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Sep 2009 08:12:48 -0400
Received: by bwz19 with SMTP id 19so247549bwz.37
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 05:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=um9bljhxo0qIRQXjyk6PIlP5yZmjqGF7PoWQkcW/Gwo=;
        b=a5smSI3emgTmvBWlbpTlkpWPK7DHhLkSkQ2CvyhuVJguqSWavXivPRRjGhDe/KGmfz
         YHdzYBjFaAhmtSUqeRvODMudosriFS6uwrWH2PHmrB6854uDopld9lJYH+Rgs53MBHDZ
         Nb5W5WAYG5300rfaLe/JxInMf4BQn0LLmyF8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bFESVgr3iiBi4pdfGiJ6iRzrponbZYuvuGVzDNpXub29fAFfqvNq+bzzNbHOCqXxPO
         XwFSo6HK61tcFXLUuNxW5rzxMeeYwHJh79jzj8itsr3Ome0RODhG6uuCoA4UwybAMrZo
         +2FW/gG5w56Kyax9P1eZUXSo2Cje/jtbh4l/U=
Received: by 10.204.34.22 with SMTP id j22mr346921bkd.43.1253189570722; Thu, 
	17 Sep 2009 05:12:50 -0700 (PDT)
In-Reply-To: <4AB1E41F.6050304@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128745>

On Thu, Sep 17, 2009 at 9:24 AM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Junio C Hamano schrieb:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>> Junio C Hamano schrieb:
>>> (2) The intended use-case of --merge-safe is to point the branch he=
ad to a
>>> different commit, but to carry the changes that currently are in th=
e index
>>> and wd over to the new commit, similar to checkout --merge.
>
> This is actually an operation that I need quite often, but I can do i=
t
> only by way of git stash.
>
> Clarification: I did not say that I actually meant to carry *only* th=
e
> index and wd changes to the new commit. That is, the operation I have=
 in
> mind can roughly be done in terms of
>
> =A0$ git stash
> =A0$ git reset --hard $target
> =A0$ git stash pop
>
>> I have _no_ idea what the intended use-case of --merge-safe is, and =
that
>> was why I asked Christian for clarification in the previous round. =A0=
The
>> answer was still not clear enough so I pointed out --merge-safe coul=
d be
>> still doing a wrong thing even in _his_ use-case.
>
> Reading Christian in 200909170554.49416.chriscool@tuxfamily.org, I th=
ink
> this *is* his use-case? Christian?

Yes, I agree, it can be used instead of git stash. By the way Linus, in=
 his
patch that added the --merge option, said that --merge could be used li=
ke
that.

So for this use case --merge-safe is safer than --merge, and that's why=
 I
suggested that name. But I know I suck at naming things, so there is
probably a better name.

Thanks,
Christian.
