From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2] gitweb: Better regexp for SHA-1 committag match
Date: Sat, 7 Feb 2009 11:09:27 +0100
Message-ID: <200902071109.27894.jnareb@gmail.com>
References: <200902022204.46651.toralf.foerster@gmx.de> <200902071025.02491.jnareb@gmail.com> <9b18b3110902070132h2401a2f1w7abefa1c9906a567@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 11:14:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVkCQ-00046P-L1
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 11:14:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbZBGKI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 05:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752420AbZBGKI2
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 05:08:28 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:15690 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbZBGKI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 05:08:27 -0500
Received: by fg-out-1718.google.com with SMTP id 16so709728fgg.17
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 02:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=rqPRYFSowzR/ri/uGv22HMe8yi9g3MEDC9IHc/sjQb4=;
        b=hUldkDqYkeJRKp6CgJ3VQm4AeNUKsyCocN50lItjck1S33+C6q6sGtE/dBSPI3RlDF
         TH+tku/Fqal+w/VcN8rfhtM4aPhaw0/Zhivsf4S9YdmAIot9bZir23xOuwB068O9RX+A
         x6KvL4w4FrnBo59KbjIYWCz37kdYjR7pUyoP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=uv9UoN1wldYNmKoe1a2JzwUDP0a8mb//LpD34UfZ7XMYre4uudXqvAxc0OkBtRUhOx
         bXmtjo8QzFjBAQHlaG08NHjA83UeXvN0JIP7t48Ti5tKuLtjy9eXc/eoGwfrnkkT7mg1
         p+92Am2D3cJu2vBZYpUOOlVDAiPnhpujaD3GA=
Received: by 10.86.86.12 with SMTP id j12mr242888fgb.1.1234001305386;
        Sat, 07 Feb 2009 02:08:25 -0800 (PST)
Received: from ?192.168.1.13? (abwn77.neoplus.adsl.tpnet.pl [83.8.237.77])
        by mx.google.com with ESMTPS id 3sm2462788fge.42.2009.02.07.02.08.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Feb 2009 02:08:24 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <9b18b3110902070132h2401a2f1w7abefa1c9906a567@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108837>

On Sat, 7 Feb 2009, demerphq wrote:
> 2009/2/7 Jakub Narebski <jnareb@gmail.com>:
>> Junio C Hamano wrote:
>>> Jakub Narebski <jnareb@gmail.com> writes:
>>>
>>>> It would unfortunately falsely match... but we cannot eliminate this
>>>> case (well, at least not checking if hexnumber is followed by dot),
>>>> because of totally legitimate
>>>>
>>>>    ... at commit 8457bb9e.
>>>>
>>>> So even with that we would have still false matches...
>>>
>>> Yeah, so what's the value in v2 over v1?  It is still wrong but it is less
>>> wrong than it used to be?  I think the word-boundary one made a good
>>> sense.  I do not see the @lookahead adding much value at all.
>>
>> Right. So v2 is less useful that I thought it to be; and adding further
>> "exceptions" doesn't seem like a good idea.  The 'msgid' committag
>> when/if it gets implemented would help there...
>>
>> So please take v1, as it is sane improvement and generic enough.
> 
> If you make it configurable then everybody can be happy right?

That are the long term plans, to implement generic 'committags' support
(which would include current SHA-1 and signoff committags).

BTW. it is the 'configurable' part that makes it difficult... ;-)
-- 
Jakub Narebski
Poland
