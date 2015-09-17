From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 3/8] branch: roll show_detached HEAD into regular ref_list
Date: Thu, 17 Sep 2015 16:18:42 +0200
Message-ID: <vpqpp1hqgcd.fsf@anie.imag.fr>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
	<1442129035-31386-4-git-send-email-Karthik.188@gmail.com>
	<xmqqzj0ovlno.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQ51+TKvOiJvWa-emmJJGirAqkr9m0a_7BrQ2UbiSJdjA@mail.gmail.com>
	<CAOLa=ZQxounTiJk0t+zB2-7=UQa8oL+uJ9EQpTkWL7kYFHjxwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 16:19:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zca1Z-0007a9-4Z
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 16:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbbIQOSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 10:18:51 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38862 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175AbbIQOSu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 10:18:50 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8HEIetK028036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 17 Sep 2015 16:18:40 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8HEIgXu026064;
	Thu, 17 Sep 2015 16:18:42 +0200
In-Reply-To: <CAOLa=ZQxounTiJk0t+zB2-7=UQa8oL+uJ9EQpTkWL7kYFHjxwQ@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 17 Sep 2015 15:17:06 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 17 Sep 2015 16:18:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8HEIetK028036
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1443104323.89981@gEQdkmCNW1Xqz6K9LpOi0A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278116>

Karthik Nayak <karthik.188@gmail.com> writes:

> So either we could introduce a new atom for sorting something like
> `branch_sort` which uses the FILTER_REFS_(DETACHED_HEAD | BRANCHES |
> REMOTES)

I don't think you need a new atom. You can just change the sorting
function to consider that detached HEAD is always first, and when
comparing two non-detached-HEAD branches, use the atom supplied by the
user.

That would mean the detached HEAD would be displayed first regardless of
--sort (which is the case right now).

Introducing a new atom would mean that "git branch --sort authorname"
would not use this new atom, hence the HEAD would be sorted like the
others. I don't know if this is good or bad.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
