From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH v3 0/5] Apply blanks at EOF
Date: Sat, 27 Feb 2010 14:51:39 +0100
Message-ID: <4B89236B.5050708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 14:52:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlN5B-0006a5-15
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 14:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968328Ab0B0Nvn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2010 08:51:43 -0500
Received: from mail-ew0-f220.google.com ([209.85.219.220]:55312 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968320Ab0B0Nvn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 08:51:43 -0500
Received: by ewy20 with SMTP id 20so535804ewy.21
        for <git@vger.kernel.org>; Sat, 27 Feb 2010 05:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=yTxvfcgG1aGjciLm40dodPOXXywIHfV66tc6qUFw294=;
        b=TqRgktETvVDQ+mBv1PJY5/hDm/Rq5eYhng1GC1vzGIQMyl49a7n3Bp/aKyWyN1P48a
         OLlrmddTMsciP8VTW3YB2R8J5fDsXtgT0dMy98IzlAMH70BYTLXEd1Y9C23/8VTreVnL
         SSe4rIBhMTz7mhQofX2yoEoXojpQn2IforP2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=Fg84tcQ6Y1hZlWXxunLwHn1n57Jvy2YI2j2gA0kBsIdYEJJI2f3MNbFw9dnISqFWfb
         vFos/yMsZ2bR0puSMZTFjghcl9thsQAK5X9F9UEq4tFQ+wii2oUfB2CLhXB6AS4sO/Vt
         DRAL1W0MYfhvEnf8TQzcRnd2dWhpN3mm2TQbk=
Received: by 10.213.59.145 with SMTP id l17mr943100ebh.56.1267278701499;
        Sat, 27 Feb 2010 05:51:41 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 10sm4578795eyd.36.2010.02.27.05.51.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Feb 2010 05:51:40 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141206>

Here is my third attempt.

Bj=C3=B6rn Gustavsson (5):
  apply: Don't unnecessarily update line lengths in the preimage
    As far as I understand, there was a completely unnecessary update
    of line lengths which I have got rid of.

  apply: Remove the quick rejection test
    Unchanged (except for a minor correction of the commit message).

  apply: Allow blank context lines to match beyond EOF
    Included Junio's suggested clean-up that eliminates the "limit" var=
iable.

    Now handling --ignore-space-change.

  t4124: Add additional tests of --whitespace=3Dfix
    Added some more test cases and modified several tests to
    run "git apply" both with and without the --ignore-space-change
    option.

  t3417: Add test cases for "rebase --whitespace=3Dfix"
    Unchanged.

 builtin-apply.c                  |  184 +++++++++++++++++++++++++++++-=
--------
 t/t3417-rebase-whitespace-fix.sh |  126 ++++++++++++++++++++++++++
 t/t4104-apply-boundary.sh        |    9 ++
 t/t4124-apply-ws-rule.sh         |  119 ++++++++++++++++++++++++
 4 files changed, 397 insertions(+), 41 deletions(-)
 create mode 100755 t/t3417-rebase-whitespace-fix.sh
