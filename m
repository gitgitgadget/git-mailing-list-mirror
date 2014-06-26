From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Thu, 26 Jun 2014 18:27:10 +0200
Message-ID: <vpqy4wjmyap.fsf@anie.imag.fr>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>
	<1403518300-23053-3-git-send-email-tanayabh@gmail.com>
	<xmqqwqc79q1p.fsf@gitster.dls.corp.google.com>
	<53A96D2D.1020102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 18:28:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0CWs-0005Rp-3l
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 18:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755660AbaFZQ2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 12:28:01 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53872 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753211AbaFZQ2A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 12:28:00 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s5QGR8Xe023194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 26 Jun 2014 18:27:08 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s5QGRAsr014640;
	Thu, 26 Jun 2014 18:27:10 +0200
In-Reply-To: <53A96D2D.1020102@gmail.com> (Tanay Abhra's message of "Tue, 24
	Jun 2014 17:51:01 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 26 Jun 2014 18:27:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s5QGR8Xe023194
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1404404829.18136@WmKO6qqMjkDxCkYRXWvP9Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252505>

Tanay Abhra <tanayabh@gmail.com> writes:

> For the config_cache_free(), would this change be enough?
>
> +static void config_cache_free(void)
> +{
> +	struct hashmap *config_cache;
> +	struct config_cache_entry *entry;
> +	struct hashmap_iter iter;
> +	if (!hashmap_initialized)
> +		return;
> +	config_cache = get_config_cache();

That sounds better to me. And it justifies the different scopes: one can
ask whether the map is initialized from anywhere in the file, but can
only get the map after initialization, so it prevents mis-use of an
uninitialized pointer.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
