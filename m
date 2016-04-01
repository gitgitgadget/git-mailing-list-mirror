From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 00/16] port branch.c to use ref-filter's printing
 options
Date: Fri, 01 Apr 2016 15:31:17 +0200
Message-ID: <1459517477.3493.5.camel@kaarsemaker.net>
References: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, jacob.keller@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 15:31:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alzAb-0003fb-2y
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 15:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758711AbcDANbW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Apr 2016 09:31:22 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36427 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305AbcDANbV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 09:31:21 -0400
Received: by mail-wm0-f50.google.com with SMTP id 127so20169495wmu.1
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 06:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FN/7M9DFAxHtHd2A6DFPL1HvAppKAsdeMVrDD/sgNSY=;
        b=s23KvxuWJFUu2oKEMCgiHJ+EtIt2frtYP7uE0BYUdQ5CfXPf6++T6Auin3q75hoj4k
         O32q1PjP2rPQI9eG+kQPYFjzq8SPvSn/KeB1/nvOXQ+qGDX1Gdunjlyf/cV5GKWBM4AA
         inyGSGQSCmY438sCgECZVZVkj8a5QJHf826dkLw/ZIAFL+Nh7q0L3FJTdS/PntP89PlY
         x5rhzcHgUGqPyHkxYJX5awMY2SYii9BbWBAvHOKhyofoXSE7sycFYlfi1omVhSCptzCj
         HsE2678pKOn45TVV4yBl+f2lhDMHtp5uyzZh6+sfCQWQSitDaAi16C0WerPeSjoPY8hq
         NQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FN/7M9DFAxHtHd2A6DFPL1HvAppKAsdeMVrDD/sgNSY=;
        b=jY4JVi4rA5Zkd/xCMj7L0ZL6G4QGRjL5Cax1q5dnFYxayJ7TGzlS8K2oikxtckj+kU
         jWHPPB/HP7btXDX+aGD7PH6XpJ8TqHIc+HgSGWKtYWr60DAZDzT0Dt0rEpKCLJDAuCCY
         jlukL5L2TrwIs2x2P5Vt0Vze/LHrDnl79xB9fy/eBF17F6pUclvQyS+qluc45bRGjyLu
         yv+NwT4Bb/DcK7rh2Zj3qJ0q8D80Wkn5ebtOKR98h8LFm99bKK2vgnR12qbvv8b2+wgr
         suHvBDDhdv2CImIPgDqmVJiaMvpR32Efn+4+ocSnMRrLFt7nH9RO7vLhAtFTqK9yOg9R
         EPIA==
X-Gm-Message-State: AD7BkJKcBFpLciBbMwf12Fh8KsbtsNo4WpikHzvasKEJwqMgDEOvUlXWm6eh29dXXDMq/w==
X-Received: by 10.194.77.193 with SMTP id u1mr172561wjw.73.1459517479547;
        Fri, 01 Apr 2016 06:31:19 -0700 (PDT)
Received: from spirit.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id qb8sm542178wjc.24.2016.04.01.06.31.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Apr 2016 06:31:18 -0700 (PDT)
In-Reply-To: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290534>

On wo, 2016-03-30 at 15:09 +0530, Karthik Nayak wrote:
>=20
> This is part of unification of the commands 'git tag -l, git branch -=
l
> and git for-each-ref'. This ports over branch.c to use ref-filter's
> printing options.
>=20
> Initially posted here: $(gmane/279226). It was decided that this seri=
es
> would follow up after refactoring ref-filter parsing mechanism, which
> is now merged into master (9606218b32344c5c756f7c29349d3845ef60b80c).

Interaction between this series=C2=A0and something I've not yet been ab=
le to
identify seems to break t6302. In f08f64b (the merge commit that merges
this with pu), that test fails. But neither of its parents show the
same failure.

=46ull log of a failing 'make && make test':
https://ci.kaarsemaker.net/git/refs/heads/pu/718c0b31e51ab07181954fb514=
7e3283793553f4/artefact/test/log

Verbose output of the failing test:

expecting success:=C2=A0
	git for-each-ref --format=3D"%(if)%(authorname)%(then)%(authorname): %=
(refname)%(end)" >actual &&
	cat >expect <<-\EOF &&
	A U Thor: refs/heads/master
	A U Thor: refs/heads/side
	A U Thor: refs/odd/spot

	A U Thor: refs/tags/foo1.10
	A U Thor: refs/tags/foo1.3
	A U Thor: refs/tags/foo1.6
	A U Thor: refs/tags/four
	A U Thor: refs/tags/one

	A U Thor: refs/tags/three
	A U Thor: refs/tags/two
	EOF
	test_cmp expect actual

--- expect	2016-04-01 13:28:14.157855026 +0000
+++ actual	2016-04-01 13:28:14.153855026 +0000
@@ -2,6 +2,8 @@
=C2=A0A U Thor: refs/heads/side
=C2=A0A U Thor: refs/odd/spot
=C2=A0
+
+
=C2=A0A U Thor: refs/tags/foo1.10
=C2=A0A U Thor: refs/tags/foo1.3
=C2=A0A U Thor: refs/tags/foo1.6
not ok 34 - check %(if)...%(then)...%(end) atoms
#=09
#		git for-each-ref --format=3D"%(if)%(authorname)%(then)%(authorname):=
 %(refname)%(end)" >actual &&
