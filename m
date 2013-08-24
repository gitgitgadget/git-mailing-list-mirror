From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] git-remote-mediawiki: reset private ref after non-dumb push
Date: Sat, 24 Aug 2013 09:46:56 +0200
Message-ID: <vpq8uzr5y4v.fsf@anie.imag.fr>
References: <1376400700-8863-1-git-send-email-Matthieu.Moy@imag.fr>
	<CAMP44s2u1edB3g9GK_kak3Nc-fe4TDBjFU_JqskBW+J0Q9BJrg@mail.gmail.com>
	<vpqa9ka7mku.fsf@anie.imag.fr>
	<CAMP44s3jh4iEbgONaEU0WSCc5YiGYoK8edcgWU6qmUARToVRuw@mail.gmail.com>
	<vpqbo4o3jba.fsf@anie.imag.fr>
	<CAMP44s281qkdMXUM-2P6T+emFajASX6Jyj4nk8_cU5xYJYvdLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 24 09:47:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD8Z1-0003As-3U
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 09:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755197Ab3HXHrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 03:47:04 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55569 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754719Ab3HXHrD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 03:47:03 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r7O7ktRO005748
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 24 Aug 2013 09:46:55 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VD8Yi-0004b6-P0; Sat, 24 Aug 2013 09:46:56 +0200
In-Reply-To: <CAMP44s281qkdMXUM-2P6T+emFajASX6Jyj4nk8_cU5xYJYvdLA@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 23 Aug 2013 14:52:17 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 24 Aug 2013 09:46:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7O7ktRO005748
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1377935218.62136@C5EaPFI3FXndIjzNk44JyQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232881>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Fri, Aug 23, 2013 at 3:25 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>
>> This is assuming you follow the scheme
>>
>>   git -> local repo for other vcs -> remote repo for other vcs
>>
>> which itself more or less assumes that the other VCS is a decentralized
>> VCS. I understand this is a good idea for hg or bzr remote helpers, but
>> not applicable for git-remote-mediawiki.
>
> A centralized repository is a subset of decentralized workflows.

Yes, a strict subset. You can't keep a local copy of a remote repository
with a centralized VCS, so the way to write remote-helpers for DVCS does
not apply for centralized VCS.

> I don't know if a dumb push is the right thing to do here, but
> supposing it is, you can still report non-fast-forward errors:

That would be really complicated, as you would need to check whether
non-fast forward errors are serious. The check is done on pull, and the
reason the check should be disabled is dumb push.

> https://github.com/felipec/git/commit/0f7f0a223d710d29a4f1a03fc27348a8690d8a19
> https://github.com/felipec/git/commit/b67a8914bc1bb3ad23591875611165b84135aaf9

Err, don't they apply when pushing? In my case, the non-fast forward
occurs on pull.

> If it's too much hassle to find non-fast-forward situations by
> yourself, then perhaps it would make sense to update the remote
> namespace only when a certain feature has been flagged.

How would I do that? The update to the remote namespace is done by Git,
not by the remote-helper.

OK, I'm now convinced that my solution is the right one. The
alternatives are far more complex and I still fail to see the benefits.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
