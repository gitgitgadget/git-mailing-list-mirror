From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] WIP: begin to translate git with gettext
Date: Tue, 18 May 2010 08:11:51 +0000
Message-ID: <AANLkTikNzz5T4oJR1MQjdWjs-4zmWfXrPaBOHNfAi-1S@mail.gmail.com>
References: <20100517160503.GA12717@unpythonic.net>
	 <4BF24467.7000204@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff Epler <jepler@unpythonic.net>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>, Jan Hudec <bulb@ucw.cz>,
	Thomas Rast <trast@student.ethz.ch>,
	Marc Weber <marco-oweber@gmx.de>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 18 10:12:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEHuD-0005i4-Gt
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 10:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756858Ab0ERILz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 May 2010 04:11:55 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54449 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754226Ab0ERILw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 May 2010 04:11:52 -0400
Received: by iwn6 with SMTP id 6so1315682iwn.19
        for <git@vger.kernel.org>; Tue, 18 May 2010 01:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=S0W0JwZUV0aYyaMXHBmnCVNTGfwK0gfzdhXk8WAouNc=;
        b=MFhcnphK30D9vK9gtAApqC/3+/0VYwlXKwTIL3GayK4fQ2qL7p3SJKe0lJdGAtaATG
         ymuikj1VGSa0WifDuyYHko8ch2ER0JHHVMsoL2DjjtxV2sF0JByurLQoVdMNhH1vS8Eq
         8B2a5vXXfjumCQYq1G18YMo9CeeMRpC9dKcGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UjaTN6MC17LZJVJbsC9hGpBzdpeQsREtwEUpC9vr3u+iauGzJfFCVO16rH3iV/p3mA
         6qHemlcl4m8HFY0Zq7PqsV0M2+LWjmg7D4hr10BpxJvE7lQovugwjRzAhVRcIF0FuVFw
         s9vhPWhBMa1db0SrDeMGnHiX7m3eBQVjmbkss=
Received: by 10.231.148.200 with SMTP id q8mr1452542ibv.10.1274170311316; Tue, 
	18 May 2010 01:11:51 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 18 May 2010 01:11:51 -0700 (PDT)
In-Reply-To: <4BF24467.7000204@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147276>

On Tue, May 18, 2010 at 07:40, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> I have no experience whatsover with gettext, but it looks quite
> dangerous to me to have printf format specifiers as part of the
> localized text. It means that our programs can crash depending on the
> LANG setting at run time if localisers mess up. We'll never catch thi=
s
> unless we run all tests in all languages!

I don't have much experience with gettext either (except through
Launchpad), maybe it has some internal facilities to avoid errors in
these cases.

You can test if the translated messages contain the same format
specifiers as the originals, and in any case much larger projects than
Git manage dozens of translations with gettext while avoiding
disaster.

> Also, the basic structure of the output should probably be independen=
t
> of the language, preferring consistent structure across languages ove=
r
> linguistically consistent structure =C2=A0within a language.
>
> That means we'll have to do a lot of strcat's (the _() things are not
> compile time constants, are they?) rather than those mechanical
> replacements above. Are you prepared to do that?

Generally you don't to strcat's since you don't want to enforce word
order, doing so will make the messages sound like Yoda in some of the
target languages.

That does mean re-arranging some code if it's to be done properly.

>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> =C2=A0 =C2=A0 =C2=A0 default:
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("bug: unhandled diff=
 status %c", status);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die(_("bug: unhandled di=
ff status %c"), status);
>> =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 if (extra.len) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_fprintf(s->fp, col=
or(WT_STATUS_HEADER, s), "%s", extra.buf);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_fprintf(s->fp, col=
or(WT_STATUS_HEADER, s), _("%s"), extra.buf);
>
> Seriously?

No, as Jeff said it's just a proof of concept. That patch as-is
doesn't reflect good translation practices, it just bootstraps
gettext.

Which is very useful by the way, thanks Jeff.
