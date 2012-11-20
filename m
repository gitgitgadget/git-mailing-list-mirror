From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Crash when pushing large binary file
Date: Tue, 20 Nov 2012 18:37:35 +0700
Message-ID: <CACsJy8Ai=JK8c5GbjXBY2A4mtxSUUTzrTJt=puxXvDD1fhFmFg@mail.gmail.com>
References: <CA+AoP-n07k0r11O6ShOT8jHiX+TL+=p8sZoei+Gi+9gG_YyJqA@mail.gmail.com>
 <CACsJy8AAd0odtLDiZ+A+MhX1En_G97gF2uoHjVeJvekznY3JSw@mail.gmail.com>
 <CA+AoP-keNcjGLtxbb9t7sggur1e+XmbMN5apVJfEdfhqU2-JGQ@mail.gmail.com>
 <CACsJy8DsKc5_i6VKeYv69ikQXQPwEh3UOa5_bLaa4ss5vLxOng@mail.gmail.com> <CA+AoP-n=P3-yTshfQRwdyUcb7eFM12-+bAtS_FUAxXtwuFxjzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Thomas Gay <tgay@tokyois.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 12:38:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tam9o-0001L9-7N
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 12:38:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825Ab2KTLiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 06:38:08 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:46568 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234Ab2KTLiH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 06:38:07 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5787283oag.19
        for <git@vger.kernel.org>; Tue, 20 Nov 2012 03:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zdU5ujUXpIddi0SuaccD1r0MO4lsRESlILeGRDDEJbM=;
        b=qkC2SQ47PFPQn86wZPG3aytWSVRx4UmfNizBSkVjMesGB+6MAnIoUyKMm3O5OK1FRf
         BQrG1PnNEIv6/99bdfclwAVhvBElT+SgzlsGMOtLk06lBdTGRv4KxzGwRqXf4+fE+H88
         cR5ASykpMhxlV7aPRnhl8H7uydz9euHFW154AIc12BWTMdRQFoiXc9ITLDTYMp3bh2P7
         sAbnbEpnB/fdml7YZPq9O6lVAoVL4ag0gZoJ9Di7JMeZeDWixDSXfrOfpDBs8OKo2+3g
         teS14aJBoJPwNScFiPAjxAhPzyEb3PdLgu0jJg61oM/KOe0L4oKQBzzqhUbU/eoAmoZE
         iuPA==
Received: by 10.182.64.14 with SMTP id k14mr13341823obs.72.1353411486510; Tue,
 20 Nov 2012 03:38:06 -0800 (PST)
Received: by 10.182.14.201 with HTTP; Tue, 20 Nov 2012 03:37:35 -0800 (PST)
In-Reply-To: <CA+AoP-n=P3-yTshfQRwdyUcb7eFM12-+bAtS_FUAxXtwuFxjzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210092>

On Tue, Nov 20, 2012 at 8:50 AM, Thomas Gay <tgay@tokyois.com> wrote:
> Sorry for the late reply; I've been out of the office for the past few days.
>
> On Fri, Nov 16, 2012 at 7:11 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> If it still says "unpack-objects died of signal 11" then it was not
>> done the right way.
>
> I upgraded Git on both ends and tried setting it again. index-pack was
> used this time, but it still failed:
>
> Counting objects: 38, done.
> Delta compression using up to 4 threads.
> Compressing objects: 100% (26/26), done.
> error: index-pack died of signal 11 GiB | 62.44 MiB/s
> error: pack-objects died of signal 13
> error: failed to push some refs to '...'
>
> Would you still like me to try your other method?

Interesting. No, if index-pack fails too the culprit is something
else. Does the stack trace look the same (i.e. crashed in
write_sha1_file_prepare)? I still don't know how it crashes there.
It'd be great if you could run it under valgrind (not sure if valgrind
runs in OS X). Try building with NO_OPENSSL too to avoid external sha1
issues.
-- 
Duy
