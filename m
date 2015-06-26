From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v9 5/5] bisect: allow any terms set by user
Date: Fri, 26 Jun 2015 19:08:31 +0200
Message-ID: <vpq8ub6s8hc.fsf@anie.imag.fr>
References: <1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435258257-29047-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435258257-29047-6-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqk2urwjmq.fsf@gitster.dls.corp.google.com>
	<xmqqfv5fwib3.fsf@gitster.dls.corp.google.com>
	<vpqegkyyj7z.fsf@anie.imag.fr>
	<xmqqtwtuv2jr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 19:08:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8X7M-0004aQ-H0
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 19:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbbFZRIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 13:08:40 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55403 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752086AbbFZRIj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 13:08:39 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5QH8Sc8029347
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 26 Jun 2015 19:08:28 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5QH8VuK013985;
	Fri, 26 Jun 2015 19:08:31 +0200
In-Reply-To: <xmqqtwtuv2jr.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 26 Jun 2015 09:48:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 26 Jun 2015 19:08:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5QH8Sc8029347
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435943311.48859@dYfKOB1mDU2V/AevWZnrLQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272799>

Junio C Hamano <gitster@pobox.com> writes:

> And worse yet, majority of users may read "git bisect start" is
> where "you start bisection", but "bisect start" (either called
> directly, or via bisect_autostart by the first "git bisect good")
> is where you set up the machinery, so doing "bisect terms" before
> doing "bisect start" does not make much sense.

This is currently how it's implemented. You need to say

$ git bisect terms foo bar
$ git bisect start

And indeed "git bisect terms foo bar" errors out. I think the reason it
is this way is to allow

$ git bisect terms foo bar
$ git bisect start <sha1> <sha1>

But actually, we can allow "git bisect terms" until BISECT_TERMS is
created, which is your intuition and makes more sense IMHO. I'll try to
do that.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
