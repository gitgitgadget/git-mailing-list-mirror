From: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Subject: warning: unable to rmdir my/module: Directory not empty
Date: Thu, 4 Nov 2010 10:55:59 +0100
Message-ID: <AANLkTi=UpQTzfC39rqW48mqoL0J4Sj6=vA1cJtpfBABV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 10:56:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDwYW-0000xq-CU
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 10:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091Ab0KDJ4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 05:56:23 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53159 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270Ab0KDJ4V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 05:56:21 -0400
Received: by bwz11 with SMTP id 11so1472840bwz.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 02:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=5CqndM4kcIl129Uo9AOHQLoKj0StQceXqqtObZV7YXs=;
        b=oEncJXR8L1NB92kAz8eB1rUb0rwTiuUGZFZ/OE2sgCisjkaaI4RAnYjRBoaBmL/Cqy
         2A3Q9HXE8VVUgsjcVK98n+TkJR8l2HeLIMqjLnOzKH9v5GHjw7Hc+LDc011YzMlwlNsr
         HKI3IHLPebVT4uXsXnTA7C1x8BQw+TSVfE9UA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=uvPSTpkEdX97ejmjhFJOFwXugjeNfCIY4TsUwrWJOk2RpfGb74UUqsZZgig3BS8Nry
         5d5lgv26FGp0f63QZJJ09Q1f9WiqouMOAZYV152CEjK75HQAG/Pq2YA7hEBwP0INhm7n
         DQoW+zuRdC7ho2dCkWC1pS+EWslz1u5AgoOg4=
Received: by 10.204.120.74 with SMTP id c10mr430100bkr.116.1288864580286; Thu,
 04 Nov 2010 02:56:20 -0700 (PDT)
Received: by 10.204.54.82 with HTTP; Thu, 4 Nov 2010 02:55:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160709>

Hi all,

  Does anyone knows where is this warning is coming from:

warning: unable to rmdir my/module: Directory not empty

  I have a git master, an empty branch and a submodule on master.
Switching from master to my 'empty' branch always trigger this
warning. Here are some steps to reproduce the issue (*). I am using a
debian stable system + backports and version is:

$ git --version
git version 1.7.1

Thanks
-Mathieu

(*)
# master
cd /tmp
mkdir test
cd test
git init
touch README
git add README
git commit -mREADME

# submodule
cd ..
mkdir module
cd module
git init
touch MODULE
git add MODULE
git commit -mMODULE

cd ../test
git submodule add file:///tmp/module my/module
git commit -a -m"adding submodule"

# create an empty branch
git symbolic-ref HEAD refs/heads/newbranch
rm .git/index
git clean -fdx
touch EMPTY
git add EMPTY
git commit -a -mEMPTY

# update
git checkout master
git submodule init
git submodule update
git checkout newbranch
