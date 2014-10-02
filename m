From: Christian Halstrick <christian.halstrick@gmail.com>
Subject: Can I fetch an arbitrary commit by sha1?
Date: Thu, 2 Oct 2014 15:57:45 +0200
Message-ID: <CAENte7htO13s91UJFNzW4aBhsGxE=LpnvaZfce+vqQU5+a-cYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 02 15:58:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZgtZ-00031L-N0
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 15:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbaJBN6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2014 09:58:08 -0400
Received: from mail-qc0-f177.google.com ([209.85.216.177]:45141 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbaJBN6H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2014 09:58:07 -0400
Received: by mail-qc0-f177.google.com with SMTP id c9so2121801qcz.22
        for <git@vger.kernel.org>; Thu, 02 Oct 2014 06:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=8V45AHGpCUQqAzx85+S6hBe9qpJO7n/xzz3igOa/Yw8=;
        b=yGYL2KoPeaL/hGmbHB24I2UunHs0knxcVTHUOd/hiScbaYNL1CTiKhSEXGUDlueP7z
         BazKk+vCVGohJ+kWT3daOOtl0zhqz/BhHuMKe8AY1jnEUsvtJrULH8QSgy1jrvQGlp+X
         rd/fTtMK+0xBA+1Cl1V6qZbc/xiCs+FiPn3LYcgIjOoKfqfbg1hu7eXvBwILgRYVmILL
         8zdV+whemN5nRWADl73McRsYgX/TiFnrHFSScQaAeeaVTUH77Q7nVIPbIXWQS0CQCMD/
         Q5+2TfQ5qaoY9/xFI04mKKkTRg1mUp7FaZWFiPUUyeUX81k0kEr9d4H9uuNF+Qyi024A
         qfKg==
X-Received: by 10.140.93.230 with SMTP id d93mr103067625qge.53.1412258285741;
 Thu, 02 Oct 2014 06:58:05 -0700 (PDT)
Received: by 10.96.61.5 with HTTP; Thu, 2 Oct 2014 06:57:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257807>

I always though during fetch I have to specify a refspec and that a
sha1 would not be accepted as a ref. Firing some like 'git fetch
origin <sha1>' should be forbidden. But in fact I see that such a
fetch command succeeds if you already have that object in your local
repo.

My question: is it allowed to fetch sha1's? Shouldn't fetch fail if you try it?

See here:

> git clone -q https://github.com/chalstrick/dondalfi.git
> cd dondalfi
> git ls-remote
From https://github.com/chalstrick/dondalfi.git
ce08dcc41104383f3cca2b95bd41e9054a957f5b HEAD
af00f4c39bcc8dc29ed8f59a47066d5993c279e4 refs/foo/b1
...
> git show af00f4c39bcc8dc29ed8f59a47066d5993c279e4
fatal: bad object af00f4c39bcc8dc29ed8f59a47066d5993c279e4
> git fetch origin af00f4c39bcc8dc29ed8f59a47066d5993c279e4
error: no such remote ref af00f4c39bcc8dc29ed8f59a47066d5993c279e4
> git fetch origin refs/foo/b1
remote: Counting objects: 3, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
From https://github.com/chalstrick/dondalfi
 * branch            refs/foo/b1 -> FETCH_HEAD
> git fetch origin af00f4c39bcc8dc29ed8f59a47066d5993c279e4
From https://github.com/chalstrick/dondalfi
 * branch            af00f4c39bcc8dc29ed8f59a47066d5993c279e4 -> FETCH_HEAD

Ciao
  Chris
