From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Updated C# userdiff patterns.
Date: Sat, 26 Apr 2014 19:49:52 +0200
Message-ID: <535BF1C0.7080204@kdbg.org>
References: <29F78086-81B4-481F-9051-FF3EEBA9BB08@xamarin.com> <535B5BFF.40002@kdbg.org> <97789B23-A375-46B1-99FD-A851A15C2D85@xamarin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marius Ungureanu <marius.ungureanu@xamarin.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 19:50:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We6jj-0003Nb-E7
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 19:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbaDZRt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 13:49:57 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:25780 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751290AbaDZRt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 13:49:56 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id CF6E113004F;
	Sat, 26 Apr 2014 19:49:53 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id CF6ED19F432;
	Sat, 26 Apr 2014 19:49:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <97789B23-A375-46B1-99FD-A851A15C2D85@xamarin.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247170>

Am 26.04.2014 11:55, schrieb Marius Ungureanu:
> On 26 Apr 2014, at 10:10, Johannes Sixt <j6t@kdbg.org> wrote:
>> Am 26.04.2014 01:25, schrieb Marius Ungureanu:
>>> diff --git a/userdiff.c b/userdiff.c
>>> index fad52d6..7612c5d 100644
>>> --- a/userdiff.c
>>> +++ b/userdiff.c
>>> @@ -133,14 +133,14 @@ PATTERNS("cpp",
>>> 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lLuU]*"
>>> 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*"),
>>> PATTERNS("csharp",
>>> -	 /* Keywords */
>>> -	 "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|throw|catch|using)\n"
>>> 	 /* Methods and constructors */
>>> -	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
>>> -	 /* Properties */
>>> -	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
>>> +	 "^[ \t]*(((abstract|extern|internal|new|override|private|protected|public|sealed|static|unsafe|virtual)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
>>> +	 /* Properties, events, delegates */
>>> +	 "^[ \t]*(((abstract|internal|new|override|private|protected|public|sealed|static|unsafe|virtual)[ \t]+)*((delegate|event)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
>>> 	 /* Type definitions */
>>> -	 "^[ \t]*(((static|public|internal|private|protected|new|unsafe|sealed|abstract|partial)[ \t]+)*(class|enum|interface|struct)[ \t]+.*)$\n"
>>> +	 "^[ \t]*(((abstract|internal|new|override|partial|private|protected|public|sealed|static|unsafe)[ \t]+)*(class|enum|interface|struct)[ \t]+.*)$\n"
>>> +	 /* Keywords */
>>> +	 "!^[ \t]*(as|base|break|case|catch|checked|continue|default|delegate|do|else|finally|fixed|for|foreach|if|in|is|lock|new|null|out|readonly|ref|return|switch|this|throw|try|typeof|unchecked|unsafe|using|var|while)\n"
>>> 	 /* Namespace */
>>> 	 "^[ \t]*(namespace[ \t]+.*)$",
>>> 	 /* -- */
> 
> ...
> Modifier parsing can contain keywords, so just to be sure, I moved the
> keywords after modifier parsing, so it uses the keywords as a fallback.
> If this is not what should happen, please tell.

For each line, patterns are are scanned in order, and the first match
determines the outcome: If it is a negative pattern (i.e., it begins
with an exclamation mark), the line is not a hunk header; if it is a
positive pattern, the line is a hunk header. If no pattern matches, the
line is not a hunk header, either; it is as if the list were terminated
by a negative catch-all pattern.

Due to these rules, negative patterns in the list are only necessary
when you want to make an exception to a positive pattern in the list,
and then the negative pattern must be listed before the positive pattern.

In the csharp case, I do not see a pattern of which the keyword pattern
would make an exception (neither the old version nor your new version).
Therefore, you could drop the keyword pattern entirely.

-- Hannes
