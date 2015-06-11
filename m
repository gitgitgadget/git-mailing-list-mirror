From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 7/7] bisect: allows any terms set by user
Date: Thu, 11 Jun 2015 11:42:18 +0200
Message-ID: <vpqk2vaoa2t.fsf@anie.imag.fr>
References: <1433962918-6536-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433962918-6536-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<xmqqk2vbi7rf.fsf@gitster.dls.corp.google.com>
	<xmqq7frbi4uv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr, chriscool@tuxfamily.org,
	thomasxnguy@gmail.com, valentinduperray@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 11:42:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2z0O-0003rj-OE
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 11:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbbFKJmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 05:42:33 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51539 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526AbbFKJmb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 05:42:31 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5B9gHpg014690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 11 Jun 2015 11:42:17 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5B9gIZn006288;
	Thu, 11 Jun 2015 11:42:18 +0200
In-Reply-To: <xmqq7frbi4uv.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 10 Jun 2015 15:19:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 11 Jun 2015 11:42:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5B9gHpg014690
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434620538.09061@1vjwWKK0he03wUZ8Bb0edQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271379>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> +bisect_terms () {
>> +	test $# -eq 2 ||
>> +	die "You need to give me at least two arguments"
>> +
>> +	if ! test -s "$GIT_DIR/BISECT_START"
>> +	then
>> +		echo $1 >"$GIT_DIR/BISECT_TERMS" &&
>> +		echo $2 >>"$GIT_DIR/BISECT_TERMS" &&
>> +		echo "1" > "$GIT_DIR/TERMS_DEFINED"
>> +	else
>> +		die "A bisection has already started, please use "\
>> +		"'git bisect reset' to restart and change the terms"
>> +	fi
>> +}
>> +
>
> I think "git bisect terms" is a good way to help a user to recall
> what two names s/he decided to use for the current session.  So
> dying 'already started' with suggestion for 'reset' is OK, but at
> the same time, helping the user to continue the current bisection by
> giving a message along the lines of "You are hunting for a commit
> that is at the boundary of the old state (you are calling it
> '$NAME_OLD') and the new state ('$NAME_NEW')" would be a good idea.

I'd put a very verbose message explaining the situation and the way out
(use 'git bisect') for the second "die", and I would consider "git
bisect terms" without arguments as a valid command to ask "please tell
me what the terms are".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
