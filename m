From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/24] Yet another pre-refs-backend series
Date: Sat, 9 Apr 2016 19:10:06 -0700
Message-ID: <CAPc5daXvr-doTg482nM164189gjr-M=R8FdDXyVOaduzuepAJA@mail.gmail.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com> <57092BA6.1060808@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Apr 10 04:10:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ap4pd-00086j-47
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 04:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbcDJCK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 22:10:27 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36821 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbcDJCK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 22:10:26 -0400
Received: by mail-yw0-f195.google.com with SMTP id i125so8491360ywe.3
        for <git@vger.kernel.org>; Sat, 09 Apr 2016 19:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gR0VODiryWbPTRzVkgROrU31hJ2p+rhgl8cTRCp3soU=;
        b=r1jnPVMVyGwWFSGTqflNlVVxZ54nfpUXG3qKxC3fHZOIpx+Oa2zyJxEB3zF6UsUGU1
         FB+E/b0U2DN4b6iXWd2YZ7C2I3Esy9kxxWWxxwbiO5E73+zFKOWxedS0t5zEAN19IRuq
         anksAcZMUx6hMme6whlEqxBEyvsaOqTjuAESa4mVz1ZOoLMwjDr8s7D7mXCKyfID2XFY
         KpGWpIWvHKJC8eTPzb/M4ILm4FMiuJkdclwGW9Nh0uCh1E8bdBGp0WcVPbNWthKKL1Vz
         kxavx2+ku4G0mk7uRaMm10DaOBipaLnpRW5Cz4anap/suwHFleeOCiVWn6l9TCe+Jg9x
         8dqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=gR0VODiryWbPTRzVkgROrU31hJ2p+rhgl8cTRCp3soU=;
        b=bNGS50rGy5VD80xAtdAwAPbBPlDlWVpIMsa+GrPO0y6mfpnJIGGtoOhaRYCRsth3U7
         6/rkhI0HsR0O5IqN+IvMq4LWLAFtCY/HhZHIUd9KmeWnUX9s5aKT0KoquL9dJmd+m1CX
         y9x/LktkdMrSAFINC52xJIHXiAH4rm75cAkA/FvUSBZL0owUpgEXKFrX7vlmgSStDi+b
         6qqgXcUZbDh/k7zHQz6JfRAGvQWQ1Kof/bBDcER2xhZdYY5GZ7I5NxXztyWDTI16oCG4
         FU2VLhrgHOrv9IJRXRlZ2LuLD4kwa1Y4bY1fharzKuX49sAUWsOzWxzQ4wp8oH+H20+W
         M9TA==
X-Gm-Message-State: AD7BkJJ3XdlTix4EFHTXgOmLDp3rlE2y1bDnkljMmvkI+99r3vxUpBRFMu+JphAf/TP9GtF11Gcw+6nqPz+ZBQ==
X-Received: by 10.129.21.213 with SMTP id 204mr7810000ywv.70.1460254225916;
 Sat, 09 Apr 2016 19:10:25 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Sat, 9 Apr 2016 19:10:06 -0700 (PDT)
In-Reply-To: <57092BA6.1060808@alum.mit.edu>
X-Google-Sender-Auth: ORUypaVRBUX72YVujJZofCAkp2A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291138>

On Sat, Apr 9, 2016 at 9:19 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>
> I think this risk is acceptable nevertheless, because expiring reflogs
> is an uncommon operation and unlikely to be done from two processes at
> the same time; moreover, the integrity of reflogs is not a matter of
> life or death.
> ...
> If somebody is really upset about the risk of a race between an old and
> new version of `git reflog expire`, the way to increase the safety would
> be to lock *both* the symref and the referent while changing the
> symref's reflog. I think that would be overkill.

Thanks, I agree with all of the above.

> This whole series is
>
> Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>

Will squeeze it into all of them, then, and merge to 'next'.

Thanks.
