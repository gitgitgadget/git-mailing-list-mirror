From: Deskin Miller <deskinm@umich.edu>
Subject: Re: [PATCH] '%S' option for pretty printing to support --source
Date: Thu, 5 Mar 2009 14:41:44 -0500
Message-ID: <86d4c5e00903051141u61a131beg26b3df95bafd65d3@mail.gmail.com>
References: <200903050918.29051.petri.hodju@yumesystems.com>
	 <20090305091758.GC30445@coredump.intra.peff.net>
Reply-To: deskinm@umich.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Petri Hodju <petri.hodju@yumesystems.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 20:43:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfJTT-0004y1-Tg
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 20:43:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755865AbZCETlt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 14:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755844AbZCETls
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 14:41:48 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:32651 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755590AbZCETlr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2009 14:41:47 -0500
Received: by yw-out-2324.google.com with SMTP id 5so71313ywh.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 11:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:reply-to:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=lCejsU7mQ4heF1SWWxCX6wdpG5JbgRp/PlPSkNOTeAo=;
        b=kE5zldhfF0dGc8Bs0svrEiIcP2HcaK5eNwIEhYgYB17eI7wosZuKwiJt/qzJbotUF8
         eIFDFsH3JQ8uc7dKu8X/iODuDJK6ZDY3TZsEghYetUB5WuvYXx7CJZBP1jbWu7uHXUFL
         FfWX9huAaYdwNs1LDhv4gvEL3wTrFLGyBeLqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:reply-to:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=nZ+zHX98EMNG3kRsQd2nAgEVhK13A4Rana9iBJznMifYgue0CRd5bVlxvAVyeV25Pe
         X9lpMPNnWdXjdfSEmq8mRQQYiXnqObWXMWx098fOyEz+sL4RZVS53YTeXqIJAZJ299aK
         MXY8kE4v1bcDiFidYtbTzq0mlwvEWffE2zPcQ=
Received: by 10.150.156.20 with SMTP id d20mr2810812ybe.102.1236282105062; 
	Thu, 05 Mar 2009 11:41:45 -0800 (PST)
In-Reply-To: <20090305091758.GC30445@coredump.intra.peff.net>
X-Google-Sender-Auth: f6bfec1478aa73d6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112328>

On Thu, Mar 5, 2009 at 04:17, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 05, 2009 at 09:18:28AM +0200, Petri Hodju wrote:
>
>> +static void format_source(struct strbuf *sb, const struct commit *c=
ommit)
>> +{
>> + =C2=A0 =C2=A0if (commit->util)
>> + =C2=A0 =C2=A0 strbuf_addstr(sb, (char *) commit->util);
>> +}
>> +
>
> Hmm. This is the second patch in the last few weeks to use commit->ut=
il
> to carry information for --pretty=3Dformat: (I am cc'ing Deskin Mille=
r,
> who wrote the first).

Thanks Jeff.  Fortunately I managed to catch this one anyway.

Petri, the patch series from me which Jeff is referring to is viewable =
at

http://thread.gmane.org/gmane.comp.version-control.git/111524/

for reference.

I am in the middle of a move and ought to be packing right now, so
needless to say my git budget at the moment is pretty much nil, and
will be so for at least another week I'd guess.  This is to say, I've
not done any additional work in light of Jeff's or Dscho's comments on
my series, though I intend to once I'm relocated.

> They cannot both work, obviously. So we need to do one of:
>
> =C2=A0- refactor the information out of commit->util to somewhere els=
e
>
> =C2=A0- allow multiple commit->util users somehow (which I think is a
> =C2=A0 =C2=A0potential performance problem -- the simplistic design i=
s meant to
> =C2=A0 =C2=A0avoid things like allocation overhead)

I'm inclined to do as Dscho suggests here: glancing at the current
struct decoration usage briefly I think my reflog printing could work
that way with no problem.  However, this would largely ignore your
other comments about prettifying the pretty-printing code.  If a new
series using struct decoration isn't useful, let me know, otherwise
I'll plan on doing this once I have a chance.

> =C2=A0- gracefully block concurrent use of conflicting features

I agree that any blocking should be graceful, but ultimately I find
the idea of disallowing features because they happen to use the same
underlying implementation distasteful.  With a little work we should
be able to allow both with no problem.

Deskin Miller
