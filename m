From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Mon, 22 Feb 2010 16:33:27 +0300
Message-ID: <20100222133327.GH10191@dpotapov.dyndns.org>
References: <201002131539.54142.trast@student.ethz.ch>
 <20100213162924.GA14623@Knoppix>
 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
 <20100218013822.GB15870@coredump.intra.peff.net>
 <alpine.LFD.2.00.1002172350080.1946@xanadu.home>
 <7vocjnqf5c.fsf@alter.siamese.dyndns.org>
 <4B827FC6.1090905@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 14:37:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjYPx-0006KJ-AM
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 14:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821Ab0BVNdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 08:33:40 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:33003 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab0BVNdj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 08:33:39 -0500
Received: by fxm19 with SMTP id 19so2485606fxm.21
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 05:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=38TssKQc5njtfmlftWhImqKEcOab67ZxOv9awa2cGJY=;
        b=ZO5FcN+84R5o/hHtxdeOF82QqRqxgklSv6pLuGO1LPhlGEMj/FQ1Wn1ezbSUP2qtfV
         a+wueZvMzEvScR5Y0K5F/Hrm95XLQJI2Pr+SjVI9wUrpuQZzhLLOEBi31KPZYEjANDa2
         Q2w7iQYn3hFxAOVo1+OCFt3mXL6QLevkEFCkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CN071fET0P4BRBo8utO7cReJS06eSt7DSET+ZW7hlHlx7GYc2STZIVHtjPFeOIfv8o
         vVOZ3M4YCxDhzBM1YLX7FANd3HlB25L4au8y0C++SiNJShoihQ+ofKVjMbm8jHfojoZ/
         WjHDhOjvLZa9QL41l+XsFPd+rpvWbNX5zZ9zk=
Received: by 10.223.100.129 with SMTP id y1mr6784254fan.15.1266845617793;
        Mon, 22 Feb 2010 05:33:37 -0800 (PST)
Received: from localhost (ppp91-77-227-64.pppoe.mtu-net.ru [91.77.227.64])
        by mx.google.com with ESMTPS id k29sm5020813fkk.45.2010.02.22.05.33.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Feb 2010 05:33:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B827FC6.1090905@gnu.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140682>

On Mon, Feb 22, 2010 at 01:59:50PM +0100, Paolo Bonzini wrote:
> On 02/18/2010 06:36 AM, Junio C Hamano wrote:
> >
> >In any case, with any size of paranoia, this hurts the sane use case
> 
> Because by mmaping + memcpying you are getting the worst of both
> cases: you get a page fault per page like with mmap, and touch
> memory twice like with read.

and there is also an extra round of SHA-1 calculation, which I believe
is more expensive than memcpy().


Dmitry
