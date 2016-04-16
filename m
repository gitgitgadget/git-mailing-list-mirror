From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v2 0/2] t1500-rev-parse: re-write t1500
Date: Sat, 16 Apr 2016 12:13:48 -0400
Message-ID: <1460823230-45692-1-git-send-email-rappazzo@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com, pclouds@gmail.com,
	szeder@ira.uka.de, peff@peff.net,
	Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 18:14:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arSrB-0003nG-HX
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 18:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbcDPQN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2016 12:13:58 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35068 "EHLO
	mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbcDPQN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2016 12:13:57 -0400
Received: by mail-qk0-f196.google.com with SMTP id u190so5731908qkh.2
        for <git@vger.kernel.org>; Sat, 16 Apr 2016 09:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=gJRLhmBNi9oCJMvAUDcSBmpzH7yU8nojKmFwJb2xBVs=;
        b=i3X0rMxvlAl57qwSq43fKpIVduos9k2SpKByspJopYNLbc2jPuWttb+H624RF7C0Ho
         QPSgU57sql6DOwpyssQQ3c7hE60djtRmNr/rdXg6WSAYQvxzEeOfGGUxEj/TDInlVdnw
         n1EMvkBofGr6f3o9i2bZH6/oJJNO8ss6tDd9zsVT253RLqLUpycGUcTu3Wraq2PgPwqx
         30Zel3D3JiajurB6ki4IjxGNGtCBZuWpwd/1BzwSY4cR9N4X3bLFQY9ocm4zcO1tkaCo
         cb126X2s5UXdyALh/fU3lJKEmtOsU/eIBTR/bqu4QySaqDXMtYLDyx92ZyjO0l5dvNsx
         j34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gJRLhmBNi9oCJMvAUDcSBmpzH7yU8nojKmFwJb2xBVs=;
        b=id9wb779wKaXluYvqobepvaQ+JRCfiZQFpVPYda6jp/eQVZEyfFU2bcZo1i+OneArN
         6l8FczWkeA4hO0T+3yqMAxTj3UCzE0JeoF7OB+ufC5Wbj9yD0LqbjY20n9sTfFOk2y8h
         Kh2LCzGBWYpKNYjpVM09+uw5m1qSjIUJ1sqysfPmZR812lqCGF3MpkFQtRu/cQxXcRFr
         oQqm72g/oabp5ppivp03D75pPfIwJOW+q0S25SyD9+gkV9Ts46Jw/7ThZIWik+F+lwBr
         lwblesH1pelobEmc4cyjQaBO0Kmwv5UVAgtCsodfZR03/Z5C0F/NUMWbPbuMJPlbm0f+
         tfQQ==
X-Gm-Message-State: AOPr4FWZrDkjYc5wTz/SMLFRXrWoX9Bz3rgr3x/F2XSlca8+2VcC8Bgs6Hc9h3k7ga82Zw==
X-Received: by 10.55.73.85 with SMTP id w82mr34249344qka.52.1460823236202;
        Sat, 16 Apr 2016 09:13:56 -0700 (PDT)
Received: from MRappazzo-8.local.info (pool-100-35-125-216.nwrknj.fios.verizon.net. [100.35.125.216])
        by smtp.gmail.com with ESMTPSA id w69sm22643384qhw.3.2016.04.16.09.13.54
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 16 Apr 2016 09:13:55 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291729>

Differences between v1[1]:
	- Rebased the change on master.
	- Added a test-lib function `test_stdout` which is similar to `test_cmp`.
	  This addition is based on a patch from Jeff King[2] found the same 
	  discussion.
	- Cleaned up the use of subshells as recommended in the discussion.


[1] http://thread.gmane.org/gmane.comp.version-control.git/291087
[2] http://thread.gmane.org/gmane.comp.version-control.git/291087/focus=291475

Michael Rappazzo (2):
  test-lib: add a function to compare an expection with stdout from a
    command
  t1500-rev-parse: rewrite each test to run in isolation

 t/t1500-rev-parse.sh    | 355 ++++++++++++++++++++++++++++++++++++++++--------
 t/test-lib-functions.sh |  34 +++++
 2 files changed, 329 insertions(+), 60 deletions(-)

-- 
2.8.0
