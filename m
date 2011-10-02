From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Does git have "Path-Based Authorization"?
Date: Sun, 2 Oct 2011 14:24:32 +1100
Message-ID: <CACsJy8B2rhXvGKUsu10Po8cCi7p8uqWXWE5ZHB2Z6hH-aMyR2Q@mail.gmail.com>
References: <CAN0CFw0QXkNSF8+qGu+pCrv5dgy1OEvtq-53f23GRd4RrZ1GcQ@mail.gmail.com>
 <m3lit4oo9q.fsf@localhost.localdomain> <CAN0CFw3kzAgaVBKNHE5ttJgYnc_csjeHjOLq=EBjLizW=RPUkA@mail.gmail.com>
 <CAMK1S_icdpCyA8SBcNu8CbCk3N-h8yEYZ9+6N=JVPAeayuzSPw@mail.gmail.com> <CAN0CFw2gVH7=LdKhseE3zo+Av_=kVdz=tH3s=BKeTK9bDOprcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Grant <emailgrant@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 02 05:25:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RACfu-00034a-GQ
	for gcvg-git-2@lo.gmane.org; Sun, 02 Oct 2011 05:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423Ab1JBDZG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Oct 2011 23:25:06 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40555 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab1JBDZE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Oct 2011 23:25:04 -0400
Received: by bkbzt4 with SMTP id zt4so3676174bkb.19
        for <git@vger.kernel.org>; Sat, 01 Oct 2011 20:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=96V3WGrFNvLoi38T+HuXLqRwmQjNgqbDKMDVHLbAr/Y=;
        b=M+BIL46/MFHwk7MpkBFURqdaqi1ttHy/9T2as64ljgZDQM2UJa4bAf5OdxJwM9fICW
         886wlbMjIzGXuMcDW02xLAD5kohc76VPDDF3vXdCdVBc7SPj2jE+mAC6DavC5FVNS1zt
         wlNUK9kBxunm5AYAg3r73cn66+BCMXBgZwBGg=
Received: by 10.204.133.92 with SMTP id e28mr8382035bkt.407.1317525902170;
 Sat, 01 Oct 2011 20:25:02 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Sat, 1 Oct 2011 20:24:32 -0700 (PDT)
In-Reply-To: <CAN0CFw2gVH7=LdKhseE3zo+Av_=kVdz=tH3s=BKeTK9bDOprcw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182589>

On Sun, Oct 2, 2011 at 1:53 PM, Grant <emailgrant@gmail.com> wrote:
> How would something like that work in a case like mine where I have a
> series of maybe 100 files and I only want to give my developer
> read/write access to one or a few files at a time with no read or
> write access to any of the other files? =C2=A0Wouldn't setting up a
> different repo for each set of files be difficult to manage?

The write part is easy. Just setup hooks to reject updates on those
files (however, notice the offline nature of git, people may commit
locally and the push later, you may need to check commit time on your
hooks).

The reading part is hard, especially the way you put it ("at a time").
The only way I can think of is to not download those objects and try
to fetch from central repo every time the objects are read,
essentially turn git into a central scm again. Git does not support
this and may never do unless there's an reasonable use case.

So I have to ask, why do you do it this way? Once you give read-access
to a developer, he/she can always save the files somewhere, revoking
read access later on would be useless.
--=20
Duy
