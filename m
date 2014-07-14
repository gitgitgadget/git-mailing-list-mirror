From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: No fchmod() under msygit - Was: Re: [PATCH 00/14] Add submodule
 test harness
Date: Mon, 14 Jul 2014 21:30:40 +0200
Message-ID: <53C42FE0.10904@gmail.com>
References: <539DD029.4030506@web.de> <53B41D42.2090805@web.de> <53B46425.3030000@web.de> <53B4F0AA.10809@web.de> <53B5C7AC.4040701@web.de> <xmqqsimddrq3.fsf@gitster.dls.corp.google.com> <53BAF7AF.4020901@web.de> <53BC47BD.1000705@web.de> <53BC53C3.1010304@ramsay1.demon.co.uk> <53BCE3A7.8070600@web.de> <20140709200046.GB17454@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 14 21:30:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6lxW-0002vo-RY
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 21:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756122AbaGNTan convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2014 15:30:43 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:47312 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754870AbaGNTam (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 15:30:42 -0400
Received: by mail-wi0-f181.google.com with SMTP id bs8so3092480wib.14
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 12:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=afNrwJTAAk+wwFhXsSy0hnBOxOiL+VxAKx3H0M0uxIQ=;
        b=krUscok69713b+g8uMyuUZsF9xs+qsu7tNMlSgu96mrUBXvtoMQM8Ha3UUQMmGkquN
         Z+zNsuMFdp1z/3ZspYKEmEQwWXCBxfdsl6FYZgIqLUHDXT693fqb4JNxIlBCI7/JlNfw
         sD8axUtXq7AJ8QQQspFtnj6sXnEB2P6qgMzQSppWkFHyXsu+38U9EzXCy4RSU9dHHx9z
         MJXCDDpkTl0r46E6mIul3zy/Z4SgFFfY/4XLJP4JZMk17/1MD+u8qYdPAAojrIxqgCcB
         z/+p0tCljn5FS1dt0yvgXWuqXXMOW/h1jjvOHH8EhCZ+qqzIB8xiiSMD9QsdlIDl+m9y
         JOrg==
X-Received: by 10.180.39.144 with SMTP id p16mr170897wik.4.1405366240968;
        Mon, 14 Jul 2014 12:30:40 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id wp6sm27406949wjb.9.2014.07.14.12.30.39
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Jul 2014 12:30:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140709200046.GB17454@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253510>

Am 09.07.2014 22:00, schrieb Eric Wong:
> Torsten B=C3=B6gershausen <tboegi@web.de> wrote:
>> (And why is it  "& 07777" and not  "& 0777")
>=20
> This is to preserve the uncommon sticky/sgid/suid bits.  Probably not
> needed, but better to keep as much intact as possible.
>=20
>> Can we avoid the fchmod()  all together ?
>=20
> For single-user systems, sure.
>=20
> For multi-user systems with git-imap-send users and passwords in
> $GIT_CONFIG, I suggest not.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

The Windows fchmod() problem is easily solved by using chmod() instead =
of
fchmod(). The file name is known in both cases (and even used in the er=
ror
message).

However, IMO there are more fundamental problems with your patch (not
related to Windows):

1.) Permissions of files in .git are controlled by the core.sharedRepos=
itory
setting, and your patch seems to break that (i.e. if someone accidental=
ly
has made .git/config world readable, git-config no longer fixes that, e=
ven
if core.sharedRepository=3D0600).

2.) Sensitive data such as passwords doesn't belong in config files in =
the
first place, that's what git-credentials is good for.
