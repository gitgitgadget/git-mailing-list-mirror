From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v12 01/13] ref-filter: move `struct atom_value` to ref-filter.c
Date: Wed, 19 Aug 2015 16:56:26 +0200
Message-ID: <vpqy4h72up1.fsf@anie.imag.fr>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
	<1439923052-7373-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 16:56:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS4n7-0004om-7Z
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 16:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbbHSO4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 10:56:32 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52410 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932096AbbHSO4c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 10:56:32 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t7JEuO2h003042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 19 Aug 2015 16:56:24 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7JEuQ11020687;
	Wed, 19 Aug 2015 16:56:26 +0200
In-Reply-To: <1439923052-7373-2-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Wed, 19 Aug 2015 00:07:20 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 19 Aug 2015 16:56:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7JEuO2h003042
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1440600985.71462@ysFXlLmj/LLOw0wq34/I3A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276180>

Karthik Nayak <karthik.188@gmail.com> writes:

> +static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state **state)
> +{
> +	struct ref_formatting_state *current = *state;
> +	if (!current->at_end)
> +		die(_("format: `end` atom used without a supporting atom"));

You error out on %(end) without %(align), but not on %(align) without
%(end).

You should probably check that the stack is empty at the end and error
out otherwise.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
