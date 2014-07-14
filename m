From: Nico Williams <nico@cryptonector.com>
Subject: Re: No fchmod() under msygit - Was: Re: [PATCH 00/14] Add submodule
 test harness
Date: Mon, 14 Jul 2014 08:55:29 -0500
Message-ID: <CAK3OfOjoqOsL5GnJAC251gqRoQo_4qwKMicLSod=7ZA69SL68w@mail.gmail.com>
References: <539DD029.4030506@web.de>
	<53B41D42.2090805@web.de>
	<53B46425.3030000@web.de>
	<53B4F0AA.10809@web.de>
	<53B5C7AC.4040701@web.de>
	<xmqqsimddrq3.fsf@gitster.dls.corp.google.com>
	<53BAF7AF.4020901@web.de>
	<53BC47BD.1000705@web.de>
	<53BC53C3.1010304@ramsay1.demon.co.uk>
	<53BCE3A7.8070600@web.de>
	<20140709200046.GB17454@dcvr.yhbt.net>
	<CABPQNSY5x_JOsxyKn7xZ9nc5TJ0yHdNvam0htyX01U58bvV7vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Jul 14 15:55:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6gjN-0000a4-DK
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 15:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545AbaGNNze convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2014 09:55:34 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:35681 "EHLO
	homiemail-a106.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754685AbaGNNzb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 09:55:31 -0400
Received: from homiemail-a106.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a106.g.dreamhost.com (Postfix) with ESMTP id 23C5920047B75
	for <git@vger.kernel.org>; Mon, 14 Jul 2014 06:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:in-reply-to:references:date:message-id:subject:from
	:to:cc:content-type:content-transfer-encoding; s=
	cryptonector.com; bh=QBSfHCI2QYBRJmq2EiZ0P4ANVVY=; b=J3dIdZaS8tR
	CwQOpTcvvyKRBolnOiGUor3im6VhH5ij3xaFGOvaYNfrqpgFt59/wDZtuYRwzz11
	3ushDtoUfa+D81MF7p8yFYQEIAFFr6omDLXJAUBV4G+d6QA9MRavQyXdy1CPwn4M
	dSP5ZWo3wXqkLPGAt2+aRRXE9ienXdzc=
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com [209.85.212.171])
	(using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a106.g.dreamhost.com (Postfix) with ESMTPSA id CB7D920047B64
	for <git@vger.kernel.org>; Mon, 14 Jul 2014 06:55:30 -0700 (PDT)
Received: by mail-wi0-f171.google.com with SMTP id hi2so2605328wib.16
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 06:55:29 -0700 (PDT)
X-Received: by 10.194.85.78 with SMTP id f14mr19834110wjz.36.1405346129114;
 Mon, 14 Jul 2014 06:55:29 -0700 (PDT)
Received: by 10.217.98.6 with HTTP; Mon, 14 Jul 2014 06:55:29 -0700 (PDT)
In-Reply-To: <CABPQNSY5x_JOsxyKn7xZ9nc5TJ0yHdNvam0htyX01U58bvV7vg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253492>

On Mon, Jul 14, 2014 at 6:31 AM, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
> On Wed, Jul 9, 2014 at 10:00 PM, Eric Wong <normalperson@yhbt.net> wr=
ote:
>> Torsten B=C3=B6gershausen <tboegi@web.de> wrote:
>>
>
> You're saying this as if Windows is a single-user system. It's not,
> but it uses ACLs rather than POSIX permissions to manage file-system
> permissions. So far we've opted to ignore ACLs in Git for Windows,
> though.

The clever thing to do (that some versions of ZFS do nowadays) is to
use the new mask to "edit" the ACL as follows:

 - leave any DENY ACEs as-is; for all others continue

 - remove (reset) from any ACEs for Everyone (and/or Authenticated
Users) any bits corresponding to zero'ed bits in the new mask's other
bits

 - remove from any other ACEs that are not for the owner (@OWNER in
NFSv4 speak) any bits corresponding to zero'ed bits in the new mask's
group bits

 - remove from the owner's ACEs any bits corresponding to zero'ed bits
in the new mask's owner bits, but with some exceptions, in particular
the owner must retain the right to edit the ACL

 - add (set) to the Everyone (and/or Authenticated Users) ACEs a set
of bits corresponding to the set bits in the new mask's other bits

 - add (set) either only to the ACE for the file's group
(alternatively, to all non-owner, non-Everyone/Authenticated Users
ACEs) a set of bits corresponding to the set bits in the new mask's
group bits

=2E..

I.e., use the chmod mask to decrease/increase access without changing
the "shape" of the ACL.

Determining a file's mode_t from an ACL is similar, though it must
take DENY entries into account: make a set of users/groups referred to
by any ACEs in the ACL, divide them into owner, other (Everyone and/or
Authenticated Users), and group (all others), find the maximal access
granted.

Still, git might like to know what ACLs to apply to files at checkout
time.  That would be a vast new feature, I think, and probably not
worth it, particularly since that would require dealing with the
different types of ACLs: NTFS/NFSv4/ZFS on the one hand, POSIX Draft
on the other, plus AFS and who knows what else -- ETOOMUCH IMO.

Nico
--
