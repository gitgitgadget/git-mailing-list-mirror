From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 1/2] diff --stat: use asymptotic scaling in graph
Date: Thu, 12 Oct 2006 15:20:09 -0700
Message-ID: <452EBF99.5020108@gmail.com>
References: <d620685f0610121237k458665c5m7bbde2d565d7ef81@mail.gmail.com>	 <20061012201646.GC10922@admingilde.org> <d620685f0610121437m38eb454g7597b2a93010b023@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 00:32:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY8ub-0001Wm-AO
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 00:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWJLWUQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 18:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWJLWUQ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 18:20:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:18906 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751203AbWJLWUO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 18:20:14 -0400
Received: by nf-out-0910.google.com with SMTP id x30so716961nfb
        for <git@vger.kernel.org>; Thu, 12 Oct 2006 15:20:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=EkG52vvdZp45NWCld+8m+a9G+UdgolW487cgNpRNcJaii/ZOL9WJsEMd6/8YluDG1iWd+HsUQzK8lVUh4FEkO7lDojlzBaI94tHtoEn2Y+9Gz4cEuh3+9TeM4okLNHnlRhSSoqeUDIjSfSoeHqr2R9pukh9MkrRF/pLAKeh5ApE=
Received: by 10.78.201.8 with SMTP id y8mr2863959huf;
        Thu, 12 Oct 2006 15:20:13 -0700 (PDT)
Received: from ?10.0.0.6? ( [68.233.231.217])
        by mx.google.com with ESMTP id 28sm2608806hua.2006.10.12.15.20.11;
        Thu, 12 Oct 2006 15:20:13 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: apodtele <apodtele@gmail.com>
In-Reply-To: <d620685f0610121437m38eb454g7597b2a93010b023@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28807>

apodtele wrote:
> On 10/12/06, Martin Waitz <tali@admingilde.org> wrote:
>> On Thu, Oct 12, 2006 at 03:37:17PM -0400, apodtele wrote:
>> > Instead of conditionally scaling the stat graph for large changes,
>> > always scale it asymptotically: small changes shall appear without any
>> > distortions.
>>
>> very nice idea!
>>
>> > +     return it * width / (it + width) + 1;
>>
>> but wouldn't this formula result in at least 1, even for a 0 change?
>> Perhaps we'd have to special case an input of 0?
[...]
> +    if (it)
> +        return it * width / (it + width) + 1;
> +    else
> +        return 0;

No conditional needed:

	return it * width / (it + width - 1)
