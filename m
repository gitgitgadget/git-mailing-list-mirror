From: Michael Wookey <michaelwookey@gmail.com>
Subject: Re: Git crashes on pull
Date: Wed, 16 Sep 2009 09:30:51 +1000
Message-ID: <d2e97e800909151630w44d440f5hadb088aa5e1f8e22@mail.gmail.com>
References: <alpine.LSU.2.01.0909152044450.10936@bianca.dialin.t-online.de> 
	<7vljkg57xs.fsf@alter.siamese.dyndns.org> <alpine.LSU.2.01.0909160022430.24554@bianca.dialin.t-online.de> 
	<7vzl8v4y5g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Guido Ostkamp <git@ostkamp.fastmail.fm>, git@vger.kernel.org,
	Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 01:52:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnhod-0005u7-Mu
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 01:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700AbZIOXvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 19:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753559AbZIOXvq
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 19:51:46 -0400
Received: from mail-px0-f176.google.com ([209.85.216.176]:37899 "EHLO
	mail-px0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509AbZIOXvq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 19:51:46 -0400
X-Greylist: delayed 1239 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Sep 2009 19:51:46 EDT
Received: by pxi6 with SMTP id 6so3541332pxi.21
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 16:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Z5sly7bZw8C1lHA2XbvIGU4L6DU2S+843/hCqY4OKRI=;
        b=WshAooEx6ComJ4ldwQUITn/0OKBYdrOn4fVb5zBaEbsi5b+s8l8c0oAHiXYWT7jlxm
         jirlIZUf7BZbbYRBPJgkB3e9xcVXuka4dY8KX3EEMoz1uw4ilP6DghGETta5SZLotaC4
         ActJ8DQF/26Lspf5S6fry/28bwq7fDcKg+sd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=hY/l3WW6p19+LvyOhaWwbmjdL/1oWgUv19PghGepoLb0xdrNRMWZlGAk3xNuSDi4eG
         uMBbLsQ+Ws/VmdH9wb1JbnO5cbMlJXPPchFishjK4rpQ4yGad5oWR5k4f7WaFO8bBANq
         0+r41nEQXuYBAjDaRtlKD7ZQBmc0vov41ckb0=
Received: by 10.143.138.5 with SMTP id q5mr595060wfn.55.1253057471070; Tue, 15 
	Sep 2009 16:31:11 -0700 (PDT)
In-Reply-To: <7vzl8v4y5g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128594>

2009/9/16 Junio C Hamano <gitster@pobox.com>:
> Guido Ostkamp <git@ostkamp.fastmail.fm> writes:
>
>> On Tue, 15 Sep 2009, Junio C Hamano wrote:
>>
>>> Please try this patch, which I have been preparing for later pushout.
>>>
>>> From: Junio C Hamano <gitster@pobox.com>
>>> Date: Mon, 14 Sep 2009 14:48:15 -0700
>>> Subject: [PATCH] http.c: avoid freeing an uninitialized pointer
>>>
>>> An earlier 59b8d38 (http.c: remove verification of remote packs) left
>>> the variable "url" uninitialized; "goto cleanup" codepath can free it
>>> which is not very nice.
>>>
>>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>
>> Appears to be working ok now, thanks.
>
> Thanks.
>
> The sad part of the story was that this regression was introduced by a
> change to work around recent breakage observed when fetching from the http
> server github runs, and it was the primary purpose of pushing 1.6.4.3 out.

If only I had given it a run with the clang static analyzer earlier :(

Here is what Xcode would have shown -

    http://dl.getdropbox.com/u/1006983/git-clang.png

I can make the Xcode project available if anyone is interested.
