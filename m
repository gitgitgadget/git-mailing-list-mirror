From: Elijah Newren <newren@gmail.com>
Subject: Re: cherry-picking a commit clobbers a file which is a directory in
 the target commit
Date: Mon, 6 Sep 2010 09:20:51 -0600
Message-ID: <AANLkTimz8qSwefp137-D+vEbsf6soG51u0im9EC911_O@mail.gmail.com>
References: <4C7FCE27.7000500@letterboxes.org>
	<4C84B948.9040907@letterboxes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nick <oinksocket@letterboxes.org>
X-From: git-owner@vger.kernel.org Mon Sep 06 17:21:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsdVE-00004r-F2
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 17:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430Ab0IFPUx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 11:20:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55423 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175Ab0IFPUw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 11:20:52 -0400
Received: by fxm13 with SMTP id 13so2503688fxm.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 08:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=X0LoKaYaKa6bpEBCXAALcfYITfkUW98fT0NzE13nnZ0=;
        b=mszNOlP0DWknORLIBENJ16gGYk8t9jEekc9djsqmgaq25wnVj9JO/BQAyPBYADdlhY
         BnZoDY19H1Ne4xy2F1P6Mdek71SZNNy92xuhEMLYyvY92ZFfG9IgKfOPQslHsudj4Ioa
         vlJS+LgVy6R++c75VYq/P4faYKWKdQia2/w8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LnnFIJ2FKq+4T+go/cv1PDRVTIR+O3q3aLnW6fAO7VfFX9a6zxPtZIww4JaTu7HA01
         wgU0ElC7tloxhUO1PGi7MxNJAHUTBoPEn8VM/jLpH3DNSPO3pkBvhDgII/F9MG2RBG7g
         XIy5+g34xd8AY0tv/CwpCc/4jDXfmlAscSyZY=
Received: by 10.223.123.199 with SMTP id q7mr2568991far.84.1283786451088; Mon,
 06 Sep 2010 08:20:51 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Mon, 6 Sep 2010 08:20:51 -0700 (PDT)
In-Reply-To: <4C84B948.9040907@letterboxes.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155574>

On Mon, Sep 6, 2010 at 3:50 AM, Nick <oinksocket@letterboxes.org> wrote=
:
> I've been Warnocked. =C2=A0Can anyone point me in the right direction=
?

It's a bug in the recursive merge strategy (i.e. the default one), and
affects current master as well as 1.7.0.4.  The resolve strategy
(which can be used with cherry-pick since 1.7.2) handles this
correctly:

$ git cherry-pick --strategy=3Dresolve branch1
Trying simple merge.
Simple merge failed, trying Automatic merge.
[master e95e377] added falafel
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 falafel

I'll investigate.


Elijah
