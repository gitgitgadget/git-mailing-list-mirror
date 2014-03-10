From: Robin Pedersen <robinp@snap.tv>
Subject: Accidentially deleted directory, bug in git clean -d?
Date: Mon, 10 Mar 2014 11:31:37 +0100
Message-ID: <CABN9-fcpyDogh45WPwuS1qgkE1jLuOAtejuW=fGCKNNyNm3DEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 11:38:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMxbP-0001ge-6k
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 11:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbaCJKi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 06:38:28 -0400
Received: from exprod7og105.obsmtp.com ([64.18.2.163]:57055 "HELO
	exprod7og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752651AbaCJKiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 06:38:25 -0400
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Mar 2014 06:38:25 EDT
Received: from mail-vc0-f174.google.com ([209.85.220.174]) (using TLSv1) by exprod7ob105.postini.com ([64.18.6.12]) with SMTP
	ID DSNKUx2WIFt6ENDuf04WnzuRtBkcMYkG2zgB@postini.com; Mon, 10 Mar 2014 03:38:25 PDT
Received: by mail-vc0-f174.google.com with SMTP id ld13so1522705vcb.33
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 03:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=5DSEinc753lThAHgi/+3zbgKZwgyinw+9+ov6jmOMTM=;
        b=XUpvUBtLNYnqj/se10/JUe+YpV7BGBJ30KgOwGlwq1pI/BZrncSKe/FGjJqb9A5Ylu
         b3BBNEtY5mrMWIX2WknN/emGKQ/9lkh5G+xA/eq7QtxTypVnsLdowC6VrbjfpFPZgE8W
         V8ZnxbTEdgObL+Iznq0pRQ9Jb9IF/qq6VOjOooXZrLI4ahKSI4K7bJj42l/bGkresV8T
         85+oPYOgsvk4WiN+LS6ACQffT0hK2PxFX0xflIgb9up2UgdFSfQ+EcdA/q4oB+cmSZBI
         IQFWxXDnndrlNJ72yXuTUQ/3TawF2SCPOQ3Feiyxtw1xbU9gQGR+cnGnTlhfLtOiEW6l
         lUzw==
X-Received: by 10.58.170.69 with SMTP id ak5mr99255vec.28.1394447497995;
        Mon, 10 Mar 2014 03:31:37 -0700 (PDT)
X-Gm-Message-State: ALoCoQm3DoK6Bl7dHYWEZGgJE7N53WeRvBj3RdKCUZa7O0T5Trjoxl2AiuvNXHaHEQ4DAYNaNT3H+V66b7gquBhvUvQ1CWGPsThCzf8Rac0aYLEeehJjevufxZLum4SyIYRhOrT1dkgJg78ryBdlOSZQpMrvo+zMWA==
X-Received: by 10.58.170.69 with SMTP id ak5mr99244vec.28.1394447497799; Mon,
 10 Mar 2014 03:31:37 -0700 (PDT)
Received: by 10.59.5.99 with HTTP; Mon, 10 Mar 2014 03:31:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243725>

I accidentially deleted a directory using git clean. I would think
this is a bug, but I'm not sure. Was using 1.8.1, but upgraded to
1.9.0 just to see if it was still reproducable, and it was.

Here's a minimal way to reproduce:

$ git init
$ mkdir foo foobar
$ git clean -df foobar
Removing foo/
Removing foobar/
$ ls
$

I expected only "foobar" to be deleted, but "foo" was also deleted.

The same thing happens in the opposite case:

$ git init
$ mkdir foo foobar
$ git clean -df foo
Removing foo/
Removing foobar/
$ ls
$

However, it only happens when there is a common prefix in the names:

$ git init
$ mkdir foo bar
$ git clean -df foo
Removing foo/
$ ls
bar
$

In this case, "bar" was not deleted.

-- 
Best regards,

Robin Pedersen
Software Engineer

SnapTV AS
Jordmor Magdalenes vei 17
N-9519 Kviby.
Norway

robinp@snap.tv
http://www.snap.tv
