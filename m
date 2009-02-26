From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] t5540-http-push.sh: avoid non-portable grep -P
Date: Thu, 26 Feb 2009 18:40:09 -0500
Message-ID: <76718490902261540m77925a38id628fc3bce2a8667@mail.gmail.com>
References: <1235677745-939-1-git-send-email-jaysoffian@gmail.com>
	 <7vwsbdq6u4.fsf@gitster.siamese.dyndns.org>
	 <76718490902261243gaebdd8an2bd75bf625556f7b@mail.gmail.com>
	 <7vmyc8rhry.fsf@gitster.siamese.dyndns.org>
	 <76718490902261419r314f6ea4r5eb02e9b5b0c40d0@mail.gmail.com>
	 <7veixkrfif.fsf@gitster.siamese.dyndns.org>
	 <76718490902261440p4c9981fbncbdd58ad12e38349@mail.gmail.com>
	 <7v4oygrd3w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 00:43:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcptE-0005eT-L9
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 00:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797AbZBZXkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 18:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754233AbZBZXkM
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 18:40:12 -0500
Received: from rv-out-0506.google.com ([209.85.198.234]:9416 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbZBZXkL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 18:40:11 -0500
Received: by rv-out-0506.google.com with SMTP id g37so766609rvb.1
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 15:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nSxU4MjvWz/2Iy5QBbJtuF8LVTykwusov5Fn/iRJ2wk=;
        b=b3pNR29LZ6Mdz2Yi7yvQIFJ7HRhDg7ReOtt4cPJ2HSCmDzU9w3FBlbXtMwu1mFdDtc
         kr4MfXnYoFrkBhtjRVBf1uwTbfIoC3f+H6XVMfJZ+oxk/buC5A+32sIz1U5eF/yuXK9v
         lWVrby8PpR6xiZKaCwXPdykkj4I44KJ8Ks8oc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gyLFOTpZv5mgTZXwuebvbKgV0a9P0n7HPe4Y8lh57mUyL/FVtcp8YfpaU7RfOnJxVE
         dOU5s8mxuTd91/6FapAWLN1lngmTgztm6hfIp6va0OkIK9ce+/E9pFuBGlesfCPjp/ZA
         cOPXkD/3CzuAfBP2pKzF4Ujj8jmh9Exd0ppsQ=
Received: by 10.141.205.10 with SMTP id h10mr861840rvq.225.1235691609198; Thu, 
	26 Feb 2009 15:40:09 -0800 (PST)
In-Reply-To: <7v4oygrd3w.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111614>

On Thu, Feb 26, 2009 at 6:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Heh, at least with /a-z/a-f/, I think it is usable.
>
> Or is there a reason I am missing that we want to allow g-z there?

OMG, I didn't even notice that until this message. When you asked:

> Why [a-z0-9] not [0-9a-f]?

I noticed only that you had flipped the relative positions of the
alphas and the digits, no that you had also a-z to a-f. Please squash
this on top of the last patch I sent:

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 470bca3..bd45203 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -94,7 +94,7 @@ test_expect_success 'MKCOL sends directory names
with trailing slashes' '

 '

-x1="[0-9a-z]"
+x1="[0-9a-f]"
 x2="$x1$x1"
 x5="$x1$x1$x1$x1$x1"
 x38="$x5$x5$x5$x5$x5$x5$x5$x1$x1$x1"


Sheesh.

j.
