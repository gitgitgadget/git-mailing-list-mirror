From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: Git-aware HTTP transport
Date: Tue, 26 Aug 2008 10:45:41 +0600
Message-ID: <7bfdc29a0808252145k40c41993h4e3504a6aff66e12@mail.gmail.com>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com>
	 <20080826034544.GA32334@spearce.org>
	 <alpine.DEB.1.10.0808252052350.29665@asgard.lang.hm>
	 <48B38377.3050901@zytor.com>
	 <alpine.DEB.1.10.0808252121510.30743@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Tue Aug 26 06:46:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXqS7-00062x-RR
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 06:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbYHZEpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 00:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbYHZEpn
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 00:45:43 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:41916 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbYHZEpm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 00:45:42 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1056137yxm.1
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 21:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=HiZeV7Prwpfw+7d2fuucJvecU3vjHTygFLbb+6U92Qs=;
        b=FubVR9zCV4sc0exuqR/Lz3mozPJz2O9/+cKCn7IOIfpm67/mefWDK9QOKmk5HaEgCZ
         DhqWoZmtVojeg00zj1IxyqujD+usNnZn3bhO5/YidHzCPUyK//nu7svasNvDWwq/w59C
         9ZODEB1GtIO5gu9FkFTGAcydKtWvOlgaYM0pM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Ka5m7wJiwxl4ZSbO3QZxF40FpFHBs/FV08NBITnUrllHtM4qdZvDsDpBaJuZX/1Scb
         li45hkUPSHqMZCuLE9zNEG5EdbyBVoVNAsnAw+ywQ9NGpZHEdqhEvu+qmSutVzHCG1Hs
         7SupZ8nyAXZNLxLVJUgJ/WpvAeg8P5TDLNo7w=
Received: by 10.150.122.13 with SMTP id u13mr8476485ybc.63.1219725941905;
        Mon, 25 Aug 2008 21:45:41 -0700 (PDT)
Received: by 10.150.225.1 with HTTP; Mon, 25 Aug 2008 21:45:41 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0808252121510.30743@asgard.lang.hm>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93710>

On Tue, Aug 26, 2008 at 10:25 AM,  <david@lang.hm> wrote:
> On Mon, 25 Aug 2008, H. Peter Anvin wrote:
>
>> david@lang.hm wrote:
>>>
>>> on the other hand, it would be a good thing if pack files could be
>>> cached.
>>>
>>> in a peer-peer git environment the cache would not be used very much, but
>>> when you have a large number of people tracking a central repository (or
>>> even a pseudo-central one like the kernel) you have a lot of people
>>> upgrading from one point to the next point.
>>>
>>
>> Worth noting that this also applies to the raw git protocol.
>
> IIRC the native git server will use existing packs when it can.
>
> it would be interesting to modify git to record what packs it generates and
> then see how much a big server (like kernel.org) would re-use a pack under
> different caching strategies.

I fully agree with the caching logic as well. In this regard I was
thinking whether the protocol could be modified a bit to accommodate
it or not. From initial proposal GET was dropped because there will be
caching, which I also agree :), and we need GET in order to achieve
cache - so I would have done something such as - initial request would
be POST and if there is no change and cache can be used I would
redirect it to a equivalen GET URL and if cache is invalid (which the
server can track by pinging the GET URL) serve directly through the
POST method untill either the GET is out of the cache or is updated.

- Imran

>
> David Lang
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Imran M Yousuf
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
