From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [PATCH RFC v2 01/19] rebase -i: Failed reword prints redundant
 error message
Date: Thu, 10 Jul 2014 10:30:50 -0400
Message-ID: <CADgNjakNQKbA8fYJqz7n-C9aPoZdfxX+N9Xuq1irJ_ajB8Yt_w@mail.gmail.com>
References: <53A258D2.7080806@gmail.com>
	<cover.1404323078.git.bafain@gmail.com>
	<10d7fae199e4d8adec537aa377177de652badc07.1404323078.git.bafain@gmail.com>
	<xmqqtx6r8uem.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Fabian Ruch <bafain@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 16:30:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5FNA-0004nL-T7
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 16:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446AbaGJOax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 10:30:53 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:40078 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbaGJOav (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 10:30:51 -0400
Received: by mail-wi0-f169.google.com with SMTP id hi2so4574863wib.2
        for <git@vger.kernel.org>; Thu, 10 Jul 2014 07:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=F2lnolRVCMvhLg019Q1SU4dAW4HcJwPxTC15LAGAXNo=;
        b=krOMk0DLT8jyXWJx5o1fnalfKzk/reswnQrW1+a8fBB0AvApWs7FaBf02pHJq4EvqY
         Hap/zcaIub8Nxicz/TxSVgDrTRpclGRDmIPijp3YhGnc+SHh26XsmS90no88P7EhtgWj
         +ck3Flx567wFPG9vE9x0LD0w7Wg8qzTCvQUL218Dz9EV90uU1uiOq03z+Xe/V6mFrTgQ
         exJvddqFVxX5PreCVlsabexdaIOITV7xaWXQ3fSaqwBYgMVLzYYViBMxffY4z0n3XqZz
         7AREDVE9likWyTciPdodbjeDgmdGbtXArk91tGO6qtkBVgcm9GD6We84bTuheWcYRONl
         Xisg==
X-Received: by 10.181.13.137 with SMTP id ey9mr20015713wid.57.1405002650475;
 Thu, 10 Jul 2014 07:30:50 -0700 (PDT)
Received: by 10.194.136.46 with HTTP; Thu, 10 Jul 2014 07:30:50 -0700 (PDT)
In-Reply-To: <xmqqtx6r8uem.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253187>

On Tue, Jul 8, 2014 at 4:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Fabian Ruch <bafain@gmail.com> writes:
>> It is true that a failed hook script might not output any diagnosis...
>
> I think the message originally came from 0becb3e4 (rebase -i:
> interrupt rebase when "commit --amend" failed during "reword",
> 2011-11-30); it seems that the primary point of the change was to
> make sure it exits and the warning message may not have been well
> thought out, but before discarding the result of somebody else's
> work, it may not be a bad idea to ask just in case you may have
> overlooked something (Andrew Wong Cc'ed).
>
>
>
>
>
>> but then the generic message is not of much help either. Since this
>> lack of information affects the built-in git commands for commit,
>> merge and cherry-pick first, the solution would be to keep track of
>> the failed hooks in their output so that the user knows which of her
>> hooks require improvement.

Since "git commit" already prints out error messages for failing due
to empty commit message, the third message is really about giving
hints in the case where pre-commit fails. We could probably assume
that pre-commit would also print out error messages. So I'd be fine
with removing the third message. But I wonder if we need to explain
that the user needs to run "git rebase --continue" to resume the
rebase?
