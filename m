From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 00/16] port branch.c to use ref-filter's printing
 options
Date: Fri, 1 Apr 2016 15:44:36 +0200
Message-ID: <20160401134435.GA16027@spirit>
References: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
 <1459517477.3493.5.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, jacob.keller@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 15:44:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alzNU-0001NP-Uf
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 15:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754279AbcDANol convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Apr 2016 09:44:41 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38862 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbcDANok (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 09:44:40 -0400
Received: by mail-wm0-f53.google.com with SMTP id 20so23749376wmh.1
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 06:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mJZHm3t0m6KkCh4sLU2gVMdY7/AFg3U9626Eb5mfM2g=;
        b=SKInUR3toyndWCpkc6sjeoqZdwXtwdZbgDMc+3w5GumylVJIUrFBhc/wY+m26z+iRx
         gMl3Pjv5mz01uj49xAJ40P1c1xdq2hIWgvOCorrePOu2/NxKo3JF8qprvZ4OrzGx13zI
         Xh8sKLwAr4UxkuO9OIG9Iz9avP+6Y3O9xbHmQ18il8qghvKv8pMbP7wNExeWA6oIcZgQ
         DcaXb4qYlCprewGyveMfBdAsmZU9Ztko5cOqcat75oh2I/JeFZ/ngCxD5/qK4yfsq24o
         jg5MmVfHRXgPSrpwzdMpVyj0zliSjFzf+yibviWXJvMRtEj6J6iyB7kaul2zVdVpJSLp
         eHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mJZHm3t0m6KkCh4sLU2gVMdY7/AFg3U9626Eb5mfM2g=;
        b=cwQvHFdqeuFxOYPupx2Jn6aMw15k513GkaxzJXF5DsildkpPSyNqGIGt83aGo/Vrks
         CdQlEWWaizsxMRJoDm0BK2yvCY8PN/uGV/WTPL4+tCF4slSNqKv1V9IxxeB3r4cvhHYr
         PFiAXsQt/xCbVHXwDSWKcYs9AsuKaK/nvWVkyrIAjVUm8PRiTVQdeMV03stOqjhHcnFR
         maZ57yiDljbcZRVcaR3dZqDcX5aY91B+YTYYcKEP8FByi5vrxKQdrS9s0IT6YGYWqS43
         KeS23TYUEF+peWkwPppkx39D5RngeIlDMlQRR8qEgY6RXXVR4s71clOQT6I5MdfKbMOs
         YTGw==
X-Gm-Message-State: AD7BkJKNDGWz9p6jpl4VM19sVzbmTFjlQb59IWkoRRXwYjWFP+Grwgj8VPEarozQm0/6Hw==
X-Received: by 10.194.60.100 with SMTP id g4mr4946051wjr.30.1459518279034;
        Fri, 01 Apr 2016 06:44:39 -0700 (PDT)
Received: from spirit ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id b8sm14121774wjf.9.2016.04.01.06.44.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Apr 2016 06:44:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1459517477.3493.5.camel@kaarsemaker.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290536>

On Fri, Apr 01, 2016 at 03:31:17PM +0200, Dennis Kaarsemaker wrote:
> On wo, 2016-03-30 at 15:09 +0530, Karthik Nayak wrote:
> >=20
> > This is part of unification of the commands 'git tag -l, git branch=
 -l
> > and git for-each-ref'. This ports over branch.c to use ref-filter's
> > printing options.
> >=20
> > Initially posted here: $(gmane/279226). It was decided that this se=
ries
> > would follow up after refactoring ref-filter parsing mechanism, whi=
ch
> > is now merged into master (9606218b32344c5c756f7c29349d3845ef60b80c=
).
>=20
> Interaction between this series=A0and something I've not yet been abl=
e to
> identify

That someting is es/test-gpg-tags. Karthik, can you maybe squash this
fix in if you do another reroll?

diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filt=
er.sh
index 98a1c49..7420e48 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -349,6 +349,8 @@ test_expect_success 'check %(if)...%(then)...%(end)=
 atoms' '
 	A U Thor: refs/heads/side
 	A U Thor: refs/odd/spot
=20
+
+
 	A U Thor: refs/tags/foo1.10
 	A U Thor: refs/tags/foo1.3
 	A U Thor: refs/tags/foo1.6
@@ -367,7 +369,9 @@ test_expect_success 'check %(if)...%(then)...%(else=
)...%(end) atoms' '
 	A U Thor: refs/heads/master
 	A U Thor: refs/heads/side
 	A U Thor: refs/odd/spot
-	No author: refs/tags/double-tag
+	No author: refs/tags/annotated-tag
+	No author: refs/tags/doubly-annotated-tag
+	No author: refs/tags/doubly-signed-tag
 	A U Thor: refs/tags/foo1.10
 	A U Thor: refs/tags/foo1.3
 	A U Thor: refs/tags/foo1.6
@@ -385,7 +389,9 @@ test_expect_success 'ignore spaces in %(if) atom us=
age' '
 	master: Head ref
 	side: Not Head ref
 	odd/spot: Not Head ref
-	double-tag: Not Head ref
+	annotated-tag: Not Head ref
+	doubly-annotated-tag: Not Head ref
+	doubly-signed-tag: Not Head ref
 	foo1.10: Not Head ref
 	foo1.3: Not Head ref
 	foo1.6: Not Head ref


--=20
Dennis Kaarsemaker <dennis@kaarsemaker.net>
