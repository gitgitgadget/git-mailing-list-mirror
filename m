From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: No fchmod() under msygit - Was: Re: [PATCH 00/14] Add submodule
 test harness
Date: Mon, 14 Jul 2014 13:31:35 +0200
Message-ID: <CABPQNSY5x_JOsxyKn7xZ9nc5TJ0yHdNvam0htyX01U58bvV7vg@mail.gmail.com>
References: <539DD029.4030506@web.de> <53B41D42.2090805@web.de>
 <53B46425.3030000@web.de> <53B4F0AA.10809@web.de> <53B5C7AC.4040701@web.de>
 <xmqqsimddrq3.fsf@gitster.dls.corp.google.com> <53BAF7AF.4020901@web.de>
 <53BC47BD.1000705@web.de> <53BC53C3.1010304@ramsay1.demon.co.uk>
 <53BCE3A7.8070600@web.de> <20140709200046.GB17454@dcvr.yhbt.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jul 14 13:32:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6eUW-0006gr-Sw
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 13:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198AbaGNLcR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2014 07:32:17 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36656 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869AbaGNLcQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jul 2014 07:32:16 -0400
Received: by mail-ig0-f175.google.com with SMTP id uq10so1594190igb.8
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 04:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=pBXmF/5Dx+wBJgM9UTA1xQRZ+SrV/Xu62SoL0xrroaM=;
        b=BI9mlcc9i7vGvwEzWoZ/XnXK8KaSKv/9vYvJxENqo6Nk1gTywxRFQiyvDt5QDKNYGM
         pwmIBaMrt+Nk7bebZwdW5Y4Rb318u7fdSaUywzlrM+os6J/ToLmemkZdktB409kOXsdW
         /O/RLlbVtgzEZnXpAV1r0WVoT62/XTQW2agnXdSZKNHtvh7vmGGkBp3JBsxutk9mEhkh
         iQ0K7g3fDyRllIB5HWaGsijb/DGAafKBoEahLqpyjvLWC8QLFNP3tiANtSNI5gCSeGCH
         bknofKErSNZKIGpLjZbDBLKwDqs0dJwx7OU3g+HSHBfwLuEJxnZ7yYbLL8RdoARJZVNv
         IZeA==
X-Received: by 10.42.162.71 with SMTP id w7mr20831396icx.50.1405337535686;
 Mon, 14 Jul 2014 04:32:15 -0700 (PDT)
Received: by 10.64.246.129 with HTTP; Mon, 14 Jul 2014 04:31:35 -0700 (PDT)
In-Reply-To: <20140709200046.GB17454@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253489>

On Wed, Jul 9, 2014 at 10:00 PM, Eric Wong <normalperson@yhbt.net> wrot=
e:
> Torsten B=C3=B6gershausen <tboegi@web.de> wrote:
>> (And why is it  "& 07777" and not  "& 0777")
>
> This is to preserve the uncommon sticky/sgid/suid bits.  Probably not
> needed, but better to keep as much intact as possible.
>
>> Can we avoid the fchmod()  all together ?
>
> For single-user systems, sure.
>
> For multi-user systems with git-imap-send users and passwords in
> $GIT_CONFIG, I suggest not.

You're saying this as if Windows is a single-user system. It's not,
but it uses ACLs rather than POSIX permissions to manage file-system
permissions. So far we've opted to ignore ACLs in Git for Windows,
though.
