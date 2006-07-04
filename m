From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Additional merge-base tests
Date: Tue, 04 Jul 2006 13:18:57 -0700
Message-ID: <44AACD31.70702@gmail.com>
References: <44A9E6AE.10508@gmail.com> <7v3bdhoraa.fsf@assigned-by-dhcp.cox.net> <44AA0DAE.1060308@gmail.com> <7vpsgllsnp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0607041019580.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jul 04 22:19:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxrMP-0005Rr-Hq
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 22:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWGDUTB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 16:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWGDUTB
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 16:19:01 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:51751 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932380AbWGDUTA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 16:19:00 -0400
Received: by wr-out-0506.google.com with SMTP id 69so817283wra
        for <git@vger.kernel.org>; Tue, 04 Jul 2006 13:18:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=j0bdt7zBdZvgvhelW83yBjUykuNzGbwmwcymDmcP3KDkHpfllyA1DVFlO/k5rUAE+LyQtN8YG079xYvdVv8f2M6enKU0+BDJDntU4rX+Xv+zwTlI28c0x9q/FhCVFaJAbRsXqCOYfKVe6Y3SHdjir3TnKlyYJ2kWI2ScyKovjuI=
Received: by 10.65.218.8 with SMTP id v8mr4457857qbq;
        Tue, 04 Jul 2006 13:18:59 -0700 (PDT)
Received: from ?10.0.0.6? ( [69.160.147.208])
        by mx.gmail.com with ESMTP id e16sm1154016qbe.2006.07.04.13.18.58;
        Tue, 04 Jul 2006 13:18:59 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060411)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0607041019580.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23314>

Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 4 Jul 2006, Junio C Hamano wrote:
> 
>> A Large Angry SCM <gitzilla@gmail.com> writes:
>>
>>>> This is a good demonstration that merge-base may not give you
>>>> minimal set for pathological cases.  If you want to be through
>>>> you could traverse everything to make sure we do not say 'S' is
>>>> relevant, but that is quite expensive, so I think there will
>>>> always be artifacts of horizon effect like this no matter how
>>>> you try to catch it (didn't I keep saying that already?).
>>> The problem is in mark_reachable_commits(); it is either superfluous
>>> or it needs to parse_commit() those commits that haven't been parsed
>>> yet that it needs to traverse.
>> Yes, you could traverse everything.  But that is not practical.
>> We have known that the clean-up pass has this horizon effect,
>> and it is a compromise.
> 
> We could introduce a time.maximumSkew variable, and just walk only 
> that much further when traversing the commits.
> 
> So, if you do not trust your clients to have a proper ntp setup, just say 
> "I trust my peers to be off at most 1 day". That would save lots vs 
> traverse-everything.

The fuzz would only serve to mask, even more, that the heuristic is 
broken. But, it would also allow the (broken) heuristic to be used _and_ 
let the user decide how much effort may be used to find the correct bases.

If this happens, it should be (yet another) user configurable; either, 
per repository, command line, or both.
