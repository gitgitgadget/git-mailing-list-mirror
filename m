From: =?UTF-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
Subject: Diff filename has trailing tab if filename contains space
Date: Sat, 5 Mar 2016 07:50:32 +0800
Message-ID: <CAHtLG6TLAOA0hg897EntOjG1kJsZEmjDshc-yyO9zP27540AAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 05 00:50:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abzUU-0002At-Vl
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 00:50:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760576AbcCDXue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 18:50:34 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:33985 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760368AbcCDXud (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 18:50:33 -0500
Received: by mail-vk0-f44.google.com with SMTP id e185so69957292vkb.1
        for <git@vger.kernel.org>; Fri, 04 Mar 2016 15:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=aE378dfQY1Tfbj/kz4uLbEe+x/Mr84SupmVLgLpFdqE=;
        b=QW0RPpFgGVIft0aFiwL8D6hoLOK+uBTOydPLKF1qZJDRZMtfDqdFhXmDn2TzDJyNyN
         vZAQ8rWaeE4JKdABFIlN39N1wklI0TcOzLQxZW7kfuS84bkVrqCGDxz6QfGIBFCltOu6
         woT8j8BfrIfoZAvjRRDR1FwlK5xt7ALdXPVpkfJTIfdrWLB7Triv+8/slJLCuOY8RLNc
         FqNSerzMS2s0t3egj7kUFsPzl8Zh5aBPRJ5fZLAMFGwXG1efvI0NbwRffPV3WiR6pOc/
         0eG/8PQovlHG96owrxMz+9nLWmx49iaYrC213H8bgCljjlXXW9LAXwOdRXUxM8mj7vML
         ob9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=aE378dfQY1Tfbj/kz4uLbEe+x/Mr84SupmVLgLpFdqE=;
        b=CEvZ8tMGEvJ+gl3elee3qCvgUorOhZ7t1hxNANgry4ZL7MHKGFA8ARMre/D57zF4Zl
         q23qAIMCDHtUYtL+bLJwhGT6HcVlrXKqtHptiq3CsCfHFKXRh9pyFMWhWM3u1Focu75l
         vyLz26IEh5uhPxfiQaeUBlh7qG2kDvGQedUKNTFDoC4Ijr4TuZgIpL3QaLXGLM3X/Q61
         KgA9vxsYrq3rVcTYaTMirDVgtH2IuWKxgqqJAv2RXrDMJALYa6FB85xKxVjn0OBl0qBE
         kTqvXi7WaZllAjbYWdsbuAat/PP05+0KZ5QPVBfbfbE7Uh4NSbbHqGQxqwmOd7zNWwXf
         H65Q==
X-Gm-Message-State: AD7BkJI9p4wZtr0gypvlFTRqM9Qxfz4SxMNzVFM+mxSRnaAgyGTATkDuQ3tKaVwOcGyibmbUq2jeuc4ZspuaLA==
X-Received: by 10.31.194.2 with SMTP id s2mr8531089vkf.12.1457135432536; Fri,
 04 Mar 2016 15:50:32 -0800 (PST)
Received: by 10.159.33.67 with HTTP; Fri, 4 Mar 2016 15:50:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288281>

Hi,

Using git 2.7.1

Diff filename has trailing tab if filename contains space
Please run below shell script
and look at the output diff file 1.diff
There is trailing tab chars after these lines:
--- a/8 1/8.txt
+++ b/8 1/8.txt
---- b/9 86
+++ b/9 86



#!/bin/sh
set -e
git init

echo a >> "normal"
git add "normal"
echo y >> "9 86"
git add "9 86" # file name has space
mkdir x
echo d >> "x/normal"
git add "x/normal"
mkdir "8 1"
echo u >> "8 1/8.txt" # directory name has space
echo k >> "8 1/8.txt"
git add "8 1/8.txt"
git commit -m "Initial commit"

echo b >> "normal"
git add "normal"
echo c >> "9 86"
git add "9 86"
echo e >> "x/normal"
git add "x/normal"
echo h >> "8 1/8.txt"
git add "8 1/8.txt"
git commit -m "Edit files"
git diff master~1 > 1.diff
