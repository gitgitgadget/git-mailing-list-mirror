From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 07/13] remote-hg: redirect buggy mercurial output
Date: Tue, 2 Apr 2013 14:22:44 -0600
Message-ID: <CAMP44s1C37+drw3HhysO4aRgxUt=knAKnT+Bk0JCqLr=CL5yjQ@mail.gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
	<1364929382-1399-8-git-send-email-felipe.contreras@gmail.com>
	<7vehesd7rl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 22:23:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN7jf-0000bd-7n
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 22:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762224Ab3DBUWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 16:22:47 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:48490 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758662Ab3DBUWq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 16:22:46 -0400
Received: by mail-lb0-f180.google.com with SMTP id t11so882807lbi.39
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 13:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=R8k6Bo/ErIPMefmgweJB8Gs8vSIoHBVk1G5l9Zbl8J4=;
        b=Rxq8Dg0tx7JkZJ7wr2YDtnWshPEoLY5p8+gv8eMn8JwQf5RrMSROwZhlJdigs7f29w
         EbuOotDAJzhNmxoHxQFHKvQR/MWWn3+t82hLFAn9VGQS07P7dbBdF48zC6d3ZH0lUdR5
         RjwR/WlqXdOqvDa8IZluh3JoeTwNySemrXdeDF9dctsd8JHLJDz9G7TnH96PSLsqALNA
         PZfDi+05SjZuSTPJLMnUH6+dfCDNPO57gI7kyrfv4gN1G9fwSU+sgTywCFzLzyxC2ANo
         bVlkUDiitYdP7isKcyvQ8IFB+dsfOY1Eg2ODDiUfGMFdAQRE7/UJlnPinYnjfKcahc5+
         b/tw==
X-Received: by 10.112.130.201 with SMTP id og9mr8486688lbb.65.1364934165053;
 Tue, 02 Apr 2013 13:22:45 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Tue, 2 Apr 2013 13:22:44 -0700 (PDT)
In-Reply-To: <7vehesd7rl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219879>

On Tue, Apr 2, 2013 at 1:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> We can't use stdout for that in remote helpers.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>
> You may want to clarify "buggy output" a bit.  Will mercurial
> forever be broken?  Some versions of Hg emit [[[it is unclear for
> Junio to tell what it is to fill this blank]]] to its output that
> we want to ignore?

The problem is that mercurial's code is kind of hardcoded to run under
mercurial's UI, so it throws messages around willynillingly, like:

searching for changes
no changes found

And they can't be turned off. Theoretically we could override
mercurial's UI class, but I think that has the potential to create
more problems, it's not worth at this point in time.

Cheers.

-- 
Felipe Contreras
