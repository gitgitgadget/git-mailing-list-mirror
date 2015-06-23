From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 3/5] bisect: simplify the addition of new bisect terms
Date: Tue, 23 Jun 2015 20:18:40 +0200
Message-ID: <vpqsi9ixp8f.fsf@anie.imag.fr>
References: <1435006836-18182-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435064084-5554-4-git-send-email-Matthieu.Moy@imag.fr>
	<CAPig+cSzymZ+JEO8sPrayQ+XNag0kAry_9_eH4=kSqPp=JKk7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Nguy <thomasxnguy@gmail.com>,
	Valentin Duperray <valentinduperray@gmail.com>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 20:19:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7Smj-0006Ib-8x
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 20:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754956AbbFWSS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 14:18:58 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47625 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753817AbbFWSS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 14:18:56 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5NIIcra028157
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 23 Jun 2015 20:18:38 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5NIIe1O010192;
	Tue, 23 Jun 2015 20:18:40 +0200
In-Reply-To: <CAPig+cSzymZ+JEO8sPrayQ+XNag0kAry_9_eH4=kSqPp=JKk7w@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 23 Jun 2015 13:49:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 23 Jun 2015 20:18:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5NIIcra028157
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435688321.62837@N73OiGC9A1WLWMoFk3YHJA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272475>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Jun 23, 2015 at 8:54 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:

>> +       strbuf_addstr(&bisect_refs_buf, "refs/bisect/");
>> +       strbuf_addstr(&bisect_refs_buf, name_bad);
>
> A single strbuf_addf() rather than two strbuf_addstr()s?

>> +       bisect_refs_str = strbuf_detach(&bisect_refs_buf, NULL);
>> +       status = for_each_ref_in_submodule(submodule, bisect_refs_str, fn, cb_data);
>> +       free((char *)bisect_refs_str);
>
> Why the above rather than the simpler?
>
>     strbuf_addstr(&bisect_refs, ...);
>     status = for_each_ref_in_submodule(submodule, bisect_refs.buf, fn, cb_data);
>     strbuf_release(&bisect_refs);
>
> What am I missing?

Indeed, your version is much better.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
