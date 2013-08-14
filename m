From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] repack: rewrite the shell script in C.
Date: Wed, 14 Aug 2013 09:26:37 +0200
Message-ID: <vpqy584n36a.fsf@anie.imag.fr>
References: <1376421797-26443-1-git-send-email-stefanbeller@googlemail.com>
	<1376421797-26443-2-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, iveqy@iveqy.com,
	gitster@pobox.com, apelisse@gmail.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 09:26:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9VTl-0006qT-1E
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 09:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757886Ab3HNH0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 03:26:45 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47863 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754696Ab3HNH0o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 03:26:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r7E7QbIu009484
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 14 Aug 2013 09:26:37 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V9VTa-0006kA-1F; Wed, 14 Aug 2013 09:26:38 +0200
In-Reply-To: <1376421797-26443-2-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Tue, 13 Aug 2013 21:23:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 14 Aug 2013 09:26:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7E7QbIu009484
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1377069998.31825@K0v+Ts82cYhoGwCA8cvrig
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232267>

Stefan Beller <stefanbeller@googlemail.com> writes:

> This is the beginning of the rewrite of the repacking.

(please, mark your patch as RFC/PATCH in the subject in this case)

A few quick comments on style below.

>  Makefile                       |   2 +-
>  builtin.h                      |   1 +
>  builtin/repack.c               | 313 +++++++++++++++++++++++++++++++++++++++++
>  contrib/examples/git-repack.sh | 194 +++++++++++++++++++++++++
>  git-repack.sh                  | 194 -------------------------
>  git.c                          |   1 +

I suggested that you first enrich the test suite if needed. Did you
check that the testsuite had good enough coverage for git-repack?

> +static const char * const git_repack_usage[] = {

Style: no space after *.

> +static int delta_base_offset = 1; // enabled by default since 22c79eab (2008-06-25)

No // comments please (they're C99, not portable C90).

> +int cmd_repack(int argc, const char **argv, const char *prefix) {

Brace on the next line.

> +	fname = xmalloc(strlen(packdir) + 47); // 40 chars for the sha1

> +	fname_old = xmalloc(strlen(packdir) + 52); // 40 chars for the sha1

I'd rather have "40 + strlen("whatever")" explicitly.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
