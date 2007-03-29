From: Tom Prince <tom.prince@ualberta.net>
Subject: SEGV in git-merge recursive:
Date: Thu, 29 Mar 2007 11:50:10 +0400
Message-ID: <20070329075010.GA3493@hermes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 29 09:50:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWpOZ-00042H-DK
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 09:50:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023AbXC2HuE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 03:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753305AbXC2HuD
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 03:50:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:4836 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289AbXC2HuB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 03:50:01 -0400
Received: by ug-out-1314.google.com with SMTP id 44so445949uga
        for <git@vger.kernel.org>; Thu, 29 Mar 2007 00:50:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent:sender;
        b=OPdeknMiky5VKYb/LcFrQWyMOv5fXTcEcq+ehNz69XN00FBoUWvW0ZH2Y45oGJZdHYHKhNZ2KhbRFg0SQoiACd8A3AmV8OduWNMgHKOwvOjTIEfOUafTky7y6R0mlBo4jWBKnB/BA32a3umSCoMfGO0ILrJCDnbtJcdx8GCFxFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent:sender;
        b=WvHYPD0YxTkR+W2FR/fu/CKeGm/PMUfMSAA2AyHj8PiuidBkl1khyoSogxK6pcTAYZqSCAHAK5Ndv2XyLjf/NyjprqErhloLVfe9L7rF+ZMB6RGFbGUjVDMCWKsu8tPCJzIh6k6+Xh2fIiq4glxLKi5hrF7icsW48VbKapn8Jr8=
Received: by 10.67.117.18 with SMTP id u18mr1223517ugm.1175154600449;
        Thu, 29 Mar 2007 00:50:00 -0700 (PDT)
Received: from hermes ( [80.240.215.209])
        by mx.google.com with ESMTP id j2sm1395724ugf.2007.03.29.00.49.58;
        Thu, 29 Mar 2007 00:49:59 -0700 (PDT)
Received: by hermes (nbSMTP-1.00) for uid 500
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	Tom; Thu, 29 Mar 2007 11:50:12 +0400 (MSD)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43408>

I have been keeping my Maildir in git, a non-trivial merge that causes a
segfault in git-merge-recursive.

It does not appear to matter which direction I try to merge.

I have a bundle of the relevant portion (rewritten with
cg-admin-rewritehist) which still exhibits the problem.
It is about 160M, but has private email in it.

  Tom Prince

# git-rev-list --parents head merge
922ee6e3f1222c8e171e6ea0b6ac0f28fb1f0683 2405850f1f347e471e040039672489573532582b # head
2405850f1f347e471e040039672489573532582b 490451aa36da8dc35db59b68a5dc2dfa1a38d9b9
0134d595adb023841750f1ce84ecb94dd4e4c9cb a85b502a7e827667bc84df06f0eb10a8abdd9a91 # merge
490451aa36da8dc35db59b68a5dc2dfa1a38d9b9 e3870054c7f67aa401dbf830b5297c91add076d6
e3870054c7f67aa401dbf830b5297c91add076d6 c14f3b6fef2727c26c993c8565f50047b036cedf
a85b502a7e827667bc84df06f0eb10a8abdd9a91 93c2854d90bd126b594594df3d5eb921361844ba
c14f3b6fef2727c26c993c8565f50047b036cedf c96c42fca513eb782e0f9905ff8649a1800fc628
c96c42fca513eb782e0f9905ff8649a1800fc628 7f1260b89b194b09f11f4d7f4a10dfd27c75ad59
93c2854d90bd126b594594df3d5eb921361844ba a711bb1b8b4fd38d980235e662f801bf31af5782
7f1260b89b194b09f11f4d7f4a10dfd27c75ad59 cc71e5ab9c70c1a3a018abfd770acbe823cc3746
cc71e5ab9c70c1a3a018abfd770acbe823cc3746 1b21b61d2ebe6f54c258d9d1a846690145c408bc
a711bb1b8b4fd38d980235e662f801bf31af5782 29e722de58df3cd82600fa5215ec26f80a8c0f9a 2c3490d82610d12d8dfde36b29c4ec5a50955b89
1b21b61d2ebe6f54c258d9d1a846690145c408bc 2c3490d82610d12d8dfde36b29c4ec5a50955b89 29e722de58df3cd82600fa5215ec26f80a8c0f9a
29e722de58df3cd82600fa5215ec26f80a8c0f9a e2123cfd9a53e441c7c715627953606c6093e0e4
2c3490d82610d12d8dfde36b29c4ec5a50955b89 3eb95ece931c80b50ad182c602ada3f35e240916
3eb95ece931c80b50ad182c602ada3f35e240916 5a8eaa887ec82657fcf42a25db928ec263946018
5a8eaa887ec82657fcf42a25db928ec263946018 e2123cfd9a53e441c7c715627953606c6093e0e4
e2123cfd9a53e441c7c715627953606c6093e0e4
