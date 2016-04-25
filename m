From: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Subject: How to have EOL=LF and keep binary files auto-detection?
Date: Mon, 25 Apr 2016 17:11:51 +0300
Message-ID: <3670335C-4938-4DCD-9B1D-6B4737CBE6C2@jetbrains.com>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?0J3QuNC60L7Qu9Cw0Lkg0KfQsNGI0L3QuNC60L7Qsg==?= 
	<Nikolay.Chashnikov@jetbrains.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 16:12:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auhF8-0006hn-6H
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 16:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754719AbcDYOL4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 10:11:56 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:33972 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbcDYOLy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2016 10:11:54 -0400
Received: by mail-lb0-f182.google.com with SMTP id b1so68380270lbi.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 07:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetbrains.com; s=googleapps;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=w5alRBSkhWSb4tDYezrzdWCKQS13/+g60tcXZTYmPKs=;
        b=VetyrtUyGyngStmj9lYbdk9kqpra56pA0K5CvXHP5eoTbZfgOudp7FdPftK9WJAW51
         4Ry7zciqyA7edVf9lCMoujVSdxZBf7YXa4ZzOmPiP5XpYQ67KVOIWzoxpiir1Bfg6TMu
         CiQK5a8J6F9AKoH41nh9aHw8uoI3LdMeE1fP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=w5alRBSkhWSb4tDYezrzdWCKQS13/+g60tcXZTYmPKs=;
        b=PP5LLn1rlkVI7pTilCS8VIS/5K/iW4v5wPlkZPV8oJrwaIwrc+KhbEYKMqIT4MZqYr
         OaQEfNEk2ylJqizlaqnejb4ZM4lZiEmHHY8cpehZnTukJXzWvh9jTVcbP9xVGAAO2ahh
         n3pNZbicT5UnKTASTU7kjUPh2mEfP+WZGlbUikNt8CFf/cFUj+GnyLQExHNvLNOr1XZ/
         6lWRfcelRWpsTF0FOCkA8Eh7m0ZmtuuHPiBaAc7oAE2W3LHMALD/2XcbI+kN0J7bdLbX
         3GsoCT6m46bLkgpHvuLPN00luHEHEFGCBlljelClQdLSq/pYBFCAFT9TvzMjSf7LclV+
         l14g==
X-Gm-Message-State: AOPr4FUwVVtMw6bJMnl3Vq4NSFa1+J9nVDoLiNLYeTgWZNJtDbVVKoN+aedbukDQwNCWk4zG
X-Received: by 10.112.43.140 with SMTP id w12mr13967107lbl.51.1461593513048;
        Mon, 25 Apr 2016 07:11:53 -0700 (PDT)
Received: from loki.times.labs.intellij.net ([195.144.231.194])
        by smtp.gmail.com with ESMTPSA id wt10sm4308214lbb.25.2016.04.25.07.11.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Apr 2016 07:11:52 -0700 (PDT)
X-Google-Original-From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
X-Mailer: Apple Mail (2.3096.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292480>

Hi,=20

I wonder if it is possible both to have LFs in all and only text files =
in working trees, and keep Git=E2=80=99s binary files auto-detection?

To be more precise:
* we want all text files to be checked out in LF;=20
* we don=E2=80=99t want force people to set =E2=80=9Ccore.autocrlf=E2=80=
=9D to false, preferring to keep this configuration in .gitattributes;=20
* we obviously don=E2=80=99t want binary files to be touched by eol-nor=
malization;=20
* we also don=E2=80=99t want to declare all possible patterns of binary=
 files - Git is good enough in detecting them automatically.

However, I=E2=80=99ve found no way to do so.

If I declare `* eol=3Dlf` in .gitattributes, it makes Git treat all fil=
es as text and thus convert CRLF to LF even in binary files. It is cons=
istent with man, but a bit surprising to have e.g. a zip or png file mo=
dified in this way.

One could expect `* text=3Dauto eol=3Dlf` to work the way we want, but =
unfortunately it doesn=E2=80=99t work either: =E2=80=9Ceol=3Dlf=E2=80=9D=
 forces =E2=80=9Ctext=E2=80=9D on all files.

Thanks a lot for your help!
-- Kirill.
