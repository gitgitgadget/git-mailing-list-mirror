From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 7/7] bisect: allows any terms set by user
Date: Thu, 11 Jun 2015 11:22:52 +0200
Message-ID: <vpqoakmoaz7.fsf@anie.imag.fr>
References: <1433962918-6536-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433962918-6536-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<xmqqk2vbi7rf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr, chriscool@tuxfamily.org,
	thomasxnguy@gmail.com, valentinduperray@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 11:23:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2yhZ-0002jW-2t
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 11:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331AbbFKJXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 05:23:05 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37799 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752207AbbFKJXB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 05:23:01 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5B9MpST016663
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 11 Jun 2015 11:22:51 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5B9MqVJ005826;
	Thu, 11 Jun 2015 11:22:52 +0200
In-Reply-To: <xmqqk2vbi7rf.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 10 Jun 2015 14:16:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 11 Jun 2015 11:22:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5B9MpST016663
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434619372.22855@w40AOe0TdcYGKembMYdK+g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271378>

Junio C Hamano <gitster@pobox.com> writes:

> Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr> writes:
>
>> -USAGE='[help|start|bad|good|new|old|skip|next|reset|visualize|replay|log|run]'
>> +USAGE='[help|start|bad|good|new|old|terms|skip|next|reset|visualize|replay|log|run]'
>
> I think this patch makes the whole series go in the right direction.
>
> I wonder if you can skip the "we only support new/old if you are not
> doing bog-standard bad/good" step and start from this "bisect terms"
> one, though.

While I think we should not hardcode too much in the code, I also think
it makes sense to have hardcoded old/new in the user-interface. If you
give me just

  git bisect terms <first-term> <second-term>

then half of the times, I'll use old/new in the wrong order. And if I
hadn't looked to bisect close enough, I'd even complain that the terms
are not usable interchangeably.

At least, a in a flow like

  git bisect start
  git bisect new
  git checkout <old-sha>
  git bisect old

there's no ambiguity.

So, to me, having both hardcoded old/new (unambiguous) and "git bisect
terms" (for flexibility) makes sense.

Another important parameter: the students are finishing their project
tomorrow. They may continue on their personnal free time, but at best
their time budget is considerably reduced, and from my past experience,
the time budget usually reaches 0. That's not a reason to merge bad code
in git.git, but an incentive to close the series with something going in
the right direction. Typically:

>  - preliminary clean-up steps (e.g. "correct 'mistook'");

This is straightforward

>  - use $name_new and $name_old throughout the code, giving them
>    'bad' and 'good' as hardcoded values; finally

This is relatively uncontroversial, and should be easy to finish. I
would consider it a good thing anyway.

>  - add 'bisect terms' support.

I'd put this on the low-priority whishlist. If the codebase is ready and
a preliminary patch exists, it will be relatively easy for someone else
to finish the job.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
