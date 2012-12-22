From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH 3/3] Makefile: use -Wdeclaration-after-statement if supported
Date: Sat, 22 Dec 2012 12:25:07 +0000
Message-ID: <CAOkDyE_+3n8PS_6vs-HG6v5A4SirBPVVCdgeUPOPpwaNpkk9Uw@mail.gmail.com>
References: <1355686561-1057-1-git-send-email-git@adamspiers.org>
	<1355686561-1057-4-git-send-email-git@adamspiers.org>
	<7vk3shphru.fsf@alter.siamese.dyndns.org>
	<20121217021501.GA13745@gmail.com>
	<7v8v8xpazq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 22 13:28:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmOBx-0004K7-Ja
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 13:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113Ab2LVMZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 07:25:14 -0500
Received: from mail-we0-f178.google.com ([74.125.82.178]:33320 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059Ab2LVMZM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 07:25:12 -0500
Received: by mail-we0-f178.google.com with SMTP id x43so2616363wey.37
        for <git@vger.kernel.org>; Sat, 22 Dec 2012 04:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=J6A4MZ0vKJaTOFXGuEV+y4M3fwy5HDkQRa6wwAdSbIc=;
        b=Sk21fR37/k62JKuHbsf62dLm4PNzJInLwanzJZ6Am6wFkvPEQt1Xl3nraLyhErOSjK
         nyvw6k83rJ5DI6dn0Pmlbu+Fh4m1dEbavJG4kexuiruCFQAiUwUD00HpbrhWurSUVsZ/
         2dXxgw8Q7UFONnV1mCnvuoMqbLHgpomkO4Vpfs8peJ5+BidqG5ray4ew7UZmCBEzhNnu
         uKqN4WGtb89DnXTmBqpWqAno5pQ36SjCbp9ayt97guGn7gBYdMBn+XcszRkB0L/l58t0
         IMoWK8wbZ1xUmu/493/pAcEq+8KloEPo5ZsZ1mQeXa6nRp0H+Qd4knzJHAEDmMOhPEd2
         1cog==
Received: by 10.194.236.68 with SMTP id us4mr28429863wjc.11.1356179107404;
 Sat, 22 Dec 2012 04:25:07 -0800 (PST)
Received: by 10.194.84.97 with HTTP; Sat, 22 Dec 2012 04:25:07 -0800 (PST)
In-Reply-To: <7v8v8xpazq.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 5dOTyHfV102W_VJpg6Mrp_he2hk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212045>

On Mon, Dec 17, 2012 at 4:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Adam Spiers <git@adamspiers.org> writes:
>
>> OK; I expect these issues with the implementation are all
>> surmountable.  I did not necessarily expect this to be the final
>> implementation anyhow, as indicated by my comments below the divider
>> line.  However it's not clear to me what you think about the idea in
>> principle, and whether other compiler flags would merit inclusion.
>
> As different versions of GCC behave differently, and the same GCC
> (mis)detect issues differently depending on the optimization level,
> I do not know if it will be a fruitful exercise to try to come up
> with one expression to come up with the set of flags to suit
> everybody.

Fair enough, but let's not allow perfect to become the enemy of good.
Other flags aside, surely enabling -Wdeclaration-after-statement when
it is available is an improvement on the status quo, if it is done in
a way which doesn't damage the current build process?  History shows
quite a few instances of other developers falling into the same trap I
did, e.g.

  http://search.gmane.org/search.php?group=gmane.comp.version-control.git&query=decl-after-statement

So if the check was automated in the majority of cases (I guess the
majority of developers use gcc), it would mean less review work for
you and fewer re-rolls.  If you agree, I will try to rework the patch
so that it doesn't damage the build.

> One flag I prefer to use is -Werror, but that means the
> other flags must have zero false positive rate.

Personally I'm a fan of -Werror too.  How frequent are false
positives, and are any of them ever insurmountable?

> If you are interested, the flags I personally use with the version
> of GCC I happen to have is in the Make script on the 'todo' branch.

Thanks for the info.
