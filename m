From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH np/pack-v4] index-pack: tighten object type check based on
 pack version
Date: Wed, 18 Sep 2013 10:39:07 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309181024290.20709@syhkavp.arg>
References: <1379507129-27151-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_SLciwkvwZcAUhEsWGI6HhQ)"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 18 16:39:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMIv0-0001Do-0C
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 16:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511Ab3IROjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 10:39:46 -0400
Received: from relais.videotron.ca ([24.201.245.36]:49165 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344Ab3IROjp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 10:39:45 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MTB004I8SP7VAC0@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 18 Sep 2013 10:39:07 -0400 (EDT)
In-reply-to: <1379507129-27151-1-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234967>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_SLciwkvwZcAUhEsWGI6HhQ)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Wed, 18 Sep 2013, Nguyễn Thái Ngọc Duy wrote:

> In pack version 4, ref-delta technically could be used to compress any
> objects including commits and trees (both canonical and v4). But it
> does not make sense to do so. It can only lead to performance
> degradation. Catch those packers.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  I could now verify that pack-objects does not compress commits nor
>  trees using ref-delta in v4. But perhaps these are a bit too strict?
>  Maybe downgrade from die() to warning() and still accept the pack?

Even then...  There is a difference between an "invalid" pack and a 
"suboptimal" one.  I don't think we should complain when presented with 
suboptimal encoding if it is still valid and there is no problem 
actually processing the data correctly.  You never know when this 
alternative encoding, even if suboptimal, might be handy.

Robustness principle: Be conservative in what you send, be liberal in 
what you accept.


Nicolas

--Boundary_(ID_SLciwkvwZcAUhEsWGI6HhQ)--
