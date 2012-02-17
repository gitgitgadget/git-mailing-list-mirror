From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git repository clonning
Date: Fri, 17 Feb 2012 04:59:00 -0800 (PST)
Message-ID: <m38vk1sjj4.fsf@localhost.localdomain>
References: <4F3E384A.3040006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-2?q?Martin_P=F8ececht=ECl?= <precechtel@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 13:59:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyNPE-0003I2-Jc
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 13:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598Ab2BQM7D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Feb 2012 07:59:03 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:64015 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064Ab2BQM7C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Feb 2012 07:59:02 -0500
Received: by eekc14 with SMTP id c14so1336855eek.19
        for <git@vger.kernel.org>; Fri, 17 Feb 2012 04:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=YwrDoO/ZtSfO/FGOqxsUBkPs76JYwdYkHg9kcp/577U=;
        b=nxZ2+j/b6CkaVgsi2HvdPEeYNUPqBxsaONzaFlUHdoxbNFTpp33Li7OQiQfR0fATWo
         0/kQQjMezeJYMQ6cZkcWMgfK7aYiUNbgmMIsatpMkfjVzC9gLhJ0Wu8ImiCIZRzNMyxb
         wVsVpgGVIVutgu9BlAkjkRWE/0g2qqIv9gbzg=
Received: by 10.213.10.196 with SMTP id q4mr1091151ebq.82.1329483540896;
        Fri, 17 Feb 2012 04:59:00 -0800 (PST)
Received: from localhost.localdomain (abwb118.neoplus.adsl.tpnet.pl. [83.8.225.118])
        by mx.google.com with ESMTPS id o49sm38261864eeb.7.2012.02.17.04.58.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 17 Feb 2012 04:59:00 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q1HCxCE7025668;
	Fri, 17 Feb 2012 13:59:13 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q1HCxCKG025665;
	Fri, 17 Feb 2012 13:59:12 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4F3E384A.3040006@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190954>

Martin P=F8ececht=ECl <precechtel@gmail.com> writes:

> I have a problem and I would like to ask you for help. I need to
> somehow access the git repository over network and read files from
> it. In the concrete, only thing I need is to read some files from
> repository, where I have files needed for installation of
> computers. So on  computer where installation takes place, I need to
> read from this repository some files needed for installation
> process.

Where this repository is?  Is it on computer you control?  If yes, why
not use some networking filesystem or just rsync checked out files?

> I tried command git clone <my_repository> but this command
> download the whole repository which size is now almost 8GB files + 4G=
B
> .git folder. This process is very slow. So I want to ask you if there
> is a way how to access my repository (read some files from it) but to
> significantly improve speed. Is there for example something what will
> somehow map the repository to folder and then dowload only thouse
> files which are accessed?

You can try to use shallow clone, which would download only tip of
history... but all the files:

  $ git clone --depth=3D0 <URL>

If remote repository is configured correctly, and all the files are
inside one directory, you can try to use remote archive:

  $ git archive --remote=3D<URL> --prefix=3D<dir>/ --output=3D<dir>.tar=
 \
    HEAD:<dir>

It wouldprobably not work.

If there is some web interface, like gitweb or GitHub, you can
download snapshots of some subdirectory from there.

HTH
--=20
Jakub Nar=EAbski
