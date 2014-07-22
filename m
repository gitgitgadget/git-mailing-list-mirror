From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] rewrite `git_default_config()` using config-set API functions
Date: Tue, 22 Jul 2014 09:55:10 +0200
Message-ID: <vpqsiltkeu9.fsf@anie.imag.fr>
References: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>
	<53CCFD02.6010704@gmail.com> <vpqha2addyn.fsf@anie.imag.fr>
	<53CD2273.3000600@gmail.com> <vpqzjg2204x.fsf@anie.imag.fr>
	<xmqqa982k2lm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 09:55:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9Uv6-0001Aj-Gx
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 09:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbaGVHzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 03:55:25 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38790 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569AbaGVHzY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 03:55:24 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6M7tAf9006855
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 22 Jul 2014 09:55:10 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6M7tA3q002642;
	Tue, 22 Jul 2014 09:55:10 +0200
In-Reply-To: <xmqqa982k2lm.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 21 Jul 2014 11:07:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 22 Jul 2014 09:55:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6M7tAf9006855
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406620513.28242@LojTKADx395xQlSbv+ijZw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254006>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> In general, most strings one manipulates are "const char *", it's
>> frequent to modify a pointer to a string, but rather rare to modify the
>> string itself.
>
> We seem to have a disagreement.  Unlike git_config_get_value() that
> lets callers peek the only cached copy, git_config_get_string()
> gives its caller a new copy that the caller needs to free.  Such a
> new string can and should be given as mutable, I would say.

You're right (I guess you replied to this one before seeing my other
message). imap_folder could be declared const char *, but
git_config_get_string() shouldn't be the one to force this.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
