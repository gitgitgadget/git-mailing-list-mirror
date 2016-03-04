From: Alexander Rinass <alex@fournova.com>
Subject: git diff does not precompose unicode file paths (OS X)
Date: Fri, 4 Mar 2016 10:07:48 +0100
Message-ID: <0008C25D-C3F0-4A1F-8B50-4EF1E84CA04F@fournova.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 04 10:07:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abli4-0007Tg-0j
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 10:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759148AbcCDJHk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Mar 2016 04:07:40 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35882 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758812AbcCDJHd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2016 04:07:33 -0500
Received: by mail-wm0-f48.google.com with SMTP id n186so25131833wmn.1
        for <git@vger.kernel.org>; Fri, 04 Mar 2016 01:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fournova-com.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=3nbjSWHJlO4ebeDSRk8D3gtUsC80HeG3WloMGpGAA6g=;
        b=Kz6KnKkiQ5R+A1sdH8vE7Abv9bGuw8OemGTa6bhlN6J7822hhD4zSX13pbJdOoZvvp
         RgmJh5LGSqWwhiR+zgK6eMmB+fdYbQHCyaHaW48ff6V2IhWfBoWjxVh27/TV4OahnTaK
         cAPtgO5KNw/zXm/IRvZRUVy4SynWNjncaoQaDEJfGTuXOxpfOas58hkXFmIu1LXU3FQt
         fjzJqmR3s+wIz8amKqfxKVjXZREvJyznU1yR/+jp9vEWkbwp3dJ+/PZk4pk9uE/TDN8h
         DWTazM4jc7miWulmFcHlnQzSAJyl2LY+ee0Q7LM950fcEyO7uzM0Krj0293+QHw9a28E
         Nxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=3nbjSWHJlO4ebeDSRk8D3gtUsC80HeG3WloMGpGAA6g=;
        b=fB80lFd3TX85m6DSo5MfnOIqEpVtlUj93fwoBjTd+xjQredD1pthLqSUA6vjIDUitS
         Zf1UurGXg0BrSe6D0068eXYjlBrZESYSRhlQ4B0zQ1HlYLenAacX/uc7t8UkdRjRDNPO
         JZHOvlYXwSk0NPx0aHjcIZoVgQQZDyju2OLRgIrg/hBnWupBaoM17LLXq81B/bTuZzrd
         wLjoFJ0IclUucWjNsTSnFgXnYCt2fkEAiYYvNUhIh1PEdMz7/5NnEbciwT0OxmXgwHV8
         L3mCtdVWBAlLm53w7lCJKLKabx4DONwHLBU5BILccEf+qRCvLCb/xnWLIpjHTeOPZHpq
         G8SA==
X-Gm-Message-State: AD7BkJLpy5jxJEzdBxWOyC5LvuT6EpPs5onD3/D+6Jei7bA5pqh3EguLpkJJjLUtWfNAlA==
X-Received: by 10.194.92.174 with SMTP id cn14mr8923450wjb.66.1457082452098;
        Fri, 04 Mar 2016 01:07:32 -0800 (PST)
Received: from ?IPv6:2a02:908:df42:8b00:54b8:eea0:3e61:8f6b? ([2a02:908:df42:8b00:54b8:eea0:3e61:8f6b])
        by smtp.gmail.com with ESMTPSA id 192sm2363630wmw.0.2016.03.04.01.07.31
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Mar 2016 01:07:31 -0800 (PST)
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288240>

Hallo,

It appears that the git diff command does not precompose file path argu=
ments, even if the option core.precomposeunicode is set to true (which =
is the default on OS X).

Passing the decomposed form of a file path to the git diff command will=
 yield no diff for a modified file.

In my case, the decomposed form of the file path is sent by the OS X Co=
coa framework's NSTask, wich I am using in an application. It can be si=
mulated on OS X by using $(iconv -f utf-8 -t utf-8-mac <<< FILE_PATH) a=
s file path argument on the shell.

Git commands like add, log, ls-tree, ls-files, mv, ... accept both file=
 path forms, git diff does not.=20

It can be tested with the following setup on OS X (as iconv's utf-8-mac=
 encoding is only available on OS X):

    git init .
    git config core.quotepath true
    git config core.precomposeunicode true # (default on OS X)
    touch .gitignore && git add .gitignore && git commit -m "Initial co=
mmit"
   =20
    echo "." >> =C3=84
    git add =C3=84
    git commit -m "Create commit with unicode file path"
   =20
    echo "." >> =C3=84
   =20
This gives the following status, showing the precomposed form of "=C3=84=
":

    git status --short
     M "\303\204"
   =20
Running git add with both forms does work as expected:

    git add =C3=84
    git status --short
    M  "\303\204"
   =20
    git reset HEAD -- =C3=84
   =20
    git add $(iconv -f utf-8 -t utf-8-mac <<< =C3=84)
    git status --short
    M  "\303\204"
   =20
    git reset HEAD -- =C3=84
   =20
However, running git diff only works with the precomposed form:

    git status --short
     M "\303\204"
   =20
    git --no-pager diff -- =C3=84
    [...shows diff...]
   =20
    git --no-pager diff -- $(iconv -f utf-8 -t utf-8-mac <<< =C3=84)
    [...shows NO diff...]

I took a look at the Git source code, and the builtin/diff*.c do not co=
ntain the parse_options call (which does the precompose_argv call) that=
 the other builtins use.

But I am not really familiar with either C or the Git project structure=
, so this may not mean anything.=20

Best regards,
Alexander Rinass
