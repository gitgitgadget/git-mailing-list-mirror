From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v10.1 7/7] bisect: allow any terms set by user
Date: Mon, 29 Jun 2015 07:08:26 +0200
Message-ID: <CAP8UFD0NjExQJHQWix1+zc4_k15e3+aC5vAv=dHipg-X+2y1sQ@mail.gmail.com>
References: <xmqqsi9etjwy.fsf@gitster.dls.corp.google.com>
	<1435351183-27100-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqa8vmrtsh.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1PyS_qM3EHW_Nzmo=3aeTDkZ0M3hnhRQANAO+ShF3H1Q@mail.gmail.com>
	<CAPc5daXSnovQPxR5kVoeRy4kApH7DiuTDvAz1ooQFp=5DZZg4Q@mail.gmail.com>
	<558F8B55.1070708@alum.mit.edu>
	<CAPc5daWmhkqDL0pNYne4-kRoxWK7ObcOKxtE5DsfHA2cnMM1pQ@mail.gmail.com>
	<558F9854.5080605@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 29 07:08:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9RJ2-0004mY-VC
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 07:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020AbbF2FI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 01:08:29 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35365 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbbF2FI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 01:08:27 -0400
Received: by wiga1 with SMTP id a1so60368452wig.0
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 22:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=eIVEXeyNWtzNeokMrCSownytdMRbNaV9pJZYMhkIB2g=;
        b=tReSwylAe2sQTSIoJNc694bBeZ3jGvnvmzu3dNzojUYOMbOH5buL3zYY5atMQyo9/9
         QDMbScFQN+Ryw/YM9XWy+xWdOZ/jU4HuMArBQlCdpGd3kOg93vzhzV0IeXXRf5BTnmEY
         4lT0lYgwm6dl4cgDnR4bpkz1vaD4OZsNMWcWnZ7HzgnyeQgk4HHoniFCUQbj1foZv81j
         LPDO10LVOq+Nh70qxrnAd2F33V28rNpdLxN3FIOEKsvAQyG9WIKUqbPg/XamI4ovSnAF
         5C0IT+5R5A0c14v0P0idsjJDyEXPrma2Sf/04AQ5tJ6ib7WW2Kyg6E8blcsRvqOWKs+O
         4hzg==
X-Received: by 10.194.95.132 with SMTP id dk4mr27328213wjb.88.1435554506397;
 Sun, 28 Jun 2015 22:08:26 -0700 (PDT)
Received: by 10.194.221.229 with HTTP; Sun, 28 Jun 2015 22:08:26 -0700 (PDT)
In-Reply-To: <558F9854.5080605@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272938>

On Sun, Jun 28, 2015 at 8:46 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 06/28/2015 08:15 AM, Junio C Hamano wrote:
>> On Sat, Jun 27, 2015 at 10:51 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>>
>>> I would like to remind everybody of my old claim that it would be
>>> possible to teach `git bisect` to infer by itself which term means
>>> "older" and which term means "newer":
>>>
>>>     http://article.gmane.org/gmane.comp.version-control.git/244036
>>
>> But then one mistake at the beginning and the user will be on a wrong
>> track during the whole bisect session, no? Unless you make absolutely
>> clear when making the "intelligent" decision what Git inferred, that is.
>
> Definitely, `git bisect` should tell the user what it inferred.
>
>> For something complex like bisect, I highly suspect that a tool that is
>> more intelligent than the end users (more precisely, a tool that it thinks
>> it is more intelligent) would hurt them more than it helps them.
>
> This isn't about making bisect "more intelligent than the end users". It
> is about not forcing the user cumbersomely to spell out redundant
> information because the tool is too stupid.
>
> If I mark one commit "broken" and another commit "fixed", and the
> "broken" commit is an ancestor of the "fixed" commit, then it is pretty
> obvious that I am looking for the commit that caused the transition
> "broken" -> "fixed". The same if I mark one commit "xyzzy" and the other
> one "plugh".
>
> I understand that the user might make a mistake when marking the initial
> commits, but as soon as bisect says
>
>     Commit <sha1-abbrev> is an ancestor of <sha1-abbrev>, so I
>     will look for the commit that caused the transition from
>     "xyzzy" to "plugh".
>
> then I hope the user will notice and correct her/his mistake.

This looks fragile to me. Unfortunately many users will probably not
read it and continue, and then spend a lot of time later trying to
understand what went wrong, not remembering about the message at all.

The message looks like an informative message. At least we should add
something like "Please check that it is what you want to do and abort
with 'git bisect reset' if it is not."

> For example, a session could be started with
>
>     git bisect start --mark=broken <committish> --mark=fixed <committish>

This look nearly the same as:

git bisect start --name-old=broken --broken=<committish>
--name-new=fixed --fixed=<committish>

except that it looks safer and more backward compatible to me with
--name-old and --name-new.

By the way we could use "mark" or "term" instead of "name" in the
option name (like --mark-old or --term-old) and in the code too if it
looks clearer.

> and from then on
>
>     git bisect broken
>     git bisect fixed
>
> Or, if the user doesn't want to specify both endpoints on the `start` line,
>
>     git bisect start
>     git bisect --mark=broken [<committish>]
>     git bisect --mark=fixed [<committish>]

We could do that too with:

     git bisect start
     git bisect --name-old=broken broken [<committish>]
     git bisect --name-new=fixed fixed [<committish>]

and/or:

     git bisect start
     git bisect --name-old=broken --broken=[<committish>]
     git bisect --name-new=fixed --fixed=[<committish>]
