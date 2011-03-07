From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: --max-count useless with git-rev-list's --reverse
Date: Mon, 7 Mar 2011 20:17:38 +0100
Message-ID: <AANLkTikpK-r_kdqCEPwpqEgENtwgUrZDLwZnuS2QMdH=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 07 20:18:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pwfwc-0003Y8-QA
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 20:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755407Ab1CGTSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 14:18:08 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45913 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161Ab1CGTSH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 14:18:07 -0500
Received: by fxm17 with SMTP id 17so4406922fxm.19
        for <git@vger.kernel.org>; Mon, 07 Mar 2011 11:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=Bm4Rx4r4LP82TVFfzTJQl0lheT5KC1b/It1o+kvTgSM=;
        b=UiKaXnHs5LDJeuurVFn1VUAkyydVkPNbdOP0MoGTDnnozvUOxQ3BA88jvaXTtd81eA
         z6JWSaelSETzfDGmcrA7SoAt16FhFrEAll47t3aMhi1L9jdFw0KRlTou6iD2fov1VaYk
         bCWrHQfmYD1vZVUwvvvFbeMSGdoGQkm4ifgfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=KLMNhSOa8X9ef1Kqp+0wcqBOhnaOKfju+MyOmnNQWu3XLWqVp+h93GcHG7BRE+OZXj
         X/vvQXeAh0j8ay06p1OL/aKWU/iwC8FigIrrgA0L140uFpVgLXf4tUz2w33ycSeOClUg
         PVicUiVtV5aNpbaV0zvxUcc6YCqt60tz/Ni9s=
Received: by 10.223.143.86 with SMTP id t22mr5301888fau.68.1299525458834; Mon,
 07 Mar 2011 11:17:38 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Mon, 7 Mar 2011 11:17:38 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168604>

On git.git, this works as expected, gives me the first 3 commits:

   $ git rev-list --reverse origin/master | head -n 3
    e83c5163316f89bfbde7d9ab23ca2e25604af290
    8bc9a0c769ac1df7820f2dbf8f7b7d64835e3c68
    e497ea2a9b6c378f01d092c210af20cbee762475

Why is this so useless about ignoring the --reverse option, is this my
design (these are the 3 *latest* commits):

    $ git rev-list --reverse origin/master --max-count=3
    08fd8710e277eed73a21c6c5483c57bfeb14e8a7
    6d74e5c9dbe71e2eb63c6e8862ec979e9a5f068b
    07873dc5dd67398324278ff0d7627bb1a863ba89
    $ git rev-list origin/master --max-count=3
    07873dc5dd67398324278ff0d7627bb1a863ba89
    6d74e5c9dbe71e2eb63c6e8862ec979e9a5f068b
    08fd8710e277eed73a21c6c5483c57bfeb14e8a7

>From the manpage:

   --reverse
       Output the commits in reverse order. Cannot be combined with
--walk-reflogs.

Shouldn't --reverse be applied *before* --max-count?
