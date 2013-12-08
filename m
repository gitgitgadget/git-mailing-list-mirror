From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: What's cooking in git.git (Dec 2013, #02; Fri, 6)
Date: Sun, 08 Dec 2013 11:20:44 +0100
Message-ID: <87lhzvhceb.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
References: <xmqqk3fh1qrc.fsf@gitster.dls.corp.google.com>
	<52A37D70.3090400@gmail.com> <87fvq41esw.fsf@thomasrast.ch>
	<52A3A1F5.3080906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 08 11:21:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpbTw-00080Q-TU
	for gcvg-git-2@plane.gmane.org; Sun, 08 Dec 2013 11:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507Ab3LHKU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Dec 2013 05:20:57 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:53708 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751248Ab3LHKU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Dec 2013 05:20:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 92D6C4D6560;
	Sun,  8 Dec 2013 11:20:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id HULYmIn9MamF; Sun,  8 Dec 2013 11:20:44 +0100 (CET)
Received: from linux-1gf2.Speedport_W723_V_Typ_A_1_00_098.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 2A7274D64C4;
	Sun,  8 Dec 2013 11:20:44 +0100 (CET)
In-Reply-To: <52A3A1F5.3080906@gmail.com> (Karsten Blees's message of "Sat, 07
	Dec 2013 23:32:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239043>

Karsten Blees <karsten.blees@gmail.com> writes:

> Am 07.12.2013 23:23, schrieb Thomas Rast:
>> Karsten Blees <karsten.blees@gmail.com> writes:
>> 
>>> Extending 'struct hashmap_entry' with an int-sized member shouldn't waste
>>> memory on 64-bit systems. This is already documented in api-hashmap.txt,
>>> but needs '__attribute__((__packed__))' to work. Reduces e.g.
>> 
>> You'd have to guard __attribute__((__packed__)) with some compiler
>> detection in git-compat-util.h though.
>> 
>
> Isn't that already handled? __attribute__ is already widely used
> (e.g. for printf formats), and platforms that don't support it define
> it as empty (e.g. MSVC). Or do you mean I should account for
> compiler-specific variants (#pragma pack...)?

True, __attribute__ expands to nothing on unknown compilers, but what
does the compiler do when it sees an unknown attribute?  If some of them
choke, you need a separate macro.

I'm a bit confused myself though, many attributes have special macros in
git-compat-util.h but others we just use in the code.

-- 
Thomas Rast
tr@thomasrast.ch
