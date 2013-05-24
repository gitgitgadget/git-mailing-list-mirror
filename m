From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Random thoughts on "upstream"
Date: Fri, 24 May 2013 12:09:49 +0530
Message-ID: <CALkWK0nGhYYvHA4-nEtfCvRV3UyA2u28LJoX=GhxbmtRW1mMvA@mail.gmail.com>
References: <7vobca6c7r.fsf@alter.siamese.dyndns.org> <CAMP44s2t3+yBQMj9uSd_=3w0CgeJsHeAQM051j7Xt+SqVthvzQ@mail.gmail.com>
 <7vobca3465.fsf@alter.siamese.dyndns.org> <7vzjvu1jes.fsf@alter.siamese.dyndns.org>
 <CALkWK0=rHFQ14G8baYpY7gYo+Qb+5a0qOKZGBTrp6BamKC2vRg@mail.gmail.com>
 <7vk3mx1rox.fsf@alter.siamese.dyndns.org> <CALkWK0mLtc8dmMPOcLMez1agF1+ZMUDAUwtwmiKSxOCfyiW0Bw@mail.gmail.com>
 <7vk3mxze8v.fsf@alter.siamese.dyndns.org> <CALkWK0kYKZGhthdrb6-7RD_c2A7E9rscAZU3=JHM-4rYre6w=Q@mail.gmail.com>
 <7vmwrr1pem.fsf@alter.siamese.dyndns.org> <CALkWK0=6L529C452MaNGksL5KeVb+cL1SeC=FwA9veS=tNQurA@mail.gmail.com>
 <7vfvxixoks.fsf@alter.siamese.dyndns.org> <CALkWK0m1x_qrJfQ2Xw3w_kVuM-JHERFukbfxHyR08ODvxysKzw@mail.gmail.com>
 <7vppwhfw20.fsf@alter.siamese.dyndns.org> <CALkWK0n+_QqavstRCt8zM5ahmu9jnKB4M4XwdtqB4qSsJgq=hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 24 08:40:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uflg2-0004wq-Ha
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 08:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097Ab3EXGka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 02:40:30 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:55928 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153Ab3EXGk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 02:40:29 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so11157325iej.2
        for <git@vger.kernel.org>; Thu, 23 May 2013 23:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KQrq/fh7pHNE6Z6SkyyZjfc9+C4j38xA+CXjtQkiEic=;
        b=lO28ib5P3Apf/DIxOIKiqZlXZCsxCkiknKIoacZ6YtixvuqwX0SUfZKHlTSOF8u/SY
         P4zD+QYX1Y6J+ktWPVNmzTHxDbbtZSKF1Yoz2Uv3lXugZhKk1wLhso3uh0LDESecPKP+
         fAKOItJfo5JSozWScqy9C7sikklAvJDFE/+xKFxp0Of8DgZb2yavz0d0Sj1CK0nmxUz0
         jRRy73KUAV59zOSV6aOUo71nJpL3SvaPf6R4cbyvLclyZ1RMk6wHEtNb7e3Cc2cEhPKa
         Cn3d9Nw0/ELo3+u+jzLCpvE9q1aw24DweA4LYBXd/DvjSEiOwlTL6+AnF4F8eVf9S9EJ
         DKIA==
X-Received: by 10.42.27.146 with SMTP id j18mr12310683icc.54.1369377629450;
 Thu, 23 May 2013 23:40:29 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 23 May 2013 23:39:49 -0700 (PDT)
In-Reply-To: <CALkWK0n+_QqavstRCt8zM5ahmu9jnKB4M4XwdtqB4qSsJgq=hQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225329>

Ramkumar Ramachandra wrote:
> you'd essentially have to grab the remote.<name>.push refspec, rewrite
> it to replace refs/heads/*: with $HEAD: and feed that refspec to the
> transport layer

Um, sorry.  It involves two independent steps:

1. add_refspec() $HEAD:$HEAD@{push} to feed to the transport layer.
(@{push} is already in progress; see list)

2. Forcing the transport layer to ignore remote->push and use the fed
refspec instead.  (I'm not sure how to do this yet)
