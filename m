From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] git-remote-mediawiki: reset private ref after
 non-dumb push
Date: Mon, 26 Aug 2013 11:28:02 -0500
Message-ID: <CAMP44s1dNHi5Xg9KPp_717BMfAem-H8YOv5c+K9-2b-Aewpe3w@mail.gmail.com>
References: <1376400700-8863-1-git-send-email-Matthieu.Moy@imag.fr>
	<CAMP44s2u1edB3g9GK_kak3Nc-fe4TDBjFU_JqskBW+J0Q9BJrg@mail.gmail.com>
	<vpqa9ka7mku.fsf@anie.imag.fr>
	<CAMP44s3jh4iEbgONaEU0WSCc5YiGYoK8edcgWU6qmUARToVRuw@mail.gmail.com>
	<vpqbo4o3jba.fsf@anie.imag.fr>
	<CAMP44s281qkdMXUM-2P6T+emFajASX6Jyj4nk8_cU5xYJYvdLA@mail.gmail.com>
	<vpq8uzr5y4v.fsf@anie.imag.fr>
	<xmqq61uumnsz.fsf@gitster.dls.corp.google.com>
	<vpqhaeckfbh.fsf@anie.imag.fr>
	<vpqr4dgizhm.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 26 18:28:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDzeE-0003HF-Bp
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 18:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756732Ab3HZQ2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 12:28:05 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:52658 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab3HZQ2E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 12:28:04 -0400
Received: by mail-lb0-f179.google.com with SMTP id v1so2581568lbd.10
        for <git@vger.kernel.org>; Mon, 26 Aug 2013 09:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+DvRUo/pnAQdag2nXntC/GXC3ukiti88GDQGxnsPDD4=;
        b=pXxb3szW812x3JtIG9+ElUjGFiDGeWLz39n/XavOwxA8cXGBeX0CTFyjZNShqbgpYU
         N7S9BusFyWPzha+sxQ87kUI2fmSZZ64bW8jOdZCoffYVESVQkyldgwGsHBHbKS4Gmjiv
         SHXFUaYydZnRt2pwe+HhdwaLhPoANQ5KKLBKmJX1GK0sQKegGFMHt7sgZMmEEGeabudT
         +GKLO1Rr+ZQOx5GP17Z/R+rP05ZOdMAd4Stg0i6P5vfiBLkZc8WU8qAwwAUu3oUFdGId
         l/WmpK+q1zQyKuvRNNxremp+tpVfYXabCN6flXTZt4/zIzVC2Wzw97f5ff1FoNWGPfRB
         3yFg==
X-Received: by 10.112.155.39 with SMTP id vt7mr2621145lbb.29.1377534482531;
 Mon, 26 Aug 2013 09:28:02 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Mon, 26 Aug 2013 09:28:02 -0700 (PDT)
In-Reply-To: <vpqr4dgizhm.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233001>

On Mon, Aug 26, 2013 at 4:16 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>>
>>>> How would I do that? The update to the remote namespace is done by Git,
>>>> not by the remote-helper.
>>>>
>>>> OK, I'm now convinced that my solution is the right one. The
>>>> alternatives are far more complex and I still fail to see the benefits.
>>>
>>> Sounds like a plan, even though it smells like the "update is done
>>> by Git" that does not have any way to opt-out may be the real design
>>> mistake and your "solution" is a work-around to that.
>>>
>>> Would it be a possibility to make it tunable, perhaps by introducing
>>> a capability on the remote-interface side that allows you to tell it
>>> not to mess with the remote namespace?
>>
>> Ideally, it would be possible to ask for a non-update without a fatal
>> error on old Git versions, but this is not possible (hence, my fix is
>> the "portable" one, that works on Git 1.8.4).
>>
>> But that's probably the best we can do now.
>
> ... and a patch implementing that would look like:

This is exactly what I meant by only update when a feature has been flagged.

-- 
Felipe Contreras
