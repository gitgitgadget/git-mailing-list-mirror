From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] git-rebase: Add --stat and --no-stat for producing diffstat on rebase
Date: Sun, 01 Mar 2009 13:47:06 -0800 (PST)
Message-ID: <m3zlg4ud9v.fsf@localhost.localdomain>
References: <1235942908-5419-1-git-send-email-torarnv@gmail.com>
	<1235942908-5419-2-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-15?q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 22:48:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdtWi-0002no-8h
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 22:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755946AbZCAVrM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2009 16:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755986AbZCAVrL
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 16:47:11 -0500
Received: from mu-out-0910.google.com ([209.85.134.184]:39262 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755620AbZCAVrK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Mar 2009 16:47:10 -0500
Received: by mu-out-0910.google.com with SMTP id i10so673028mue.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 13:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=8cfjd/ZIcPlS6oSJ8GCWtoktopfDt3njymCIAgskU/A=;
        b=dhxfzR6r2Ur90nWrc/9Ecu2k8fpzTUpR8ryc0oKNb/H/68DBrLOFhIutj/T44A3o2i
         +K9UR6UXT3IGCyfIU55sm2QcngaFOsSu3hYP0LsaGAH6I+aqZL1BxVWzo5TEYoRKV6jV
         2QXqy49xGcJmt5XCgTA9tPJk/xVC/Z7jgUh00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=xFyNv+0KVm+4Ovte73UIfqMoD5qKT8nWRQnsZN7JqvkaD/WTPlYPE3mwGILgzN/2P8
         HbM1hO+8J+AP8YrFbH35sOmvqHnlRdEEaTCfCMnfOuz3eEVth3WCvYO/AzbfrrKU9I67
         kgtEFnJi/B1AiuPLaitpD7AAuilpqNgT01Q0Q=
Received: by 10.103.220.18 with SMTP id x18mr2585306muq.38.1235944027282;
        Sun, 01 Mar 2009 13:47:07 -0800 (PST)
Received: from localhost.localdomain (abvv234.neoplus.adsl.tpnet.pl [83.8.219.234])
        by mx.google.com with ESMTPS id w5sm977730mue.3.2009.03.01.13.47.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 01 Mar 2009 13:47:06 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n21LkwqO005198;
	Sun, 1 Mar 2009 22:47:02 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n21LkrMW005194;
	Sun, 1 Mar 2009 22:46:53 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1235942908-5419-2-git-send-email-torarnv@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111882>

Tor Arne Vestb=F8 <torarnv@gmail.com> writes:

> The behavior of --verbose is unchanged, but uses a different state
> variable internally, so that the meaning of verbose output may be
> expanded without affecting the diffstat. This is also reflected in
> the documentation.
>=20
> The configuration option rebase.stat works the same was as merg.stat,
> but the default is currently false.
>=20
> Signed-off-by: Tor Arne Vestb=F8 <torarnv@gmail.com>
> ---
>  Documentation/git-rebase.txt |   17 ++++++++++++++++-
>  git-rebase.sh                |   25 ++++++++++++++++++-------
>  t/t3406-rebase-message.sh    |   23 ++++++++++++++++++++++-
>  3 files changed, 56 insertions(+), 9 deletions(-)
>=20

You have to update also Documentation/config.txt

--=20
Jakub Narebski
Poland
ShadeHawk on #git
