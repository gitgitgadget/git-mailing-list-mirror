From: "Anatol Pomozov" <anatol.pomozov@gmail.com>
Subject: Commit templates are not readable after 'make install'
Date: Tue, 9 Sep 2008 08:41:38 -0700
Message-ID: <3665a1a00809090841l5d34f57ax8ad99d99a28bd494@mail.gmail.com>
References: <3665a1a00809090835g2a8ea4aas6cfa2ebc922f12b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 09 17:43:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd5Mp-0004He-UB
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 17:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754418AbYIIPll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 11:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754427AbYIIPll
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 11:41:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:19737 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754342AbYIIPlk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 11:41:40 -0400
Received: by nf-out-0910.google.com with SMTP id d3so683271nfc.21
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 08:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=n8It25v08Bu2yaOhUVUuyj9R2Z2xMbLFOwiWIa+Fve0=;
        b=Nqqn0brN5bYY3aIzKzIkgXEdy6XJB+My/65+y/lRYGhwQMMIoMejxrpnWh6u1OS5EW
         RRv5II3pYhSPmuLtKctoBeblBsPNs/oTmxJu6481pAGVkZ0AF+okAN0bjvmTHIGxzJCU
         IJ4gyKvEcHDpqzioxJtvt8IyK/UjHS2brFqxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Q2tYiApFDWpbnobm/sZ5o6nPoadYQQAaqtaQ8v5C9BJtAIVw0+2Qt4Ar5JrB4zxgQ0
         zogJHhpQu962Ejgacs78roulT7B4C4x7fvM+t5VJQS6XR3fxe1DREwvEkoOO2OBOZLco
         47raoLmzbSiJLwE4VGRqg50gwl6uRiKfW7Oag=
Received: by 10.210.67.20 with SMTP id p20mr20772225eba.66.1220974898835;
        Tue, 09 Sep 2008 08:41:38 -0700 (PDT)
Received: by 10.210.130.11 with HTTP; Tue, 9 Sep 2008 08:41:38 -0700 (PDT)
In-Reply-To: <3665a1a00809090835g2a8ea4aas6cfa2ebc922f12b2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95400>

Hi,

I build git from sources and I have one small permissions issue that
(I think) should be fixed.

So I build it as described in INSTALL file
make prefix=/usr all
sudo make prefix=/usr install

Everything goes fine here and we have a new version of git installed
$ git --version
git version 1.6.0.1.285.g1070

But when I want to create a new repo, I have a fatal problem
$ git init
fatal: cannot copy /usr/share/git-core/templates/
hooks/applypatch-msg.sample to
/personal/sources/opensource/1/.git/hooks/applypatch-msg.sample


Because of the template files are readable only for root
$ ls -l /usr/share/git-core/templates/hooks/
total 44
-rwxr-x--- 1 root root  452 2008-08-29 11:04 applypatch-msg.sample
-rwxr-x--- 1 root root  894 2008-08-29 11:04 commit-msg.sample
-rwxr-x--- 1 root root  160 2008-08-29 11:04 post-commit.sample
-rwxr-x--- 1 root root  553 2008-08-29 11:04 post-receive.sample


I could fix the problem by running
$ sudo chmod a+r -R /usr/share/git-core/templates


But I think it should do 'make' when it installs git-core, isnt it?

--
anatol
