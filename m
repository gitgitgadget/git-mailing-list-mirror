From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git-status and git-diff now very slow in project with a submodule
Date: Sat, 22 May 2010 14:08:38 +0200
Message-ID: <4BF7C946.1040000@web.de>
References: <ht3194$1vc$1@dough.gmane.org>	 <7vy6fe7ldo.fsf@alter.siamese.dyndns.org> <AANLkTilctjct-a911H14XMnaBydYR1I6lPbEuFThTJ99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: SLONIK.AZ@gmail.com
X-From: git-owner@vger.kernel.org Sat May 22 14:09:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFnVj-00034A-KQ
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 14:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785Ab0EVMIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 08:08:41 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:42824 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283Ab0EVMIk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 08:08:40 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate02.web.de (Postfix) with ESMTP id 5F0DE161ED6CF;
	Sat, 22 May 2010 14:08:39 +0200 (CEST)
Received: from [80.128.110.225] (helo=[192.168.178.26])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OFnVN-0008Ic-00; Sat, 22 May 2010 14:08:37 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <AANLkTilctjct-a911H14XMnaBydYR1I6lPbEuFThTJ99@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18CGq11N9eTp2o31galw1PE+01LTZqSW1++G5aU
	7bVS6egO9a6OvdXoC5rfiVXiAnXqiTkM9cTRLw+Y/t50sY07vb
	AeGm6O0FJVh+92Y5EH7w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147520>

Am 21.05.2010 14:52, schrieb Leo Razoumov:
> On 2010-05-20, Junio C Hamano <gitster@pobox.com> wrote:
> I would be interested to know of any counter-example: that is, a
> use-case where it makes logical sense to declare a repo dirty when it
> gets an untracked file not mentioned in .gitignore.

For submodules the presence of untracked files must be visible in the
superproject. When new files are added to a submodule but the user
forgot to commit them, the superproject might not even build at all
when another developer clones the superproject. And yes, this is a
real-life use case from my dayjob.

The alternative to these broader definitions about when to declare a
submodule dirty (new commits, modified content and untracked content)
would have been to handle all eight combinations of these states. In
all relevant parts of the toolchain. Which seems pretty insane. So
the submodule shows up as modified; and all but the short outputs of
diff and status also tell you /why/ it is considered modified. So the
user can decide what to do about that.
