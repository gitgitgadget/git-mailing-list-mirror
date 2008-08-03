From: david@lang.hm
Subject: Re: More on git over HTTP POST
Date: Sun, 3 Aug 2008 01:10:37 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0808030105510.22058@asgard.lang.hm>
References: <48938539.9060003@zytor.com> <20080802205702.GA24723@spearce.org> <20080803025602.GB27465@spearce.org> <7v63qiydzg.fsf@gitster.siamese.dyndns.org> <48952A62.6050709@zytor.com> <20080803041014.GD27465@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Aug 03 10:11:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPYgE-0007MX-Hz
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 10:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752959AbYHCIKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 04:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752761AbYHCIKC
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 04:10:02 -0400
Received: from mail.lang.hm ([64.81.33.126]:37952 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734AbYHCIKA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 04:10:00 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m7389kIs026249;
	Sun, 3 Aug 2008 01:09:46 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20080803041014.GD27465@spearce.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91215>

On Sat, 2 Aug 2008, Shawn O. Pearce wrote:

> 
> "H. Peter Anvin" <hpa@zytor.com> wrote:
>> Junio C Hamano wrote:
>>>  For example, putting them [capabilities] on extra HTTP headers is probably Ok.
>>
>> I think that would be a mistake, just because it's one more thing for
>> proxies to screw up on.
>
> I didn't realize we were in an era of proxies that are that
> brain-damaged that they cannot relay the other headers.  The Amazon
> S3 service relies heavily upon their own extended headers to make
> their REST API work.  If proxies stripped that stuff out then the
> client wouldn't work at all.
>
> IOW I had thought we were past this dark age of the Internet.

actually, it's not just a matter of not getting 'past this dark age of the 
Internet', it's an issue that so many people are tunneling _everyting_ 
over http (including the bad guys tunneling malware) that proxies are 
getting more aggressive then they have ever been before in pulling apart 
the payload and analysing it before letting it get through to the far 
side.

David Lang

>> It's better to have negotiation information in
>> the payload, before the "real" data.
>
> I guess I could do that.  At least for the really complex stuff.
>
>> Obviously one thing that needs to be included in each transaction is a
>> transaction ID that will be reported back on the next transaction, since
>> you can't rely on a persistent connection.
>
> No.  That requires the server to maintain state.  We don't want to
> do that if we can avoid it.  I would much rather have the clients
> handle the state management as it simplifies the server side,
> especially when you start talking about reverse proxies and/or
> load-balancers running in front of the server farm.
>
>
