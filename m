From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: When Will We See Collisions for SHA-1? (An interesting analysis
 by Bruce Schneier)
Date: Mon, 15 Oct 2012 21:09:44 +0200
Message-ID: <CA+EOSBki6-PWu=mwxr3PU0XC15cBhqr7L5Ay7-e9on+jGumsxw@mail.gmail.com>
References: <CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>
	<CACBZZX65Kbp8N9X9UtBfJca7U1T0m-VtKZeKM5q9mhyCR7dwGg@mail.gmail.com>
	<20121015183438.GB31658@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org, Scott Chacon <schacon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Oct 15 21:10:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNq33-000244-S2
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 21:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122Ab2JOTJq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 15:09:46 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:57580 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025Ab2JOTJp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2012 15:09:45 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so3928680iag.19
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 12:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=+kQjL26yIM24+80/SkVmgutRlHi/NpO960w7fxVFjRM=;
        b=Bg0vNzpX3QPImcOcr7iqjH59FEX+qR+19Djyj3mCWlIQkta5MQkb3NR3q2jrnBzWJ9
         hHTg9f721ZpfH090u5/Eb4RqDHGoPsEdgIRhtbke8Z9ScsP2VwIzLy8hliTImtNc/QIO
         HQ2Y0k+ywFOf+LKNwwYPbdi+zXAsNnHlUiY6q8zFRwU0ueEUgzCEWMztVe2/hKr4NWAI
         lgNEuNm/bl6KQIz6wj4UmvHgD3+JaLL6qgq9kjfpQqmoFmc5psgendjR4cQnjvritW56
         7tCa3riXxFyMh9IzAsqfN1la5CJPTr8dneyfBsKf6O8fk97HNQyYSDO1OCeHbW+PhPXJ
         g9ew==
Received: by 10.50.56.139 with SMTP id a11mr9677394igq.3.1350328184898; Mon,
 15 Oct 2012 12:09:44 -0700 (PDT)
Received: by 10.64.48.37 with HTTP; Mon, 15 Oct 2012 12:09:44 -0700 (PDT)
In-Reply-To: <20121015183438.GB31658@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207774>

Hem , sha-3 i suppose, keccak, no ? But really is not so urgent as you
have already told .

Best

2012/10/15, Jeff King <peff@peff.net>:
> On Mon, Oct 15, 2012 at 07:47:09PM +0200, =C6var Arnfj=F6r=F0 Bjarmas=
on wrote:
>
>> On Mon, Oct 15, 2012 at 6:42 PM, Elia Pinto <gitter.spiros@gmail.com=
>
>> wrote:
>> > Very clear analysis. Well written. Perhaps is it the time to updat=
e
>> > http://git-scm.com/book/ch6-1.html (A SHORT NOTE ABOUT SHA-1) ?
>> >
>> > Hope useful
>> >
>> > http://www.schneier.com/crypto-gram-1210.html
>>
>> This would be concerning if the Git security model would break down =
if
>> someone found a SHA1 collision, but it really wouldn't.
>>
>> It's one thing to find *a* collision, it's quite another to:
>>
>>  1. Find a collision for the sha1 of harmless.c which I know you use=
,
>>     and replace it with evil.c.
>>
>>  2. Somehow make evil.c compile so that it actually does something
>>     useful and nefarious, and doesn't just make the C compiler puke.
>>
>>     If finding one arbitrary collision costs $43K in 2021 dollars
>>     getting past this point is going to take quite a large multiple =
of
>>     $43K.
>
> There are easier attacks than that if you can hide arbitrary bytes
> inside a file. It's hard with C source code. The common one in hash
> collision detection circles is to put invisible cruft into binary
> document formats like PDF or Postscript. Git blobs themselves do not
> have such an invisible place to put it, but you might be storing a
> format that does.
>
> But worse, git _commits_ have such an invisible portion. We calculate
> the sha1 over the full commit, but we tend to show only the portion u=
p
> to the first NUL byte. I used that horrible trick in my "choose your =
own
> sha1 prefix" patch. However, we could mitigate that by checking for
> embedded NULs in git-fsck.
>
>>  3. Somehow inject the new evil object into your repository, or
>>     convince you to re-clone it / clone it from somewhere you usuall=
y
>>     wouldn't.
>
> Yeah, this part is the kicker. With the commit NUL trick, you would m=
ake
> a useful commit and then ask somebody to pull it, and then later repl=
ace
> it with a commit pointing to an arbitrary tree. But if we assume we c=
an
> detect that easily (which I think we can), we are left with replacing
> binary blobs that have hidden bits. And most projects do not take man=
y
> such blobs, and the result is that you could only replace the content=
s
> of that particular blob, not an arbitrary part of the tree.
>
>> It would be very interesting to see an analysis that deals with some
>> actual Git-related security scenarios, instead of something that jus=
t
>> assumes that if someone finds *any* SHA1 collision the sky is going =
to
>> fall.
>
> I agree that most of the analysis is overblown. Having read the analy=
sis
> Schneier pointed to, it actually is not that bad. We have 5-10 years =
to
> get to a point where it's really expensive and extremely complex to
> mount a single attack.
>
> That doesn't seem like an emergency to me. It sounds like something w=
e
> should be thinking about (and we are). The simplest thing would be to
> wait for a moment when it makes sense to break compatibility (e.g., w=
e
> decide that "git 2.0" is here, and everybody will have to rewrite to
> take advantage of new features, so we can jump to sha-2). We can also
> start building sha-2 history that references sha-1 history. That woul=
d
> mean everybody needs to upgrade their git, but that is not a problem
> that requires 5-10 years of foresight and planning.
>
> -Peff
>

--=20
Inviato dal mio dispositivo mobile
