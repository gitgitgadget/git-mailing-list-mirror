From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 02/18] Change style of some regular expressions to make
 them clearer
Date: Fri, 7 Jun 2013 00:39:34 -0400
Message-ID: <CAPig+cRyHc0SiWrHKQ3w4jCW5a-2p=k0TsjeRBe_kyw+DfnrqA@mail.gmail.com>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
	<1370547263-13558-3-git-send-email-celestin.matte@ensimag.fr>
	<CAPig+cQvWJ8RRsqKEMooV_AntTBZ1Pi=WA_1LFU955J+9jDzTg@mail.gmail.com>
	<7vbo7iwt3h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>,
	Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 06:39:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkoSv-0001np-OP
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 06:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023Ab3FGEjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 00:39:37 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:41864 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898Ab3FGEjg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 00:39:36 -0400
Received: by mail-lb0-f172.google.com with SMTP id p10so3858390lbi.31
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 21:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=mQDB5Y3d5EHPpIAFEdLcmJoQyfuS9KRgIrqvgR7/9Z0=;
        b=Ir2QOVU1du64X6Yv3ZkYCXNHd/g+M9m8+DvDTtnsut/LcolYGTnWr27vUUlX2XhBy9
         Vy+Y3pvFxNeAVr1UPo/7QNvhHLpaaOPZlYddtHGtJlKsDL1zfY1dz5A0eElU71CCYBRI
         t6wUhvM+KFG5GBU90S/NY/Wdg7ftnXHVceyaAk5ok+O+83aLLldR4GH1R4skVHwoZ62h
         Bn1T+TzdIsmK4HFf3qHcDzi7f5FpSyyjEP8xRrHKWUIUPPemmlY88tPWCW+XO56Fm3Cg
         scbPfA2chmHU1t2euFSjJCjeTs83BfQ05U0zpYle5Ze7zXaIuj6erJwVL89TEa84SI7G
         Thaw==
X-Received: by 10.152.44.225 with SMTP id h1mr1612945lam.90.1370579974956;
 Thu, 06 Jun 2013 21:39:34 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Thu, 6 Jun 2013 21:39:34 -0700 (PDT)
In-Reply-To: <7vbo7iwt3h.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 30G48ZjBPVUBXhlDccE6egkiHpI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226588>

On Thu, Jun 6, 2013 at 10:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>> -                       if (my ($child, $parents) = $line =~ m/^-?([a-f0-9]+) ([a-f0-9 ]+)/) {
>>> -                               foreach my $parent (split(' ', $parents)) {
>>> +                       if (my ($child, $parents) = $line =~ /^-?([a-f0-9]+) ([a-f0-9 ]+)/) {
>>> +                               foreach my $parent (split(/ /, $parents)) {
>>
>> This is a behavior-altering change. split(' ',...) is handled as a
>> special case[*1*] which strips leading whitespace and then splits on
>> /\s+/ (run of whitespace). Changing it to split(/ /,...) makes it
>> match only a single space (rather than a run of whitespace).
>
> I initially had the same reaction, but this is reading the output of
> the "rev-list --parents" command, whose fields are separated by one
> SP each, so there is indeed no behaviour change.

True. This potentially subtle point may deserve mention in the commit
message (or this particular change can be dropped).
