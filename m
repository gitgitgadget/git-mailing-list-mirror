From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/2] set NO_TRIVIAL for custom merge strategies
Date: Sun, 15 Aug 2010 20:06:52 -0500
Message-ID: <20100816010652.GA22546@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Miklos Vajna <vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 16 03:08:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkoBz-0004oA-GC
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 03:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837Ab0HPBId convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 21:08:33 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36300 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab0HPBIc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Aug 2010 21:08:32 -0400
Received: by iwn7 with SMTP id 7so1116396iwn.19
        for <git@vger.kernel.org>; Sun, 15 Aug 2010 18:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=IyD8MLsrc7RI3eYiSdgwf7xVa4ZxaMBTc0hIPDxTdfk=;
        b=eUbyRQXfQej0b+lCJZFwaIwa8hF6anzf6VH6F0oSmUaWtPDtmPNwlHDwhhgAimpwa8
         XlfqhGNLbPI/Rv3w7QGFdnhI0qfUh21qxXc3Yeuk3UcaHtEGOKWFxKLVdhdkDsyqXRN2
         10AIbwo6WvB+8W4LqKJhzCmS0KXwM7mI77/so=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=SBHgCnj56i/x8cSka8YaOalYeHKjNqjtITZ9+p+6rFlL404GV71Zm3j8MgB0QgxIxR
         35Sml/Zm/rHorzKOKW1hQObcizVdmlkJ9+kiLRYjqL7/xxuwNq2cilZ6zgN3sK5Ull9s
         0ZHz5Czb3+AyUa+W7FftFBiIkYgnRSG0J/jzw=
Received: by 10.231.184.168 with SMTP id ck40mr4583701ibb.174.1281920911393;
        Sun, 15 Aug 2010 18:08:31 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h8sm3982819ibk.3.2010.08.15.18.08.30
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 15 Aug 2010 18:08:30 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153637>

As noticed at <http://bugs.debian.org/581691>, the example custom
=E2=80=9Ctheirs=E2=80=9D strategy does not take effect for trivial merg=
es.
A user-defined =E2=80=9Cours=E2=80=9D-like strategy would also not be p=
ossible without
this change.

Longer term, it would be nice to be able to override the
NO_FAST_FORWARD and NO_TRIVIAL flags for custom strategies in
~/.gitconfig, but let=E2=80=99s wait until we need it.

Thoughts?

Jonathan Nieder (2):
  t7606 (merge-theirs): modernize style
  merge: let custom strategies intervene in trivial merges

 builtin/merge.c         |    1 +
 t/t7606-merge-custom.sh |   96 ++++++++++++++++++++++++++++++++++-----=
--------
 2 files changed, 71 insertions(+), 26 deletions(-)
