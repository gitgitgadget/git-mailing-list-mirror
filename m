From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] doc: technical details about the index file format
Date: Wed, 2 Mar 2011 18:43:56 +0700
Message-ID: <AANLkTimKT2dgPu_0L=K-14e6bBCgPhiQ59AmPWp7y6vg@mail.gmail.com>
References: <AANLkTi=iFe=MmUiXzC_HMwueZxLJDCea+zp_-SNWvSup@mail.gmail.com>
 <1283769430-9263-1-git-send-email-pclouds@gmail.com> <AANLkTi=YJkk6KHChCrrazij_ziyG-Ru7kGLWc7JnUGoN@mail.gmail.com>
 <AANLkTi=hz0xRsTy5f8xhzBhu0md_iPCxvdTrEPrzYwzt@mail.gmail.com>
 <20110226100310.GA21724@do> <7vsjvb6qmt.fsf@alter.siamese.dyndns.org>
 <20110226133639.GA32442@do> <7vpqqaffy2.fsf@alter.siamese.dyndns.org>
 <AANLkTi=GhdfWCyx7MN3w0ZPhqKHcC1e6RmPeZt67OeqG@mail.gmail.com> <7voc5ucb6b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	kusmabite@gmail.com, raa.lkml@gmail.com, jjuran@gmail.com,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 12:44:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PukTp-0005Ge-IM
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 12:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756680Ab1CBLo2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2011 06:44:28 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55731 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755977Ab1CBLo1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Mar 2011 06:44:27 -0500
Received: by wwb22 with SMTP id 22so5727350wwb.1
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 03:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=w2cZ7wjx4F9N5jgs0LSxyIB3e9qucXhfAKR73yDt89s=;
        b=em0ImcQFJwHCYXUrUcIVWLBeRsRZEwJZeFjSfxi0XK+9oBs9q7+c6GzgWMOKkG+ZSZ
         Tn7Pf/6t091Gv0ewmWZ5akdPP4hND/P/jI0/A1SzL0HGHm7SrKa57+rXASqE9F1QpR7b
         olZ720SRBrcLOodYK0lKuoWHccCX2mrbPf4yU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=TxMr9PNmpUVIlEha3QoM9d7TFcXBBPHw0p3saKj6dzCdNxd20kV2SLtbpuN7/l56Lo
         v9Kx2fBnEFDON14fRcRKlyCesj5AwdkiEkT4RMUuVxgyCCuTQxLlz6jJekkBQJg9u7ms
         713Hircy0BxXaoEDzYuFqKeTw+ICevIzsorgU=
Received: by 10.216.163.69 with SMTP id z47mr7244025wek.43.1299066266106; Wed,
 02 Mar 2011 03:44:26 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Wed, 2 Mar 2011 03:43:56 -0800 (PST)
In-Reply-To: <7voc5ucb6b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168302>

On Wed, Mar 2, 2011 at 1:02 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>> I wonder if we should also point to relevant source files, so if thi=
s
>> document becomes out of date, the readers can jump in the source and
>> verify themselves (perhaps coming up with patches to this doc)?
>
> I suspect that is a sure way to guarantee the document to go stale.

No it does not. The point is to make it easier for readers to help
themselves when they suspect the document is not entirely correct.

> I didn't like the way I explained the cache-tree entry order. =C2=A0W=
as it
> understandable?

It is, although I'm wondering if it's just like memcmp() order with
parent component cut out.

> I am wondering if an illustration with an example might be in order. =
=C2=A0I
> think anybody halfway intelligent may be able to get a fuzzy idea of =
what
> is going on by looking at the output from test-dump-cache-tree after
> "reset --hard && write-tree" and then by comparing it with the output=
 from
> test-dump-cache-tree after running ">t/something && git add t/somethi=
ng"
> (which invalidates the top-level tree and t/ subtree).

A short example would be great. test-dump-cache-tree might not be.
Last time I read its output, I wasn't sure I understood. Maybe because
I ran it on git.git and did not compare two outputs.

> But a well written
> documentation should be able to help clarifying the idea obtainable t=
hat
> way. =C2=A0I don't think what I wrote in the previous message is suff=
icient
> even for that (i.e. comparing the two output would give you better
> explanation of what is going on than what I wrote--iow, what I wrote =
may
> not be very useful for people who are motivated to learn).
--=20
Duy
