From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] unpack-trees.c: Do not check ce_stage in 
	will_have_skip_worktree()
Date: Sat, 31 Jul 2010 13:12:59 +1000
Message-ID: <AANLkTi=K1Q+BkMvTPxKCo_VFgWY-ZLRznFcBEN2qQ3Yk@mail.gmail.com>
References: <1280135310-2347-1-git-send-email-pclouds@gmail.com>
	<1280135310-2347-2-git-send-email-pclouds@gmail.com>
	<20100731021144.GA906@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 05:13:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of2Vm-0000Jw-Fz
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 05:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731Ab0GaDND convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jul 2010 23:13:03 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42556 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab0GaDNB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jul 2010 23:13:01 -0400
Received: by wyb39 with SMTP id 39so1776364wyb.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 20:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gPb8IPRSuXWSEJQ4wF5T40PYKtecZEc8/Ahcpe4Bg7s=;
        b=PahNUGfkgvKwU8Q0QSPWPt1E/ItrdApeGETl9lsjf7kwlNPcFGznyn8nBRkt6YlMOD
         nR0hZx2J1oyZx13Bttyat94Tju4UsE6AXCiYwMVhy8QjoCyGyjzfFmMCz64xwOhNgYXp
         lOH3JLOYsSCFoH7xb8l5/VPtr+umgEA52TLqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pmlTzoVefzPbW8g6ft/F3SvYDPHVZr2RyXyl2TYpqKG9euKJXfNEuBSZ605C3yGWwG
         C7ZVEKh4hyFQltcXu4MBg4DUVUrFc7Uer8EqA2btEwAXbyxYIkmr2eS9/NO9RLXJCLOk
         tONkKDlNFu8IjLAMb158UDLAbDVjmUc2b4MpE=
Received: by 10.216.231.26 with SMTP id k26mr2492845weq.3.1280545979915; Fri, 
	30 Jul 2010 20:12:59 -0700 (PDT)
Received: by 10.216.173.199 with HTTP; Fri, 30 Jul 2010 20:12:59 -0700 (PDT)
In-Reply-To: <20100731021144.GA906@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152293>

2010/7/31 Jonathan Nieder <jrnieder@gmail.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> The idea of sparse checkout is conflicted entries should always stay
>> in worktree, regardless $GIT_DIR/info/sparse-checkout. Therefore,
>> ce_stage(ce) usually means no CE_SKIP_WORKTREE. This is true when al=
l
>> entries have been merged into the index, and identical staged entrie=
s
>> collapsed.
>>
>> However, will_have_skip_worktree() since f1f523e (unpack-trees():
>> ignore worktree check outside checkout area) is also used earlier in
>> verify_* functions, when entries have not been merged to index yet
>> and ce_stage() may not be zero. Checking ce_stage() then can make
>> unnecessary verification on entries outside checkout area and error =
out.
>
> s/make/provoke/?
>
> So: conflicts from unmerged index entries are supposed to be kept in
> the work tree; but unpack_trees() is checking too early and seeing
> conflicts where there are none. =C2=A0Do I understand correctly?

Correct.
--=20
Duy
