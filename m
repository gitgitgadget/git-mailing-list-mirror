From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] fast-export: ensure that a renamed file is printed after
 all references
Date: Tue, 7 Sep 2010 23:46:34 -0600
Message-ID: <AANLkTim4iuDOG9U1epcafWarckaa6ZnxCOpfJW8KJW_m@mail.gmail.com>
References: <201009072133.02930.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Sep 08 07:46:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtDUX-0007wp-IJ
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 07:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650Ab0IHFqh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 01:46:37 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54428 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467Ab0IHFqf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Sep 2010 01:46:35 -0400
Received: by fxm16 with SMTP id 16so515835fxm.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 22:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CXbmW5Vucam8D/+kwQHKHx1y6TlnSCXhdFIn2wVZO+Y=;
        b=voXmmngmD2aycrnKyyk3hN3Ep3ssGaTi0lj2rst7Ru5J4tGzrwerZlbdC6kDOGOqBC
         hY03FEB/H1pxl9U/+KQzMtq5s0ZHZeOh1FKB5wNRn7QDFUNx+xZwPht893jVTHCWjDuA
         rpz/8s8W6oIoRgBdu5kZ3gvHDQTn0ZrHlhMNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GPJQjWy0JSBuPpyeFffcz0iC+eyrIST4ZJgz7PytmBVviG1iUJcd/HJLyxvhqFFIZm
         G9mfnex/HXo90vMJq4xpjepz2+CCoFNiRTXZzBopvdcnN+pWQrMsP13z2rQJlQHg2lgY
         cYJCwFJX3W+yG+2j4LD8q6zp/wkWXVumefhaA=
Received: by 10.223.104.141 with SMTP id p13mr424434fao.64.1283924794343; Tue,
 07 Sep 2010 22:46:34 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Tue, 7 Sep 2010 22:46:34 -0700 (PDT)
In-Reply-To: <201009072133.02930.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155767>

Hi,

On Tue, Sep 7, 2010 at 1:33 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> t9350 sets up a commit where a file is both copied and renamed. The o=
utput
> of fast-export for this commit should look like this:
>
> =C2=A0author ...
> =C2=A0committer ...
> =C2=A0from :19
> =C2=A0C "file2" "file4"
> =C2=A0R "file2" "file5"
>
> The order of the two modification lines is derived from the result th=
at
> the diff machinery produces.
>
> 060df62 (fast-export: Fix output order of D/F changes) inserted a qso=
rt
> call that modifies the order of the diff result. Unfortunately, qsort=
 need
> not be stable. Therefore, it is possible that the 'R' line appears be=
fore
> the 'C' line and the resulting fast-import stream is incorrect.
>
> Fix it by forcing that the rename entry is printed after all other
> modification lines with the same file name.

Patch and description looks good to me...however, I was a little
surprised to see no testsuite addition or additional explanation.  Are
you seeing some t9350 tests fail on some platform despite passing on
linux?


Elijah
