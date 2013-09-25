From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: "git checkout foo" is getting confused by folder named "foo"
Date: Wed, 25 Sep 2013 22:01:00 +0200
Message-ID: <vpqzjr0oemb.fsf@anie.imag.fr>
References: <CAEQewpqLcDJPo2gUWPk-xc3OitdTC4gH2tnyqaURiQ77BApNog@mail.gmail.com>
	<CAJDDKr64ou+gO7WJLFZ4zOSv+VCbkiW7nKuZa9=5_fiSqGUeyQ@mail.gmail.com>
	<CAEQewpqbf-sWSt0GS9eXQNi0yFz5-23NcO2JWKO4OgSFv3SXdA@mail.gmail.com>
	<vpqzjr1ujyn.fsf@anie.imag.fr>
	<CAEQewpoD2VRVtpEyG121TqAptoYfEXxt57CCthBX_EfN7LU0fQ@mail.gmail.com>
	<vpqzjr0pvfn.fsf@anie.imag.fr>
	<CAEQewpoRhGGnc7HMES1nNbduiRP-qLF4hKBJhRKy7CjMzXnGNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Aguilar <davvid@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jona Christopher Sahnwaldt <jc@sahnwaldt.de>
X-From: git-owner@vger.kernel.org Wed Sep 25 22:01:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOvGs-00078q-5X
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 22:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365Ab3IYUBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 16:01:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52833 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752406Ab3IYUBI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 16:01:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r8PK0w6I031833
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 25 Sep 2013 22:00:58 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VOvGe-0003rP-Kn; Wed, 25 Sep 2013 22:01:00 +0200
In-Reply-To: <CAEQewpoRhGGnc7HMES1nNbduiRP-qLF4hKBJhRKy7CjMzXnGNg@mail.gmail.com>
	(Jona Christopher Sahnwaldt's message of "Wed, 25 Sep 2013 21:36:52
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 25 Sep 2013 22:00:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8PK0w6I031833
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1380744062.63031@xFKYsEepKZqCu7Lbr2Gfkw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235375>

Jona Christopher Sahnwaldt <jc@sahnwaldt.de> writes:

> Yes, I think the rules for the "short form" (the guessing when there's
> no --) should be made simpler, or maybe the guessing should be dropped
> altogether. I don't know. I don't know git well enough to be able to
> be more specific. I just find the current behavior very confusing.

It can hardly be "simpler" (in the sense "behavior that can be described
with fewer words"), but it could be tightened to be safer.

When a remote branch $foo exists, a local branch $foo does not, and a
file $foo does, then

  git checkout $foo

rather likely means "I want to use git checkout's DWIM and create local
branch $foo", but it currently means to Git "checkout file foo from the
index". It would make sense to die here, and require the use of --.

No time to write a patch for this. Any volunteer?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
