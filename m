From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] Disambiguate "push not supported" from
	"repository not found"
Date: Fri, 29 Aug 2008 07:31:16 -0700
Message-ID: <20080829143116.GB7403@spearce.org>
References: <1219969118-31672-1-git-send-email-spearce@spearce.org> <200808291120.44413.robin.rosenberg@dewire.com> <48B7E927.2000205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 16:34:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ52i-0001LZ-7f
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 16:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758783AbYH2ObU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 10:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758778AbYH2ObT
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 10:31:19 -0400
Received: from george.spearce.org ([209.20.77.23]:56874 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758765AbYH2ObS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 10:31:18 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D756C38376; Fri, 29 Aug 2008 14:31:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48B7E927.2000205@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94289>

Marek Zawirski <marek.zawirski@gmail.com> wrote:
> Robin Rosenberg wrote:
>> fredagen den 29 augusti 2008 02.18.38 skrev Shawn O. Pearce:
>>> +				if (avail.isEmpty())
>>> +					throw noRepository();
>>>  				throw eof;
>>>  			}
>>>  @@ -185,6 +182,10 @@ else if (this instanceof FetchConnection)
>>>  		available(avail);
>>>  	}
>>>  +	protected TransportException noRepository() {
>>> +		return new NoRemoteRepositoryException(uri, "not found.");
>>> +	}
>>> +
>>
>> Why an extra method for instantiating the exception?
>
> Isn't it overrode in subclass - BasePackPushConnection?

Correct.  I introduced the method so the subclass can inject its
own implementation for the catch block.  But its required to give
back a TransportException so the catch block can throw it, as we
do not want the subclass to be able to continue at this point.

-- 
Shawn.
