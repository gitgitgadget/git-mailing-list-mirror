From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: New NULL dereference in sequence.c
Date: Wed, 02 May 2012 19:39:19 +0200
Message-ID: <vpqd36mcwjc.fsf@bauges.imag.fr>
References: <CANV9Rr9PFR7SA_3jB-6PRF_V+4yB-FsYEuX5gs-LMpoTAxGDCQ@mail.gmail.com>
	<4FA12E42.201@lsrfire.ath.cx>
	<20120502173436.GA26732@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Michael Mueller <mmueller@vigilantsw.com>, git@vger.kernel.org
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Wed May 02 19:39:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPdWa-0003Sc-IA
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 19:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755408Ab2EBRjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 13:39:32 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37911 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754749Ab2EBRjb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 13:39:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q42HWUlV013214
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 2 May 2012 19:32:30 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SPdWK-0007jy-3d; Wed, 02 May 2012 19:39:20 +0200
In-Reply-To: <20120502173436.GA26732@hmsreliant.think-freely.org> (Neil
	Horman's message of "Wed, 2 May 2012 13:34:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 02 May 2012 19:32:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q42HWUlV013214
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1336584750.56029@mi7NGnGuLlIGv3wTrAF35g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196847>

Neil Horman <nhorman@tuxdriver.com> writes:

>> >         if (!head_commit || parse_commit(head_commit))
>> >             return error(_("could not parse commit %s\n"),
>> >                      sha1_to_hex(head_commit->object.sha1));

[...]

> Have you actually seen this problem occur? It seems to me that the
> only way head_commit could be NULL is in the event that HEAD wasn't a
> commit object, whcih I don't think can be the case unless something
> else is very wrong with your tree.

I don't know whether it can actually happen, but if it can't happen,
then the if() condition should be rewritten. As it is, it explicitly
allows head_commit to be NULL within the if body.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
