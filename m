From: Mason <slash.tmp@free.fr>
Subject: Re: Salvaging borked project history
Date: Thu, 26 Feb 2015 12:54:51 +0100
Message-ID: <54EF098B.4080803@free.fr>
References: <54EB5DD7.7050202@free.fr> <xmqq7fv8to7e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 12:55:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQx1u-0007z6-Dm
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 12:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639AbbBZLyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 06:54:54 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:11726 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753286AbbBZLyy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 06:54:54 -0500
Received: from [172.27.0.114] (unknown [83.142.147.193])
	(Authenticated sender: shill)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 6C2544B018C;
	Thu, 26 Feb 2015 12:54:32 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:35.0) Gecko/20100101 Firefox/35.0 SeaMonkey/2.32.1
In-Reply-To: <xmqq7fv8to7e.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264434>

Junio C Hamano wrote:

> But I personally think "git am -3" may be easier to handle.

Thanks! At least now, I see the light at the end of the tunnel.

I fetched linux-stable.git inside our repo.
I created ~300 patches using git format-patch -1 in a loop.
I can now run 'git am --3way $IGNORE *.patch'

IGNORE is used to --exclude the directories I'm not interested in.

Note: it seems --exclude=arch/mips and --exclude=arch/mips/ are
not sufficient, I need to write --exclude=arch/mips/* for git-apply
to ignore changes to files inside arch/mips.

Is that expected behavior?

Another nit: if a patch contains only changes to files inside arch/mips
then git-apply will create an "empty commit" (one with no diff). Is there
an option to say "skip empty patches"?

One more thing: "regular" diff -q returns 0 when the files are identical,
and 1 when they differ. It seems git diff -s does not have that behavior.
Is that by design?

If there is no option to skip empty patches, I'm thinking I can script
a fixup step to squash all empty commits. What do you think?

Regards.
