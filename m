From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to	significantly
 speed up packing/walking
Date: Thu, 06 Aug 2009 19:43:16 -0400
Message-ID: <4A7B6A94.9020200@gmail.com>
References: <op.ux8i6hrbtdk399@sirnot.private> <alpine.DEB.1.00.0908061645470.8306@pacific.mpi-cbg.de> <4A7AEFA8.5010001@drmicha.warpmail.net> <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com> <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de> <c77435a80908061301n5e855aeci16af392ed3128651@mail.gmail.com> <c77435a80908061330h2461012at8b877970cab4906b@mail.gmail.com> <20090806203223.GK1033@spearce.org> <4A7B68C4.8070406@gmail.com> <20090806233739.GL1033@spearce.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nick Edelen <sirnot@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Sam Vilain <sam@vilain.net>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 07 01:43:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZCcV-00033P-B7
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 01:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756932AbZHFXnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 19:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756587AbZHFXnV
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 19:43:21 -0400
Received: from mail-yw0-f177.google.com ([209.85.211.177]:35035 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756597AbZHFXnT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 19:43:19 -0400
Received: by ywh7 with SMTP id 7so1638602ywh.21
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 16:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=EA7RTyJQJYcUoJSXzOm6ym4uSSAC74jbrlfIMfJA5i0=;
        b=CQhqIPebrLIhvWM4/CcV11Pqv5X8I7EAp7IHDTgNtqsdIRrw7QH3yNg7TDdqyxVr6+
         dDE88Ovkmv/Cb266wHrkV81PGp+TAqF3cZAMQ9Zr3hGcTnMOxsByITiM/2pRNKk77B8W
         m7nHpn9+AUIXLYrnyHZv0+tSQlhqZt/SIX8qQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=mNNc2qa5aCIciV7RphPsgRTu5LyfnRAr8Ggf2WWNIToFw1mu5DKk5vkzammVCHrRRy
         7LFmjGIt4LWUvMoZkHDNnDOkLIYaBRqYpJIDzsQFYz5VJn67q5eWBWEiqrh1tkrUkXNP
         sCRiSrT00HOH2r77bpDDcND7BQwoOtu8y4+wI=
Received: by 10.90.100.20 with SMTP id x20mr364956agb.45.1249602198663;
        Thu, 06 Aug 2009 16:43:18 -0700 (PDT)
Received: from ?10.0.0.6? (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 20sm1221993agd.63.2009.08.06.16.43.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 16:43:17 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20090806233739.GL1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125144>

Shawn O. Pearce wrote:
> A Large Angry SCM <gitzilla@gmail.com> wrote:
>> Shawn O. Pearce wrote:
>>> Nick Edelen <sirnot@gmail.com> wrote:
>>>> Hrmm, I just realized that it dosn't actually cache paths/names...
>>> You may not need the path name, but instead the hash value that
>>> pack-objects computes from the path name.
>> Please do NOT expose the hash values. The hash used by pack-objects is  
>> an implementation detail of the heuristics used by the _current_ object  
>> packing code. It would be a real shame to have to maintain backward  
>> compatibility with it at some future date after the packing machinery  
>> has changed.
> 
> This is a local cache.  If there was a version number in the header,
> and the hash function changes, we could just bump the version number
> and invalidate all of the caches.
> 
> No sense in storing (and doing IO of) huge duplicate string values
> for something where we really only need 32 bits, and where a
> recompute from scratch only costs a minute.
> 

That will work for me if the cache gets a version number and iff the 
pack-objects hash code gets big warning comments about the cache code 
dependency.
