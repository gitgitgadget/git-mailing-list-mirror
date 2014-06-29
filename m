From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] pager.c: replace git_config with git_config_get_string
Date: Sun, 29 Jun 2014 14:04:26 +0200
Message-ID: <vpq7g3zsz05.fsf@anie.imag.fr>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
	<1403520105-23250-6-git-send-email-tanayabh@gmail.com>
	<CAPig+cTwBB8bmKDtdv8zPojR+6Kyu6fYB7Sw0-UJoSHFLQX+fQ@mail.gmail.com>
	<53AC6A7B.3040602@gmail.com> <vpqr42afty5.fsf@anie.imag.fr>
	<53ADA26E.8030801@gmail.com> <vpqmwcyw47q.fsf@anie.imag.fr>
	<53AE50A9.6010707@gmail.com> <vpqy4whshbj.fsf@anie.imag.fr>
	<53AED13D.60705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Tanay Abhra <tanayabh@gmail.com>,
	Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 14:04:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1DqY-0007yP-WA
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 14:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752652AbaF2MEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2014 08:04:35 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56664 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752961AbaF2MEe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2014 08:04:34 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s5TC4P2L023976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 29 Jun 2014 14:04:25 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s5TC4Qbo015170;
	Sun, 29 Jun 2014 14:04:26 +0200
In-Reply-To: <53AED13D.60705@gmail.com> (Karsten Blees's message of "Sat, 28
	Jun 2014 16:29:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 29 Jun 2014 14:04:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s5TC4P2L023976
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1404648266.2833@ZlBgv0UxRKWLT2isTtk8Kw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252640>

Karsten Blees <karsten.blees@gmail.com> writes:

> Am 28.06.2014 08:01, schrieb Matthieu Moy:
>> Karsten Blees <karsten.blees@gmail.com> writes:
>> 
>>> I still don't like that the invalidation is done in git_config_set, though, as
>>> this is also used to write completely unrelated files.
>> 
>> I don't get it. It is used to write the config files. Yes, we trigger a
>> complete reload instead of just changing this particular value in the
>> hashmap, but I do not see "unrelated files" in the picture.
>> 
>
> git-cherry-pick, revert: writes '.git/sequencer/opts' (sequencer.c:save_opts)
> git-mv <submodule>: writes '.gitmodules' (submodule.c:update_path_in_gitmodules)
>   ...and the submodule's '.git/config' (submodule.c:connect_work_tree_and_git_dir)

In the previous patch series, the cache was only about the system, user
and repo config files. So, .git/sequencer/opts, .gitmodules are totally
independant. In the latest series, there's a new notion of config_set.
.gitmodules, .git/sequencer/opts and the usual config files are in
different config sets, and their cache is invalidated independently.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
