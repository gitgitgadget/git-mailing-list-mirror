From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Thu, 04 Apr 2013 23:20:06 +0200
Message-ID: <515DEE86.3020301@web.de>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com> <CA+55aFz1D_dMtMHHMpiGi3KL=Y-m4DVxHVr=1ZX8zYWQ2TPvwA@mail.gmail.com> <CALkWK0nNjvV5VGvT_eaubFoOhMnJ-N8FECAayd5A2K3BzeRh6Q@mail.gmail.com> <CA+55aFyQwJfiYo06y1bRNpKT6wOquhG9a9M_4YvLG_UT3b34-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 23:21:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNrah-0006Bl-Qq
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 23:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764300Ab3DDVUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 17:20:11 -0400
Received: from mout.web.de ([212.227.15.4]:51493 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764260Ab3DDVUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 17:20:09 -0400
Received: from [192.168.178.41] ([79.193.90.93]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MPowc-1UK1pN12bS-0052QE; Thu, 04 Apr 2013 23:20:07
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <CA+55aFyQwJfiYo06y1bRNpKT6wOquhG9a9M_4YvLG_UT3b34-w@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:EBXXt5QAj1FHxypWu9Y95iZjx84k2rOKLhjGY1+LEE0
 zjAoaapVkvQnMii/31/SLzAsHdLI+ABzknvqR/Gifpyhy4s1vn
 x/1WH/UolPfKBrMF+QT4uY7iL647VmvarXE1wBieDstPrd9Vpx
 C9XBBNYNrQ8nD0vKGwbO1IVK2RGUoV1LhLEpJqgVUOJrE5N7fg
 lmh0yA8nlLvKLH+KlfaNg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220109>

Am 04.04.2013 21:04, schrieb Linus Torvalds:
> My gut feel is that yes, .gitmodules was always a bit of a hack, but
> it's a *working* hack, and it does have advantages exactly because
> it's more fluid than an actual git object (which by definition has to
> be set 100% in stone).

Exactly. The flexibility of the .gitmodules file will really help us
when it comes to the next feature that submodules are going to learn
after recursive update: automatically initialize and then populate
certain submodules during the clone of the superproject. You have to
be able to configure that per submodule, which needs a new config
option in .gitmodules. Others may follow for different use cases.

While starting to grok submodules I was wondering myself if the data
stored in .gitmodules would better be stored in an extended gitlink
object, but I learned soon that the scope of the data that has to be
stored there was not clear at that time (and still isn't). So I'm
not opposed per se to adding a special object containing all that
information, but I strongly believe we are not even close to
considering such a step (and won't be for quite some time and maybe
never will).
