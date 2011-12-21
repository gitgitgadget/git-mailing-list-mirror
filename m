From: Bill Zaumen <bill.zaumen@gmail.com>
Subject: Re: Patches for message-digest support
Date: Wed, 21 Dec 2011 10:44:47 -0800
Message-ID: <1324493087.1761.23.camel@yos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Dec 21 19:45:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdR9t-0007Rm-UT
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 19:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866Ab1LUSoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 13:44:54 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60729 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab1LUSow (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 13:44:52 -0500
Received: by iaeh11 with SMTP id h11so12252260iae.19
        for <git@vger.kernel.org>; Wed, 21 Dec 2011 10:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=8g9UxgdAV/FQ+NQNjLG9hhDjCx0m3QUOnMrnjwJNa+g=;
        b=Sj2/bpNgYP0+at2ott9kUBWKYnih8tewv0QhKz+cr+sC+HbhDbKjexYPwKzCRSgClz
         2WWdjRSbs3TRwyJi30JJQ2MY9o5xTMdC58OqHRTPQ3zKpLJRtfqNqALgAUVnylGr+lAW
         w+1+aazu0eh6pvUDOtaD5KnXC7FoNGYwHGz6A=
Received: by 10.42.244.1 with SMTP id lo1mr6240072icb.9.1324493092097;
        Wed, 21 Dec 2011 10:44:52 -0800 (PST)
Received: from [192.168.1.20] (adsl-209-233-20-69.dsl.snfc21.pacbell.net. [209.233.20.69])
        by mx.google.com with ESMTPS id l28sm19769781ibc.3.2011.12.21.10.44.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 21 Dec 2011 10:44:50 -0800 (PST)
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187577>

... sorry for an additional message.  The patches I just sent
were based on commit 876a6f4991abdd72ea707b193b4f2b831096ad3c
(Update draft release notes to 1.7.9).

I should have also added that the function verify_commit was
tested via a compile-time option, but it is currently not used.
Its purpose is to verify that the (new) digest header in commit
messages is consistent with the commit's tree, parents, other
headers, and the commit message.   For authentication, one
would want to sign the commit SHA-1 hash and the message digest
for the commit (which is stored separate from the commit object).
My patch doesn't do that, but there is a single function that
can be called to look up the digest, if one is present (which may
not be the case due to backwards compatibility issues) - I'd prefer
to have someone familiar with the signature code make any changes.

The version of Makefile in the patch turns off the commit message-digest
header because some of the test scripts won't run with it, due to
those encoding specific SHA-1 values and file lengths, but the test does
run far enough to have created and used a number of commits.  I didn't
want to go to the trouble of updating the test scripts unless the patch
is actually going to get used - updating the scripts is a bit tedious
and you'd probably want to decide on the digest hash first.

Bill
