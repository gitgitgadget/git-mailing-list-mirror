From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] HOME must be set before calling git-init when creating
 test repositories
Date: Sat, 26 Mar 2011 11:08:06 +0100
Message-ID: <AANLkTi=+SZGxLyP8vFPpmK8DZvke6-Tu-crwq5+89qWx@mail.gmail.com>
References: <20110325200528.GA7302@blimp.localdomain> <7vsjub53j2.fsf@alter.siamese.dyndns.org>
 <AANLkTimQzPVOWCUx1hr+DEmRfdFB8=UeY_xCaxzVSwFy@mail.gmail.com>
 <7voc4y6g6v.fsf@alter.siamese.dyndns.org> <AANLkTikO4=TtFtpsQ_JtmGKqQ1NzgTuo7e8cdaQca+T7@mail.gmail.com>
 <7vvcz64ygm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 11:08:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3QQ5-0001HE-OT
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 11:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564Ab1CZKI2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Mar 2011 06:08:28 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54890 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764Ab1CZKI1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Mar 2011 06:08:27 -0400
Received: by bwz15 with SMTP id 15so1415298bwz.19
        for <git@vger.kernel.org>; Sat, 26 Mar 2011 03:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=PLokkZukTgVghirpgS/dilQ/9lsTRfWZawDUsvtV758=;
        b=QJOQmR+JE6tzkg7EkpIcjS7dmrobwdZlGCDYPiewhHrPcD1Hq1aUYjRFN/RHud0dkm
         oU2bx9fIumvsEiTQe7+PtYBREbcypVf9LlojltYq7ArtxAuF8ur7xqnonWQn4OuTsO2z
         j0GfDjCMBkghePh4AK67YS4EQSug+2cw9+pcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=c1NEEJvtN+9Lq5w8Xcl06EWdaYwN3V3VbOE6hfRnqmFctZTZ6o7GsogkqdvFqmrV1v
         SuQy+zYcgnDYN3U0qNGS6542ojKfoRz0j4HTtpXUK/D9l3nIBVcPeXtqBA26WfQ3g6D+
         kNawlK1NGbNsZClc8NjextAguOvwydycY8LBE=
Received: by 10.204.74.7 with SMTP id s7mr1630993bkj.57.1301134106099; Sat, 26
 Mar 2011 03:08:26 -0700 (PDT)
Received: by 10.204.29.2 with HTTP; Sat, 26 Mar 2011 03:08:06 -0700 (PDT)
In-Reply-To: <7vvcz64ygm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170048>

On Fri, Mar 25, 2011 at 23:39, Junio C Hamano <gitster@pobox.com> wrote=
:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
>> On Fri, Mar 25, 2011 at 22:30, Junio C Hamano <gitster@pobox.com> wr=
ote:
>>> Alex Riesen <raa.lkml@gmail.com> writes:
>>>
>>>> On Fri, Mar 25, 2011 at 21:49, Junio C Hamano <gitster@pobox.com> =
wrote:
>>>>
>>>>> Doesn't this change the location of HOME used during the test as =
well?
>>>>
>>>> As long as the test only includes test-lib.sh only once - it doesn=
't.
>>>> Why? Or rather, how?
>>>
>>> I thought you moved HOME=3D$(pwd) across "cd somewhere-else". =C2=A0=
Doesn't it
>>> change what is returned from pwd?
>>>
>>
>> Oh, it does. That's why the second patch (prefixed "[PATCH, fixed]")=
=2E
>> It makes HOME to be "$(pwd)/somewhere-else", or precisely:
>>
>> =C2=A0 HOME=3D"$(pwd)"/"$test"
>> =C2=A0 export HOME
>
> What happens to people who has non-empty "$root", iow, their $test be=
gins
> with '/'?

It's still under $test then.

> I am not saying that having HOME at t/ directory instead of t/trash-*=
/
> directory would necessarily break things (I don't know). =C2=A0I am j=
ust
> pointing out that the patch changes behaviour.

It does. I still think we're better off using the test's trash director=
y
for a this. For instance, consider the case when a user's .gitconfig
created by one of the tests collides with .gitconfig's of the other tes=
ts.
Either when running in parallel or just sequentially: the .gitconfig in
"t/" is not cleaned up after a test finishes.
