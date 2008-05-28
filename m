From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now incompatible with Cygwin (and probably Windows)
Date: Wed, 28 May 2008 13:52:56 -0400
Message-ID: <32541b130805281052o2a56f00m4b64299737d27091@mail.gmail.com>
References: <483AC2CE.7090801@gmail.com>
	 <7vy75vvtxo.fsf@gitster.siamese.dyndns.org>
	 <32541b130805280933r573d59d0mf9cdc09f5e5a6a17@mail.gmail.com>
	 <7vfxs2uytm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Mark Levedahl" <mlevedahl@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 28 19:53:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1PqR-0007bK-Tw
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 19:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbYE1Rw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 13:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbYE1Rw7
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 13:52:59 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:60992 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbYE1Rw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 13:52:58 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2749383fkq.5
        for <git@vger.kernel.org>; Wed, 28 May 2008 10:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=y7lY6uCzsVMFpRRkQ08dVEdISEOuWe3LZfDfF2XhVns=;
        b=oHhl8ynn741BH/xBkdpyhZZWdid3hjpzYWDE7EvRLeSC3Z3N3Bu6ON+4XwTxgFJzN2nXYvWXpFirdfeSMSeASzI2NJFLElzqGJGQL0Q7jSDZ8t1TcWo8grypeJfeLfmUYSdG84rQpkkhofuAnWmIp8UuPMGicDMnv3i1skkkKek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=agz+26B0elxFg3wl5Dpmu41Y5hdXZbolnhu/+MhsnhGWd1vs340V5J5CYiWQciLfDJrJR3MlwHdHnC/AHpEk1dvzmJSfzQ8yL9fPVyCbMvTu040f3kmov2PVXp9jLiqIzttjSzGFpYiLmOdOOLhDA8UBRz7WCFiSWUGAKT+hFKI=
Received: by 10.82.153.12 with SMTP id a12mr389855bue.2.1211997176665;
        Wed, 28 May 2008 10:52:56 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Wed, 28 May 2008 10:52:56 -0700 (PDT)
In-Reply-To: <7vfxs2uytm.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83117>

On 5/28/08, Junio C Hamano <gitster@pobox.com> wrote:
>  Please learn to think before typing, let alone sending such a message to
>  waste other people's time.

Phew, just mentioning Windows on this list seems to get people flamed.

Reading over my message, I'm not sure what I would have written to
have it interpreted as being negative.  I was simply suggesting that
git could fail more gracefully here.

>  We give the user an error message, and signal error by exiting with
>  non-zero.  You cannot have that path on the system, and we are being
>  honest about it.  It is not like we are suddenly painting the screen in
>  blue and refusing to get any more user input when you try to check out
>  such a tree.  Which part of that is _not_ surviving?

The part that's not surviving is git-bisect, which is a valid problem
that resulted in someone asking to rewrite the history.  Clearly
rewriting the history is not a good solution, thus no good solution
has yet been proposed, which is why I wrote my message.

>  The system with a *fatal* error is not git but the one that does not want
>  an not-so-unreasonable name "NUL" on it.

That is clearly true.  But knowing that doesn't seem to be making this
user's problem go away.

>  What alternatives do you want to implement?  Certainly not silently
>  creating "nul-garbage" file instead and pretend that nothing bad happened,
>  as that would lead to madness.

If the file failed to be created (with a warning), but we treated it
as having been deleted in 'git status' instead of throwing an error,
it would work much like the case sensitivity problem: the index is
annoyingly dirty, but you can still get work done.  I think that
(perhaps with a little patch) would allow git-bisect to work.

Have fun,

Avery
