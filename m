From: Stephen Leake <stephen_leake@stephe-leake.org>
Subject: Re: `git stash pop` UX Problem
Date: Tue, 25 Feb 2014 14:52:42 -0600
Message-ID: <85mwhe52zp.fsf@stephe-leake.org>
References: <530B0395.5030407@booking.com>
	<CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>
	<530C953F.9050805@booking.com> <vpqlhwz5o58.fsf@anie.imag.fr>
	<530CA4C9.60601@booking.com> <vpqeh2r43kx.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 25 21:52:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIOzh-0005Uz-TS
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 21:52:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbaBYUwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 15:52:46 -0500
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:5115 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750712AbaBYUwp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Feb 2014 15:52:45 -0500
Received: from [75.87.81.6] ([75.87.81.6:50485] helo=TAKVER)
	by cdptpa-oedge03 (envelope-from <stephen_leake@stephe-leake.org>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id 57/E5-02678-C920D035; Tue, 25 Feb 2014 20:52:44 +0000
In-Reply-To: <vpqeh2r43kx.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	25 Feb 2014 16:25:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (windows-nt)
X-RR-Connecting-IP: 107.14.168.142:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242682>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Omar Othman <omar.othman@booking.com> writes:
>
>> [omar_othman main (trunk|MERGING*)]$ git add path/to/file.txt
>> [omar_othman main (trunk*)]$
>>
>> Note how the status message has changed to show that git is now happy.
>> It is at that moment that the stash reference should be dropped
>
> Dropping the stash on a "git add" operation would be really, really
> weird...

Why? That is when the merge conflicts are resolved, which is what
logically indicates that the stash is no longer needed, _if_ the merge
conflicts are related to the stash, which is true in this use case.

There are other uses for 'git add' that don't indicate that; we'd have
to be very careful to not throw away the stash at the wrong time.

>> (or the user (somehow) is notified to do that herself if desired),
>> because this means that the popping operation has succeeded.
>
> But how would you expect to "be notified"?

When 'git add' checks to see if all merge conflicts are now resolved,
and those merge conflicts were related to the stash, it can either pop
the stash, or issue a message telling the user it is now safe to do so.
We would need a config setting to indicate which to do.

Maybe that check is hard to do in general?

-- 
-- Stephe
