From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] logging branch deletion to help recovering from mistakes
Date: Tue, 7 Dec 2010 18:37:01 +0700
Message-ID: <AANLkTinDyix3KEdLLGJEWQ8X+a3zQZOAiTh2mLf5wuvQ@mail.gmail.com>
References: <7vlj42siu5.fsf@alter.siamese.dyndns.org> <AANLkTikbsyFUzZeu8R6yAND6spV6OnvYL08gYZ+ZgJCh@mail.gmail.com>
 <7vmxoiqeoq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 12:37:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPvrW-0008UV-7D
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 12:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787Ab0LGLhd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 06:37:33 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:39352 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697Ab0LGLhc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 06:37:32 -0500
Received: by wwi17 with SMTP id 17so785670wwi.1
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 03:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=gRCODxSkibojL2231ErELZBHRW/yo7ZOttwKY6Y827M=;
        b=MXvR8SnsN4/JXxcQetJp7dEBHT4WSp9COrpUH6GLnNFh2/MmVlfGNUVmVh9zn8Z51R
         2YI/gsh5o8G0Itv3DB2BAP24MO4Ev3xm4hXA3c3a5g/98C6cRuaMG9mpMAS61tisYYLR
         3auhq94MiSHJ+ItUQmAnRh05delPK4RoBa1DI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ZGjaWA1VvrrsAlRKgC9V+u8UqpZ9vRV54f4G2VGPAByWevWwVRegCMjGTyVzc55hSE
         GKxenfgESh2MttsGZ/RGhDDPtpQI4NJlGDn0IC4Uqv5oZUsIB6AYe9F3IQRGXdhcotra
         RGRNSQhUBonmBBc7Qyjuf4uvVyyVgLl+VS8Is=
Received: by 10.216.156.21 with SMTP id l21mr3211493wek.49.1291721851205; Tue,
 07 Dec 2010 03:37:31 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Tue, 7 Dec 2010 03:37:01 -0800 (PST)
In-Reply-To: <7vmxoiqeoq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163075>

On Tue, Dec 7, 2010 at 1:28 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Tue, Dec 7, 2010 at 4:16 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>> +#define BRANCH_DELETION_LOG "DELETED-REFS"
>>> +
>>
>> Should this special log be mentioned in git-update-ref.txt or
>> gitrepository-layout.txt?
>
> Perhaps, but I wasn't sure if this patch itself is a good idea to beg=
in
> with. =C2=A0Not the problem it tries to solve, but its approach.
>
> For example, this cannot be shown with "reflog show" or "log -g" due =
to
> the way these frontends locate the reflog file to read (the logic wan=
ts to
> have an underlying ref).
>

I think you have thought of this. What's wrong with keeping reflog
when a branch is removed and appending "delete" line to the said
reflog? I don't know how reflogs are managed, but those reflogs
without associated branch will (or should) be cleaned when they are
expired.

I stick with this idea because I also want to archive old branches and
am thinking those reflogs ending with "archive" line will be kept
forever, or until I feel like digging up them again.
--=20
Duy
