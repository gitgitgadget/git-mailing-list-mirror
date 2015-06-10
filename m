From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/4] bisect: simplify the add of new bisect terms
Date: Wed, 10 Jun 2015 17:24:11 +0200
Message-ID: <vpq381zsi1w.fsf@anie.imag.fr>
References: <1433794930-5158-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433794930-5158-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<vpqbngpl5zu.fsf@anie.imag.fr>
	<550645264.367778.1433881052933.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<xmqq1thkwg5r.fsf@gitster.dls.corp.google.com>
	<1926405730.374352.1433920537226.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpqk2vcat2t.fsf@anie.imag.fr>
	<2070840481.381260.1433929304815.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, jch2355@gmail.com
To: Louis-Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 10 17:25:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2hsi-00060j-3k
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 17:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246AbbFJPZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 11:25:26 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33328 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933666AbbFJPYW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 11:24:22 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5AFO9xt020572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Jun 2015 17:24:09 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5AFOB86024817;
	Wed, 10 Jun 2015 17:24:11 +0200
In-Reply-To: <2070840481.381260.1433929304815.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Louis-Alexandre Stuber's message of "Wed, 10 Jun 2015 11:41:44 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 10 Jun 2015 17:24:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5AFO9xt020572
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434554653.66178@W0fp+7EqR+jDAslYtYNhSA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271305>

Louis-Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr> writes:

> But ENOENT is not a normal case at all. Should we not treat it the same
> way as other fopen() errors ? (either going on with default case or
> returning an error)
>
> Would :
>
>>	if (!fp) {
>>			die("could not read file '%s': %s",
>>				filename, strerror(errno));
>>	} else {
>
> be ok ?

That would be much better than what we had in the patch, which did not
look like an error at all:

+	FILE *fp = fopen(filename, "r");
+
+	if (!fp) {
+		name_bad = "bad";
+		name_good = "good";

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
