From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Mon, 9 Sep 2013 22:34:29 +0100
Organization: OPDS
Message-ID: <FE7D06F70ABF477DA271A6A596C1F1E9@PhilipOakley>
References: <CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com> <20130908172605.GF5359@vauxhall.crustytoothpaste.net> <CAMP44s0SLoD7ptgiYOg_vq+Jpo5uhWvzFC8Bd76JHo5zbjf8fg@mail.gmail.com> <20130909000153.GG5359@vauxhall.crustytoothpaste.net> <CAMP44s2seqO_0o=G2PjoL77HNSNcjTe4s6ZYj90_wsUT30pW8A@mail.gmail.com> <vpqr4cy4g5q.fsf@anie.imag.fr> <xmqq1u4x4yst.fsf@gitster.dls.corp.google.com> <20130909195231.GA14021@sigill.intra.peff.net> <20130909202435.GJ2582@serenity.lan> <vpq38pdlnxk.fsf@anie.imag.fr> <20130909205349.GA15506@sigill.intra.peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "John Keeping" <john@keeping.me.uk>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Felipe Contreras" <felipe.contreras@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	<git@vger.kernel.org>, "Andreas Krey" <a.krey@gmx.de>
To: "Jeff King" <peff@peff.net>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 09 23:34:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ96N-00031q-92
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 23:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978Ab3IIVeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 17:34:25 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:5028 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755539Ab3IIVeX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Sep 2013 17:34:23 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoGAJ0+LlJOl3GZ/2dsb2JhbABbgweEM4U+uS0JgSYXdGmBIRYBBAEBBQgBARkVHgEBIQsCAwUCAQMOBwECAgIFIQICFAEEGgYHFwYBEggCAQIDAYU4B4ITI7E1kXuBKY5CgnA0gQADjw+aTIMhOw
X-IPAS-Result: ApoGAJ0+LlJOl3GZ/2dsb2JhbABbgweEM4U+uS0JgSYXdGmBIRYBBAEBBQgBARkVHgEBIQsCAwUCAQMOBwECAgIFIQICFAEEGgYHFwYBEggCAQIDAYU4B4ITI7E1kXuBKY5CgnA0gQADjw+aTIMhOw
X-IronPort-AV: E=Sophos;i="4.90,873,1371078000"; 
   d="scan'208";a="422341977"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip04ir2.opaltelecom.net with SMTP; 09 Sep 2013 22:34:20 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234381>

From: "Jeff King" <peff@peff.net>
Sent: Monday, September 09, 2013 9:53 PM
> On Mon, Sep 09, 2013 at 10:50:31PM +0200, Matthieu Moy wrote:
>
>> John Keeping <john@keeping.me.uk> writes:
>>
>> > I think we need to make sure that we give instructions for how to 
>> > go
>> > back if the default hasn't done what you wanted.  Something like 
>> > this:
>> >
>> >     Your pull did not fast-forward, so Git has merged '$upstream' 
>> > into
>> >     your branch, which may not be correct for your project.  If you
>> >     would rather rebase your changes, run
>> >
>> >         git rebase
>> >
>> >     See "pull.mode" in git-config(1) to suppress this message in 
>> > the
>> >     future.
>>
>> Sounds good to me. One option is to display the warning on the
>> command-line, and another option is to show it in COMMIT_EDITMSG 
>> (since
>> we now default to showing it even for non-conflicted merges).
>
> I hadn't though of that, but showing it in COMMIT_EDITMSG is a great
> moment, because you are notifying the user _before_ they create a 
> merge
> commit. So the backout/switch procedure is "cancel this by giving an
> empty message, then re-run git pull --rebase".
>
> On the other hand, if we run into conflicts, you'd probably want to 
> let
> them know before asking them to resolve them all. So perhaps a 
> separate
> message would be needed for that case (to suggest "reset --merge && 
> git
> pull --rebase").

In fact this [running into conflicts unexpectedly] is usually my use 
case, which I mis-described as a no-ff in an earlier reply.

Usually I'd want a clean rebase before submitting patches, but I can see 
other uses cases where there is a desire that branches show where they 
started so rebase wouldn't be appropriate.

It should not be necessary to give prescriptions about how to backout of 
a difficult corner, rather give details about how to go forward after 
stopping safely and early. The urge to press on (various proposals)  may 
not be the right thing.

Philip 
