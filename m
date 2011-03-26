From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] HOME must be set before calling git-init when creating
 test repositories
Date: Sat, 26 Mar 2011 19:42:14 +0100
Message-ID: <AANLkTi=Pt_Pw9BvL6y8Wq34PeRHVOZpr6ZekRYqfDXq6@mail.gmail.com>
References: <20110325200528.GA7302@blimp.localdomain> <7vsjub53j2.fsf@alter.siamese.dyndns.org>
 <AANLkTimQzPVOWCUx1hr+DEmRfdFB8=UeY_xCaxzVSwFy@mail.gmail.com>
 <7voc4y6g6v.fsf@alter.siamese.dyndns.org> <AANLkTikO4=TtFtpsQ_JtmGKqQ1NzgTuo7e8cdaQca+T7@mail.gmail.com>
 <7vvcz64ygm.fsf@alter.siamese.dyndns.org> <AANLkTi=+SZGxLyP8vFPpmK8DZvke6-Tu-crwq5+89qWx@mail.gmail.com>
 <20110326141118.GA3475@sigill.intra.peff.net> <20110326182126.GA13496@blimp.localdomain>
 <20110326183102.GA3796@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 26 19:42:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3YRn-0005ro-9j
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 19:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556Ab1CZSmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2011 14:42:36 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:58487 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474Ab1CZSmf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 14:42:35 -0400
Received: by gxk21 with SMTP id 21so802171gxk.19
        for <git@vger.kernel.org>; Sat, 26 Mar 2011 11:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=pOVJ+1fpSs+r+XFm0NkD6GkvF2Bm4mXSsJBk8U561Uw=;
        b=R/BtAL6D5rQO/KxVNAGUrkZPsy7rsgWChqpEdoryQvx52enL0eCsZpwL52WbbTj8ao
         Q49QuGrx077a1sUXOMRIDbK8fAf9t9zYyCPmLgr/kauWRVi069HdFy0tIgOrxk1Hq7vz
         SF5s9h+8qLiTB2VCLu1YflL8tZlp7RUfdUQvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=qpBLRQm4DF/Q4mmExqbg+uFiBB3tcT+2Cr24CpdKzDHVvrLkMbZwZdEv/9YuYDcJpj
         GpGzIAO381EFsNBOfX/+G914N9kcwWOhZkguMtE9kMBiM4zOj6GYy1fIpYnGXod8jKGD
         dvd88r/S6kfuAGCLQb0xJZBojtbjfAcEWT03g=
Received: by 10.90.152.8 with SMTP id z8mr2273626agd.67.1301164954141; Sat, 26
 Mar 2011 11:42:34 -0700 (PDT)
Received: by 10.90.223.11 with HTTP; Sat, 26 Mar 2011 11:42:14 -0700 (PDT)
In-Reply-To: <20110326183102.GA3796@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170066>

On Sat, Mar 26, 2011 at 19:31, Jeff King <peff@peff.net> wrote:
> On Sat, Mar 26, 2011 at 07:21:26PM +0100, Alex Riesen wrote:
>
>> > No, it's totally broken. $(pwd)/$test is nonsensical. The code right
>> > above your change guarantees that $test is an absolute path, either
>> > because the user gave us an absolute $root or because it has been
>> > prepended with $TEST_DIRECTORY (which itself comes from $(pwd)).
>>
>> I see. I mistook "$root" for the root of a filesystem, not the variable in
>> test-lib.sh. How about this, than?
>
> Oops, when I said "$test" I meant to say $TRASH_DIRECTORY. That is,
> $TRASH_DIRECTORY is always the absolute path to the trash.
>
>> +HOME="$(pwd)/$test"
>> +test -n "$root" && HOME="$test"
>> +export HOME
>
> So you can simplify this to just:
>
> HOME=$TRASH_DIRECTORY
>

Aah... I should have actually looked at the "case" which
sets TRASH_DIRECTORY!

Will resend in a moment.
