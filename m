From: Adam Mercer <ramercer@gmail.com>
Subject: Determining if a file exists in a bare repo
Date: Tue, 4 May 2010 11:11:57 -0500
Message-ID: <w2q799406d61005040911p8fd7c234s5e6382298129985f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 04 18:12:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9KjT-00005U-BJ
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 18:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282Ab0EDQMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 12:12:21 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:64334 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932155Ab0EDQMT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 12:12:19 -0400
Received: by yxe1 with SMTP id 1so1028963yxe.33
        for <git@vger.kernel.org>; Tue, 04 May 2010 09:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=U0Ay9DEuTv88kBWi0++oKQ9tg1Kz/eA/RtD0eBQTIto=;
        b=pH7XZr44Om2bEMaOgC2VkwyD0SbuSAqIxArVAfoFkfBb5gqdvZeIcHK6ceciUgxeL6
         aj0M7/GgGLNviPpw8fxM9UPvQP5x2bwzngagKTJn+UaM9cyYbiZxBDjtrEWfZOc6nYLU
         Yxmycct+Sh9sQElxx4x7QleyDIQBdex+F8SPM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=n7zri9b9kYWdHja4zn1pfdCzeISXiABnQ+NQZMvswRug8UcbGvG7jXHu5tlq7ctshA
         4litE3+sg/tsiZCL/mmniVcZIQLhDWkqKd/fEmMFlP1OjkO+2kL2I7r3lGA1r6F5dLG/
         qH4vNoCuhdnNexJnn9eMykwDLo3CxzanYpT2E=
Received: by 10.91.161.11 with SMTP id n11mr2814961ago.51.1272989538155; Tue, 
	04 May 2010 09:12:18 -0700 (PDT)
Received: by 10.90.97.8 with HTTP; Tue, 4 May 2010 09:11:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146320>

Hi

I'm trying to write a post-receive hook that generates some HTML files
from reStructured text files stored in a repository. Essentially I'm
doing this with

git show master:INSTALL | rst2html --no-raw --no-file-insertion >
/path/to/INSTALL.html

However I would like this script to fail gracefully if the INSTALL
file is not available in the repository so would like to check if this
file exists. The problem I'm having is that git-show seems to return a
zero return code even if the file you request doesn't exist, e.g.:

$ git show master:NoneExistantFile
fatal: ambiguous argument 'master:NoneExistantFile': unknown revision
or path not in the working tree.
Use '--' to separate paths from revisions
$ echo $?
0
$

is there another, scriptable, way to determine if a given file exists
in a given branch of a bare repository?

Cheers

Adam
