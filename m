From: Jonathan del Strother <jdelstrother@gmail.com>
Subject: Re: Expected behaviour of 'git log -S' when searching in a
 merged/deleted file?
Date: Thu, 23 Dec 2010 09:47:57 +0000
Message-ID: <AANLkTim4z3XvpjnEERuXgTE6CtA7D-dnBxSUgO3mE-FM@mail.gmail.com>
References: <AANLkTimXk6ei6EAQfvTTfnMzdBqYHkNoaxkEab+atnHd@mail.gmail.com> <7vzkrx4qp6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 23 10:48:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVhmj-0006Hv-Im
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 10:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367Ab0LWJsV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Dec 2010 04:48:21 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49860 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233Ab0LWJsS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Dec 2010 04:48:18 -0500
Received: by qwa26 with SMTP id 26so6025791qwa.19
        for <git@vger.kernel.org>; Thu, 23 Dec 2010 01:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=E+6wJ6yxqcwxk93h8+owUrXW/3VPOhowQcRtOsNEVxA=;
        b=ww5Je2AKGeCUEDtQDYzqUV8az85GjJe8a+qq08n5ob9n7L+rwrJ17odBqagzxyOriA
         tUTOz5Q3DZ3dUA4nW101KN37XfgAElC7BdVzp5E4zRvTc02Q3fpaGCngqd1Yp+Xk3WnK
         w5UZKheu9iUWsRkwjjd7AT78bHDCUGSQAkW88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=fVemFN25f5gsQ52hNrt9WKb5t0fCwOEs/kA2zr6z3wJaAq2lSqxBLU15INazoPZpM/
         2+TUa1Y5WzNSq7hvoffeU9pC3Ev9zpIWvgJHkpZ+cNsxS+/MqVCXhOOiWEMaHkUQhG2L
         Z6QlyaSdU84LRgq7B7CzGUwGRFCDD1WYWVXBU=
Received: by 10.229.74.206 with SMTP id v14mr6587932qcj.187.1293097697737;
 Thu, 23 Dec 2010 01:48:17 -0800 (PST)
Received: by 10.229.86.201 with HTTP; Thu, 23 Dec 2010 01:47:57 -0800 (PST)
In-Reply-To: <7vzkrx4qp6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164122>

On 22 December 2010 18:17, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan del Strother <jdelstrother@gmail.com> writes:
>
>> I was trying to find a particular string in my project this morning.
>> 'git grep mystring' suggested that the string didn't exist in my rep=
o,
>> but 'git log -Smystring' turned up a single commit that had added it=
=2E
>> It took me a long time to figure out that in the past, a branch had
>> added that string to foo.c, but a second branch deleted foo.c, and t=
he
>> two branches were later merged (deleting foo.c and ignoring mystring=
).
>
> This is a typical case of the history simplification in action, isn't=
 it?
>
> "log" will give you one possible and simplest explanation of how the
> project came into the current shape. =C2=A0Because side branches with=
 changes
> that were discarded before merging it to the history that lead to the
> commit you run "log" from do not contribute anything to the end resul=
t,
> "log" will not traverse the entire side branch when it sees the merge=
=2E

I don't follow ...  'log' isn't showing me how the project came into
it's current shape. In the test case I posted, for example, it's
showing me that 'needle' was added to the repository at some point,
but it neglects to mention that it was removed.  If 'needle' was added
and removed within the duration of a single branch, I could understand
"git log -S" never finding 'needle' due to history simplication, but I
don't understand how simplification applies here.

>
> Try your "log" with --full-history, perhaps?

Doesn't seem to affect the output in this case.
