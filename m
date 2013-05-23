From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Random thoughts on "upstream"
Date: Thu, 23 May 2013 23:11:21 +0530
Message-ID: <CALkWK0n+_QqavstRCt8zM5ahmu9jnKB4M4XwdtqB4qSsJgq=hQ@mail.gmail.com>
References: <7vobca6c7r.fsf@alter.siamese.dyndns.org> <CAMP44s2t3+yBQMj9uSd_=3w0CgeJsHeAQM051j7Xt+SqVthvzQ@mail.gmail.com>
 <7vobca3465.fsf@alter.siamese.dyndns.org> <7vzjvu1jes.fsf@alter.siamese.dyndns.org>
 <CALkWK0=rHFQ14G8baYpY7gYo+Qb+5a0qOKZGBTrp6BamKC2vRg@mail.gmail.com>
 <7vk3mx1rox.fsf@alter.siamese.dyndns.org> <CALkWK0mLtc8dmMPOcLMez1agF1+ZMUDAUwtwmiKSxOCfyiW0Bw@mail.gmail.com>
 <7vk3mxze8v.fsf@alter.siamese.dyndns.org> <CALkWK0kYKZGhthdrb6-7RD_c2A7E9rscAZU3=JHM-4rYre6w=Q@mail.gmail.com>
 <7vmwrr1pem.fsf@alter.siamese.dyndns.org> <CALkWK0=6L529C452MaNGksL5KeVb+cL1SeC=FwA9veS=tNQurA@mail.gmail.com>
 <7vfvxixoks.fsf@alter.siamese.dyndns.org> <CALkWK0m1x_qrJfQ2Xw3w_kVuM-JHERFukbfxHyR08ODvxysKzw@mail.gmail.com>
 <7vppwhfw20.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 19:42:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfZWj-0007od-Lz
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 19:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758299Ab3EWRmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 13:42:05 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:58517 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757992Ab3EWRmD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 13:42:03 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so9513742iea.17
        for <git@vger.kernel.org>; Thu, 23 May 2013 10:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iVVtrxUr8Kt20dP4hsRkFbOkRS5F+zephLyqbY1fcG0=;
        b=RAtLUhVDHIJtUKIvKGw7GYKrPKH0B1cPJ5HJPTCD4qwuzx2LyW0112uaKR1SG9Ioh9
         UwbF2mEq1D4ueYJI9TArwCX/5UkjMlYYK14HMULSVGbAm1VjbF+NSvH/Zwa2hIAp2JAc
         WmVWnaqhzBVWZxEM2UJ4mgmXkkaFuW0O55pbEyW08bi5oyDp7bbNpL2kowIqtmY6J7O7
         IM2kiJOp3Nt+ppGrRNIrQcVnsZtK6xvQA2Tot3MlZ566veiXQXq8RJvZmKVtLOVA7nEk
         SX4MU5IEdRkLRlXMAFBDajy2fGV2NBGXreCoZ5F3gq5QnC0drLfuXQwguaXMYA+jwd+h
         A03g==
X-Received: by 10.42.47.77 with SMTP id n13mr10089165icf.12.1369330922018;
 Thu, 23 May 2013 10:42:02 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 23 May 2013 10:41:21 -0700 (PDT)
In-Reply-To: <7vppwhfw20.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225274>

Junio C Hamano wrote:
> I am not saying default=single would be _the_ single right way to
> solve it, but "when you have default=single, remote.$name.push is
> used only to describe the mapping, not forcing you to push
> everything out at once" is one possible solution to that.

The big advantage it has, in my opinion, is ease of implementation:
you'd essentially have to grab the remote.<name>.push refspec, rewrite
it to replace refs/heads/*: with $HEAD: and feed that refspec to the
transport layer.  Compare that to inventing a new refspec syntax,
which is a mammoth task.  We can always extend the refspec later, if
we want that.  I wonder if it makes sense to bake the functionality
into current though: will we be breaking anything?

(My opinion has changed after wrestling with the horrible transport layer)
