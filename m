From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: permissions
Date: Wed, 9 Jun 2010 14:56:43 +0200
Message-ID: <AANLkTik1FqUkgLYLiz1frA_G0Lws8B4tf7c6Kp3dXcCO@mail.gmail.com>
References: <4C0A19FE.1020802@wpursell.net>
	<m27hmdn704.fsf@igel.home>
	<4C0A9615.4090307@wpursell.net>
	<AANLkTileRHwUuJpvKJbivRiM9Prn9wJ0zH6abExBgcq0@mail.gmail.com>
	<4C0B6C32.1090700@wpursell.net>
	<7vvd9wvswy.fsf@alter.siamese.dyndns.org>
	<4C0E1AB1.2030702@wpursell.net>
	<AANLkTimAmSxq8dC-4bnpLsvN3JabQeTO6pDTh9ds7D0D@mail.gmail.com>
	<7vtypds09x.fsf@alter.siamese.dyndns.org>
	<4C0EC3D0.6060509@wpursell.net>
	<AANLkTikGpbeP1ba0y0oUsWGQXsrL8Z-GKjybCB83W_FJ@mail.gmail.com>
	<4C0F6CF0.3020603@wpursell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 14:56:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMKpu-00024d-Cu
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 14:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874Ab0FIM4p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 08:56:45 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50512 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab0FIM4o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jun 2010 08:56:44 -0400
Received: by gwb15 with SMTP id 15so2372277gwb.19
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 05:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=77EQOrXZ5l1TbhZnqMjUIxZBQ5ZdA/RuBXwzOq/0LwM=;
        b=ZAXPez++FQHxjTVUGYxBIiJlrK+5L3gaWgpZxV5xjlmvnm+y4565iKBSKdxubZPUT7
         weXaiS7eeQ2J9mYPIUSQ4GcWvxzD5hsMOzAozGNi2XZrOhpFKOH8go5ZkrLh9djU7WK0
         ngjWEhIPhrRQKH4sy3YzRdQnJkyiwCUQHGHh4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CRZfM+vS94krKwZ0stJ7yqcjdMDVwRSn2FmSyl3Qg9sQ2Jcx9zgUncD4GgDFTYLsoa
         fMl8QuTEqb0HCrEGyp1QXT0sRsgc5eJinTnL6KMDlmE37tN1T/aEtstd8jb9zBLWR/Wy
         ft4Pan3vQOq4MIRgUSCXONC2LEw35GgkuTsTo=
Received: by 10.101.173.28 with SMTP id a28mr17878443anp.229.1276088203625; 
	Wed, 09 Jun 2010 05:56:43 -0700 (PDT)
Received: by 10.100.229.5 with HTTP; Wed, 9 Jun 2010 05:56:43 -0700 (PDT)
In-Reply-To: <4C0F6CF0.3020603@wpursell.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148768>

On Wed, Jun 9, 2010 at 12:29, William Pursell <bill.pursell@gmail.com> =
wrote:
> I do care quite a lot actually. =C2=A0My primary goal
> was to minimize the changes, and it seemed that
> is_git_directory() was the right place to make
> the change with minimal impact.

While smaller patches are preferred, they are not the goal, per say.

>=C2=A0Perhaps the following patch would be more to your liking:

Looks like a lot of effort just to get a little more information in
an infrequent (and frankly, obscure) failure case.
How about just use errno after failed is_git_directory? It seems
to make sense even when the function calls down to validate_headref.
You may even reset errno to 0 (this will also make obvious
the expectation of valid errno from is_git_directory).
