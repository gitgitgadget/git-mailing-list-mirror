From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] Port branch.c to use ref-filter APIs
Date: Tue, 28 Jul 2015 19:53:31 +0200
Message-ID: <vpqr3nsnp7o.fsf@anie.imag.fr>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<vpqoaiwwgl2.fsf@anie.imag.fr>
	<CAOLa=ZTDsYDbyvCfC0Ad1uZ+5wPeFusCoa0JuzOcYS2qB8Wbjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 19:53:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK94R-0007kV-63
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 19:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664AbbG1Rxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 13:53:39 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51605 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775AbbG1Rxi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 13:53:38 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t6SHrTJ1025683
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 28 Jul 2015 19:53:29 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6SHrVFn003542;
	Tue, 28 Jul 2015 19:53:31 +0200
In-Reply-To: <CAOLa=ZTDsYDbyvCfC0Ad1uZ+5wPeFusCoa0JuzOcYS2qB8Wbjg@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 28 Jul 2015 21:18:06 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 28 Jul 2015 19:53:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6SHrTJ1025683
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438710811.41904@YFGXuPtXqfjqGL+ZWBuIHg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274800>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Tue, Jul 28, 2015 at 7:05 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>
>> Ideally, you could also have a modifier atom %(alignleft) [...]
>
> This could work for refname, as each ref_array_item holds the refname,
> But other atoms are only filled in after a call to
> verify_ref_format().

If you swap the order and call verify_ref_format() after filter_refs(),
then you could detect %(alignleft) and iterate over the list as needed
in verify_ref_format().

(You would actually force swapping the order and you would need to adapt
other callers in for-each-ref and tag)

> But I don't see this as priority for now, so will mark it off for later.

Absolutely, that's what I meant by "Ideally". I'm just thinking aloud.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
