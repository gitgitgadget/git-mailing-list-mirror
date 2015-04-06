From: KES <kes-kes@yandex.ua>
Subject: Feature request: implement '--follow' option for `git blame`
Date: Mon, 06 Apr 2015 15:12:42 +0300
Message-ID: <4215491428322362@web26m.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 14:29:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf6A3-0000SU-Cd
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 14:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbbDFMUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2015 08:20:45 -0400
Received: from forward18m.cmail.yandex.net ([5.255.216.149]:46067 "EHLO
	forward18m.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752681AbbDFMUo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2015 08:20:44 -0400
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Apr 2015 08:20:44 EDT
Received: from web26m.yandex.ru (web26m.yandex.ru [37.140.138.117])
	by forward18m.cmail.yandex.net (Yandex) with ESMTP id 4211D20E72
	for <git@vger.kernel.org>; Mon,  6 Apr 2015 15:12:43 +0300 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	by web26m.yandex.ru (Yandex) with ESMTP id AEDF732E2A38;
	Mon,  6 Apr 2015 15:12:42 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1428322362; bh=DaZP59RIlNm1ROT9uSnG4aqeg6PaaIWY5dtU61BYbbU=;
	h=From:To:Subject:Date;
	b=fVj/PPboD0LCgIVCrhaiYiAuxSPBjodEhkLL9YEsH/gJedUjwKwPW+twv7421ZXfA
	 48GyJhfmwpZeX5EI0bg+e+okjyLKGCIbg3eB7FqfNUxTJuqWj42zdJDno+HhpujX+K
	 TDgIi/RWK4vzrSuY6bmrrfLgqD8HEE4RiEmBSj9A=
Received: by web26m.yandex.ru with HTTP;
	Mon, 06 Apr 2015 15:12:42 +0300
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266843>

    $ pwd
    /data/mdi2/classes

    $ git blame -L22,+1 -- utils.js
    99b7a802 mdi2/utils.js (user 2015-03-26 21:54:57 +0200 22)  #comment

    $ git blame -L22,+1 99b7a802^ -- utils.js
    fatal: no such path mdi2/classes/utils.js in 99b7a802^

As you have noticed, the file were in different directory in that commit

    $ git blame -L22,+1 99b7a802^ -- ../utils.js
    c5105267 (user 2007-04-10 08:00:20 +0000 22)    #comment 2

Despite on doc

    The origin of lines is automatically followed across whole-file renames (currently there is no option to turn
           the rename-following off)

blame does not follow renames. Why?

**UPDATE:** Short answer

`git blame` follow renames but not for `git blame COMMIT^ -- <filename>`

But this is too hard to track file renames manually through bulk of renames and ton of history.
I think, this behaviour must be fixed to silently follow renames for `git blame COMMIT^ -- <filename>`. Or, at least, `--follow` must be implemented, so I can: `git blame --follow COMMIT^ -- <filename>`

The good answer is here:
http://stackoverflow.com/questions/29468273/why-git-blame-does-not-follow-renames
