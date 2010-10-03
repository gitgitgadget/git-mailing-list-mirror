From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v4 4/4] Add testcases for the --hide-dir-rename-details
 diffcore flag.
Date: Mon, 4 Oct 2010 01:04:32 +0200
Message-ID: <AANLkTikdD06x45yQsVjhk4NYZYKCXmYzOcioNA_-rZ5O@mail.gmail.com>
References: <1286138529-6780-1-git-send-email-ydirson@altern.org>
 <1286138529-6780-2-git-send-email-ydirson@altern.org> <1286138529-6780-3-git-send-email-ydirson@altern.org>
 <1286138529-6780-4-git-send-email-ydirson@altern.org> <1286138529-6780-5-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Yann Dirson <ydirson@free.fr>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Mon Oct 04 01:05:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2XcP-0006eM-HV
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 01:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173Ab0JCXE4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 19:04:56 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36641 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037Ab0JCXEz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Oct 2010 19:04:55 -0400
Received: by iwn5 with SMTP id 5so6160147iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 16:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=J9kxCDY3RGgPZo1YfFviTIQwffzR4saHh8hjGuH8NuA=;
        b=Orc63Zxg/55wCXAH1PyY2a4QXdUn6F+hcjyo5T6YUPueDPYGaCbdzTGxabxNr1GYk7
         BKt3B/K9Mpp0LgeTE673QL6Ku2QS3DO0KoGvLp6spNSJ2LrRkt5m9ZITejh5Zznyuhip
         d19QhOyVb8S/K4RixV84VB+FoWhSgTJMb2zcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=MnB25Jdfddzc0y3ccM752E9fazN7m/9aIX1qd1vFpUgGNgAS5TyONM5ZFfJY58CoaJ
         BM0ecvY8aanDamYzgbGy9/baWYXvnTPD8LLP7lr+Z0KYOPttvW6mofkJyoyVcJcdOS95
         04glsLtdz3Nrf3gAtLmRm7ZWUpUxcj8+QsGc4=
Received: by 10.231.14.71 with SMTP id f7mr9074677iba.118.1286147094867; Sun,
 03 Oct 2010 16:04:54 -0700 (PDT)
Received: by 10.231.33.138 with HTTP; Sun, 3 Oct 2010 16:04:32 -0700 (PDT)
In-Reply-To: <1286138529-6780-5-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157941>

Heya,

On Sun, Oct 3, 2010 at 22:42, Yann Dirson <ydirson@altern.org> wrote:
> +:040000 040000 0000000000000000000000000000000000000000 000000000000=
0000000000000000000000000000 R100 =C2=A0a/ =C2=A0 =C2=A0 =C2=A0b/
> +:100644 000000 c6971ab9f08a6cd9c89a0f87d94ae347aad6144a 000000000000=
0000000000000000000000000000 D =C2=A0 =C2=A0 a/path3
> +:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737=
c8aa0003672c1bc21ded48c6c3b9 R100 =C2=A0a/path2 b/2path
> +:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 4db595d12886=
f90e36765fc1732c17bccb836663 R093 =C2=A0a/path0 b/path0
> +:000000 100644 0000000000000000000000000000000000000000 1ba465088551=
3e62386fd3e23aeb45beeb67d3bb A =C2=A0 =C2=A0 b/path100

There was a recent discussion that came to the conclusion that we
don't want to be comparing against hashes outside t0000. So either
don't use diff-index, or use 'git rev-parse' to get those objects
first, and then compare against them symbolically (e.g., ":100644
000000 $(path3) $(nullref)", or such).

--=20
Cheers,

Sverre Rabbelier
