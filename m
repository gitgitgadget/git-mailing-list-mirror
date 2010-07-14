From: Alexander Gladysh <agladysh@gmail.com>
Subject: git rebase does not understand --work-tree
Date: Wed, 14 Jul 2010 13:04:46 +0400
Message-ID: <AANLkTimnk6tflv9ZZCydlX1la35GjsRfvjgTk44uDFbO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 14 11:04:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYxte-0006bn-9D
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 11:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503Ab0GNJEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 05:04:48 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37300 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738Ab0GNJEs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 05:04:48 -0400
Received: by wyb42 with SMTP id 42so781192wyb.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 02:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=H2E7QwotuBlLomuVxTiPMY/BeXQVObH/EXn9DEmbPko=;
        b=mztl3ielsVa1y8H4o5zioJl1USsox6qFi/EQFjrWknOgNbEcp9XmxArzbYgoUnIg+d
         HV61RzCDpyDQOrABwguw0HIABpNMGv9J5Fvwh6WnNexL8w8vYZQXhqdNTc+Sueu1FyWm
         q5qvEwhZ07DNwR4dEOr6YjxFYgYwG3zdNbgjk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=HWJhirGseBV/XtpBNRxFWEai/Cs5pvnb2r2yCOoom9NdftHM/a8Mz8dCmoBrP1J1KK
         09bxYMFhIzmJ9BNiXbv6wr9L9qJhhoVBWLYoFbaw/4sJ2n9YRYF/GHbHItjyiE3v0jst
         CHobOGMvX+hLG+pxW++A/Qt3HQsUGiX42h+Kk=
Received: by 10.216.178.199 with SMTP id f49mr11522040wem.110.1279098286683; 
	Wed, 14 Jul 2010 02:04:46 -0700 (PDT)
Received: by 10.216.165.6 with HTTP; Wed, 14 Jul 2010 02:04:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150973>

Hi, list!

$ git --version
git version 1.7.1.1

I often use --work-tree and --git-dir to avoid doing cd in my scripts.

However, I've found that git rebase does not understand --work-tree
option (see test below). Is this fixable?

Thanks,
Alexander.

mkdir tmp
cd tmp
git init
echo "test">file.txt
git add .
git commit -m "initial commit"

git checkout -b other-branch
echo "test2">otherfile.txt
git add .
git commit -m "second commit"

cd ..
git --git-dir=tmp/.git --work-tree=tmp rebase other-branch

fatal: /usr/local/libexec/git-core/git-rebase cannot be used without a
working tree.
