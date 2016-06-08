From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv3] Documentation: triangular workflow
Date: Wed, 08 Jun 2016 15:20:14 +0200
Message-ID: <vpq37on4y29.fsf@anie.imag.fr>
References: <1465206518-1780-1-git-send-email-jordan.de-gea@grenoble-inp.org>
	<1465288693-6295-1-git-send-email-jordan.de-gea@grenoble-inp.org>
	<xmqqr3c8q0d5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>,
	mhagger@alum.mit.edu, philipoakley@iee.org, git@vger.kernel.org,
	erwan.mathoniere@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	tom.russello@grenoble-inp.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 15:20:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAdPM-0006XT-G7
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 15:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177AbcFHNU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 09:20:28 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34771 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753775AbcFHNU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 09:20:27 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u58DKDQD026466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 8 Jun 2016 15:20:14 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u58DKER7014123;
	Wed, 8 Jun 2016 15:20:14 +0200
In-Reply-To: <xmqqr3c8q0d5.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 07 Jun 2016 12:12:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Wed, 08 Jun 2016 15:20:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u58DKDQD026466
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465996815.88156@MEEMbphsy93skntDV1x2oA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296796>

Junio C Hamano <gitster@pobox.com> writes:

>     * Introduction.  As a summary, here are the four configuration
>       variables you'll be using to make it easier to arrange.

I'd actually skip this, and keep configuration variable names for later.
The very point of these --set-upstream & friends options is to allow the
user to work without knowing about them. Typically:

git clone http://example.com/foo
cd foo
# hack hack hack
git commit
git push

=> no configuration variable involved for the user, and it just works.

So, instead of having a flow like "We need to configure
branch.<branch>.merge, and a shortcut to do so is to use
--set-upstream", I'd rather see "Let's push and ask push to remember
where we're pushing so that we don't have to tell it again next time:
git push --set-upstream origin master. Oh, BTW, internally this sets
branch.<branch>.merge.".

Talking about --set-upstream, it does not appear at all in your
patch. Is this on purpose?


OTOH, an introduction that would motivate the workflow would be very
useful IMHO. I see many people using triangular workflows just because
"it's cool" and I can't be satisfied with this. Among real arguments:

* Allows contributor to work with Git even though they do not have write
  access to upstream.

* Symmetrically, this allows maintainers to receive code from
  contributors they don't trust a priori.

* This makes code review more efficient

* This encourrages clean history (because you can "rebase -i" and
  force-push as much as you want to your public fork before the code is
  merged)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
