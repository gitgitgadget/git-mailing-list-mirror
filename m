From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] HOME must be set before calling git-init when creating
 test repositories
Date: Fri, 25 Mar 2011 22:51:58 +0100
Message-ID: <AANLkTikO4=TtFtpsQ_JtmGKqQ1NzgTuo7e8cdaQca+T7@mail.gmail.com>
References: <20110325200528.GA7302@blimp.localdomain> <7vsjub53j2.fsf@alter.siamese.dyndns.org>
 <AANLkTimQzPVOWCUx1hr+DEmRfdFB8=UeY_xCaxzVSwFy@mail.gmail.com> <7voc4y6g6v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 22:52:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3Evh-0006MK-KN
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 22:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310Ab1CYVwU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2011 17:52:20 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64781 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755114Ab1CYVwT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2011 17:52:19 -0400
Received: by bwz15 with SMTP id 15so1222279bwz.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 14:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=pEINQfEE6TKi8Dq33rIFkqfLznLBW+DcbeJ0De40umg=;
        b=IiJrLftaOSEqBRHXm7XbsOfuiqGEE2dMBOmYfFAO5HY7o7nBInOzGo9IllCT9Ta2Y2
         dMdu9LUNPplZGemEwWunaK2NjRGG4tHfS1eSNux3OxvErMuJou9rrM4UJNpnzxn8qmZe
         6llfXI/anYnzRAr3o3upMI6HqZLoyeIuTNNKU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=BUl+kW7g1V0T+zhXXB9lzFvl/wOYEK4VWGZl7OkZZvinAeuS4iZQuJ43/K+T06q57W
         FTz0ZUCve9j/nCbl5r2blTGDMpxsXd2L4jm2JOLLIIMGlqK03FgpxMuA3/knfxOHvNPl
         axw5cIvGJ4fKRpGg/I0xmyUsBPwCtq/Bb0jAk=
Received: by 10.204.20.134 with SMTP id f6mr1223583bkb.165.1301089938192; Fri,
 25 Mar 2011 14:52:18 -0700 (PDT)
Received: by 10.204.29.2 with HTTP; Fri, 25 Mar 2011 14:51:58 -0700 (PDT)
In-Reply-To: <7voc4y6g6v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170025>

On Fri, Mar 25, 2011 at 22:30, Junio C Hamano <gitster@pobox.com> wrote=
:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
>> On Fri, Mar 25, 2011 at 21:49, Junio C Hamano <gitster@pobox.com> wr=
ote:
>>
>>> Doesn't this change the location of HOME used during the test as we=
ll?
>>
>> As long as the test only includes test-lib.sh only once - it doesn't=
=2E
>> Why? Or rather, how?
>
> I thought you moved HOME=3D$(pwd) across "cd somewhere-else". =C2=A0D=
oesn't it
> change what is returned from pwd?
>

Oh, it does. That's why the second patch (prefixed "[PATCH, fixed]").
It makes HOME to be "$(pwd)/somewhere-else", or precisely:

  HOME=3D"$(pwd)"/"$test"
  export HOME
