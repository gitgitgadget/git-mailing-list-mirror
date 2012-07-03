From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 03/18] sha1_name.c: get rid of ugly get_sha1_with_mode_1()
Date: Tue, 03 Jul 2012 10:01:14 +0200
Message-ID: <vpqsjd9nuid.fsf@bauges.imag.fr>
References: <1341268449-27801-1-git-send-email-gitster@pobox.com>
	<1341268449-27801-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 10:01:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sly3L-0005Wo-40
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 10:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202Ab2GCIBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 04:01:34 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33303 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030198Ab2GCIBV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 04:01:21 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q6380CWZ021082
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 3 Jul 2012 10:00:12 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sly2t-0008HQ-6r; Tue, 03 Jul 2012 10:01:15 +0200
In-Reply-To: <1341268449-27801-4-git-send-email-gitster@pobox.com> (Junio C.
	Hamano's message of "Mon, 2 Jul 2012 15:33:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 03 Jul 2012 10:00:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6380CWZ021082
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1341907213.84716@9YZCHvzkfSNPrpE+rFuyTw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200907>

Junio C Hamano <gitster@pobox.com> writes:

> +/*
> + * Call this function when you know "name" given by the end user must
> + * name an object but it doesn't; the function _may_ die with a better
> + * diagnostic message than "no such object 'name'", e.g. "Path 'doc' does not
> + * exist in 'HEAD'" when given "HEAD:doc", or it may return in which case
> + * you have a chance to diagnose the error further.
> + */
> +void die_on_misspelt_object_name(const char *name, const char *prefix)

It seems unusual to have a function named die_* that is not a noreturn
function. I'd call it die_*_maybe, or diagnose_* instead.

(but as the comment above documents the behavior, it's not terribly
important, you may ignore my comment if you whish)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
