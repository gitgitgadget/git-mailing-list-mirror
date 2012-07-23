From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Solve git-submodule issues with detached work trees
Date: Mon, 23 Jul 2012 19:38:56 +0200
Message-ID: <500D8C30.9010807@web.de>
References: <CAHCkQtNfz8Kbn810LgXEQ_rkyk4qn5amGgHQsv2uR6H38sTSrg@mail.gmail.com> <7vsjcjnjvj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?RGFuaWVsIEdyYcOxYQ==?= <dangra@gmail.com>,
	git@vger.kernel.org,
	Richard Hartmann <richih.mailinglist@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 19:39:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StMbA-0000Kx-QU
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 19:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211Ab2GWRjG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jul 2012 13:39:06 -0400
Received: from mout.web.de ([212.227.17.12]:59089 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754141Ab2GWRjF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 13:39:05 -0400
Received: from [192.168.178.48] ([91.3.175.185]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0MfqAq-1TELNw3kqS-00NoHV; Mon, 23 Jul 2012 19:39:02
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vsjcjnjvj.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:zL7l2PzphFAZ2PCXXy7aEeI7LLG0Chm/FDMAvv6DKde
 Nd4YvrsMRMkK+O30DIMKIGUTwkuTsC5LvQWD+/6FRxKWqKs+UQ
 MZ9+t6wHxDYXIe1Lbsiordq2150uTdrMBtg/8pW3gzvgnvnI+V
 ZOwJHdkSp1YH+Zsh72vvhTULjXfO07ZeNOQJWG9dg05xGYKuvb
 ZxD8cmbOHdk2Q/kQel07w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201944>

Am 23.07.2012 07:09, schrieb Junio C Hamano:
> Daniel Gra=C3=B1a <dangra@gmail.com> writes:
>=20
>> A common way to track dotfiles with git is using GIT_DIR and
>> GIT_WORK_TREE to move repository out of ~/.git with something like:
>>
>>     git init --bare ~/.dotfiles
>>     alias dotfiles=3D"GIT_DIR=3D~/.dotfiles GIT_WORK_TREE=3D~ git"
>>
>>     dotfiles add ~/.bashrc
>>     dotfiles commit -a -m "add my bashrc"
>>     ...
>>
>> but git-submodule complains when trying to add submodules:
>>
>>     dotfiles submodule add http://path.to/submodule
>>     fatal: working tree '/home/user' already exists.
>>
>>     git --git-dir ~/.dotfiles submodule add http://path.to/submodule
>>     fatal: /usr/lib/git-core/git-submodule cannot be used without a
>> working tree.
>>
>> Signed-off-by: Daniel Gra=C3=B1a <dangra@gmail.com>
>> ---
>=20
> I think this is in line with what we discussed earlier on list when
> the interaction between GIT_DIR/GIT_WORK_TREE and submodules came up
> the last time.  Jens?

Yes, I think this is the only way submodules in current git can
be used with the GIT_DIR and GIT_WORK_TREE environment variables:
set them when adding or initializing the submodule and always use
the same settings when accessing them later. Daniel's dotfile
alias achieves exactly that, so his fix looks good. But I agree
the tests should be improved as you already pointed out.
