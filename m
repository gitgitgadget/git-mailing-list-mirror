From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: t5539 broken under Mac OS X
Date: Tue, 27 Jan 2015 17:35:16 +0100
Message-ID: <CABPQNSaqtczB3LDGq2T6c=1jbbxMEAra5DDrjpUXHC5TEvMh-w@mail.gmail.com>
References: <54B68D99.2040906@web.de> <xmqqmw5l9pje.fsf@gitster.dls.corp.google.com>
 <54B6C897.5030405@web.de> <20150114211712.GE1155@peff.net>
 <064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com> <xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com>
 <20150115222719.GA19021@peff.net> <xmqqa91j6537.fsf@gitster.dls.corp.google.com>
 <20150115235752.GB25120@peff.net> <xmqqh9vr4mlz.fsf@gitster.dls.corp.google.com>
 <CABPQNSYZMS+feX=jSxwOhr+P8isroct2=Dcw18LSjCYZUvug=A@mail.gmail.com> <xmqqh9vdlyuu.fsf@gitster.dls.corp.google.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, "Kyle J. McKay" <mackyle@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 17:36:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YG97R-00020Z-Px
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 17:36:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754286AbbA0Qf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2015 11:35:58 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:60551 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464AbbA0Qf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2015 11:35:56 -0500
Received: by mail-ie0-f179.google.com with SMTP id x19so16205672ier.10
        for <git@vger.kernel.org>; Tue, 27 Jan 2015 08:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=EHnWj9fevLVcPIlhl8GbmBPpDIZS+mGM8IWdPIFj8m4=;
        b=odgCclJBw2oe2p+ZUn6WWs+h5/ccYfTB0Hs1PH7D7us4w2WZOxY1VSN2fjKq6FuYKM
         UM8YMvqr4scJfB9sSucpPfk5bOpCFv/0WlKDoKVI1sZRCeedZ9fc6go65I4XElB22kBo
         7UDmCLP7Gph4TqJ597AnSwoc+tDnG2+xVeOPkDfVwnzfuOj9nGG9GcPb7m6w8LNC4ND9
         9OIx5ZzpH17/IQQMi60kUNls1SgLVx6fKSJd3VW2y9nIrFFDL9NqAjyt1SY7bMUYUK5f
         Abu6OyFKb4hxe8pFG3j+84q25VT0fuJNF2/nmZ5ttlA9GWlqLSG0ho6KQ5qbTRdysXuz
         TIDQ==
X-Received: by 10.50.85.44 with SMTP id e12mr4037211igz.48.1422376556354; Tue,
 27 Jan 2015 08:35:56 -0800 (PST)
Received: by 10.64.240.139 with HTTP; Tue, 27 Jan 2015 08:35:16 -0800 (PST)
In-Reply-To: <xmqqh9vdlyuu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263076>

On Tue, Jan 27, 2015 at 3:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> On Fri, Jan 16, 2015 at 1:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Jeff King <peff@peff.net> writes:
>>>
>>>> Exactly. I am happy to submit a patch, but I cannot think of any
>>>> mechanisms besides:
>>>>
>>>>   1. Calling `id`, which I suspect is very not portable.
>>>>
>>>>   2. Writing a C program to check getuid(). That's portable for most
>>>>      Unixes. It looks like we already have a hacky wrapper on mingw that
>>>>      will always return "1".
>>>>
>>>> Is (2) too gross?
>>>
>>> Not overly gross compared to some existing test-*.c files, I would
>>> say.
>>>
>>> I wondered what 'perl -e 'print $>' would say in mingw, and if that
>>> is portable enough, though.
>>
>> $ perl -e 'print $>'
>> 500
>
> Thanks for a follow-up.
>
> Is "id -u" not useful over there?  I ask because that is what is
> used in the version tentatively queued on 'pu' for NOT_ROOT
> prerequisite (the jk/sanity topic).

It's pretty much the same thing:

$ id -u
500

> The SANITY prerequisite in that topic needs to be replaced with the
> one from Torsten that attempts to check what we want to know in a
> more direct way; i.e. "after making a directory or a file read-only,
> does the filesystem really honours that, or lets us clobber?" is
> what we need to know to skip some tests, and we should check that,
> instead of "is / writable by us?" or "are we root?".

$ test -w / && echo yes
yes

$ mkdir foo && chmod a= foo
$ test -w w && echo yes
$ rm -r foo
rm: directory `foo' is write protected; descend into it anyway? n
$ rm -r foo < /dev/null
$ ls -la foo
ls: foo: No such file or directory
$

So, Windows does only kind-of respect read-only flags. Dunno if this
tells you something useful, though.
