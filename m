From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Give better 'pull' advice when pushing non-ff updates to current branch
Date: Tue, 24 Apr 2012 09:04:07 +0200
Message-ID: <vpqipgpehlk.fsf@bauges.imag.fr>
References: <1335221121-36664-1-git-send-email-christiwald@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net
To: Christopher Tiwald <christiwald@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 09:04:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMZnV-0003Fc-Kc
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 09:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754357Ab2DXHEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 03:04:21 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49852 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751939Ab2DXHEU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 03:04:20 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q3O6vd69010929
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 24 Apr 2012 08:57:40 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SMZnE-0006VP-J1; Tue, 24 Apr 2012 09:04:08 +0200
In-Reply-To: <1335221121-36664-1-git-send-email-christiwald@gmail.com>
	(Christopher Tiwald's message of "Mon, 23 Apr 2012 18:45:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 24 Apr 2012 08:57:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3O6vd69010929
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1335855463.67542@jgmmYlpyykKAR0EEjcbUaA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196192>

Christopher Tiwald <christiwald@gmail.com> writes:

> +		/* Branches configured for octopus merges should advise
> +		 * just 'git pull' */

Style: Git usually writes these comments 

/*
 * like this
 */

> +		if (branch->remote_name &&
> +		    branch->merge &&
> +		    branch->merge_nr == 1 &&
> +		    !strcmp(transport->remote->name, branch->remote_name) &&
> +		    !strcmp(strbuf_detach(&buf, NULL),
> +			    prettify_refname(branch->merge[0]->dst))) {
> +			advise_tracked_pull_before_push();
> +		}
> +		else
> +			advise_untracked_pull_before_push();

Isn't this doing the opposite of what the comment is saying about
octopus merge, i.e. if branch->merge_nr > 1, call
advise_untracked_pull_before_push() which will advise 'git pull <remote>
<branch>'?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
