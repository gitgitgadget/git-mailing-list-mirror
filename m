From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 4/4] t/t8006: test textconv support for blame
Date: Fri, 04 Jun 2010 10:49:41 +0200
Message-ID: <vpq1vcnqj16.fsf@bauges.imag.fr>
References: <1275562038-7468-1-git-send-email-axel.bonnet@ensimag.imag.fr>
	<1275562038-7468-2-git-send-email-axel.bonnet@ensimag.imag.fr>
	<1275562038-7468-3-git-send-email-axel.bonnet@ensimag.imag.fr>
	<1275562038-7468-4-git-send-email-axel.bonnet@ensimag.imag.fr>
	<1275562038-7468-5-git-send-email-axel.bonnet@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>
To: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 04 10:49:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKSb7-0003x6-Tx
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 10:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366Ab0FDIto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 04:49:44 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43504 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753504Ab0FDItn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 04:49:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o548gD17021736
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 4 Jun 2010 10:42:13 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OKSb0-0005R4-2W; Fri, 04 Jun 2010 10:49:42 +0200
In-Reply-To: <1275562038-7468-5-git-send-email-axel.bonnet@ensimag.imag.fr> (Axel Bonnet's message of "Thu\,  3 Jun 2010 12\:47\:18 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 04 Jun 2010 10:42:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o548gD17021736
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148387>

Axel Bonnet <axel.bonnet@ensimag.imag.fr> writes:

> +test_expect_success 'blame with --no-textconv' '
> +	git blame --no-textconv one.bin | grep Number2 >blame
> +	find_blame <blame >result
> +	test_cmp expected result
> +'

Don't you want to add && at each end of line, to make sure you catch
potential failures of git blame on the first line (e.g. git blame
producing the correct output and then segfaulting for example)?

Actually, to really catch such failures, you should not run git on the
left hand side of a | (otherwise, you look for failures of the right
hand side), and do this instead:

test_expect_success 'no filter specified' '
	git blame one.bin >to-grep &&
	grep Number2 to-grep >blame &&
	find_blame <blame >result &&
	test_cmp expected result
'

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
