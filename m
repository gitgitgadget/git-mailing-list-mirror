From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Tue, 2 Oct 2012 21:34:56 +0200
Message-ID: <CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 21:35:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ8FJ-00016z-Kd
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 21:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144Ab2JBTe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 15:34:58 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:54583 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754029Ab2JBTe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 15:34:57 -0400
Received: by vbbff1 with SMTP id ff1so7010640vbb.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 12:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=p69IJOMsFiyxvwWiAr2K2jdosROS7RveB/vbBVnhf20=;
        b=DSI/rE3jzd8dCOI7CZdvELJUMQJRLfJYE9THeHAFBBs9RmwDOT8N6cJaorkDH6JNYP
         XsPAUPQGjSWqmXYvhf4PIDmNEXuL9O7xRAFKkfpL0Mf8us24MXQi+c4AA9Q8/k0v2ZKV
         NpRY1K89MGnYK2HcQkb+irQF1304tYzeTN3mNxgT0M6is3NJqpiwcA7f26QbEugppGvT
         TGrV9DeG5ImEIk+RZi/4cx1Hhyf/bgjPMYBS4WSgoieYCcqa7E2loyaeByTsgjuE9dBd
         j2ltT0nMXJbXe7dwmwlbdiTg0lr1z8+AoMRJP3PAqogwfyGUScBq4FfPsA3GratjNnuT
         adAw==
Received: by 10.52.72.164 with SMTP id e4mr8696082vdv.103.1349206496422; Tue,
 02 Oct 2012 12:34:56 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Tue, 2 Oct 2012 12:34:56 -0700 (PDT)
In-Reply-To: <7vzk449449.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206838>

Hi Junio,

if I put on my head the implementor's hat, I would agree with you: that command
after all behaves as implemented.
However, if I put the user's hat I would reason differently. What I
need are predictable
commands, and that by all means is not. This because the time at which a command
is executed is not predictable (more precisely, the statement in it
that reads the system
calendar). So, even if an implementor thinks that this behavior is
reliable, a user
thinks that it is not predictable. Actually, I called that command
from within a script,
and thus I could not count on it being executed within 1 second from
the last commit.
Read also the paragraph in the man page that describes it:

"Usually recording a commit that has the exact same tree as its sole
parent commit is a mistake, and the command prevents you from making
such a commit. This option bypasses the safety, and is primarily for
use by foreign SCM interface scripts."

I cannot find any clue in it that lets me know that is does not create
a commit if the time is
within the same second as the other commit.

My suggestion is either to include a sleep in the command so as to
guarantee that a commit
is created, or to remove the option.

-Angelo
