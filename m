From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCHv2 03/10] refs.c: Refactor code for mapping between shorthand
 names and full refnames
Date: Wed, 15 May 2013 08:45:47 +0200
Message-ID: <51932F1B.9000200@alum.mit.edu>
References: <1368289280-30337-1-git-send-email-johan@herland.net> <1368289280-30337-4-git-send-email-johan@herland.net> <7vmwrzsck1.fsf@alter.siamese.dyndns.org> <CALKQrgf0m8r-Ofb+Ss1OpEF67dPS73b8nB+usVxH=Y=h3441Wg@mail.gmail.com> <7v8v3jqsy7.fsf@alter.siamese.dyndns.org> <7vwqr2liv6.fsf@alter.siamese.dyndns.org> <CALKQrgcDBMPeXPzTnpGyeosipR6Ln_zLh4Q_i1A7-eFUnTnBcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jrnieder@gmail.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed May 15 08:45:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcVTI-0005sl-L3
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 08:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755230Ab3EOGpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 02:45:52 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:56609 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752002Ab3EOGpw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 May 2013 02:45:52 -0400
X-AuditID: 12074412-b7f216d0000008d4-3a-51932f1fca24
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 6A.BC.02260.F1F23915; Wed, 15 May 2013 02:45:51 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4F6jmgS020181
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 15 May 2013 02:45:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CALKQrgcDBMPeXPzTnpGyeosipR6Ln_zLh4Q_i1A7-eFUnTnBcA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqCuvPznQ4PR5IYuuK91MFg29V5gt
	5t3dxWTx9uYSRgcWj52z7rJ7XHr5nc3j4iVlj8+b5AJYorhtkhJLyoIz0/P07RK4M55NWcJc
	8FC04s21eewNjBMFuxg5OSQETCT2NT5khbDFJC7cW8/WxcjFISRwmVFi659JjBDOdSaJjQu2
	M4FU8QpoS7ydtokRxGYRUJV4fP8kWJxNQFdiUU8zmC0qECaxav0yZoh6QYmTM5+wgNgiQPU7
	Hv9iA7GZBSIk1i9pBpsjLJAlcePcGajN/5kkXh+9AXYSp0CgxMrmQ0A2B1CDusT6eUIQvfIS
	29/OYZ7AKDALyYpZCFWzkFQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrppebWaKXmlK6
	iRESzkI7GNeflDvEKMDBqMTDK+E/KVCINbGsuDL3EKMkB5OSKO9f3cmBQnxJ+SmVGYnFGfFF
	pTmpxYcYJTiYlUR4Da8BlfOmJFZWpRblw6SkOViUxHl/Llb3ExJITyxJzU5NLUgtgsnKcHAo
	SfCy6wENFSxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdFanwxMFZBUjxAe9VA2nmL
	CxJzgaIQracYdTlWXnnymlGIJS8/L1VKnPc5yOECIEUZpXlwK2DJ6xWjONDHwhCjeICJD27S
	K6AlTEBLNEtAnisuSURISTUwqpzeWL9uz5HH2/b/CN9p/ELxp/i8vQVPE/9u29V6/2Rp6fbI
	3B8qHk96V23qvCV488xTk0lif9r2THNkWzh915OEBbMSVvWGX1gof/X/GrvmR1+r 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224385>

On 05/14/2013 04:24 PM, Johan Herland wrote:
> On Mon, May 13, 2013 at 10:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>> Johan Herland <johan@herland.net> writes:
>>>> Obviously, I named it '%1' since it expands into the _first_ component
>>>> of the (slash-separated) shorthand.
>>>
>>> OK, I can buy something like
>>>
>>>       %*
>>>         refs/%*
>>>         refs/heads/%*
>>>         ...
>>>         refs/remotes/%*/HEAD
>>>         refs/remotes/%1/%2
>>>         refs/peers/%1/heads/%2
>>>
>>> that is, for a pattern that has %*, we feed the end-user string as a
>>> whole, and for a pattern that has %1 thru %N, we find an appropriate
>>> way to chop the end-user string into N pieces (e.g. nick/name would
>>> be split into %1 = nick, %2 = name, while foo/bar/baz might have two
>>> possibilities, <%1, %2> = <foo, bar/baz> or <foo/bar, baz>).  The
>>> earlier ones on the above list can even be written with their %*
>>> substituted with %1 if we go that route.
>>
>> Just to make sure.
>>
>> Please do not let "two possibilities" stop you.  As I said in the
>> nearby thread, I do not necessarily insist that we must try all N
>> possibilities.  "We find an appropriate way" could be just "we
>> always chop at the first slash, and %1 is what comes before it, %2
>> is what comes after it".
>>
>> That will close the possibility for us to use %1 thru %N (N is
>> limited to 2), but it still is "We have %1 and we have %2, both fall
>> into the same 'path components, numbered from left to right'
>> category", and justifies the use of %1 ("one", not "el").
>>
>> So still no objection to %1 from me.
> 
> I think I like "refs/peers/%1/heads/%*" better than
> "refs/peers/%1/heads/%2", since the latter sort of makes me wonder
> whether the 3rd, 4th, etc. components would be discarded. That said,
> having %* mean "the rest of the shorthand" means that we must adjust
> the expansion of %* for every preceding %N, which prevents us from
> simplifying the code by using strbuf_expand_dict_cb() with a static
> dictionary [1].
> 
> I am not sure why we would want "refs/remotes/%1/%2" instead of
> "refs/remote/%*". Maybe I've been staring at this for too long, but I
> find the latter shorter and more descriptive and the "%1/%2" notation
> needlessly cumbersome, especially if it's also supposed to match
> "foo/bar/baz"

"refs/remotes/%1/%2" (or "refs/remotes/%1/%*") might be a nice way to
imply that the rule should only be attempted if the input has at least
two components, whereas something like "refs/heads/%*" would be applied
even for inputs with no slashes.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
