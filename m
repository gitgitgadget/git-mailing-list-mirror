From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] trailer: ignore first line of message
Date: Fri, 21 Aug 2015 09:01:34 +0200
Message-ID: <vpqk2sprupd.fsf@anie.imag.fr>
References: <CAP8UFD0YcBdAfMJxc2bQD_zTp+kPk2L2sQfWYzTDn+trFk+DMA@mail.gmail.com>
	<1440107955-26892-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 09:01:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSgKe-0000C3-Sj
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 09:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbbHUHBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 03:01:40 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56899 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751807AbbHUHBk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 03:01:40 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t7L71XP8018494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 21 Aug 2015 09:01:33 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7L71YMs014900;
	Fri, 21 Aug 2015 09:01:34 +0200
In-Reply-To: <1440107955-26892-1-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Thu, 20 Aug 2015 23:59:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 21 Aug 2015 09:01:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7L71XP8018494
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1440745296.81875@mbAh5LNDtkfIVV6db3yzMA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276278>

Christian Couder <christian.couder@gmail.com> writes:

> When looking for the start of the trailers in the message
> we are passed, we should ignore the first line of the message.

Thanks, this fixes my issue.

There's one more corner-case I've just thought of:

git commit -m 'place of
code: change we made'

(with the line break)

Git considers this message as a summary line broken in the middle. "git
log --oneline" shows it as a one-liner, as if it were
'place of code: change we made'.

Even with your patch, the trailer is added without a blank line, and
renders on the subject line in `git log --oneline`. My command above
with a commit-msg hook outputs:

[master 86f32d5] place of: code: change we made Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>

(on a single line)

I do not care deeply, but you may want to let interpret-trailers deal
with this case too.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
