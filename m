From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git-submodule.sh respects submodule.$name.update in .git/config
 but not .gitmodules
Date: Thu, 12 Dec 2013 19:57:51 +0100
Message-ID: <52AA072F.2000105@web.de>
References: <CABYr9QtSeX=Euf73MZPq6suo+GpVA=f+tH73Ct0tP-3LYogh9w@mail.gmail.com>	<20131209223506.GF9606@sandbox-ub>	<xmqqlhztvbi8.fsf@gitster.dls.corp.google.com> <52A8E689.80701@web.de>	<20131211224424.GB25409@odin.tremily.us> <7vtxeeuaw7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Charlie Dyson <charlie@charliedyson.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Dec 12 19:58:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrBSS-0003D6-7O
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 19:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907Ab3LLS54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 13:57:56 -0500
Received: from mout.web.de ([212.227.15.3]:51298 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751774Ab3LLS54 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 13:57:56 -0500
Received: from [192.168.178.41] ([84.132.160.5]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0M9XQB-1Vh2q63d2l-00D1lA for <git@vger.kernel.org>;
 Thu, 12 Dec 2013 19:57:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <7vtxeeuaw7.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:bvtXBDA7vcFh2J/sk3CTo3rH9lFpi0JvQyg8JzhRIzCv2voO1eS
 ZXdDmNpju+qzv4TDqQtSUgcWciS8FP3w03KNp5DbBtb/Tzk2VL9sOkc0blqJv8qipykb+HA
 0A6bo5M61CYGb0Gs2ERKG379SCD1J0r3n7K59uIzOu7IJJoroxaM3YMLWQtrHg0XqzJJ+yQ
 iWILpyAF5JLXftgoXGEAg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239236>

Am 12.12.2013 02:16, schrieb Junio C Hamano:
> "W. Trevor King" <wking@tremily.us> writes:
> 
>> For
>> safety, maybe the default `init` should copy *everything* into
>> .git/config, after which users can remove stuff they'd like to
>> delegate to .gitmodules.
> 
> Copying everything into config is "be unsafe and inconvenient by
> default for everybody", isn't it?  Folks who want safety are forced
> to inspect the resulting entries in their config file (which is more
> inconvenent if you compare with the design where nothing is copied
> and nothing dynamically defaults to what then-current .gitmodules
> happens to contain).  Folks who trust those who update .gitmodules
> for them are forced to update their config every time upstream
> decides to use different settings in .gitmodules, because they have
> stale values in their config that mask what are in .gitmodules.
> 
> I think the solution we want is to copy only minimum to the config
> (and that "minimum" may turn out to be "nothing"), and to default
> keys that are only absolutely safe to .gitmodules file.

I agree and will prepare a patch for that.

What about teaching "git submodule sync" the "--url", "--update",
"--fetch", "--ignore", "--branch" and "--all" options to allow the
user to copy the current settings he wants from .gitmodules to
.git/config (but only safe values of course)? Trevor, would you be
ok to issue another command to copy everything to .git/config?
