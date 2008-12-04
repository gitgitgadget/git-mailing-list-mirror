From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFCv3 1/2] gitweb: add patch view
Date: Thu, 4 Dec 2008 08:24:52 +0100
Message-ID: <cb7bb73a0812032324m24991c5cydec41203e738fa89@mail.gmail.com>
References: <1228345188-15125-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <7vy6yw95ln.fsf@gitster.siamese.dyndns.org>
	 <cb7bb73a0812031620s2459f773q3db33971e3507b2f@mail.gmail.com>
	 <200812040249.01374.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 08:26:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L88bF-0003rD-0Q
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 08:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953AbYLDHYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 02:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753109AbYLDHYy
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 02:24:54 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:47883 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbYLDHYy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 02:24:54 -0500
Received: by nf-out-0910.google.com with SMTP id d3so2041479nfc.21
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 23:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=j1v7Fhwtydqni5FjtC67uMQ7thhK26+iVM1DBDWRTlM=;
        b=k68hJEmB6aCx/ZLMlDhsm6JwkPUKuH26sCDpttqontgJMukucMs6Hi7sQMlCKVA/Pu
         t6iDgp/5lbJWurcqLnk+fGiM7aKYacqjGDdaIA/95BKeU7EUuP3UuH5isppPi1xmZDcP
         yTQ6wpXmasrmMYP0riCQSsgudQ/K7TUzCx6CQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Y1qpIdwX9mpNP34Zxro2QI96gBFRiAMXaYwnvXXXMwDMREO6LmsNWllz8gnRficRtj
         D2syRwyc6JfDLLOVik8Qhp18dQCFdchzXh0OGbbfAxgB+DKLXc2yy7/tkXjxH7PbqTgT
         9Aw/hp+9SY9k9fDVnHQ6U8SpuuNRoQO8dtXaQ=
Received: by 10.210.52.15 with SMTP id z15mr3200202ebz.28.1228375492237;
        Wed, 03 Dec 2008 23:24:52 -0800 (PST)
Received: by 10.210.79.12 with HTTP; Wed, 3 Dec 2008 23:24:52 -0800 (PST)
In-Reply-To: <200812040249.01374.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102328>

On Thu, Dec 4, 2008 at 2:48 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Thu, Dec 4, 2008 at 01:20, Giuseppe Bilotta wrote:
>> On Thu, Dec 4, 2008 at 12:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>>>> +
>>>> +     # The maximum number of patches in a patchset generated in patch
>>>> +     # view. Set this to 0 or undef to disable patch view, or to a
>>>> +     # negative number to remove any limit.
>>>> +     'patches' => {
>>>> +             'override' => 1,
>>>> +             'default' => [16]},
>
> Errr... you need something like 'sub' => \&feature_patches for override
> to actually work, I think.

Oops, right.

>> I always assumed that the disabled default was related to how invasive
>> the changes would be (to the UI or computationally-wise). As for the
>> overridability, that's actually the only reason why it would make
>> sense to put in the %feature hash ... otherwise a conf-settable
>> $patch_max (as in v2) would have been enough.
>
> Add to that the fact that this patch just adds the new view, like for
> example in the case of 'snapshot' link, which was turned on... but fact,
> it was by default not overridable. I would agree that it can be turned
> on with low limit but not overridable in introductory patch.

Ok, I'll make it non-overridable, and keep this 16 limit for starters.
Or would you suggest even lower?

>>>>  sub git_commitdiff {
>>>>       my $format = shift || 'html';
>>>> +
>>>> +     my $patch_max = gitweb_check_feature('patches');
>>>> +     if ($format eq 'patch') {
>>>> +             die_error(403, "Patch view not allowed") unless $patch_max;
>>>> +     }
>>>> +
>>>
>>> Should you have to pay overhead for the check-feature call even when
>>> the $format is not "patch"?
>>
>> Actually I wasn't sure if I could use my within the if block, and have
>> the value visible outside (it's used further down when picking the
>> options to pass to format-patch). And since it was used in the second
>> patch anyway to choose whether to add the 'patch' link in html view or
>> not, I just put it outside the block.
>
> You have to use _declaration_ ourside block, but assignment can happen
> inside:
>
> +     my $patch_max;
> +     if ($format eq 'patch') {
> +             $patch_max = gitweb_check_feature('patches');
> +             die_error(403, "Patch view not allowed") unless $patch_max;
> +     }

Right, stupid me.

> (Side note: doesn't it uses spaces instead of tabs for align?)

I'll check.

-- 
Giuseppe "Oblomov" Bilotta
