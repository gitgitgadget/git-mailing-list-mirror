From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: sparse fetch, was Re: [PATCH 08/12] git-clone: support --path to do sparse clone
Date: Thu, 24 Jul 2008 21:01:15 +0200
Message-ID: <bd6139dc0807241201v50cd5ef2m58ee7efc05119e20@mail.gmail.com>
References: <20080723145718.GA29134@laptop>
	 <20080724171952.GB21043@sigill.intra.peff.net>
	 <alpine.DEB.1.00.0807241837441.8986@racer>
	 <20080724185332.GQ32184@machine.or.cz>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jeff King" <peff@peff.net>,
	"=?ISO-8859-1?Q?Nguy=3Fn_Th=E1i_Ng=3Fc_Duy?=" <pclouds@gmail.com>,
	git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jul 24 21:02:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM64w-0003Hf-D1
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 21:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbYGXTBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 15:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752718AbYGXTBS
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 15:01:18 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:35364 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbYGXTBR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 15:01:17 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1288521ywe.1
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 12:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=CcRYmQPIfwLJNmX0CgnHSlNF65U3OmwM8g41BKFxYJM=;
        b=iB6FXhKOerXBHWPHhp1pHdxpjiPUzpcmzPE0Qg4El0aZzArD1NSe/KnZDridtMuLzn
         xVv/phSUEv1rjadeC/X9nLfyB/VosBFncmEx870SGw7/lyAfsGf4d5etS1kRHE4bTAj7
         A5WecOohrex9wxbhyui1Gf3ohSxewu/+dmC0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=FDB4hkdXBSp/ztoJQkidfm+uFPzDurk5TvggQ+2cXmwqVkiI5DiePb2Hai8l+1RTDb
         QB1opGfkfoyH6lkj6izUpsyYIbAPMamI1jonpdgZXcyz2DaOUv1MygKFhnI4y1JOUskW
         ikbl8NHqgWPZmiKxuEhtfzahXjdobx+0ccPjA=
Received: by 10.142.135.16 with SMTP id i16mr219805wfd.144.1216926075252;
        Thu, 24 Jul 2008 12:01:15 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Thu, 24 Jul 2008 12:01:15 -0700 (PDT)
In-Reply-To: <20080724185332.GQ32184@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89943>

On Thu, Jul 24, 2008 at 8:53 PM, Petr Baudis <pasky@suse.cz> wrote:
>  I don't follow how these two issues arise, if the server will do the
> pruning for you. It will just skip entering some tree objects when doing
> object traversal; why opening the git protocol or faking commits? This
> would be a simple extra capability in the protocol.

Wouldn't that be as simple as passing a pathspec to git-rev-list? Not
a lot of overhead there I reckon.

> One question is what to do with delta chains including unwanted
> objects, but I think that given the objects' associativity for delta
> chains, this shouldn't be huge practical issues and it could be
> affordable in principle to include even unwanted objects.

Just keep them? What we're doing here is trying to optimize in the
case that someone has a sparse checkout, nothing bad will happen if
they get too many info surely? (Save for them not getting as much
improvement as would have been possible would the pack have been
created differently.)

-- 
Cheers,

Sverre Rabbelier
