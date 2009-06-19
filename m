From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t8005: Nobody writes Russian in shift_jis
Date: Fri, 19 Jun 2009 09:54:56 -0500
Message-ID: <dfYgk9RFOucTCHxtLQsMXejAeKlGJg-R15sTW_RFemcrjsjqoYD0eg@cipher.nrlssc.navy.mil>
References: <7vmy85m0ea.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Alexander Gavrilov <angavrilov@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 16:55:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHfUl-0002Mg-6J
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 16:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbZFSOzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 10:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbZFSOy7
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 10:54:59 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:42373 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbZFSOy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 10:54:58 -0400
Received: by mail.nrlssc.navy.mil id n5JEsvei016625; Fri, 19 Jun 2009 09:54:57 -0500
In-Reply-To: <7vmy85m0ea.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 19 Jun 2009 14:54:57.0587 (UTC) FILETIME=[E9B88830:01C9F0ED]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121900>

Junio C Hamano wrote:
> The second and third tests of this script expected that Russian strings
> are converted between ISO-8859-5 and Shift_JIS in the "blame --porcelain"
> format output correctly.
> 
> Sure, many platforms may convert between such a combination, but that is
> only because one of the base character set of Shift_JIS, JIS X 0208,
> defines codepoints for Russian characters (among others); I do not think
> anybody uses Shift_JIS when seriously writing Russian, and it is perfectly
> understandable if iconv() libraries on some platforms fail converting
> between this combination, as it does not matter in reality.
> 
> This patch changes the test to verify Japanese strings are converted
> correctly between EUC-JP and Shift_JIS in the same procedure.  The point
> of the test is not about verifying the platform's iconv() library, but to
> see if "git blame" makes correct iconv() library calls when it should.
> 
> We could instead use ISO-8859-5 and KOI8-R as the combination, because
> they are both meant to represent Russian, in order to make this test
> meaningful on more platforms, but we already use Shift_JIS vs EUC-JP
> combinations to test other programs in our test suite, so this combination
> is safer from the point of view of the portability.  Besides, I do not
> read nor write Russian; sorry ;-)
> 
> This change allows tests to pass on my (friend's) Solaris 5.11 box.

No change on my systems.  I can convert eucJP and SJIS from/to UTF-8, but
I cannot convert between eucJP and SJIS.  So tests 2 and 3 still fail for
me.  Nothing was broken though.  The fourth test still passes which converts
each of the encodings to UTF-8.  So this patch is fine with me.

-brandon
