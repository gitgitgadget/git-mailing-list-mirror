From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [Bug] Permissions of temp file created in git's sha1_file.c correct?
Date: Wed, 02 Feb 2011 04:47:20 -0800 (PST)
Message-ID: <m3vd128uz7.fsf@localhost.localdomain>
References: <5dfd4de157546244c86acd52564247ce@kloeckner.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: =?iso-8859-15?q?Daniel_H=F6pfl?= <daniel@hoepfl.de>
X-From: git-owner@vger.kernel.org Wed Feb 02 13:47:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pkc7M-00053B-Ie
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 13:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754003Ab1BBMrX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Feb 2011 07:47:23 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33593 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125Ab1BBMrX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Feb 2011 07:47:23 -0500
Received: by fxm20 with SMTP id 20so7982602fxm.19
        for <git@vger.kernel.org>; Wed, 02 Feb 2011 04:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=x/xZZNQGAoFRo+cIS3GpziaFpM422A1fpZRrPlh44nw=;
        b=W+GDTtgzk4FvLZl7VSTi/i9iBU2bSiU94HzItCNX9VgeMgXDnFeLmsMfeUYBgHuHES
         mhcqtBv+1gQipgFAkD5ambkICwr/7BMUe/Fn62sAVNC3LeurTS4S22K04FGdseEDab4y
         8NoLMFyjKgiC6DZZwnMFT/b5hViRFkOd9QmLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=BQv6PUdXPz1SiDRgLDL8MG9KszFE27WOzQfEZxymufkbLWMkgsGwwBeYvaIeEj4u3d
         8dj9y2JGq4hF9p7CGbx6ODzgt8RIpM7H0ViKUd66LfO2GUwACv6e8WfeyYNNbG9A//Lw
         J9+/T5kzGT6nxSvJNOyKW2wicwxNxsQbJXxPA=
Received: by 10.223.87.75 with SMTP id v11mr1923152fal.131.1296650841806;
        Wed, 02 Feb 2011 04:47:21 -0800 (PST)
Received: from localhost.localdomain (abvv233.neoplus.adsl.tpnet.pl [83.8.219.233])
        by mx.google.com with ESMTPS id y1sm8317565fak.15.2011.02.02.04.47.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Feb 2011 04:47:20 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p12Ckm5m006908;
	Wed, 2 Feb 2011 13:46:58 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p12Ckb7N006905;
	Wed, 2 Feb 2011 13:46:37 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <5dfd4de157546244c86acd52564247ce@kloeckner.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165907>

Daniel H=F6pfl <daniel@hoepfl.de> writes:

> Hello,
>=20
> I recently (very recently: yesterday) started using git. I switched f=
rom
> Bazaar, that required me to have a file system that supports the exec=
utable
> flag (as it always stores this flag based on what the file system say=
s).
> FAT does not support the executable flag.

That is why there is `core.fileMode` config variable, see git-config(1)
manpage:

   core.fileMode
         If false, the executable bit differences between the index  an=
d  the
         working copy are ignored; useful on broken filesystems like FA=
T. See
         git-update-index(1).

         The default is true, except git-clone(1) or git-init(1)  will =
 probe
         and  set  core.fileMode  false if appropriate when the reposit=
ory is
         created.

Didin't git detect that it was on such filesystem?

[...]
> I think that my file system is right (of course ;-) ): A file that is=
 not
> writable must not be renamed (arguable as the name could be seen as t=
he
> content of the containing directory) and it must not be deleted.

Not true.  Whether file can be renamed or deleted is governed by
permissions in directory that contains given file, not the file itself
(at least on POSIX).  If I understand things correctly, of course.

Note that git doesn't store full permissions, in particular read/write
permissions, only executable bit and "is symlink" thing.
--=20
Jakub Narebski
Poland
ShadeHawk on #git
