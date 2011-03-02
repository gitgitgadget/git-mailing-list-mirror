From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2011, #07; Mon, 28)
Date: Wed, 2 Mar 2011 19:28:12 +0100
Message-ID: <AANLkTim_euHU-vSULW0zk6SwrHridtvv5aqPVhBr_aXi@mail.gmail.com>
References: <7vbp1vfy5f.fsf@alter.siamese.dyndns.org> <AANLkTim7Jo5KLwf760dQN5PucrsD1wvuksds-4Qi0csd@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 19:28:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Puqmt-000710-GH
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 19:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756288Ab1CBS2d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2011 13:28:33 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49343 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755636Ab1CBS2d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Mar 2011 13:28:33 -0500
Received: by mail-bw0-f46.google.com with SMTP id 15so423351bwz.19
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 10:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=VItjicQiXku9kMdjkjeDXX1hdkzLnnPX/WmjxxxEUJc=;
        b=VAxiMTsIoBTJ9JGJQk5b7Qjs6p7HPl+wv+irs0em1mHpXAV4ZcYZy36bQhpmiaVvfL
         vRIYViiFhcAvJTLStWmKolxB+e3pFzk2vYohrsagUD8WX0rutZQTeT6g2VD3o9mOMWnp
         GBVCa7/7ry0A4vKODgnhPYp2n/O6KELpt6XbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=KekmUmkiLIS2/GpuXIVw8BVoguUpdBHG+GMCfCOHc7+UMnYPQOs0Ku2CQGHtcXRLFd
         aGUZDarVV4dAEtm+YqW9Vg4MCDlGB5T5URVLnmMyE5ze+GK0NvHHvSEndP5CmX8zgWdE
         Q2qrT+BmBjf1WainPfEzHGyYqcMqfT4czq01o=
Received: by 10.204.71.20 with SMTP id f20mr342910bkj.139.1299090512123; Wed,
 02 Mar 2011 10:28:32 -0800 (PST)
Received: by 10.204.67.81 with HTTP; Wed, 2 Mar 2011 10:28:12 -0800 (PST)
In-Reply-To: <AANLkTim7Jo5KLwf760dQN5PucrsD1wvuksds-4Qi0csd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168332>

On Wed, Mar 2, 2011 at 7:22 PM, Erik Faye-Lund <kusmabite@gmail.com> wr=
ote:
> On Tue, Mar 1, 2011 at 2:05 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> * sp/maint-fd-limit (2011-02-28) 2 commits
>> =A0- mingw: add minimum getrlimit() compatibility stub
>> =A0- Limit file descriptors used by packs
>>
>> Erik, please check the made-up commit log message and sign it off.
>> Will merge to 'next' after that.
>
> Seems to work:
>
> $ ls .git/objects/pack/*.pack | wc -l
> =A0 2049
> $ git gc --auto
> Auto packing the repository for optimum performance. You may also run
> "git gc" manually. See "git help gc" for more information.
> Counting objects: 2056, done.
> Delta compression using up to 4 threads.
> Compressing objects: 100% (2049/2049), done.
> Writing objects: 100% (2056/2056), done.
> Total 2056 (delta 2048), reused 13 (delta 5)
> Removing duplicate objects: 100% (256/256), done.
>
> So feel free to add:
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>

Oh, and to be clear: Doing the same before these two patches gave this =
error:

$ git gc --auto
Auto packing the repository for optimum performance. You may also
run "git gc" manually. See "git help gc" for more information.
Counting objects: 2056, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (2049/2049), done.
fatal: Unable to create temporary file: Too many open files
error: failed to run repack

So the issue is indeed fixed, and it seems we don't have to bias the
resource limit.
