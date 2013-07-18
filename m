From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git_mkstemps: correctly test return value of open()
Date: Thu, 18 Jul 2013 13:54:35 -0700
Message-ID: <CAPc5daVVDCHqjyDV3zYVV33EFYjea7ge84+CE=M=QXagxnHd-A@mail.gmail.com>
References: <cover.1373618940.git.trast@inf.ethz.ch> <9af38018d55c95a6807d305bb3a088e48916baac.1373618940.git.trast@inf.ethz.ch>
 <878v16kfqy.fsf@linux-k42r.v.cablecom.net> <7v38rd6l3j.fsf@alter.siamese.dyndns.org>
 <51E7E05E.4000201@gmail.com> <7v4nbr4v7m.fsf@alter.siamese.dyndns.org> <201307182032.r6IKWtWC016218@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: n1xim.email@gmail.com, trast@inf.ethz.ch, git@vger.kernel.org,
	fonseca@diku.dk
To: "Dale R. Worley" <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jul 18 22:55:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzvE5-0000zd-IN
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 22:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817Ab3GRUy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 16:54:57 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:46858 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759187Ab3GRUy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 16:54:57 -0400
Received: by mail-la0-f44.google.com with SMTP id er20so2930076lab.17
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 13:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=44I0SLwJSyN+bHfSRq5VxTJf82360UArc6IS6VQmmMs=;
        b=Qg+uWbPrCD3pTSeF/JxqejWu06Ln9TURcDEfOcP2BTcxdPIO+M9bDTClpT9GaesiTC
         efWQQm2N1HOsgSuImAfXHFBUzXbsIZgLwgrejtgJY62O9FDjZaYFg8/4XsbvMC+9osrs
         9cCp5/Y81aA8JxDPjyGi7kIZNU8Ey/w5ld/ZR8vX48BuQWiaQn6tpio8m+u1JRhUAhT6
         7IIq05znfISeuaGjNTm6MG9uqU4pypiN3WwUJyVhufBifimtZvuoaRiIbsivqlRa3IdV
         FjPKVnAyJFgCMeULN88HUcdwVxC0A4+C6rM2CycbtPPXpr9ZraSl09kIMEe0bC6sMATx
         jtYQ==
X-Received: by 10.152.5.197 with SMTP id u5mr6009240lau.59.1374180895550; Thu,
 18 Jul 2013 13:54:55 -0700 (PDT)
Received: by 10.112.64.73 with HTTP; Thu, 18 Jul 2013 13:54:35 -0700 (PDT)
In-Reply-To: <201307182032.r6IKWtWC016218@freeze.ariadne.com>
X-Google-Sender-Auth: xKIiXuJpWUscyi1Jx-hKDocv3fo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230745>

On Thu, Jul 18, 2013 at 1:32 PM, Dale R. Worley <worley@alum.mit.edu> wrote:
> I've been looking into writing a proper test for this patch.  My first
> attempt tests the symptom that was seen initially, that "git commit"
> fails if fd 0 is closed.
>
> One problem is how to arrange for fd 0 to be closed.  I could use the
> bash redirection "<&-", but I think you want to be more portable than
> that.

That's just a plain-vanilla part of POSIX shell behaviour, no?

http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_07_05
