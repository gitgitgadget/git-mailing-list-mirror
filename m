From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] t5403: do not use access repos with GIT_DIR when
 worktree is involved
Date: Thu, 13 Oct 2011 15:54:29 +1100
Message-ID: <CACsJy8BS=z+5bALvMEAr567O2jT3ytSz9rWmvDSiRHL0Ub69wg@mail.gmail.com>
References: <1318412105-13595-1-git-send-email-pclouds@gmail.com>
 <1318412105-13595-3-git-send-email-pclouds@gmail.com> <7vwrc95xe5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 06:55:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REDK0-0007PD-3S
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 06:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965Ab1JMEzB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Oct 2011 00:55:01 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41282 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789Ab1JMEzA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2011 00:55:00 -0400
Received: by bkbzt4 with SMTP id zt4so925792bkb.19
        for <git@vger.kernel.org>; Wed, 12 Oct 2011 21:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=QAZG5hPGpE92E0At5uA8zPXeTTi+b6mSHWLRZhvv4TM=;
        b=FpQULGTJO8xyHGEjVyp8i2+txn9UWiqPMaMwRDSVQp0cz1nuiwV7/v8y5Ly2FS+zDq
         nqzcZttx9lufC8MIzRskq2BYr4xFSodutLRBXvSDzG2p9sEGSkoUZL5fo34+rGZR2hnK
         AebiZau2WXxrj8U2hxqmJsY1sIz5ZctMlkTT0=
Received: by 10.204.7.83 with SMTP id c19mr1022879bkc.81.1318481699089; Wed,
 12 Oct 2011 21:54:59 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Wed, 12 Oct 2011 21:54:29 -0700 (PDT)
In-Reply-To: <7vwrc95xe5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183440>

2011/10/13 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> Setting GIT_DIR alone means worktree is current directory for legacy
>> reasons. Avoid using that, instead go to the worktree and execute
>> commands there.
>>
>> The troublesome command is "GIT_DIR=3Dclone2/.git git add clone2/b".=
 The
>> real worktree is clone2, but that command tells git worktree is $(pw=
d).
>> What does user expect to add then? Should the new entry in index be =
"b"
>> or "clone2/b"?
>
> There is no troublesomeness here, as the semantics has been clearly
> defined and (hopefully) stayed constant before the days when GIT_WORK=
_TREE
> was invented.

It's not wrong per se. The trouble comes from the people who reads the
test. It's not clear the author wants to add "b" or "clone2/b".

Another thing, because "clone2" has .git inside, should "clone2" in
this case be considered a submodule and "git add" refuse to add
anything "clone2/*" but "clone2" itself?

> Unless we are trying to break them without knowing, and declare that =
we
> deprecated it after the fact, which is not exactly the way we want to
> remove existing (mis)feature.

I had problems with my read_directory() rewrite but it's been some
time since I touched the code. I don't remember what went wrong. Need
to have another look.
--=20
Duy
