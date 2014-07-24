From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/7] rewrite git_config() to use the config-set API
Date: Thu, 24 Jul 2014 08:43:37 +0200
Message-ID: <vpqfvhrqmsm.fsf@anie.imag.fr>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<1406140978-9472-3-git-send-email-tanayabh@gmail.com>
	<xmqq7g33d9fe.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 08:43:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XACko-0003ER-Jy
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 08:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934120AbaGXGnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 02:43:46 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60577 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934045AbaGXGnq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 02:43:46 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6O6haw4028219
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 24 Jul 2014 08:43:36 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6O6hbhG030348;
	Thu, 24 Jul 2014 08:43:37 +0200
In-Reply-To: <xmqq7g33d9fe.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 23 Jul 2014 14:58:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 24 Jul 2014 08:43:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6O6haw4028219
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406789021.03057@uRNjSGbohICwMEFz13t5Vw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254150>

Junio C Hamano <gitster@pobox.com> writes:

>> +int git_config(config_fn_t fn, void *data)
>> +{
>> +	git_config_check_init();
>> +	return configset_iter(&the_config_set, fn, data);
>> +}
>
> Perhaps if you define this function at the right place in the file
> you do not have to add an forward decl of git_config_check_init()?

OTOH, having git_config right next to git_config_raw and configset_iter
is a good thing, and keeping git_config_raw where git_config used to be
seems logical.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
