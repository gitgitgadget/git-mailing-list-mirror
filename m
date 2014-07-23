From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/7] rewrite git_config() to use the config-set API
Date: Wed, 23 Jul 2014 21:58:49 +0200
Message-ID: <vpqwqb3u9s6.fsf@anie.imag.fr>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<1406140978-9472-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:59:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA2gk-00026e-BA
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 21:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933314AbaGWT6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 15:58:54 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60838 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932873AbaGWT6y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 15:58:54 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6NJwlNV006721
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Jul 2014 21:58:47 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6NJwnpM026364;
	Wed, 23 Jul 2014 21:58:49 +0200
In-Reply-To: <1406140978-9472-3-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Wed, 23 Jul 2014 11:42:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 23 Jul 2014 21:58:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6NJwlNV006721
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406750328.86399@CcPcZ+c9eT4BjMqDulLn7Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254117>

Tanay Abhra <tanayabh@gmail.com> writes:

> +static int configset_iter(struct config_set *cs, config_fn_t fn, void *data)
> +{
> +	int i;
> +	struct string_list *strptr;
> +	struct config_set_element *entry;
> +	struct hashmap_iter iter;
> +	hashmap_iter_init(&cs->config_hash, &iter);
> +	while ((entry = hashmap_iter_next(&iter))) {
> +		strptr = &entry->value_list;
> +		for (i = 0; i < strptr->nr; i++) {
> +			if (fn(entry->key, strptr->items[i].string, data) < 0)
> +				die("bad config file line in (TODO: file/line info)");

One more reason to reorder (but that will actually be slightly more than
"rebase -i", you'll have a few conflicts to fix) is to avoid this TODO.
Put the patch after the line number patch and you'll be able to provide
the right information directly.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
