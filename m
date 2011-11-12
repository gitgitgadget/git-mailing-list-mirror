From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git diff --numstat <branch> always shows dirty submodules
Date: Sat, 12 Nov 2011 21:02:53 +0100
Message-ID: <4EBED0ED.7060005@web.de>
References: <j9lsc1$4uf$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Gelonida N <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 12 21:03:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPJn7-0005O6-L6
	for gcvg-git-2@lo.gmane.org; Sat, 12 Nov 2011 21:03:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022Ab1KLUC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Nov 2011 15:02:57 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:41768 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727Ab1KLUC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2011 15:02:56 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate01.web.de (Postfix) with ESMTP id 9390E1A3D8A88
	for <git@vger.kernel.org>; Sat, 12 Nov 2011 21:02:54 +0100 (CET)
Received: from [192.168.178.43] ([79.247.243.250]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0Letkl-1QZF2n0cPP-00ptG0; Sat, 12 Nov 2011 21:02:54
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <j9lsc1$4uf$1@dough.gmane.org>
X-Provags-ID: V02:K0:q9Xf6brWxKoxl66Wpo5ay5fqxeBDC8xBm4S7xt4wXlI
 CIkqv1I1m7+aJRtA7hlhNPLhinPofbQP1yIAimUkwtZZW9mSGp
 DT8/1Xifi0ge3SkLbNy9OfGuPRIfnk78L/J20wH9TODmySmtDN
 UuGBVh/7D1KyXqrpJXK9cz/cjY2ETrClIKdNATCxf3wZWktAVI
 2Xe9KCWxhoEODxdvPhdsg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185316>

Am 12.11.2011 14:29, schrieb Gelonida N:
> I recently started using submodules and they behave mostly as I like to.

Good to hear that.

> Normally I use diff --numstat<branch>
> to check quickly whether I am aligned with another branch or not.
>
> The (for me) annoying feature of submodules is, that they are always
> reported to be different due to files, which are not under git.
>
>
> I type git diff --numstat master
> I get
> 1       1       mysubmodule
>
>
> Now I check the differences with git diff master mysubmodule
> diff --git a/mysubmodule b/mysubmodule
> index 1382b73..f4f1f1d 160000
> --- a/mysubmodule
> +++ b/mysubmodule
> @@ -1 +1 @@
> -Subproject commit xxxxxxxxx
> +Subproject commit xxxxxxxxx-dirty
>
> So the only difference (which I wasn't interested in) is, that the
> submodule is dirty.
 >
> Is there any quick way flag / helper script / . . .
> to show differences between two branches without raising the fact, that
> submodules are dirty?

Yes, there is the "--ignore-submodules" command line option and the
diff.ignoreSubmodules (which can be set globally and/or per repo) and
submodule.<name.>ignore configuration settings. They can be set to
"untracked", "dirty" or "all" to control what you want to see.

Did you check areas in the Documentation where you did expect to find
them mentioned but they weren't? Then please say so that we can fix
that.

>> From a user perspective I don't see why this is reported.
> I am not being warned about dirty files in the top level repository

This is so you can't forget to add new files inside the submodule,
which can lead to breakage when other people clone the superproject
but won't get the new files from the submodule because you didn't
commit them there.
