From: Yaroslav Halchenko <yoh@onerussian.com>
Subject: Re: problems serving non-bare repos with submodules over http
Date: Wed, 20 Apr 2016 23:14:26 -0400
Message-ID: <20160421031426.GY23764@onerussian.com>
References: <20160420152209.GH23764@onerussian.com>
 <CAGZ79kYS-F1yKpNP7jmhTiZT1R_pucUBBTCbmHKZz6Xd6dy8EA@mail.gmail.com>
 <xmqqh9ewukhw.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZMOv0r9fRFbP1WV8qFJBm+s=V8=ueFbYvnyFtgV8j9iQ@mail.gmail.com>
 <xmqqshygt1gs.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbyDuu8hUQXOUNmDLyO88GOi3kqSzsc0UfgzwAL9peZHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Gurus hangout <git@vger.kernel.org>,
	Benjamin Poldrack <benjaminpoldrack@gmail.com>,
	Joey Hess <id@joeyh.name>, Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 05:14:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1at54h-0004Xs-HQ
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 05:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbcDUDOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 23:14:32 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:39579 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbcDUDOa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 23:14:30 -0400
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
	by smtp.onerussian.com with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <yoh@onerussian.com>)
	id 1at54U-0008Mn-HA; Wed, 20 Apr 2016 23:14:26 -0400
Received: from yoh by washoe.onerussian.com with local (Exim 4.84)
	(envelope-from <yoh@onerussian.com>)
	id 1at54U-0008Mi-7W; Wed, 20 Apr 2016 23:14:26 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kbyDuu8hUQXOUNmDLyO88GOi3kqSzsc0UfgzwAL9peZHg@mail.gmail.com>
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: sbeller@google.com, gitster@pobox.com, git@vger.kernel.org, benjaminpoldrack@gmail.com, id@joeyh.name, Jens.Lehmann@web.de
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292092>

NB Thank you for the lively discussion!

On Wed, 20 Apr 2016, Stefan Beller wrote:

> >> So currently the protocol doesn't allow to even specify the submodules
> >> directories.

> > Depends on what you exactly mean by "the protocol", but the
> > networking protocol is about accessing a single repository.  It is
> > up to you to decide where to go next after learning what you can
> > learn from the result, typically by following what appears in
> > the .gitmodules file.

> Right. But the .gitmodules file is not sufficient.

why?

> >...<

> I think on a hosting site they could even coexist when having the
> layout as above.

>          top.git/
>          top.git/refs/{heads,tags,...}/...
>          top.git/objects/...
>          sub.git/
>          sub.git/refs/{heads,tags,...}/...
>          sub.git/objects/...

>          # the following only exist in non bare:
>          top.git/modules/sub.git/
>          top.git/modules/sub.git/refs/{heads,tags,...}/...
>          top.git/modules/sub.git/objects/...

> The later files would be more reflective of what you *really*
> want if you clone from top.git.

may be there is no need for assumptions and .gitmodules should be
sufficient?

- absolute url in .gitmodules provides absolute URL/path to the
  submodule of interest, regardless either submodule is present in
  originating repository as updated submodule.  Either cloning it
  instead of original repository would be more efficient is already a
  heuristic which might fail miserably (may be I have a faster
  connection to the original repository pointed by the absolute
  url than to this particular repository)

- relative url in .gitmodules provides relative location to the location
  of the "top" repository, and that is only when that submodule "absolute"
  url should be resolved relative to the one of the "top" repository 

NB I will consider it a separate issue either relative paths
without '../' prefix are having any sense in bare repositories.

or have I missed the point?
-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
