From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor 
	with no changes written
Date: Tue, 2 Feb 2010 12:14:30 -0800
Message-ID: <8c9a061002021214j673afbc8vfa5d941fba518648@mail.gmail.com>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 21:14:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcP9F-000891-IP
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 21:14:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908Ab0BBUOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 15:14:51 -0500
Received: from mail-pz0-f190.google.com ([209.85.222.190]:43829 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804Ab0BBUOu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 15:14:50 -0500
Received: by pzk28 with SMTP id 28so459979pzk.4
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 12:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=3Ez4c+N0HnhgfUpbNOjyOuSP1CS7sgStaQ5uMeGX31Y=;
        b=C46oj+/VnPnHyTT+8CU2GBA3Qmw9nGwtEiQKtC41020oq+jRqu5K5UHwbkb0Xm/aQ0
         h2O0dSbIfiwXKOd7mQmuHDEQtT3YeXf1CmChAJlYbfEifeY4yWtnW/S6ro6UN03BMaY/
         NBU7Aw2NGcwe0UXUoPYN02RttzxmKnSyFx6hk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=vcG+bBwJg/DSJNhIXc2BKmIhghDPXPpClwzuSjbF8tpCapCYe88CBtsHG2mn5ggLcR
         P1WAOwSscyB4x8hAGGf5DqlI4ukPMfLJQrq6qFDsjI81BLJb5xRjEfFZaaQbRxt8D8nj
         fVFI6kFBNqpgLMPeYK/Gr/rd2I4sM6SWUQRng=
Received: by 10.141.125.18 with SMTP id c18mr4494706rvn.18.1265141690202; Tue, 
	02 Feb 2010 12:14:50 -0800 (PST)
In-Reply-To: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138748>

On Tue, Feb 2, 2010 at 12:07, Eugene Sajine <euguess@gmail.com> wrote:
> Hi,
>
> It seems to me it is a bug:
>
> When git commit --amend is executed it fires up vi so i can change the
> commit message. If I have something staged, then when I'm exiting vi
> using :q (without doing/writing any changes), it still commits
> everything staged with old message.
>
> I believe it should actually abort amending and return to the state
> before the "git commit --amend" was issued.
>
> Thanks,
> Eugene
>

I don't think this is actually the right way to go.  A _very_ common
use case for "commit --amend" is to add things to the previous commit,
without changing the commit message at all.  Yes, you can avoid having
to fire up the editor at all in this case, but it's still a perfectly
valid thing to want to do.

If you want to abort amending, and return to the state before the "git
commit --amend", you can remove all non-comment lines (IE: write out
an "empty" commit message), or have your editor exit with a non-zero
exit code (Use ":cquit").

The comment block that comes up in your editor mentions this first
method, explicitly. "..., and an empty message aborts the commit."

-Jacob
