From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] config.c: change the function signature of `git_config_string()`
Date: Tue, 22 Jul 2014 18:03:07 +0200
Message-ID: <vpqsiltfkjo.fsf@anie.imag.fr>
References: <1406026196-17877-1-git-send-email-tanayabh@gmail.com>
	<20140722110720.GA386@peff.net> <vpqsiltsjm7.fsf@anie.imag.fr>
	<xmqqoawhgzky.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Tanay Abhra <tanayabh@gmail.com>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 18:03:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9cXG-0004Nu-Lv
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 18:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785AbaGVQDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 12:03:22 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46443 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205AbaGVQDW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 12:03:22 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6MG35Vq021989
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 22 Jul 2014 18:03:05 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6MG37Ko010526;
	Tue, 22 Jul 2014 18:03:07 +0200
In-Reply-To: <xmqqoawhgzky.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 22 Jul 2014 08:53:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 22 Jul 2014 18:03:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6MG35Vq021989
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406649787.34803@fvAhXwA/I7tduQHOUYRFVg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254018>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> OK, it seems I got convinced too quickly by Junio ;-). The function
>> produces a char * that can be modified, but it also receives a value,
>> and the function should keep the "const" to allow passing "const char
>> *".
>
> Don't blame me. I never suggested to touch that existing function,
> with existing call sites.

I don't understand what you mean. The new git_config_get_string()
function is meant to be used in essentially every places where
git_config_string() is currently used, so removing the const from
git_config_get_string() raises the same issue as changing the existing
function.

Dropping the const means we won't be able to write

const char *v = "default";
...
git_config_get_string(&v, ...);

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
