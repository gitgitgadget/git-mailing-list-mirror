From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2] submodule: add 'deinit' command
Date: Wed, 12 Dec 2012 18:22:51 +0100
Message-ID: <50C8BD6B.9010702@web.de>
References: <20121130032719.GE29257@odin.tremily.us> <50B54A68.60309@web.de> <20121130175309.GA718@odin.tremily.us> <CABURp0qNBcFnxbvhn7PsKWLUOsTiK4u5vx-=6cG3JQHw9aUeHA@mail.gmail.com> <50BA2892.7060706@web.de> <50BA3412.60309@web.de> <7vy5hhmcwp.fsf@alter.siamese.dyndns.org> <50BBB22A.7050901@web.de> <7vhao31s9e.fsf@alter.siamese.dyndns.org> <50BE6FB9.70301@web.de> <50C89DF3.20303@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>,
	"W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Dec 12 18:25:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tiq3n-0007Fs-76
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 18:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669Ab2LLRZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 12:25:10 -0500
Received: from mout.web.de ([212.227.17.12]:54685 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754570Ab2LLRZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 12:25:09 -0500
Received: from [192.168.178.41] ([91.3.188.121]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MaJng-1TP6DI1v1k-00KVrB; Wed, 12 Dec 2012 18:22:57
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <50C89DF3.20303@drmicha.warpmail.net>
X-Enigmail-Version: 1.4.6
X-Provags-ID: V02:K0:Kc5LjIQ2haHfia5YexAHHsHQlrZUMuwLShMS+61sUPo
 qHfOuxohTfXxEBM+EFGWXlUost8jBGiEimMngLQQ0nAaFC3BaZ
 qNx6JuTOIheZZvUO92B3WlLtpZBZP6rZ3VfskbkD/cVVhwoncc
 DE8mnuuDhaThdeO3Vv/OJPGPHN+JFhch5NP8AvyulAp3hEQ16f
 wQjmCr/COwaUonqD2n5Kg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211368>

Am 12.12.2012 16:08, schrieb Michael J Gruber:
> Jens Lehmann venit, vidit, dixit 04.12.2012 22:48:
>> With "git submodule init" the user is able to tell git he cares about one
>> or more submodules and wants to have it populated on the next call to "git
>> submodule update". But currently there is no easy way he could tell git he
>> does not care about a submodule anymore and wants to get rid of his local
>> work tree (except he knows a lot about submodule internals and removes the
>> "submodule.$name.url" setting from .git/config himself).
>>
>> Help those users by providing a 'deinit' command. This removes the whole
>> submodule.<name> section from .git/config either for the given
>> submodule(s) or for all those which have been initialized if none were
>> given. Complain only when for a submodule given on the command line the
>> url setting can't be found in .git/config.
> 
> Whoaaa, so why not have "git rm" remove everything unless I specify a
> file to be removed?

Because "git add" doesn't add any file in that case either?

> I know I'm exaggerating a bit, but defaulting to "--all" for a
> destructive operation seems to be a bit harsh, especially when the
> command is targeted at "those" users that you mention.

All other submodule commands (except add, which only operates on a
single submodule to be) iterate over all submodules if none were
explicitly given on the command line. So I made deinit just behave
like all the others - and especially init - do. But if people really
are surprised by being consistent here I won't argue against adding
such a "--all" option, but currently I'm not convinced it is worth
it. Especially as I suspect the number of submodule users having
customized those in .git/config is not that high ...
