From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v3 0/2] git-gui: change to display the combined diff in 
	the case of conflicts.
Date: Thu, 1 Apr 2010 00:23:17 +1200
Message-ID: <t2u2cfc40321003310523u8fda9baeo883d2e0b3c6fa807@mail.gmail.com>
References: <2cfc40321003300834w59532e58m13d42acce4f2c5ce@mail.gmail.com>
	 <4BB2F7A0.6020702@viscovery.net>
	 <k2p2cfc40321003310412hf4c6d642n4349af3f644829ff@mail.gmail.com>
	 <4BB3346C.7070700@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, spearce@spearce.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 31 14:23:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwwx9-0000s1-5i
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 14:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757530Ab0CaMXS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Mar 2010 08:23:18 -0400
Received: from mail-pz0-f186.google.com ([209.85.222.186]:36668 "EHLO
	mail-pz0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032Ab0CaMXR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Mar 2010 08:23:17 -0400
Received: by pzk16 with SMTP id 16so21849pzk.22
        for <git@vger.kernel.org>; Wed, 31 Mar 2010 05:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eMf1RIPBG6EOnwY7KXMLIdypNx/FylhlQzcDyzHlHMM=;
        b=nD1ilNp7BnVypjWfVBk8KRnsw4WCoIgmivK1etDfRF+q/DlEojUouUhbsLeUIGCjBs
         +iJlbxjoJZXRI2X5J+TVNWh0oS03Fhkzfd+MnH81fYF8RAXk4oxXYkcvS+laArYnGmdu
         wOUg3aXHtb7+mM5AR5D6bCtubU19VK34HV7OE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VMrflWFU+nhqPc6/z5hwDjoyXMCGfxF1Pa+VM0Pk1oyc0J9C1fcV3eLIbUPuy1nMDo
         /J1uLh6dWVoqfzKWqoYyk6eP25gUD9hX7ZA4Thl1bNl7qB5FNmcS4dKDkcXXuK1Wd2K/
         tSE7pxXTG2/YPmdYrM82f+98wZpQ7dk++ew5A=
Received: by 10.114.13.5 with HTTP; Wed, 31 Mar 2010 05:23:17 -0700 (PDT)
In-Reply-To: <4BB3346C.7070700@viscovery.net>
Received: by 10.115.65.27 with SMTP id s27mr1198781wak.144.1270038197196; Wed, 
	31 Mar 2010 05:23:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143670>

What about the safe (but complicated) diff -c by default (to prevent
misinformed Use Remote/Local decisions, by default) and a "Conflicts
Only" option (disabled by default) that shows the diff --cc output for
those who know what they are doing?

jon.

On Wed, Mar 31, 2010 at 11:39 PM, Johannes Sixt <j.sixt@viscovery.net> =
wrote:
> Am 3/31/2010 13:12, schrieb Jon Seymour:
>>> I looked at the result, but it does not convince me. In my case, I =
have a
>>> large file that has many changes between the "maint" and "master"
>>> branches. Whenever there are conflicts after merging "maint" to "ma=
ster",
>>> I see all these changes, and really they *are* uninteresting.
>>>
>>
>> I think you may have missed the point of my patch.
>>
>> The successfully merged lines may be uninteresting from the point of
>> deciding what I should *do* but they
>> are highly relevant to the question of what I really, really should =
*not* do.
>
> How would you decide that if you cannot read the information that is
> presented to you?
>
> Can you tell without thinking for 10 seconds which of these two chang=
es is
> lost if you choose "Use local version"?
>
> @@@ ... @@@
> =C2=A0x
> =C2=A0+foo
> =C2=A0y
> @@@ ... @@@
> =C2=A0a
> - bar
> =C2=A0b
>
> Oh, it's easy for the conflicted part of the diff, which you'll see
> elsewhere as well:
>
> @@@ ... @@@
> =C2=A0r
> ++<<<<<<< HEAD
> =C2=A0+foo
> ++=3D=3D=3D=3D=3D=3D=3D
> + bar
> ++>>>>>>> some-branch
> =C2=A0s
>
> Do not forget that in a case (like mine) where the non-condensed diff=
 is
> actually huge, the conflict markers would no exactly be easy to find =
in
> the diff.
>
>> If there are 100 successfully merged lines from each side of the mer=
ge
>> but only 2 conflicting lines, should I
>>
>> a) pick the remote branch
>> b) pick the local branch
>> c) manually edit the conflicting line (or use a merge tool)
>>
>> The point of my patch it to make it much more likely that you will p=
ick c).
>
> And I was saying almost the same, namely that it should not only be "=
much
> more likely" to pick c, but to *always* pick c (by making it the only
> option available).
>
>> In the current state, the GUI doesn't make it clear that either a) o=
r
>> b) is almost certainly a huge mistake.
>
> And therefore I suggest to disable these options.
>
>> Now, you could disable Use Remote and Use Local for all but the very
>> simplest cases - but you don't need it for these
>> cases. Hell, ed would do for these.
>
> Which are those very simplest cases that you are referring to? If you=
 mean
> modify/delete conflicts, then I indeed would like to keep the options=
 for
> them.
>
> That said, your earlier patch that presented the diff against HEAD wa=
s not
> bad after all.
>
> -- Hannes
>
