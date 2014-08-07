From: Alan Grover <alan.grover@gmail.com>
Subject: glob escaping doesn't work with git mv
Date: Wed, 6 Aug 2014 19:52:10 -0600
Message-ID: <CA+cJFMm_vJwk=D0dkhEvfXwWk1S74hONb_g7O9W0iMZD3yAdLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 03:52:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFCsL-0005de-2R
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 03:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755032AbaHGBwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 21:52:12 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:57450 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022AbaHGBwL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 21:52:11 -0400
Received: by mail-qg0-f53.google.com with SMTP id q107so3757392qgd.12
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 18:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=FWkwNV8h0hfTljQ2zZs/FwF0V5vjunRZeLy6SOognyo=;
        b=Hcw6LrCUwn1KqgyHRMh0CzkEikpdS0dFxE4I5jBlsunBwRREKK8Lc4F0dxZM8lLI2f
         dWfqmWfpm3sera0LXPoGbsAnDeYiGFx4xn7tuhrcvbWn79WWfGbh/mnsjNMmLqaOVxs/
         bE/Pnc35cwWJuWcc81z51KrbsS0FfTTMLGr8tD6WdP04fkarTtECAAFNButcj8X6uHxM
         ad6P9cWpgJr6xajmZCR+NvRh5GBTtjucVFZqtGVZywKdkiVJEJ5RIqAiCf10/93EO1SR
         vb+88fuaGGvxQof2/xthTFHcEITFzVrZ6XJUm/mxwj3t8KqsvGc1XRTIoH+tm+1Bc0FO
         lQVQ==
X-Received: by 10.140.23.37 with SMTP id 34mr9532430qgo.2.1407376330540; Wed,
 06 Aug 2014 18:52:10 -0700 (PDT)
Received: by 10.140.41.213 with HTTP; Wed, 6 Aug 2014 18:52:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254943>

I tried using escaped globs with git mv, but globs don't seem to be
expanded with git mv.

So, for example, I've got files file1 & file2, and have been editing
them, so I've got file1~ and file2~ also, and *~ is in .gitignore.

If I do:

$ mkdir newdir
$ git mv file* newdir

I get a 'fatal: not in repository' error because I'm trying to move
untracked files.

Since we can do git add file\*, I tried:

$ git mv file\* newdir

I get a 'bad source, source=file* destination=file*' error. It seems
to be looking for a file named 'file*' rather than performing glob
expansion.

If I do:

$ rm *~
$ git mv file* newdir

Everything works as expected. It would be convenient if git mv
expanded escaped globs.

Thanks!
