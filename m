From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 01/10] ref-filter: introduce 'ref_formatting_state'
Date: Thu, 30 Jul 2015 11:25:44 +0200
Message-ID: <vpqsi86atev.fsf@anie.imag.fr>
References: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
	<1438065211-3777-1-git-send-email-Karthik.188@gmail.com>
	<CAPig+cS+w8ECma--ncJDoN1fEgrFZMvBC8GBgU6+tLYm_oGkaw@mail.gmail.com>
	<xmqqfv4691ui.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	"christian.couder\@gmail.com" <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 11:27:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKk7Z-00056W-3D
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 11:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179AbbG3J1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 05:27:21 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40317 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754606AbbG3J1U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 05:27:20 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6U9Phwf018428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 30 Jul 2015 11:25:43 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6U9Pi3R031783;
	Thu, 30 Jul 2015 11:25:44 +0200
In-Reply-To: <xmqqfv4691ui.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 29 Jul 2015 12:54:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 30 Jul 2015 11:25:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6U9Phwf018428
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438853146.30112@WrbqNkcOXjvYR4wochEtNA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274976>

Junio C Hamano <gitster@pobox.com> writes:

> If the act of printing an atom uses the formatting state that says
> "next one needs X", then it is responsible to clear that "next one
> needs X" part of the state, as it is the one who consumed that
> state.  E.g. if it used to say "next one needs to be padded to the
> right" before entering print_value(), then the function did that
> "padded output", then the "next one needs to be padded to the
> right" should be cleared inside print_value().

Good point. This would also reduce the risk of forgetting to reset, as
"use" and "reset" would be next to each other in the code.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
