From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: non-empty index with git commit -a
Date: Wed, 16 Feb 2011 02:44:53 -0600
Message-ID: <20110216084452.GC3345@elie>
References: <AANLkTi=5E8D0mwMDNuMdgZS69kOnKCfs=Q8X5bpcjnYF@mail.gmail.com>
 <20110216023645.GA7085@sigill.intra.peff.net>
 <20110216032047.GA2858@elie>
 <AANLkTinbcHW+ja7T=PiCEorNdnK6W2DvA_c9F8JTEMKB@mail.gmail.com>
 <AANLkTikmxHQpir5YbiBihASL1SYf_AyoUHKT3nqKS-iP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 09:45:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppd0k-0002rI-NF
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 09:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755636Ab1BPIpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 03:45:04 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56152 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759Ab1BPIpA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 03:45:00 -0500
Received: by gxk9 with SMTP id 9so491670gxk.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 00:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=rFf8WElb1tI2xEjTGzCO+gg7WOwEmJVWlCSAA2qm7Bg=;
        b=F2P0WBAKeIGOhYq/80Le8/kFlwuH9h4J+zpDfNOv+GQVN9m0ZU92hbjoqtNSfAwaxn
         qa0mKbVg219SydUxQ7BgUoDgMMe9iM9TDz8RFE8svjGd+1dQNty/w70ywl63ay+SKd2u
         f6z1nL5luUFT1BMb+JmPtIghSP9W5JouHN2Nc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=w9YXL3Arwbum0qrVF7BgyPQ7Kg3wyH6gyRGIRCIdAOuHSmE6hKa/tc7VR0I+/QB5Lw
         ZTXTpFeOydKg/l8Z4jXYu6UuTm/dvepOg0EJSGeZH61ktthsYSZxSDYrcnNez/pg5sKY
         1jhPXUIprf4MP1FZLwGvjmIN4NC0ZIK7MElrQ=
Received: by 10.146.168.5 with SMTP id q5mr460659yae.18.1297845899752;
        Wed, 16 Feb 2011 00:44:59 -0800 (PST)
Received: from elie (adsl-69-209-51-217.dsl.chcgil.ameritech.net [69.209.51.217])
        by mx.google.com with ESMTPS id x5sm2990529yhc.38.2011.02.16.00.44.57
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Feb 2011 00:44:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikmxHQpir5YbiBihASL1SYf_AyoUHKT3nqKS-iP@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166931>

Nguyen Thai Ngoc Duy wrote:
> On Wed, Feb 16, 2011 at 3:18 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> On Wed, Feb 16, 2011 at 03:20, Jonathan Nieder <jrnieder@gmail.com> wrote:

>>> If I remember the discussion[1] correctly, by requiring a separate
>>> add -u step (or commit -f -a) if the "I don't trust my fingers"
>>> configuration is enabled.
>>
>> That would definitely work for me. The question then is, should git
>> consider the index precious by default, or not? That is, should that
>> value default to true in 1.8?
>
> Is it insane that "git commit -a" still commits everything, but then
>
> 1. If old index is different from old HEAD, keeps index as is and warn users
> 2. If old index is the same as old HEAD, update index with new HEAD
>
> ?

Yes, I think that would be very confusing. :)

My take on Sverre's question: this doesn't seem to fit the "bad choice
made long ago and finally we have a chance to fix it" mold.  More like
"nice new feature that could break muscle memory".  So I don't think
it makes sense to tie it to 1.8.

If I were writing the patch, I'd provide the configuration and hope
that the experience of using it could help with deciding on a good
default behavior.
