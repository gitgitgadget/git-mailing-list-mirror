From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/4] bisect: simplify the add of new bisect terms
Date: Wed, 10 Jun 2015 18:30:21 +0200
Message-ID: <vpq4mmfv84i.fsf@anie.imag.fr>
References: <1433794930-5158-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433794930-5158-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<xmqqvbey7wzp.fsf@gitster.dls.corp.google.com>
	<2139695602.323234.1433873829922.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 10 18:30:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2itd-0002A0-6y
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 18:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965855AbbFJQa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 12:30:29 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34678 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965184AbbFJQa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 12:30:26 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5AGUI3C032381
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Jun 2015 18:30:19 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5AGULNf026033;
	Wed, 10 Jun 2015 18:30:21 +0200
In-Reply-To: <2139695602.323234.1433873829922.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Antoine Delaite's message of "Tue, 9 Jun 2015 20:17:09 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 10 Jun 2015 18:30:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5AGUI3C032381
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434558619.59259@6SWTZrP8Xh7OV4KQ06pdsQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271325>

Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr> writes:

>>> +get_terms () {
>>> +        if test -s "$GIT_DIR/BISECT_TERMS"
>>> +        then
>>> +                NAME_BAD="$(sed -n 1p "$GIT_DIR/BISECT_TERMS")"
>>> +                NAME_GOOD="$(sed -n 2p "$GIT_DIR/BISECT_TERMS")"
>>
>>It is sad that we need to open the file twice.  Can't we do
>>something using "read" perhaps?
>
> The cost of it is quite low and we see directly what we meant. We didn't 
> found a pretty way to read two lines with read.

Should be stg like:

{
	read good
	read bad
} <"$GIT_DIR/BISECT_TERMS"

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
