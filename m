From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git should not use a default user.email config value
Date: Wed, 14 Aug 2013 16:07:44 +0200
Message-ID: <vpqr4dwl61b.fsf@anie.imag.fr>
References: <52060EF9.2040504@alum.mit.edu>
	<7vvc3d1o01.fsf@alter.siamese.dyndns.org>
	<CAH5451nHfOaBzFzkrGvw+TyRj==cVpKF_QdXsTxnn5tTr1c0dw@mail.gmail.com>
	<20130812123921.GA16088@sigill.intra.peff.net>
	<CAH5451=PK15n4U-3Mb_TLevF3-r+vrpk1PXD15Oo1A2KFc5i_w@mail.gmail.com>
	<20130812154520.GA18215@sigill.intra.peff.net>
	<CAH5451=WKXUNzovXquFii=EdkeQXJEQ96_CRRebgQW6ow_19VA@mail.gmail.com>
	<20130813114635.GA16506@sigill.intra.peff.net>
	<7vsiydy2i1.fsf@alter.siamese.dyndns.org>
	<vpqsiycn33b.fsf@anie.imag.fr>
	<20130814074035.GB5095@sigill.intra.peff.net>
	<vpq38qcmzw1.fsf@anie.imag.fr>
	<CAPc5daWqzTkMFkecrAjMCmxwZZrgUtB-FVKrjsmfvpgwPgF8AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Andrew Ardill <andrew.ardill@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 16:10:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9blt-00037J-Ol
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 16:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195Ab3HNOJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 10:09:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56074 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759819Ab3HNOJx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 10:09:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7EE7hM9023817
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 14 Aug 2013 16:07:43 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V9bjk-00017T-Ok; Wed, 14 Aug 2013 16:07:44 +0200
In-Reply-To: <CAPc5daWqzTkMFkecrAjMCmxwZZrgUtB-FVKrjsmfvpgwPgF8AA@mail.gmail.com>
	(Junio C. Hamano's message of "Wed, 14 Aug 2013 07:00:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 14 Aug 2013 16:07:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7EE7hM9023817
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1377094069.13528@fiQZGE8w9fy6/Va3nkm2iw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232286>

Junio C Hamano <gitster@pobox.com> writes:

> On Wed, Aug 14, 2013 at 1:37 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>
>> Jeff King <peff@peff.net> writes:
>>
>> > This whole discussion is basically implementing conditional config.
>> > [...] The problem is that it would be tricky to do in a
>> > backwards-compatible way.
>>
>> That could be done with "conditional comments" like
>>
>> # if <some-condition> then
>> [core]
>>         pager = less
>> # endif
>>
>> That's rather ugly, and the implementation would be even more ugly, but
>> backward-compatible.
>
>
> I highly doubt that you would want to be "backward compatible" in this
> case, though.
> The section of the configuration you are enclosing the new if/endif
> syntax may be
> understood only by newer Git (e.g. imagine core.pager is still
> bool-only today), and
> older Git that do not understand if/endif syntax will happily read
> that section and
> choke on it, no?

Indeed. That would be more

# if <some-condition> then
# [core]
#       pager = less
# endif

which is even more ugly ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
