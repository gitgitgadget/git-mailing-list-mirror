From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH v2 0/4] Apply blanks at EOF
Date: Wed, 24 Feb 2010 20:23:56 +0100
Message-ID: <4B857CCC.7080809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 20:31:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkMxc-0001rL-JC
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 20:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757762Ab0BXTbs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2010 14:31:48 -0500
Received: from mail-ew0-f212.google.com ([209.85.219.212]:52915 "EHLO
	mail-ew0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757739Ab0BXTbq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 14:31:46 -0500
Received: by ewy4 with SMTP id 4so1219910ewy.28
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 11:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=P8h6ehkoCE8CEa/wJWol11oIJC5FTfbJUOsKRRO3Y9E=;
        b=fJM2DYLzARsSUb8s8FdVU4OxzPbWz6w9+w0qdfA/tBTT8ND4oryJ1ZI0Y5HEQMOVEj
         ZbcKWPigbEX7+Mxe3PYthvESESjoVxP6o1b22mwzluLT+PAJo5g1qBFgH8UZ1X31a4Xf
         cqppMGc5tmaeWyYnEyPpRVHYfblcXikFv418o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=cOFP2QIy9b90c9m+/PAbfU9PkfKErIOT4UpaQ6P3Hk5gA1ft9JeI9ZIeawIfd5JbIW
         VFNefWdzyNLJMaqWxlJM63Guyu2YFpVAHZCG123h1EMkwhrceYH3xBPxmmQ3w+0vMSwq
         dgqx4wgUu35Pm/FSegmwNIv7BspY9litmyerQ=
Received: by 10.213.1.143 with SMTP id 15mr645760ebf.55.1267039438823;
        Wed, 24 Feb 2010 11:23:58 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 23sm359111eya.42.2010.02.24.11.23.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 11:23:57 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140980>

Here is my revised patch series.=20

Bj=C3=B6rn Gustavsson (4):
  apply: Remove the quick rejection test
    Now a separate commit for removing the quick reject and
    clarifying another test, as well as a new test case.

  apply: Allow blank context lines to match beyond EOF
    At least one non-blank context line must now match before
    the end of file. Rewrote my own changes in the beginning
    of match_fragment() in a way that I think is clearer.

  t4124: Add additional tests of --whitespace=3Dfix
    More test cases.

  t3417: Add test cases for "rebase --whitespace=3Dfix"
    No changes.

 builtin-apply.c                  |  146 ++++++++++++++++++++++++++++++=
-------
 t/t3417-rebase-whitespace-fix.sh |  126 ++++++++++++++++++++++++++++++=
++
 t/t4104-apply-boundary.sh        |    9 +++
 t/t4124-apply-ws-rule.sh         |   85 ++++++++++++++++++++++
 4 files changed, 338 insertions(+), 28 deletions(-)
 create mode 100755 t/t3417-rebase-whitespace-fix.sh
