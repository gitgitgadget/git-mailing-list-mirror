From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v3 0/2] git-gui: change to display the combined diff in 
	the case of conflicts.
Date: Sun, 4 Apr 2010 16:44:57 +1000
Message-ID: <o2m2cfc40321004032344of94fa946je6c1865cffccd69@mail.gmail.com>
References: <2cfc40321003300834w59532e58m13d42acce4f2c5ce@mail.gmail.com>
	 <4BB2F7A0.6020702@viscovery.net>
	 <k2p2cfc40321003310412hf4c6d642n4349af3f644829ff@mail.gmail.com>
	 <4BB3346C.7070700@viscovery.net>
	 <t2u2cfc40321003310523u8fda9baeo883d2e0b3c6fa807@mail.gmail.com>
	 <4BB3534E.3080803@viscovery.net>
	 <v2z2cfc40321003311252s86d44ad7l540559eafb0636d4@mail.gmail.com>
	 <4BB5ACD3.10307@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: spearce@spearce.org, Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sun Apr 04 08:45:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyJaK-0001Id-Sy
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 08:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425Ab0DDGpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 02:45:00 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:63629 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262Ab0DDGo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 02:44:58 -0400
Received: by pva18 with SMTP id 18so1331993pva.19
        for <git@vger.kernel.org>; Sat, 03 Apr 2010 23:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=7NX6m1dQuEtdcvubt+PnAwJmZKoNaS77rWnhebXgqAI=;
        b=ffHjiQoT3hqmoK3lCJo1Gous9/iNPH83K+PvPcz6jWUcq5TX2lvqZbT81doETwhZeC
         Kp5hP3xg2LjzT+OTJ7rZ6Cv77n24DLig3x1K3dFpEnc+1ALGS9QlHCDtscZlQ419EvBI
         7uplisU8kDqkAPtxgUOb4COsKsLW6a00K64+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Nl81ImIfqMqv9/xqbRhlrN2UkT04wyszAHnIZGKRA3vXg9l7QVrmW4I2oGAZ9SzeNv
         9rGUJMjYhiCjL9qziu2Bka+ZrtU81dC2L85sbrrVbKnFLJgIoyWvd1pTvpEp7XNzme/7
         RlCEhdEOiUKtdp/rkTG3YnNe7gLaUf2EuZh5Y=
Received: by 10.114.13.5 with HTTP; Sat, 3 Apr 2010 23:44:57 -0700 (PDT)
In-Reply-To: <4BB5ACD3.10307@viscovery.net>
Received: by 10.115.28.1 with SMTP id f1mr3595007waj.181.1270363497820; Sat, 
	03 Apr 2010 23:44:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143915>

On Fri, Apr 2, 2010 at 7:37 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 31.03.2010 21:52, schrieb Jon Seymour:
>>
>> I agree that removing the options is better than preserving the
>> current behaviour,
>
> So, we are in agreement in this. Suppose we do remove them. What remains
> that is dangerous?

Stage to commit is still somewhat dangerous if the current "diff"
output is displayed because all the successfully staged changes
already in the index that will be purged by the "Stage to commit"
action will still not be visible until after the action is taken -
hence the original suggestion to use the "diff HEAD" output.

>
> The user has no option to accidentally revert changes that are not displayed
> even if the current diff --cc remains. The user is forced to run mergetool
> or to go to the editor.
>
> It is now an orthogonal matter whether diff --cc is helpful. Here I do agree
> somewhat that diff against HEAD is more helpful than the current diff --cc.

I am not sure the issues are completely orthogonal since I would still
argue that in the case the "Use Local/Use Remote" actions are
preserved, the diff -c output is the only output that provides enough
information to inform the user of the likely consequences of taking
each action. [ rationale: diff HEAD allows the consequences of Use
Local to be assessed, but does not allow the consequences of Use
Remote to be adequately assessed. ] That said, I agree that
the "diff HEAD" output is still better than the current "diff" output
in this situation since it does at least tell you want "Stage to
commit" will do with respect to the current HEAD (if not with respect
to successfully staged changes in the index).

I agree in the case that the "Use Local/Remote" actions are removed
from the UI, then the only remaining action of consequence is "Stage
to commit" and that for this "diff HEAD" output is the most
appropriate output to use in order to evaluate the expected
consequences of taking that action.

Until such time as I see some indication that Shawn will accept a
"Remove Use ... actions" patch, I'll assume that he won't. I will
likely re-roll the existing patch so that the user can choose via
configuration the diff options to be used for merge conflicts so that
people who don't like "diff -c" output can configure it to use "diff
HEAD" output instead.

>
>> I would imagine that a change that proposed to remove the actions,
>> without an option to enable them, would encounter stiff resistance
>> from the list. However, perhaps the list can respond?
>
> Who knows? There was not a lot discussion when the feature was presented to
> the list, not even a word of excitement.
>
> http://thread.gmane.org/gmane.comp.version-control.git/94425/focus=94426
>

True. Perhaps I should submit a "git-gui: Remove Use Remote/Local
actions" patch just to generate some excitement?

Shawn: any thoughts on any of this?

jon.

> -- Hannes
>
