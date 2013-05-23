From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Random thoughts on "upstream"
Date: Thu, 23 May 2013 16:12:03 +0530
Message-ID: <CALkWK0m1x_qrJfQ2Xw3w_kVuM-JHERFukbfxHyR08ODvxysKzw@mail.gmail.com>
References: <7vobca6c7r.fsf@alter.siamese.dyndns.org> <CAMP44s2t3+yBQMj9uSd_=3w0CgeJsHeAQM051j7Xt+SqVthvzQ@mail.gmail.com>
 <7vobca3465.fsf@alter.siamese.dyndns.org> <7vzjvu1jes.fsf@alter.siamese.dyndns.org>
 <CALkWK0=rHFQ14G8baYpY7gYo+Qb+5a0qOKZGBTrp6BamKC2vRg@mail.gmail.com>
 <7vk3mx1rox.fsf@alter.siamese.dyndns.org> <CALkWK0mLtc8dmMPOcLMez1agF1+ZMUDAUwtwmiKSxOCfyiW0Bw@mail.gmail.com>
 <7vk3mxze8v.fsf@alter.siamese.dyndns.org> <CALkWK0kYKZGhthdrb6-7RD_c2A7E9rscAZU3=JHM-4rYre6w=Q@mail.gmail.com>
 <7vmwrr1pem.fsf@alter.siamese.dyndns.org> <CALkWK0=6L529C452MaNGksL5KeVb+cL1SeC=FwA9veS=tNQurA@mail.gmail.com>
 <7vfvxixoks.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 12:42:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfSyv-0007mx-Dx
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 12:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758275Ab3EWKmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 06:42:45 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:54055 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757958Ab3EWKmo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 06:42:44 -0400
Received: by mail-ie0-f176.google.com with SMTP id at1so7888059iec.7
        for <git@vger.kernel.org>; Thu, 23 May 2013 03:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8v4BoMt2K9CV9QSJK48EomhQdMwSYmRIQnJcooHASXQ=;
        b=o5lVfKaTln9aRYa2M2RYGa9LPcHx7tYKGst2OVtE1VGvt9RTapkAS8lvT/MRdSsOkv
         IXoyW5TAIT81DutlfBGhQSovMULlM76gqCw7BG0dHo8/WzJQT22B8/FJi5CMR5w7/+AA
         19sTAjtL8AbfKP23Yygq4dcKm5Re+iFj9WDgK7EeoGyF1UTVGHc4k6cqqhz4DUP/ng9U
         xAW07B7Qu4mQ2Kkausf8PWk5aRrmQw8tBE/JJBqyjuSLbvKoj3CWrMDtKm1rOmMhwHZh
         xc8BjZA4/t2sFmzAYaLK8vxPLbZ5mMoHbucLW7kZbKaEvm9jLOzlMti1Xey2YFTAaRXO
         aYog==
X-Received: by 10.42.47.77 with SMTP id n13mr9079930icf.12.1369305763980; Thu,
 23 May 2013 03:42:43 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 23 May 2013 03:42:03 -0700 (PDT)
In-Reply-To: <7vfvxixoks.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225234>

Junio C Hamano wrote:
> And that was done with extensivility your example implied in mind:
> you may later be allowed to push other branches as well to origin.
> That is why the refspec definition for 'origin' does not hardcode
> the name of the branch you are permitted to push there at this
> moment.  The fact that hot-branch goes to origin is encapsulated in
> the branch.hot-branch.pushremote.  The rule, under which the name of
> any branch that goes to the origin is renamed, is encapsulated in
> remote.origin.push refspec (the introduction of the new mode
> "push.default = single" is necessary to make this work).

My problem with this entire scheme _is_ the magic push.default =
single.  Currently, push.default only kicks in when no
remote.<name>.push refspec is specified (in other words, it is a
default value of remote.<name>.push for all remotes), and I don't
think we should change this.  If the user wants to configure the push
refspec (either for rewriting, or for determining what to push), there
is exactly one thing to change: remote.<name>.push.  So I can have:

[remote "theodore"]
    push = master
    push = +pu

This means that I will always push master without force and pu with
force, irrespective of the branch I'm on.

[remote "origin"]
    push = refs/heads/*:refs/heads/rr/*

This means that I will always push all branches without force with
rewriting, irrespective of the branch I'm on.

[remote "ram"]
    push = HEAD:refs/heads/rr/%1

This means that I will always push the current branch without force,
with rewriting.

[remote "felipe"]
     # empty

This means that remote."felipe".push falls back to the refspec
specified by push.default.

Isn't branch.<name>.push is completely unnecessary?  Does this make
sense to you?  Isn't it more straightforward and general (how do I get
a push.default = single on a per-remote basis) than your solution?
