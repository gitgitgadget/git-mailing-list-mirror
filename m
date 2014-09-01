From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Trailing whitespace on git diff output.
Date: Mon, 01 Sep 2014 20:10:09 +0200
Message-ID: <vpq1trv9pq6.fsf@anie.imag.fr>
References: <20140901174709.GA23397@vimeitor>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Adria Farres <14farresa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 20:10:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOW3c-0002B4-9X
	for gcvg-git-2@plane.gmane.org; Mon, 01 Sep 2014 20:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710AbaIASKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2014 14:10:17 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35658 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754686AbaIASKP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2014 14:10:15 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s81IA7QE011080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 1 Sep 2014 20:10:07 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s81IA9YX030261;
	Mon, 1 Sep 2014 20:10:09 +0200
In-Reply-To: <20140901174709.GA23397@vimeitor> (Adria Farres's message of
	"Mon, 1 Sep 2014 19:47:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 01 Sep 2014 20:10:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s81IA7QE011080
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1410199809.66763@XLTtQbkas0qrfEHjBEiPqQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256309>

Adria Farres <14farresa@gmail.com> writes:

> Hello,
>
> Today, while redirecting git diff's output to a text file, I noticed git diff
> leaves a trailing whitespace between different deltas of the same file (the line
> that separates two different deltas). For example, committing a file with the
> following content:
> ---
> test
>
> test
> ---
>
> then changing it to the following:
> ---
> test
> test
>
> test
> test
> ---
>
> committing and diffing it, leaves a trailing whitespace on line 8 of the
> diff output.

That is (I replaced spaces with _):

--- a/test.txt
+++ b/test.txt
@@ -1,3 +1,5 @@
_test
+test
_
_test
+test

GNU diff does the same, and that is what I would expect: the first
column is left for + and -, and spaces are used as a prefix for the
context.

If you diff

test
x
test

and

test
test
x
test
test

you'd expect a space before the 'x' in the diff output. In your example,
there's a space before the empty string, which has the same role as the
'x' above.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
