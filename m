From: shawn wilson <ag4ve.us@gmail.com>
Subject: filter clean leaves uncommitted file
Date: Wed, 19 Feb 2014 23:46:25 -0500
Message-ID: <CAH_OBieMx3tv3Ld74cChEvFsG3NNb-cPmBLDjsAK_-OLVkC+5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 20 05:46:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGLX9-0005Km-5w
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 05:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439AbaBTEqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Feb 2014 23:46:47 -0500
Received: from mail-ve0-f178.google.com ([209.85.128.178]:62826 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230AbaBTEqq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Feb 2014 23:46:46 -0500
Received: by mail-ve0-f178.google.com with SMTP id oy12so1357484veb.23
        for <git@vger.kernel.org>; Wed, 19 Feb 2014 20:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=H6xEK0QDEYIEYkQ6mjbBjkrcpMRjn8+TRfg1vGNK33o=;
        b=S6+A549krJQR0cDsXrJIUf9ox3LM2u95zOgJCsMLbQxlaIe6nQytZPEjjgL/uJrMRE
         kxaKVK5lt/oqJwXteYhe1f3U/yxqKGo+k8HbMR0F9JkGOtOqjbW8leIz6YOemgiYn0cv
         PgyJcw5+NTuQxy8Sy9jlCkjywGI4itiUiJtkEONISxIkUivKI8YmHSR46DPrboer9t6H
         4brUImKOcltSJAmMIIODxP24kPQRu54S5AtLuus23escmQ0LFuiOrLIFv123CwxteXSO
         RkRNNG1Z1rJ2LpfAMP6ymiB2BvRZZ9nMKSMpIjJwmSHro1aylHLPSfhterRu8Vuaw2Kb
         V5Mg==
X-Received: by 10.221.29.196 with SMTP id rz4mr27754429vcb.8.1392871605949;
 Wed, 19 Feb 2014 20:46:45 -0800 (PST)
Received: by 10.52.170.209 with HTTP; Wed, 19 Feb 2014 20:46:25 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242426>

So, I want a way of sharing parts of a gitconfig organizationally, so
I change and comment out some parts with a filter:

[filter "gitconfig-rmuser"]
  clean = sed -e \"s/^\\( *email =\\).*/\\1 <email address>/\" -e
\"s/^\\( *name =\\).*/\\1 <real name>/\" -e \"s/^\\( *signingkey
=\\).*/\\1 <gpg key>/\"

And then:
$ cat .gitattributes
* filter=ident-line
gitconfig filter=gitconfig-rmuser

Which works. The only problem is that if I change it again after the
commit, I get:
$ git status
# HEAD detached at e872204
# Changes not staged for commit:
#       modified:   gitconfig
#
no changes added to commit
$ git diff gitconfig
$

So the repo remains dirty and I can't do anything with it.
