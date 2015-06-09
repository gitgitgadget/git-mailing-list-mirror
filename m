From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [WIP/PATCH v5 05/10] for-each-ref: introduce 'ref_array_clear()'
Date: Tue, 09 Jun 2015 08:31:15 +0200
Message-ID: <vpq1thlmlzg.fsf@anie.imag.fr>
References: <55729B78.1070207@gmail.com>
	<1433574581-23980-1-git-send-email-karthik.188@gmail.com>
	<1433574581-23980-5-git-send-email-karthik.188@gmail.com>
	<vpqvbey6yli.fsf@anie.imag.fr> <5575B25A.6020608@gmail.com>
	<vpqbngq2mkw.fsf@anie.imag.fr>
	<xmqq3822cer4.fsf@gitster.dls.corp.google.com>
	<vpqa8wat8u9.fsf@anie.imag.fr> <5575F8CB.8080009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 08:31:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2D4J-0002Qo-L0
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 08:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616AbbFIGbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 02:31:23 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37462 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751344AbbFIGbV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 02:31:21 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t596VE6R027265
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 9 Jun 2015 08:31:14 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t596VFci017233;
	Tue, 9 Jun 2015 08:31:15 +0200
In-Reply-To: <5575F8CB.8080009@gmail.com> (Karthik Nayak's message of "Tue, 09
	Jun 2015 01:49:23 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 09 Jun 2015 08:31:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t596VE6R027265
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434436275.60296@sntcWGJ2CF/bvPyL5iOmLQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271146>

Karthik Nayak <karthik.188@gmail.com> writes:

> On 06/08/2015 10:51 PM, Matthieu Moy wrote:

>> We could introduce ref-filter.h earlier, indeed. To me, the current
>> solution is good enough, but introducing ref-filter.h early and adding
>> function definition there in the same commit as you drop the "static"
>> keyword for them would clearly be an improvement.
>
> But that would break the flow, wouldn't it? I wanted ref-filter to be
> introduced together, hence right after ref-filter.h we move code to
> ref-filter.c

That's why I find the current solution good enough: it also has
advantages. But in the current series, when you say "make functions
public", you are not actually doing so since they're not exported in a
.h file.

Conversely, PATCH 07 does two things: move code from for-each-ref.c and
introduce new declarations. Had you introduced these declarations
earlier, this patch would have been pure code movement.

In both cases, you have intermediate states that are not fully
consistant: either you have public functions in the builtin/ directory
(which sometimes happen in Git's codebase, but we try to avoid it), or
you have non-static functions that are not declared in a .h.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
