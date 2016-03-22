From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 0/3] builtin/apply: simplify some gitdiff_* functions
Date: Tue, 22 Mar 2016 21:58:39 +0100
Message-ID: <1458680322-17681-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 22:06:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiTVj-0000ve-4K
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 22:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364AbcCVVGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 17:06:38 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38160 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbcCVVGd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 17:06:33 -0400
Received: by mail-wm0-f47.google.com with SMTP id l68so180735401wml.1
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 14:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=75x5TQG8adq5zSsXVOMZL5dwFiTRtsCpJJXZp7S4HOQ=;
        b=Sr37BSMAwMf6H3skXA3SJv2yiD9T9IYf8hFdn9EV91lat7DpJUt/hHD8qVKev8WeEh
         dhXf3mN0kF9l03M47DLHHNqfg6Ynbht2tQRYdAamUpHgEE7w7Rzm8ox2UfWP8upIkLh2
         QtvoJgaUPGmr91Udikbs/XABZHuyXbCvmpxKxM/MxigZmed+6+IFwEtWxTooOpSMmbNt
         RCY4zR/Itsf7GHZ32R+f/hbZ1xC7rdCtQxVkJ9Aswi5fcqKvc49wyC/cWtxBGq+Sd9nf
         ZaY1rSLzWLS4xARLWE/jUwtCBaaYVY4quDIUlJyh2HlVJ5hWNbODKOUft2RaakpUAZda
         6Eog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=75x5TQG8adq5zSsXVOMZL5dwFiTRtsCpJJXZp7S4HOQ=;
        b=UFg8HnF6vpkjCdYSYGsnq9+AlPpIr343p7uPLajLn2821rmhnxX0LjDEhDXzxt6awX
         0Iha4vXEnTj8U48XcVwHxhoZe2PaETr0llbHLr7QKuzQizlGVwJlh1Ag5ilsZCh4pGEs
         8mi326iqfn25FqSx7phsOW9nyoCBQQxu7Xz3iOkp6X7AVgQDZaOmqpmCkj1Uk7Ftz9aB
         KFZn7EYCGmvWfdHntmN1TjY1pIEUx2vD/miGkJmDxmPMAeMwXefMe4fsz8YYsZMfWCXU
         UOWBeG+h+k6kft5ynNmQ/LN2zU8s7fv5IA3Sm7Tx4BTGDjJtlnf86PNgMLyxVClwm9uq
         Vbrg==
X-Gm-Message-State: AD7BkJKAgdwyr9yy/uOeYepK5/ZPJzhiBKZMZ4aciSQekg5KjzE4RPbAsslerr0LdeIVmQ==
X-Received: by 10.194.23.7 with SMTP id i7mr38507625wjf.9.1458680792386;
        Tue, 22 Mar 2016 14:06:32 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id i5sm31920087wjx.15.2016.03.22.14.06.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Mar 2016 14:06:30 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc4.59.g21809a1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289559>

While working on libifying "git apply" it appeared that some gitdiff_*
functions are unnecessarily complex.

Christian Couder (3):
  builtin/apply: get rid of useless 'name' variable
  builtin/apply: make gitdiff_verify_name() return void
  builtin/apply: simplify gitdiff_{old,new}name()

 builtin/apply.c | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

-- 
2.8.0.rc4.1.g302de0d.dirty
