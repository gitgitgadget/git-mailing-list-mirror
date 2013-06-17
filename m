From: =?iso-8859-1?Q?Stefan_Sch=FC=DFler?= <mail@stefanschuessler.de>
Subject: Git pull silently removing files in the index
Date: Mon, 17 Jun 2013 12:14:00 +0200
Message-ID: <D08911E9-6589-4A1F-9B1C-9D3F66438753@stefanschuessler.de>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 17 12:14:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoWRw-0000K5-AD
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 12:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385Ab3FQKOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 06:14:08 -0400
Received: from mail-bk0-f45.google.com ([209.85.214.45]:61928 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932277Ab3FQKOG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Jun 2013 06:14:06 -0400
Received: by mail-bk0-f45.google.com with SMTP id je9so1087549bkc.18
        for <git@vger.kernel.org>; Mon, 17 Jun 2013 03:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:content-type:content-transfer-encoding:subject
         :message-id:date:to:mime-version:x-mailer;
        bh=LCbubr9YBT1ZFWerHtsVEYOxWpGdrVtBc7npe459ToI=;
        b=dfTxuydlKXfO9asQj0AhKENwnlZAQ7HEPZZxe78bHgS8rdyuX8zJh3VwWfeqIJl7HE
         3w/2qUlvelcm8XqYy/MjPwD1KSrOv+hWweW3ZpKTgYka521ijOYnkuJlKSAUZLM2xTr7
         A9pu8IgH9gzZHcV9uOnlt+yJIGdPvdvQzEhZLhYaIoUC3T3PawXGRFEUrJan4PtKu6dF
         VzfFU8E0itm4FP1MRlKZuFKZkRjlKVJGLKheWUEgJyFc6SDgLNAs/kkf2r9iONh7xw59
         98iwf2exOkIbeT1WQsA/mtsmQhbx1m0VPAYwxhwjxBWkYVCLmNYl1Zv8m8/vptKkdjpF
         /s6g==
X-Received: by 10.205.9.129 with SMTP id ow1mr1756008bkb.130.1371464044941;
        Mon, 17 Jun 2013 03:14:04 -0700 (PDT)
Received: from [192.168.2.106] (p5790DD9E.dip0.t-ipconnect.de. [87.144.221.158])
        by mx.google.com with ESMTPSA id oy6sm3738770bkb.14.2013.06.17.03.14.04
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 17 Jun 2013 03:14:04 -0700 (PDT)
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228060>

I think there's a bug in git pull. Doing a git pull in a fresh repository without any commits removes files in the index.

Example:

  $ mkdir foo 
  $ cd foo
  $ git init
  $ touch file1 file2
  $ git add file1
  $ ls
  file1 file2
  $ git pull https://github.com/sos4nt/empty.git master
  $ ls
  file2

"file2" is still there, but "file1" was silently removed and no error message was shown.

I'm running git 1.8.3.1

Cheers, Stefan