From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] config: fix several access(NULL) calls
Date: Mon, 16 Jul 2012 11:45:21 +0200
Message-ID: <vpqmx3011la.fsf@bauges.imag.fr>
References: <877gu9wh05.fsf@thomas.inf.ethz.ch>
	<1342094660-3052-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vtxxcc36v.fsf@alter.siamese.dyndns.org>
	<vpq1ukgai4e.fsf@bauges.imag.fr>
	<7vwr28agcq.fsf@alter.siamese.dyndns.org>
	<vpq1ukg82st.fsf@bauges.imag.fr>
	<20120713130021.GA2553@sigill.intra.peff.net>
	<vpqliin6bva.fsf@bauges.imag.fr> <87hatboiwr.fsf@thomas.inf.ethz.ch>
	<vpq1ukf68ow.fsf@bauges.imag.fr>
	<7vy5mn8v2k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 11:45:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqhsB-0008Qy-PF
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 11:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766Ab2GPJpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 05:45:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35870 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271Ab2GPJpl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 05:45:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q6G9hYS6023117
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2012 11:43:34 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sqhrm-0000Pi-4P; Mon, 16 Jul 2012 11:45:22 +0200
In-Reply-To: <7vy5mn8v2k.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 13 Jul 2012 09:49:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 16 Jul 2012 11:43:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6G9hYS6023117
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1343036617.65945@6qtwt/9/KjeL53C0fKIPvQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201497>

Junio C Hamano <gitster@pobox.com> writes:

> 	if (use_global_config) {
>                 if (is $HOME/.gitconfig usable?) {
> 			use it;

Yes, but when $HOME is unset, the question doesn't really make sense.
Maybe the file exists, but we can't know since the user broke his
configuration by unsetting $HOME. The intent was to avoid writing to the
XDG file unless it was very clear that the user wanted it, so in doubt,
dying seems the best option.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
