From: Sedat Kapanoglu <sedat@eksiteknoloji.com>
Subject: git clone doesn't work in symlink dir roots on Windows
Date: Sat, 10 Aug 2013 15:10:49 +0300
Message-ID: <CABJxLaM9t1HeEVkAiXpOmaOH_V6681w9Q9ZQt37+MpmhX7yN2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 10 14:11:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V880r-00007M-BN
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 14:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758429Ab3HJMKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 08:10:53 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:42321 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758248Ab3HJMKw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 08:10:52 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd6so7396617obb.33
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 05:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:dkim-signature:mime-version:date:message-id
         :subject:from:to:content-type;
        bh=XXujc7Wgl6NpNN2rFlxcmpPxGsV0H2zYMlhLOrEsytE=;
        b=nZvmRveTdOHhbzGEtVZY6rzq6Tass1+wdbOzHL4saODKLgHxf2KlfF61bkoYlcO7nO
         D1FPGkw/AGTn5nn3KZAc3qkN7pZpe0xf2TTpPQXkF5e7PhUWZoRfGJlRY1dxO/XD2V7w
         P3NVjlTOlQO9yizCLP9yFrB2ln7qL5He8YTxzASIwNop7TTjWsAVGwfnTmXRqz8+sxZd
         VReLF1rZE8DBPkomtY/ocFin+l2TWMv4rQq4eJoLWUFXy+DcNz+VmKzbE2MInQYW5IRG
         FADu39QtU1Tqcvc8O+U5JQcUuls4hcuBZZXYYduiCl3UGepDe9QNK6roU/c783RxpB66
         kjuw==
X-Gm-Message-State: ALoCoQljniKdAZ5ETlQPSapjedDpoKTvl9KSY57czYaDd2jEu22ErriqGiZaDsaqSFPc56lJwBIK
X-Received: by 10.60.70.134 with SMTP id m6mr11892798oeu.14.1376136651787;
        Sat, 10 Aug 2013 05:10:51 -0700 (PDT)
Received: from mail-oa0-x22d.google.com (mail-oa0-x22d.google.com [2607:f8b0:4003:c02::22d])
        by mx.google.com with ESMTPSA id cp7sm23682296obb.0.2013.08.10.05.10.50
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 10 Aug 2013 05:10:51 -0700 (PDT)
Received: by mail-oa0-f45.google.com with SMTP id m1so7986412oag.18
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 05:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eksiteknoloji.com; s=google;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=XXujc7Wgl6NpNN2rFlxcmpPxGsV0H2zYMlhLOrEsytE=;
        b=UhgPBs0YBAmcNUURy6xyHozHsPMHQ0owqz5nhwrLEoSxhDxazlnELkRPVg0ciqlRKy
         AymoBivgzceoL/uJr3yyM3YWWDCtI1DSLU6ogyS9W9+K5dqJh6playEh4iWUc3ibW47R
         SHetucFqJfxD4dvXSPCnwoM97clZfNqea1530=
X-Received: by 10.60.132.113 with SMTP id ot17mr4018562oeb.104.1376136650010;
 Sat, 10 Aug 2013 05:10:50 -0700 (PDT)
Received: by 10.182.81.3 with HTTP; Sat, 10 Aug 2013 05:10:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232093>

Hi,

I verified this behavior on Git 1.7.8 and 1.8.3.

My D:\src folder is a symlink to another folder in my Google Drive, created
by Windows command mklink /d d:\src "d:\Google Drive\src"

D:\src>git clone https://github.com/jlewallen/jenkins-hipchat-plugin.git
Cloning into 'jenkins-hipchat-plugin'...
fatal: Invalid symlink 'D:/src': Function not implemented

The same error is shown with the bash prompt too:

$ git clone https://github.com/jlewallen/jenkins-hipchat-plugin.git
Cloning into 'jenkins-hipchat-plugin'...
fatal: Invalid symlink 'd:/src': Function not implemented

If I go one directory below (D:\src\somethingelse) the command works fine
but not at the root of the symlink directory.

Thanks,

Sedat
