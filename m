From: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] upload-pack.c: use of parse-options API
Date: Thu, 19 May 2016 18:10:20 +0200 (CEST)
Message-ID: <431335092.10912437.1463674220365.JavaMail.zimbra@imag.fr>
References: <20160518164019.26443-1-Antoine.Queru@ensimag.grenoble-inp.fr> <20160519153903.22104-1-Antoine.Queru@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	william duclot <william.duclot@ensimag.grenoble-inp.fr>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Antoine Queru <Antoine.Queru@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 19 18:10:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3QX1-0000lR-8S
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 18:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbcESQKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 12:10:30 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53574 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932617AbcESQKa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 12:10:30 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u4JGAIZG018228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 19 May 2016 18:10:18 +0200
Received: from z8-mb-verimag.imag.fr (z8-mb-verimag.imag.fr [129.88.4.38])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4JGAK9J002276;
	Thu, 19 May 2016 18:10:20 +0200
In-Reply-To: <20160519153903.22104-1-Antoine.Queru@ensimag.grenoble-inp.fr>
X-Originating-IP: [129.88.6.115]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF46 (Linux)/8.0.9_GA_6191)
Thread-Topic: upload-pack.c: use of parse-options API
Thread-Index: yI6zO+bb0O9ju5GSOrl821ZLWNH3lQ==
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Thu, 19 May 2016 18:10:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4JGAIZG018228
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1464279022.11306@USV/UTJY9cGNTPxZcwRM0A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295072>

Antoine.Queru@ensimag.grenoble-inp.fr wrote:
> Option parsing now uses the parser API instead of a local parser.
> Code is now more compact.
> Description for -stateless-rpc and --advertise-refs
> come from the commit (gmane/131517)

Please, use a real commit id instead of a Gmane link.

We don't know how long Gmane will remain up, but a self
reference from Git's history to itself will always remain valid.

The following alias is handy for this:

[alias]
        whatis = show -s --pretty='tformat:%h (%s, %ad)' --date=short

In your case it would allow writing: 

Description for --stateless-rpc and --advertise-refs is taken
from commit 42526b4 (Add stateless RPC options to upload-pack,
receive-pack, 2009-10-30).

> diff v1 v2:

We usually say "diff" to refer to an actual diff. I'd write "changes since v1" here.

> +		OPT_BOOL(0, "stateless-rpc", &stateless_rpc,
> +			 N_("may perform only a single read-write cycle with stdin and stdout")),

It's weird to define what an option does with "may". It's a
property of --stateless-rpc, but does not really define it.

> +	if (argc != 1)
> +		usage_with_options(upload_pack_usage, options);
>  
> -	setup_path();
> +	if (timeout)
> +		daemon_mode = 1;
>  
> -	dir = argv[i];
> +	setup_path();
>  
> +	dir = argv[0];

Not a problem with your code, but the patch shows "setup_path()"
as moved while it is not really. Maybe using "send-email
--patience" or some other diff option could make the patch nicer.
Not really important as it does not change the final state.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