#		cat >expect <<-\EOF &&
#		A U Thor: refs/heads/master
#		A U Thor: refs/heads/side
#		A U Thor: refs/odd/spot
#=09
#		A U Thor: refs/tags/foo1.10
#		A U Thor: refs/tags/foo1.3
#		A U Thor: refs/tags/foo1.6
#		A U Thor: refs/tags/four
#		A U Thor: refs/tags/one
#=09
#		A U Thor: refs/tags/three
#		A U Thor: refs/tags/two
#		EOF
#		test_cmp expect actual
#=09

expecting success:=C2=A0
	git for-each-ref --format=3D"%(if)%(authorname)%(then)%(authorname)%(e=
lse)No author%(end): %(refname)" >actual &&
	cat >expect <<-\EOF &&
	A U Thor: refs/heads/master
	A U Thor: refs/heads/side
	A U Thor: refs/odd/spot
	No author: refs/tags/double-tag
	A U Thor: refs/tags/foo1.10
	A U Thor: refs/tags/foo1.3
	A U Thor: refs/tags/foo1.6
	A U Thor: refs/tags/four
	A U Thor: refs/tags/one
	No author: refs/tags/signed-tag
	A U Thor: refs/tags/three
	A U Thor: refs/tags/two
	EOF
	test_cmp expect actual

--- expect	2016-04-01 13:28:14.161855026 +0000
+++ actual	2016-04-01 13:28:14.161855026 +0000
@@ -1,7 +1,9 @@
=C2=A0A U Thor: refs/heads/master
=C2=A0A U Thor: refs/heads/side
=C2=A0A U Thor: refs/odd/spot
-No author: refs/tags/double-tag
+No author: refs/tags/annotated-tag
+No author: refs/tags/doubly-annotated-tag
+No author: refs/tags/doubly-signed-tag
=C2=A0A U Thor: refs/tags/foo1.10
=C2=A0A U Thor: refs/tags/foo1.3
=C2=A0A U Thor: refs/tags/foo1.6
not ok 35 - check %(if)...%(then)...%(else)...%(end) atoms
#=09
#		git for-each-ref --format=3D"%(if)%(authorname)%(then)%(authorname)%=
(else)No author%(end): %(refname)" >actual &&
#		cat >expect <<-\EOF &&
#		A U Thor: refs/heads/master
#		A U Thor: refs/heads/side
#		A U Thor: refs/odd/spot
#		No author: refs/tags/double-tag
#		A U Thor: refs/tags/foo1.10
#		A U Thor: refs/tags/foo1.3
#		A U Thor: refs/tags/foo1.6
#		A U Thor: refs/tags/four
#		A U Thor: refs/tags/one
#		No author: refs/tags/signed-tag
#		A U Thor: refs/tags/three
#		A U Thor: refs/tags/two
#		EOF
#		test_cmp expect actual
#=09

expecting success:=C2=A0
	git for-each-ref --format=3D"%(refname:short): %(if)%(HEAD)%(then)Head=
 ref%(else)Not Head ref%(end)" >actual &&
	cat >expect <<-\EOF &&
	master: Head ref
	side: Not Head ref
	odd/spot: Not Head ref
	double-tag: Not Head ref
	foo1.10: Not Head ref
	foo1.3: Not Head ref
	foo1.6: Not Head ref
	four: Not Head ref
	one: Not Head ref
	signed-tag: Not Head ref
	three: Not Head ref
	two: Not Head ref
	EOF
	test_cmp expect actual

--- expect	2016-04-01 13:28:14.165855026 +0000
+++ actual	2016-04-01 13:28:14.165855026 +0000
@@ -1,7 +1,9 @@
=C2=A0master: Head ref
=C2=A0side: Not Head ref
=C2=A0odd/spot: Not Head ref
-double-tag: Not Head ref
+annotated-tag: Not Head ref
+doubly-annotated-tag: Not Head ref
+doubly-signed-tag: Not Head ref
=C2=A0foo1.10: Not Head ref
=C2=A0foo1.3: Not Head ref
=C2=A0foo1.6: Not Head ref
not ok 36 - ignore spaces in %(if) atom usage
#=09
#		git for-each-ref --format=3D"%(refname:short): %(if)%(HEAD)%(then)He=
ad ref%(else)Not Head ref%(end)" >actual &&
#		cat >expect <<-\EOF &&
#		master: Head ref
#		side: Not Head ref
#		odd/spot: Not Head ref
#		double-tag: Not Head ref
#		foo1.10: Not Head ref
#		foo1.3: Not Head ref
#		foo1.6: Not Head ref
#		four: Not Head ref
#		one: Not Head ref
#		signed-tag: Not Head ref
#		three: Not Head ref
#		two: Not Head ref
#		EOF
#		test_cmp expect actual
#=09


# failed 3 among 38 test(s)
1..38
--=20
Dennis Kaarsemaker
www.kaarsemaker.net
