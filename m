From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Why SHA are 40 bytes? (aka looking for flames)
Date: Sat, 21 Apr 2007 20:28:57 +0200
Message-ID: <e5bfff550704211128i12035947i7597e920a0eca163@mail.gmail.com>
References: <e5bfff550704210635r4008c3c6tf5f55f970bf85e44@mail.gmail.com>
	 <9e4733910704210837y3ac3654ekb60654ef6fc397fc@mail.gmail.com>
	 <e5bfff550704211006t59cb49h179685d694a1d75a@mail.gmail.com>
	 <9e4733910704211059h16c06e11k967d0bdd3e4970fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@cam.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 20:29:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfKKV-0001Yy-BL
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 20:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbXDUS27 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 14:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbXDUS27
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 14:28:59 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:40692 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbXDUS26 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 14:28:58 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1176159wra
        for <git@vger.kernel.org>; Sat, 21 Apr 2007 11:28:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=At5jWJ19u2oad6JWUNXlsoqKrTaulOy8UP2DG2BkEt86D2NU1ayrrODB46tmQStF2gcdQIYpjSRmo7NUWxrv1lPdNWCb32Ibfb5q7GbZWAW983FLKIn7GoPwBHxKV7+SHZm8HKMJKaYlHl4KI18JJ209LUR06ZKYqNRkPBrrxiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fuNCPW8d6w/26Jya/N0ZdsK2jSQ8cO/3iztsjU+gLUD+nQAc8Z5xL+PA50n7OamdF3Xw9rDwNrIxOt/lKKXngvG5MjAuCCIx0y6cZgXwRfiEUR8dyBBKjSQybXKEGsqG7DQnnHIb9M8keMRAxGufjbuXrAQDj/KD/j2aKJwSp4U=
Received: by 10.114.161.11 with SMTP id j11mr1803124wae.1177180137690;
        Sat, 21 Apr 2007 11:28:57 -0700 (PDT)
Received: by 10.114.61.6 with HTTP; Sat, 21 Apr 2007 11:28:57 -0700 (PDT)
In-Reply-To: <9e4733910704211059h16c06e11k967d0bdd3e4970fc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45188>

On 4/21/07, Jon Smirl <jonsmirl@gmail.com> wrote:
>
> You have to store the full SHAs at least once since they are the
> signature against data corruption.
>

This is interesting.

So until know I learnt 3 uses of sha:

- Reference an object
- Check against object data corruption
- Prevent any possible collision among objects


Karl says that we need 160 bits to prevent collisions:

>prevent any possible collision created by a malicious adversary, too,
>so that it's possible to e.g. sign just a commit and be able to trust
>everything it points to. The SHA1 designers felt that 160 bits was a
>good compromise between size and robustness, and we just trust that
>their (and the cryptographic community's) guess is good enough.

Probably we don't need 160bits to reference an object. I really don't
know how many bit we need to be robust against data corruption.

Someone more versed then me in SHA1 could tell the probablity to find
a corrupted object calculating his hash and checking against his
stored 160bits known good signature and *FAIL* to find as corrupt *the
same object* calculating his hash and checking against a truncated sha
to say 20bits.

I would say this probability is veery veery low in random case (not a
malicious attack of course, but I think this is not the case with git
repository as it was with SHA1 designers).

Marco
