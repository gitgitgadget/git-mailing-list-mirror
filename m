From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v10.1 7/7] bisect: allow any terms set by user
Date: Sat, 27 Jun 2015 06:51:20 +0200
Message-ID: <CAP8UFD0Zzjcc94qcUJOpfSrTej-o6hRKzZOuTufzAbOPkjUr_A@mail.gmail.com>
References: <xmqqsi9etjwy.fsf@gitster.dls.corp.google.com>
	<1435351183-27100-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqa8vmrtsh.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1PyS_qM3EHW_Nzmo=3aeTDkZ0M3hnhRQANAO+ShF3H1Q@mail.gmail.com>
	<CAPc5daXSnovQPxR5kVoeRy4kApH7DiuTDvAz1ooQFp=5DZZg4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 06:51:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8i5P-0002uk-U9
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jun 2015 06:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbbF0EvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2015 00:51:23 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33811 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbbF0EvV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2015 00:51:21 -0400
Received: by wicnd19 with SMTP id nd19so59409060wic.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 21:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UtBsd2GDYqS7eyPVG7VjPSokDIRVD38zNLG9YnnOyfA=;
        b=SUwyDgqfVB2SgwrUhTWoDcoYLqKtsAbl290UddIF5DGpL12kZ8IN67iiOZY7OsfB+v
         CwdtJ0mcJ8zrFOc/j2/hGWyGaV2CSijjGjX9WlGpKVqMGskg8yyCToTVKtIkD5utmM+d
         oyhtSuULrQago2syzbPHXdAWlHw71unyuYVMKaCNmbHg1D5g/BQvj4ImoTtQ4IZrUz/y
         jdgyav8Ywxm1uuRIYtPcJ4q7soghAl28syRgBFGqN844sutbw/OExXU1qrAGrDHeboXo
         NTv28pBYvYqdf6RBTIqFSlalO8q22RHJid4arYHvZUgImpqzjErQK++p0hImdh739hHd
         CxFg==
X-Received: by 10.194.2.68 with SMTP id 4mr9087221wjs.82.1435380680293; Fri,
 26 Jun 2015 21:51:20 -0700 (PDT)
Received: by 10.194.221.229 with HTTP; Fri, 26 Jun 2015 21:51:20 -0700 (PDT)
In-Reply-To: <CAPc5daXSnovQPxR5kVoeRy4kApH7DiuTDvAz1ooQFp=5DZZg4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272850>

On Sat, Jun 27, 2015 at 6:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> On Fri, Jun 26, 2015 at 9:10 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>>
>> If we don't want to support positional arguments, then I would suggest
>> supporting first the following instead:
>>
>>          git bisect terms --name-good=fast --name-bad=slow
>>          git bisect terms --name-bad=slow --name-good=fast
>>
>> This would make the interface consistent with the code.
>
> Which somewhat defeats the point of introducing "old" and "new", though.
> The "terms" support is for people who feel that good/bad would be too confusing
> for the particular bisect session (e.g. because they are hunting for a fix).

Well if --name-old and --name-new are also available as synonyms, it
would not be too bad I think.
People could use the option names that fit their mental model or their
use case better.

>>> We may want to start supporting
>>>
>>>         git bisect start --new=master --old=maint
>>
>> Maybe we could also support:
>>
>> git bisect start --name-good=fast --name-bad=slow --fast=maint --slow=master
>
> The same comment for the token after --name-, but allowing the terms to be set
> at "start" could be a type-saver.  With need for added "--name-"
> prefix (worse, twice),
> I am not sure if it would be seen as a useful type-saver, though.

At least people don't need to remember if they have to use "git bisect
term" before or after starting :-)
