From: Tom Prince <tom.prince@ualberta.net>
Subject: Re: SEGV in git-merge recursive:
Date: Thu, 29 Mar 2007 18:12:30 +0400
Message-ID: <20070329141230.GB16739@hermes>
References: <20070329075010.GA3493@hermes> <81b0412b0703290429k63642a34u6bea1e08803ffba7@mail.gmail.com> <20070329125803.GA16739@hermes> <81b0412b0703290634j6e62ba89tce3c8c963be3fb92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 16:12:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWvMW-0003q5-To
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 16:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbXC2OMU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 10:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753672AbXC2OMU
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 10:12:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:30216 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753661AbXC2OMT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 10:12:19 -0400
Received: by ug-out-1314.google.com with SMTP id 44so520755uga
        for <git@vger.kernel.org>; Thu, 29 Mar 2007 07:12:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=PHX4Ww9NAxu6rpdJRTrEBi01VbBFqk+bZ8a6Nfc9f6cQ6CuEX6BuyZKLeicTfMo9+ixOrUDfh5hI0EieQV9aYFwef8+/I5S4gNZI+O964TblPtB3rXZhvD2zyLBn9aZdqM34j89vWzdH8Vb+gD+S0zU8XLZ+G5jOeBuyVQ32r4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=tvPVkxf2cnjF6ViWs4ZvwKYHQLbwKBGbeeIsq5e6URXhmK1fVvVhmStNcgLxDC+RMGG+busvp9ofNN0QpF7bQDWh8pPEDbeqgOGFi1YiJOokg4/XmNBr6v1wBFct0BiRLxDnyBh7VWibIOLnxrVoaZSokC40ns/OVOo7EM3xe9E=
Received: by 10.67.98.9 with SMTP id a9mr1468460ugm.1175177538395;
        Thu, 29 Mar 2007 07:12:18 -0700 (PDT)
Received: from hermes ( [80.240.215.209])
        by mx.google.com with ESMTP id 55sm2139717ugq.2007.03.29.07.12.16;
        Thu, 29 Mar 2007 07:12:17 -0700 (PDT)
Received: by hermes (nbSMTP-1.00) for uid 500
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	Tom; Thu, 29 Mar 2007 18:12:32 +0400 (MSD)
Mail-Followup-To: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <81b0412b0703290634j6e62ba89tce3c8c963be3fb92@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43434>

On Thu, Mar 29, 2007 at 03:34:00PM +0200, Alex Riesen wrote:
> On 3/29/07, Tom Prince <tom.prince@ualberta.net> wrote:
> >On Thu, Mar 29, 2007 at 01:29:46PM +0200, Alex Riesen wrote:
> >> On 3/29/07, Tom Prince <tom.prince@ualberta.net> wrote:
> >> >I have been keeping my Maildir in git, a non-trivial merge that causes a
> >> >segfault in git-merge-recursive.
> >> >
> >> >It does not appear to matter which direction I try to merge.
> >> >
> >>
> >> BTW, what git do you have? git --version?
> >
> >1.5.1.rc3
> >
> 
> Did it crash before? If it didn't, is it possible for you to bisect
> the commit which caused the problem?

It occurs running

git merge -s recur test HEAD merge

with

6c711269d4e49072703255ce29bd4d8c53e4f4ba

which introduced the C version of merge-recursive.

Here is the output from that more verbose version:

Merging HEAD with 0134d595adb023841750f1ce84ecb94dd4e4c9cb
Merging:
922ee6e3f1222c8e171e6ea0b6ac0f28fb1f0683 Mail.
0134d595adb023841750f1ce84ecb94dd4e4c9cb Mail.
found 2 common ancestor(s):
29e722de58df3cd82600fa5215ec26f80a8c0f9a Mail.
2c3490d82610d12d8dfde36b29c4ec5a50955b89 Mail.
  Merging:
  29e722de58df3cd82600fa5215ec26f80a8c0f9a Mail.
  2c3490d82610d12d8dfde36b29c4ec5a50955b89 Mail.
  found 1 common ancestor(s):
  e2123cfd9a53e441c7c715627953606c6093e0e4 Merge commit 'origin'
  CONFLICT (rename/rename): Rename .drafts/new/1175001142.P509Q1.hermes->.mom/cur/1175098106.P18146Q0M209985.socrates:2,S in branch Temporary merge branch 1 rename .drafts/new/1175001142.P509Q1.hermes->.drafts/cur/1175001142.P509Q1.hermes:2, in Temporary merge branch 2
/Users/cougar/local/bin/git-merge: line 311: 25426 Segmentation fault      git-merge-$strategy $common -- "$head_arg" "$@"
No merge strategy handled the merge.


-- 
  Tom
