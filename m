From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Random thoughts on "upstream"
Date: Sun, 19 May 2013 01:37:51 +0530
Message-ID: <CALkWK0=0SwWW+LC3iPy=A9tLBOxrXgYH1cYNazrchv3_jU_oMg@mail.gmail.com>
References: <7vobca6c7r.fsf@alter.siamese.dyndns.org> <CAMP44s2t3+yBQMj9uSd_=3w0CgeJsHeAQM051j7Xt+SqVthvzQ@mail.gmail.com>
 <7vobca3465.fsf@alter.siamese.dyndns.org> <7vzjvu1jes.fsf@alter.siamese.dyndns.org>
 <CALkWK0=rHFQ14G8baYpY7gYo+Qb+5a0qOKZGBTrp6BamKC2vRg@mail.gmail.com>
 <7vk3mx1rox.fsf@alter.siamese.dyndns.org> <CALkWK0mLtc8dmMPOcLMez1agF1+ZMUDAUwtwmiKSxOCfyiW0Bw@mail.gmail.com>
 <7vk3mxze8v.fsf@alter.siamese.dyndns.org> <CALkWK0kYKZGhthdrb6-7RD_c2A7E9rscAZU3=JHM-4rYre6w=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 18 22:08:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdnQu-0000of-5j
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 22:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085Ab3ERUIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 16:08:32 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:46506 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983Ab3ERUIb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 16:08:31 -0400
Received: by mail-ie0-f169.google.com with SMTP id u16so11839009iet.0
        for <git@vger.kernel.org>; Sat, 18 May 2013 13:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=cc9cdrGmoVjFkcydDgzp8WqUQ0cTzHjYDWIAr+DIOnU=;
        b=oVgX7ugEtpYYJ6hObDR0sLln/tbVXBDaVU13VW1aER1AqmLX3FhkhPHUwk/eMRvXr0
         Vf0/6Eyw+TC5w0bGXETar8/+ObonJKW1fgYXyJxY71rvPmgakwjo+IlpIVHWrlpKVQdh
         QLwuR6VSb+7lXf+aEW2hGJQK8xu9FqKlIbt+BdY8FcTtnXn1htGibDb6gwB1FiHKsIC/
         ywKTi9H2ACzhJuk9T37O95mkl+Tive+/rUqibPSTiJhi0u9/GbCnjKdByCAKkgJYDJEh
         9jhqIxP8DuS/kHK/CVWaxrTh3apP+XaoQrYRJxxKX1sBKkL5xOg12VFe4dpnVJpbxK8R
         llIg==
X-Received: by 10.50.73.65 with SMTP id j1mr1784784igv.49.1368907711372; Sat,
 18 May 2013 13:08:31 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sat, 18 May 2013 13:07:51 -0700 (PDT)
In-Reply-To: <CALkWK0kYKZGhthdrb6-7RD_c2A7E9rscAZU3=JHM-4rYre6w=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224806>

Ramkumar Ramachandra wrote:
> I guess what I'm saying is: refspec semantics are inherent properties
> of the remote, not of the local branch.

[remote "ram"]
    push = refs/heads/link:refs/heads/for-junio/link

is saying: if the branch name matches "link", push it to for-junio/link.

[branch "link"]
    push = refs/heads/for-junio/link

is saying: push _this_ branch to for-junio/link, irrespective of what
it is called.

An example illustrating this clearly:

# on branch link-v2
# work ...
$ git push
# work ...
# ok, I'm ready to replace link
$ git branch -M link
$ git push
# where should the push go?

Also: putting branch-specific configuration in remote.<name>.push
would mean that it can potentially accumulate a lot of cruft from
deleted branches.  It's the same kind problem we face with .gitignore,
no?
