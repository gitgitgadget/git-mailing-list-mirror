From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Bug? diff.submodule=log adds text to commit -v message
Date: Wed, 13 Nov 2013 19:37:53 +0100
Message-ID: <5283C701.8090400@web.de>
References: <loom.20131110T222043-57@post.gmane.org> <528140F5.6090700@web.de>	<loom.20131111T214646-550@post.gmane.org> <52814C35.6040205@web.de>	<5281DCC5.2000209@kdbg.org> <5282A90A.4030900@web.de> <xmqqy54tfeje.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, Ari Pollak <ari@debian.org>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 13 19:38:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgfKM-000225-S7
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 19:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756000Ab3KMSiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 13:38:06 -0500
Received: from mout.web.de ([212.227.17.12]:60945 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755888Ab3KMSiD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 13:38:03 -0500
Received: from [192.168.178.41] ([91.3.130.121]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0Lmu2K-1VF3HI47q8-00h9lp for <git@vger.kernel.org>;
 Wed, 13 Nov 2013 19:38:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqqy54tfeje.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:+6kXimmZuhQzbtoO/QPvtURyffvVxGdQ5QYRd3JQwpqlHNcEZOW
 q/vY6xoBTjCsCPpdtrlvXmw0vOI5BvrxCsQ/nzJkOL8apq9qbmEfiedZf7Vpy4mAvjlVFlF
 Tjidun3yAp35KVskXzMFv0vkbg31UwulS+Vxttic8J2Ffjf2nArdOdmN62a5InTO7ZgS+Dw
 yVO/SsDj0uJhF04owAmIw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237797>

Am 12.11.2013 23:20, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Am 12.11.2013 08:46, schrieb Johannes Sixt:
>>> Am 11.11.2013 22:29, schrieb Jens Lehmann:
>>>> The diff below fixes the problem you describe for me. (But I do not
>>>> consider it a worthwhile fix in its current form because a line
>>>> starting with "Submodule " might appear in a perfectly normal commit
>>>> message, while "diff --git " most probably won't).
>>>
>>> And on top of that, "Submodule " originates from a translatable string,
>>> doesn't it?
>>
>> This would also be true for the marker line that Peff proposed:
>>
>>   # Everything below this line is a diff that will be removed.
>>
>> But I suspect that would be ok if the marker would be both added
>> and searched for in its translated form. Or is it possible that
>> the locale changes between those two steps?
> 
> If we were introducing a divider line for machine consumption, I do
> not think it is wise to let that line even translated...

Ok, but then it won't mean much to readers who don't understand
English. I assume prefixing all diff lines with "# " is out of
the question because of backwards compatibility, so what about
using a descriptive text together with a scissor line? The former
can be be translated (and won't make it into the commit message
because it starts with a "#") while the latter serves as a robust
divider line:

# Everything below the following line is a diff that will be removed.
# --------------------------------8<--------------------------------
