From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: commit gone after merge - how to debug?
Date: Mon, 26 Nov 2012 14:38:40 +0100
Message-ID: <vpqehjgscv3.fsf@grenoble-inp.fr>
References: <CAO1Khk_eugH--wp3s-gr4HTvuRyL=SaWHWtEXCRZ_Ak7+s5U=w@mail.gmail.com>
	<1353935441-ner-9639@calvin> <vpqr4ngsdjl.fsf@grenoble-inp.fr>
	<CAO1Khk9mzJjnysnc1iDFeMgqnRq0z35t0kgC-8nrsjJ-oOvdOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>, git@vger.kernel.org
To: Igor Lautar <igor.lautar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 14:39:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcytp-0008GW-8P
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 14:39:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249Ab2KZNiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 08:38:46 -0500
Received: from mx1.imag.fr ([129.88.30.5]:40677 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752942Ab2KZNip (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 08:38:45 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id qAQDUUuu028796
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 26 Nov 2012 14:30:30 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TcytU-0005fD-UV; Mon, 26 Nov 2012 14:38:41 +0100
In-Reply-To: <CAO1Khk9mzJjnysnc1iDFeMgqnRq0z35t0kgC-8nrsjJ-oOvdOg@mail.gmail.com>
	(Igor Lautar's message of "Mon, 26 Nov 2012 14:29:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 26 Nov 2012 14:30:30 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: qAQDUUuu028796
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1354541432.909@nskGUA3T658qfXFhrwo4uQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210446>

Igor Lautar <igor.lautar@gmail.com> writes:

> On Mon, Nov 26, 2012 at 2:23 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> The other related question being: does reading the section "History
>> Simplification" in "man git-log" help? ;-)
>
> Somewhat, but it does not explain why the file no longer has that
> change.

It still has, but it's not shown by "git log <file>", probably because
one of the parent of the merge commit introduces no change for this
file, so one side of the merge is not needed to explain you how you went
from the origin of time to the last commit.

Try this:

commit=<sha1 of your merge commit>
# Show diff with first parent:
git diff "$commit" "$commit"^1
# Show diff with second parent:
git diff "$commit" "$commit"^2

> I can understand omitting history if end result is the same, but here
> it shouldn't be - I cannot find a commit that reversed that change, so
> the change should still be in after the merge?

revert is not the only situation that can lead to history
simplification. I'm no expert in the domain, but I think if you did the
same change in two branches, the merge will be candidate for history
simplification.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
