From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] t6022: Use -eq not = to test output of wc -l
Date: Mon, 8 Nov 2010 22:35:38 +0100
Message-ID: <AANLkTik48HPHn4Xfwn5kuS2uHenQfjTJFaXMe9iSe5vU@mail.gmail.com>
References: <1289251766-48316-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 22:35:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFZNR-0004YM-OF
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 22:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173Ab0KHVfk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Nov 2010 16:35:40 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65491 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753923Ab0KHVfj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Nov 2010 16:35:39 -0500
Received: by fxm16 with SMTP id 16so4435229fxm.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 13:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pvcY3WzWn5rvMibx1Q5HWOzk3SXC9w9CCTUWDL8fgwU=;
        b=vJvQMBKGere4V8YDSci2Cv71TwD4bcBlMB7xP4R2dFRGT88fw2778eRcRDsC/KbCaS
         LCC4U0VDFhUIuDAtXe7P1CuCT9htYdPCHzNUk9xGYlb2g1bKXj6OLOJGeJWwuYoB71Nj
         7IGNIta/CEkFkpJR9si42KFjeD0CrEU3oDdEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BoIl7GNI1ppsVlqJiItV81cfKjtAl4H87iAc+aziiwRZGj5EAB0G8nOvG7CGLDL5nN
         ef73HebjONT9MkKAZRWYGtydL7DhOjDtX7GV5uTdhMQL85PrMtbpQcNg6gqcTqKW/6Sy
         1HglbIYsg+IIQcMy7fFiFN6RTEKlAz0n+u2FQ=
Received: by 10.223.86.6 with SMTP id q6mr4245671fal.144.1289252138089; Mon,
 08 Nov 2010 13:35:38 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Mon, 8 Nov 2010 13:35:38 -0800 (PST)
In-Reply-To: <1289251766-48316-1-git-send-email-brian@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160992>

> =C2=A0The alternative would be to use 3 =3D $(wc -l) (sans quotes), b=
ut other parts
> =C2=A0of the test used the -eq method.

A IMO saner alternative is to add a new test-lib.sh function for this.

E.g.:

-       test 3 =3D "$(git ls-files -u | wc -l)" &&
-       test_wc 3 "git ls-files -u" &&

We could use test_cmp or something internally so we'd get meaningful
output when those tests fail.

But this is a good fix anyway.
