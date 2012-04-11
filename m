From: Joe Angell <joe.d.angell@gmail.com>
Subject: git bug: moved file with local unstaged changes are lost during merge
Date: Wed, 11 Apr 2012 12:20:34 -0600
Message-ID: <CAAZnV3Einocd4TJ0iqcxPJNsr44j3RwhczS9OhyURX0faGWgBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 20:20:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI29p-00030k-0X
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 20:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760861Ab2DKSUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 14:20:36 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60165 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756911Ab2DKSUf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 14:20:35 -0400
Received: by yhmm54 with SMTP id m54so633850yhm.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 11:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=37rV8cpoaKUTeprIuHMQ6emwS0W3XcAyEkZtAnHOAqo=;
        b=UZ6UEFxF0ksTPU5zLTlixExRJU2jD0rerhi702VL+t/cAoDqph1cNmsMkmy6mug3Ct
         zTjZ0RwQBEH/05oE2z9B39KWX9NNyWFrqXMpSEtf1dekBUxZKGtZEsEAGESLSTZDHB8k
         P+K0aSj52z8naXmfCkrE6WlUn5DELjWpZMgXSUq2xY5n5QOmwNWl9PglVDwY15R+bxvf
         O+l3m0veR5OPRij+xH55Tni1GrMDLCOAE66tVXoRakCv6dlMKIV7Gkad1u+/ScQd+rQD
         3NH8d4vvdRDsxhFeqOwr279lQO8abZqXkM+o0v2sHUtGLZ2cUKooyJg+jJpDOAKNaVkm
         nbBQ==
Received: by 10.50.40.166 with SMTP id y6mr6656585igk.69.1334168434647; Wed,
 11 Apr 2012 11:20:34 -0700 (PDT)
Received: by 10.231.132.196 with HTTP; Wed, 11 Apr 2012 11:20:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195229>

What steps will reproduce the problem?
git init
echo "initial checkin" >> readme
git add readme
git commit -m "inital checkin"
git branch b1
git checkout b1
echo "b1" >> readme
git add readme
git commit -m "b1 readme"
git checkout master
git mv readme readme_master
git ci -m "moved readme"
echo "master" >> readme_master
git merge b1

What is the expected output? What do you see instead?
I expect to have git prevent the merge due to local changes to the
file.  Instead it overwrites the file (erasing the local modification
"master") and you end up with:
cat readme_master
initial readme
b1

What version of the product are you using? On what operating system?
Reproduced on 1.7.9.6 and from the git-core repo 1.7.10.128.g7945c.
This is on ubuntu 10.04.

Please provide any additional information below.

This problem only seems to occur after you check in the move, then
make local modifications, then do the merge.

-- 
---------------
Joe Angell
cell: (720) 260-2190
