From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] mergetools: add winmerge as a builtin tool
Date: Wed, 13 May 2015 17:22:23 +0200
Organization: gmx
Message-ID: <3d7e3b09b89c46c39befca7564f5c1d6@www.dscho.org>
References: <1431482407-63642-1-git-send-email-davvid@gmail.com>
 <55534F4E.60402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>, Phil Susi <phillsusi@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 17:22:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsYUT-0005nK-4q
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 17:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934550AbbEMPW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 11:22:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:55135 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934490AbbEMPW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 11:22:28 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MQzIE-1YmOMg0jNe-00UMs7; Wed, 13 May 2015 17:22:24
 +0200
In-Reply-To: <55534F4E.60402@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:QCXK9/dpXlTBzhgIod8TRuUJzt2+c2Zo4Gh/SFdMMK6rOi2Pf2I
 qI9oSLQzkqwd5ToDlP+Yr/SATfOOAXRl2h8l67zwZsAFeQNCoaaIA58c7c4quBHgVzhzM56
 6oDtukBRwm2yhtnTvR2kpao9VutK7ZTmEbTt8/I9eby9mLrNgCWOhX/e8gs6t+B8gn1TpX/
 upJp69S9UAhS63aVD4iow==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268987>

Hi,

On 2015-05-13 15:19, Sebastian Schuberth wrote:
> On 13.05.2015 04:00, David Aguilar wrote:
> 
>> +	if test -n "$ProgramW6432" && test -x "$ProgramW6432/$winmerge_exe"
>> +	then
>> +		printf '%s' "$ProgramW6432/$winmerge_exe"
> 
> I don't think it makes sense to check "$ProgramW6432". The content of
> that variable depends on the bitness of the process requesting the
> environment. Just checking "$PROGRAMFILES" and "$PROGRAMFILES(X86)"
> should be sufficient and more clear.

In my tests, "$PROGRAMFILES(X86)" did *not* work:

    $ echo "$PROGRAMFILES(X86)"
    bash: syntax error near unexpected token `('

> Also, note that you should use all upper case names when referring to
> Windows environment variables. While it's true that on plain Windows
> environment variable names are case-insensitive, MSYS1/2 converts all
> variable names to upper case and *is* case sensitive. I.e. while "echo
> $PROGRAMFILES" works as expected from a Git Bash on Windows, "echo
> $ProgramFiles" results in an empty string.

Exactly. In my tests, "$ProgramW6432" worked, while "$PROGRAMW6432" did not.

FWIW I think that the idea to test for a WinMerge executable of another bitness makes sense, because we can execute an executable of another bitness (unlike a .dll of another bitness).

Ciao,
Johannes
