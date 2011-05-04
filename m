From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] t3700: note a .gitignore matching fault
Date: Wed, 4 May 2011 08:05:08 +0700
Message-ID: <BANLkTi=TNjUaD4EP8sYXDqJ-tmBEzz4t4w@mail.gmail.com>
References: <1304340464-14829-1-git-send-email-pclouds@gmail.com>
 <1304340923-15927-1-git-send-email-pclouds@gmail.com> <4DBEC766.8020008@viscovery.net>
 <BANLkTik=GYXUOeo3hA5yyXfOuBydT40koA@mail.gmail.com> <7voc3jis61.fsf@alter.siamese.dyndns.org>
 <BANLkTi=ZL5aPnPMXai==gyjYRT_LHovisA@mail.gmail.com> <7vd3jzgww8.fsf@alter.siamese.dyndns.org>
 <BANLkTinSx=MAkF5mt8gReNd1qEaeFTEBpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 03:05:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHQXB-00017r-MZ
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 03:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802Ab1EDBFk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2011 21:05:40 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49436 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554Ab1EDBFk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2011 21:05:40 -0400
Received: by bwz15 with SMTP id 15so579824bwz.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 18:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=+7zwYxSo6TBFl5pYbQnVhc9NAbXIPSHYsw4hXAEasPw=;
        b=CHib2oYsKmwBzV2ysq835aNEpLQXLgmP2ZUMEr+kZ4oEH/v7VtIx/iV5SiCCCr1tVm
         wvz/dNdWNFuuRe4CIaLL86VTISw9jbyi/Lnj09tI1Lcz+xykVHnLwQ232NCj5RZUdjjg
         MUGk6B+Ddask8K27cValbRp+mnES1mQs/JZe0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=VYRknXO2Y+n6SlkvlfwLtJ3aLAqdhfm76jn2adPLlC8nEy5cLfJN+Bb+m6HY1ghgPg
         +ialEvOdzWtnmGwjE4oRwfVqaIOzzai5bBZEkumu9qdnaCE1xVeSLEMcsQLEDGdvIncG
         VPwkaZ2Uk4ekfejakFCju/H7dGNCuiyN1r/cM=
Received: by 10.204.45.152 with SMTP id e24mr465823bkf.47.1304471138158; Tue,
 03 May 2011 18:05:38 -0700 (PDT)
Received: by 10.204.53.13 with HTTP; Tue, 3 May 2011 18:05:08 -0700 (PDT)
In-Reply-To: <BANLkTinSx=MAkF5mt8gReNd1qEaeFTEBpA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172708>

On Wed, May 4, 2011 at 7:41 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com=
> wrote:
> On Wed, May 4, 2011 at 6:57 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>>
>>> Yes. But git still silently ignores some rules in the .gitignore.
>>
>> Do you want git to report each and every entry in .gitignore saying =
"this
>> rule does not apply"? =C2=A0That sounds like madness to me.
>
> This rule should apply, but not because of "efficiency reasons". Not
> just about any rule.

Maybe something like this instead of a implemantation fix?

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 8416f34..81e9d43 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -71,6 +71,8 @@ PATTERN FORMAT
    matching file excluded by a previous pattern will become
    included again.  If a negated pattern matches, this will
    override lower precedence patterns sources.
+   If a directory is excluded by earlier patterns, negated
+   patterns that touch files inside the directory will be ignored.

  - If the pattern ends with a slash, it is removed for the
    purpose of the following description, but it would only find

--=20
Duy
