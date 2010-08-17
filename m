From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: [FreeBSD? BUG]: t1304-default-acl.sh fails on FreeBSD 8.1-STABLE
Date: Tue, 17 Aug 2010 03:17:58 +0000
Message-ID: <AANLkTikTu2vSCMPqtFvD964XsURayf2MNGSVW1nAaY1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Aug 17 05:18:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlCgg-0008BC-Sq
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 05:18:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754992Ab0HQDSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Aug 2010 23:18:00 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60526 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635Ab0HQDR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 23:17:59 -0400
Received: by yxg6 with SMTP id 6so2207127yxg.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 20:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=a8MiZ/dUyWNz8AxkJGawPGp9ACqT6D0C196Ltkyhxik=;
        b=XvyiG5nntmJI6gcXkAE2y2D7WiaRqLIX7Lh6Y8Fr84VMmouhqRJQsqoI66/sUNvJpB
         Mk24qAaL0NSRa67dq/8dP/jt3+ABUi4rbnaWKsf+aUBDcSmUloe3EivdRCxoNdnDdvlF
         gRF/BlMa96we8IMBKcuahASFJtSPiT4k0H5QU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=AMNKf/aC+q3PdahDzDrQwuY/EKvYsx61SCqJKdHlbSHdguPUK6VTREAiOhaTI3aPyp
         gncq18yl0ZetDpk0Siiyoa07zfr3eihcN3Pby4XuNmP514IOZS1zVFwO6GvWzL5F9Xrd
         BYJ8lETvYdgYLzF3aAbzmsz0VlRDmaZCkN1Yw=
Received: by 10.231.174.206 with SMTP id u14mr6721718ibz.103.1282015078793;
 Mon, 16 Aug 2010 20:17:58 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Mon, 16 Aug 2010 20:17:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153686>

t/t1304-default-acl.sh fails on FreeBSD, seemingly because setfacl on
FreeBSD doesn't have a meaningful return code:

    $ setfacl -m u:root:rwx . ; echo $?
    setfacl: .: acl_get_file() failed: Operation not supported
    0

But on Linux:

    $ setfacl -m u:root:rwx . ; echo $?
    setfacl: .: Operation not supported
    1

The Solaris setfacl also behaves.

The FreeBSD manpage says this:

    EXIT STATUS
         The setfacl utility exits 0 on success, and >0 if an error occurs.

Anyone here know more about FreeBSD to shed light on this?
