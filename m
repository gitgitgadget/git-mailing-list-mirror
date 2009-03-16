From: Carlos Rica <jasampler@gmail.com>
Subject: Re: [PATCH] config: --replace-all with one argument exits properly 
	with a better message.
Date: Mon, 16 Mar 2009 15:41:35 +0100
Message-ID: <1b46aba20903160741y64598f92gda5cfe9c8dd31586@mail.gmail.com>
References: <1236998552.9952.2.camel@luis-desktop>
	 <7vtz5vakrp.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530903141434w2fb8aa28we087465482a12e41@mail.gmail.com>
	 <7vab7na6wb.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530903150326u34a0715v38269417e2785db8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 15:43:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjE23-0002bd-DK
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 15:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754893AbZCPOlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 10:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752488AbZCPOll
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 10:41:41 -0400
Received: from mail-fx0-f176.google.com ([209.85.220.176]:39548 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbZCPOlk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 10:41:40 -0400
Received: by fxm24 with SMTP id 24so3513998fxm.37
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 07:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QLYKwVbR4NZ5kUp/ztPfFUhcAmpRaWe0GDE+8FSDa34=;
        b=iHaJqIETRw3DzbQ+1+v3VHM1+LxBqkE2WP7VlWf/9k52aSJRryWKvT5BHWUz7Qb5eI
         flVf1+pj5R16spmJ4Rc9ZS+SEFbb8nJxmxmnn3bae27/gbmQvlfjkM68PAdVsOhOKgTF
         lOH36I5e8nhf2/2+QTR67BdeE0eEnb/BSkj1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iTssySeU+WItl5mB6Qbfcd0JT78dyu7FT+LGRmeFMJyWQCjp7uc+nLR1nuja2l5S3t
         e4RyRHZVQXTsGBkjtrcnBKRRG+MvVaMJb/fMSJ/0x+CbG9sbUSLH6RIGVDLywBt1mmEQ
         8iJc4gJIhUyoXM0R2Ma5KzYSzo3WIHm98klHQ=
Received: by 10.223.108.196 with SMTP id g4mr3327586fap.36.1237214496118; Mon, 
	16 Mar 2009 07:41:36 -0700 (PDT)
In-Reply-To: <94a0d4530903150326u34a0715v38269417e2785db8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113329>

Hi Felipe, I didn't know that you were writing the parse options for
config. I tried it a year ago and I leave it unfinished because (if I
remember correctly) options like -4, -5, -6... and those:
http://thread.gmane.org/gmane.comp.version-control.git/78480

On Sun, Mar 15, 2009 at 11:26 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sun, Mar 15, 2009 at 3:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> On Sat, Mar 14, 2009 at 10:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Carlos Rica <jasampler@gmail.com> writes:
>>>>
>>>>> 'config --replace-all ONE_ARG' was being treated as 'config NAME VALUE',
>>>>> showing the error "key does not contain a section: --replace-all".
>>>>
>>>> Hmm, I am getting "error: wrong number of arguments" followed by the long
>>>> and somewhat annoying "usage" from the parseopt table dump.
>>>
>>> If you find it annoying why don't you remove the usage?
>>
>> Because the primary target audience of the help text is not me?
>
> Ok. I don't think it makes a big difference to leave it on or off.
> People not familiar with 'git config' might find it handy, but I admit
> that I also find it a bit annoying, mainly because the error message
> gets lost in the noise.
>
>>>> Can you work with Felipe to see if this is still needed, or needs to be
>>>> fixed in a different way?  It could be that your tests may already pass
>>>> over there on 'next'.  I didn't check.
>>>
>>> The new code is already checking correctly that --replace-all needs at
>>> least two arguments. However, the "usage" is incorrect and of course
>>> the test will come in handy.
>>
>> So perhaps you can pick a part of it and send in an update to your
>> parseoptification series?  I think the series is ready for 'master'
>> sometime next week if not sooner.
>
> Or maybe Carlos can beat me to do it since it seems he is interested.
> Otherwise yeah, I'll do it.

Of course, I'm looking at your code in "pu" to see how could apply this.
