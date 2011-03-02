From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [RFC/PATCH] commit notes workflow
Date: Wed, 2 Mar 2011 17:24:13 +0100
Message-ID: <AANLkTimW-Cs5LVVOL9tpFiN6JsarWVo4Kua4ky7N1HB-@mail.gmail.com>
References: <20110225133056.GA1026@sigill.intra.peff.net>
	<201102251658.22678.johan@herland.net>
	<20110301215907.GA23945@sigill.intra.peff.net>
	<4D6DEB64.1080003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 17:24:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Puoqa-0003PP-Ap
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 17:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603Ab1CBQYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 11:24:15 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42635 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617Ab1CBQYO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 11:24:14 -0500
Received: by vws12 with SMTP id 12so74461vws.19
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 08:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=T6BU8MBrzRCAatJ00cesYOtMv48yYgqO3vUPiyGbylU=;
        b=Fyupy0tWwwHbwhxTiWRlIoJCR8opX4yeCmi+jWUHwfQZSuijCDSzbYBkWYWeMfpGDG
         KKlwpGa17o8GrDiKfT/WymnD1lLz8Lnlt4O09DPzkkmuDhnEPmhYPEqNiu2NFn2cqz49
         Ked/czjaLglo/AtsOje8X9rXTwEZsIUMQxDfw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=gviPKn+KTADdfOWo5teL96E6ckKz13zsDcKK5DSWdkk2N2fdu3aDD1Aa2SDS9E9Ugm
         oqbJSZH7llxv9O8vanZkVB1gY5VRjVVCOOCQId7VwEErF9in80wVUIdFhC/IRvnt7XW1
         eHasVNgIrKFMz2qf22UuG8VFRCuEIb86HbuM0=
Received: by 10.220.195.201 with SMTP id ed9mr1820vcb.35.1299083053584; Wed,
 02 Mar 2011 08:24:13 -0800 (PST)
Received: by 10.220.61.140 with HTTP; Wed, 2 Mar 2011 08:24:13 -0800 (PST)
In-Reply-To: <4D6DEB64.1080003@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168322>

Hi,

On Wed, Mar 2, 2011 at 8:01 AM, Chris Packham <judge.packham@gmail.com> wrote:
> On 02/03/11 10:59, Jeff King wrote:
>> On Fri, Feb 25, 2011 at 04:58:22PM +0100, Johan Herland wrote:
>>> Maybe we should use a slightly more verbose separator (i.e. more
>>> unlikely to trigger false positives). As you say, we already have to
>>> watch out for "---" because of "am", but that only applies to projects
>>> that _use_ "am" (i.e. mailing-list-centric projects like git.git and
>>> the Linux kernel). Other projects (e.g. github-centric projects or most
>>> centralized "$dayjob-style" projects) seldom or never use "am" at all,
>>> so I wouldn't expect those developers think of "---" as "special" in
>>> any way.
>>>
>>> What about using something like "--- Notes ---" instead?
>>
>> Yeah, it is true that many git users will never care about the
>> patch-through-mail workflow. And I think these days that is OK, because
>> rebase will take care to keep their commit message intact even if it
>> doesn't format well in a "format-patch | am" pipeline.
>>
>> I really wanted to keep it short and natural, though. Because eventually
>> I'd like to have this on all the time via a config option, and I don't
>> want to see "--- Notes ---" in every commit that doesn't have notes. But
>> I _do_ want to be able to quickly say "oh, let me make a note on this"
>> and just add a quick separator.

IMO typing "--- Notes ---" is quite fast. I suspect that most commits won't
have any notes, so you'll have to type it rarely.

Also, what should be the template with notes enabled? Should there
be the separator by default or not? Assuming notes are entered rarely,
I think template should not have the separator. But if you use "--notes"
command line option (i.e. interactive use), it should be there.


> <bikesheding>
> What about "#---"? Satisfies the quick to type and is a lot less likely
> to appear in commit messages. Not sure about the implications of finding
> that string before the commit message is stripped.
> </bikesheding>

I think the separator should be:
1. unique enough so people won't enter it by accident
2. easy to remember, easy to type
3. descriptive so you won't have to look into documentation to see what "#---"
    means.

I think "--- Notes ---" fulfills all requirements.

Also, in case of separator with some text, like "--- Notes ---", we would
like to be able to translate it probably, so I will see "--- Notatki
---" in Polish.


-- 
Piotrek
