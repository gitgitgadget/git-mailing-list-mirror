From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH 1/2] diff --stat: use asymptotic scaling in graph
Date: Fri, 13 Oct 2006 14:31:32 +0100
Message-ID: <452F9534.1030109@shadowen.org>
References: <d620685f0610121237k458665c5m7bbde2d565d7ef81@mail.gmail.com>	 <20061012201646.GC10922@admingilde.org>	 <d620685f0610121437m38eb454g7597b2a93010b023@mail.gmail.com>	 <452EBF99.5020108@gmail.com> <20061012222703.GA31152@admingilde.org>	 <452EC625.7050301@gmail.com>	 <Pine.LNX.4.64.0610122038330.2435@xanadu.home> <d620685f0610130625o2d5f70c5p7cb41f567093df32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 15:33:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYN9I-0003fr-Uv
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 15:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWJMNcZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 09:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWJMNcZ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 09:32:25 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:33797 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1750735AbWJMNcY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Oct 2006 09:32:24 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GYN8O-0000hU-EG; Fri, 13 Oct 2006 14:31:32 +0100
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
To: apodtele <apodtele@gmail.com>
In-Reply-To: <d620685f0610130625o2d5f70c5p7cb41f567093df32@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28845>

apodtele wrote:
> Hi!
> 
> On 10/12/06, Nicolas Pitre <nico@cam.org> wrote:
>> On Thu, 12 Oct 2006, A Large Angry SCM wrote:
>> > Martin Waitz wrote:
>> > > On Thu, Oct 12, 2006 at 03:20:09PM -0700, A Large Angry SCM wrote:
>> > > > > +    if (it)
>> > > > > +        return it * width / (it + width) + 1;
>> > > > > +    else
>> > > > > +        return 0;
>> > > > No conditional needed:
>> > > >
>> > > >  return it * width / (it + width - 1)
>> > >
>> > > But then it would start scaling much earlier
>> > > (for width 10: at 2 instead of 4).
>> > > This is not bad per se, but different...
>> > >
>> >
>> > OK:
>> >       return (it * width + (it + width)/2)) / (it + width - 1)
>> >
>> > Now it's back at 4. ;-)
>>
>> Sure, but at this point the original conditional is probably more
>> efficient.
>>
> 
> Don't make me use
>            return it * width / (it + width) + !!it;
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


return it * width / (it + width) + (it != 0)

Perhaps?

-apw
