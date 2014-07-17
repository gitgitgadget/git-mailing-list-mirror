From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v9r2 1/2] add `config_set` API for caching config-like files
Date: Thu, 17 Jul 2014 12:01:50 +0200
Message-ID: <vpqvbqwpalt.fsf@anie.imag.fr>
References: <1405434571-25459-1-git-send-email-tanayabh@gmail.com>
	<1405434571-25459-3-git-send-email-tanayabh@gmail.com>
	<xmqqk37ewr5r.fsf@gitster.dls.corp.google.com>
	<53C665A0.2060705@gmail.com> <vpqvbqxjzfx.fsf@anie.imag.fr>
	<53C66E70.3050507@gmail.com> <vpqha2h9tjw.fsf@anie.imag.fr>
	<53C6ABEB.3060205@gmail.com> <vpqzjg9z115.fsf@anie.imag.fr>
	<53C6C2BD.3030703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 12:02:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7iWJ-0002ye-B8
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 12:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756097AbaGQKCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2014 06:02:32 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43615 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755850AbaGQKCa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 06:02:30 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6HA1nZx000818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Jul 2014 12:01:49 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6HA1oiH005328;
	Thu, 17 Jul 2014 12:01:50 +0200
In-Reply-To: <53C6C2BD.3030703@gmail.com> (Tanay Abhra's message of "Wed, 16
	Jul 2014 23:51:49 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 17 Jul 2014 12:01:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6HA1nZx000818
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406196111.63802@HTz/VlCVl7qEMaNuICvBYQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253728>

Tanay Abhra <tanayabh@gmail.com> writes:

> I have a question about renaming git_config() to git_config_raw().
> I was working on a patch and I am getting stuck here.
> It fails in t1001, t1020 & t4018. The reason for the last test failure
> is unknown right now. For the first two, it boils down to this,
>
> 		git init --bare bare-ancestor-aliased.git &&
> 		cd bare-ancestor-aliased.git &&
> 		echo "[alias] aliasedinit = init" >>config &&
> 		mkdir plain-nested &&
> 		cd plain-nested &&
> 		git aliasedinit

Git tries to read .git/config relative to the current directory, and
tries to resolve aliases from it. The problem is: if one tries to do
this from a subdirectory inside the repo, .git/config is not the right
path, and the alias lookup fails.

I'll investigate more later.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
