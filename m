From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Implement a textconv filter for "git diff"
Date: Sun, 28 Sep 2008 12:00:44 +0200
Message-ID: <vpq8wtc1tf7.fsf@bauges.imag.fr>
References: <1222567618-22156-1-git-send-email-Matthieu.Moy@imag.fr>
	<1222567618-22156-2-git-send-email-Matthieu.Moy@imag.fr>
	<1222567618-22156-3-git-send-email-Matthieu.Moy@imag.fr>
	<1222567618-22156-4-git-send-email-Matthieu.Moy@imag.fr>
	<20080928041526.GB24214@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 28 12:04:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kjt8x-0006uy-QP
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 12:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbYI1KDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 06:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbYI1KDi
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 06:03:38 -0400
Received: from imag.imag.fr ([129.88.30.1]:41464 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751868AbYI1KDi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 06:03:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m8SA0isQ015677
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 28 Sep 2008 12:00:44 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Kjt52-00060l-5b; Sun, 28 Sep 2008 12:00:44 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Kjt52-0004we-39; Sun, 28 Sep 2008 12:00:44 +0200
In-Reply-To: <20080928041526.GB24214@coredump.intra.peff.net> (Jeff King's message of "Sun\, 28 Sep 2008 00\:15\:26 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 28 Sep 2008 12:00:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96956>

Jeff King <peff@peff.net> writes:

> On Sun, Sep 28, 2008 at 04:06:56AM +0200, Matthieu Moy wrote:
>
>> +static int textconv_two_files(const char *textconv,
>> +			      const char *name_a,
>> +			      const char *name_b,
>> +			      mmfile_t *mf1,
>> +			      mmfile_t *mf2,
>> +			      struct diff_filespec *one,
>> +			      struct diff_filespec *two)
>> +{
>
> Must we always be textconv'ing two files? What if I am comparing
> "v1.5:foo.odf" to "foo.txt" in the working tree?

Hmm, why not, and the textconv could be different (like comparing
old:foo.doc with ./foo.odt).

> In my implementation, I textconv one at a time. I just did so from
> fill_mmfile, so all of diff automagically just sees the converted text.

One has to be carefull not to call textconv for plumbing commands,
since the generated patches are not applicable, and only for the eyes
of the reader.

-- 
Matthieu
