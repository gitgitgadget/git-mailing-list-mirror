From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: repository corruption when pushing commits to a repository running 'git gc --prune='
Date: Wed, 14 Oct 2015 22:08:36 +0200
Message-ID: <vpq37xd8b7f.fsf@grenoble-inp.fr>
References: <561E5C5B.3090207@alcatel-lucent.com>
	<vpqbnc18ezo.fsf@grenoble-inp.fr>
	<xmqq7fmp8bcf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jan Smets <jan.smets@alcatel-lucent.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 22:09:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSM2-0006DE-7j
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754593AbbJNUIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:08:46 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55467 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753385AbbJNUIp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:08:45 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t9EK8YBF017550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 14 Oct 2015 22:08:34 +0200
Received: from anie (ensi-vpn-233.imag.fr [129.88.57.233])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9EK8aOG002879;
	Wed, 14 Oct 2015 22:08:36 +0200
In-Reply-To: <xmqq7fmp8bcf.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 14 Oct 2015 13:05:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 14 Oct 2015 22:08:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9EK8YBF017550
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445458117.56221@daTasxz2bCquRbAm/PU0eA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279588>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> This looks like a race between deleting objects/05/ and creating
>> objects/05/cdb51bb0ea3e229734a4b1bddd5ec70fbc65ed.
>>
>> I don't understand how this is possible, since the temporary file and
>> the final one are in the same directory, so deleting the directory
>> should fail.
>>
>> What am I missing?
>
>  1. tmp_obj_* gets created in objects/05/ by "git unpack-objects";
>
>  2. prune_cruft() comes, notices tmp_obj_* that is sufficiently old,
>     decides to remove in "git prune".

Ah, OK, the real problem is the temporary file removal. Thanks.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
