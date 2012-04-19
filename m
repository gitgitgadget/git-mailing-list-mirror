From: Junio C Hamano <jch@google.com>
Subject: Re: [PATCH v7 4/4] git-rebase: add keep_empty flag
Date: Thu, 19 Apr 2012 11:59:31 -0700
Message-ID: <xmqqty0fv97w.fsf@junio.mtv.corp.google.com>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
	<1334776680-23460-1-git-send-email-nhorman@tuxdriver.com>
	<1334776680-23460-5-git-send-email-nhorman@tuxdriver.com>
	<4F8FE2CD.3070300@in.waw.pl> <873980q6vm.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Neil Horman <nhorman@tuxdriver.com>, <git@vger.kernel.org>,
	"Clemens Buchacher" <drizzd@aon.at>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Apr 19 20:59:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKwZx-0003gG-Si
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 20:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756171Ab2DSS7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 14:59:37 -0400
Received: from mail-wi0-f202.google.com ([209.85.212.202]:58395 "EHLO
	mail-wi0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756058Ab2DSS7g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 14:59:36 -0400
Received: by wibhj13 with SMTP id hj13so115631wib.1
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 11:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ph594X1/X+WoNOdHElULka8N/MUouZFYTGotpidH/7Q=;
        b=p1oU9xpI+ZdW42YYb3rkbaD2U6jrY4y8sc3pK65SU0RDE0vtkjWLGLagNjIWEFwhwW
         GiFZ8EI5V8SwcM7NXtgM2JOomf6lKClBOIbn9PLW6eAx7vp0PxqAlM4aj+paprFCLBww
         B2Wuv7Ileodf/oqfm0I4kugWiv/Y12KTKR8e6nYes4okmhvNFOjvEJv6Cda+06Ppk9Gw
         hgbfuOhixjU+TG3EIBnLqavuFgdXGWvx/jYCRnCuCnRP6vjg9FxmNRUuvhAFEYqp6R4k
         Q1ayMi7ttexGkFn7idWCQi1XrYdXs55FII6QTKZNxnGYodjfJgwsvYbNwLtKP7RZkfrO
         x77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=ph594X1/X+WoNOdHElULka8N/MUouZFYTGotpidH/7Q=;
        b=QXsecn1oQitNGgxgMR0vJ33zhv28a3zcWwGlelnmseeGrrzSVXbCcBrQgucFiUyS4c
         Wc5FyPF40soXNiXB109aq1zNIN/0k6yKY9jqQEEZIiUJMnbsYPVG2+3bUsEy+GEt6Dj/
         kIcC0e3JnwB0FbA3mCPeMtpzrrSuI3ZObq2OQTCjUMHGHxeNUr1/Etjr4SpgulBX1hSh
         UsFlbsclDiB6APvSku2BmVTrQ1GfarU7uv0xs3HWiQqdvNZZJBkvAmx3wIzh20OVIbTT
         pElDi7Ca3iZD8n09RVElFgHX7/X+wukoaIcfn8r9u2/qwHyc+FigRa1AJVO+R62f2GpX
         RsIg==
Received: by 10.14.47.80 with SMTP id s56mr914656eeb.6.1334861975670;
        Thu, 19 Apr 2012 11:59:35 -0700 (PDT)
Received: by 10.14.47.80 with SMTP id s56mr914633eeb.6.1334861975539;
        Thu, 19 Apr 2012 11:59:35 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id y52si2918062eef.2.2012.04.19.11.59.35
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 19 Apr 2012 11:59:35 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 586835C0050;
	Thu, 19 Apr 2012 11:59:35 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 78361E1209; Thu, 19 Apr 2012 11:59:34 -0700 (PDT)
In-Reply-To: <873980q6vm.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
	"Thu, 19 Apr 2012 13:49:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQnPtXXqLSCK6nwAU1OgiAdOjgUGy/Z6/Tf31dS3ookoKLKDOrVNE+a8nWmYXuZX7zH7/euhAjAcc4XYrqT1lbwdXZlUULwhb+GxAmw70iqcj/szFFIJn3Tn0a+OX1hP26+L6xdbDuGSZ0fo15cw4Kl8X3xL24T44MtYvSawQc3ernKcU6w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195963>

Thomas Rast <trast@student.ethz.ch> writes:

> Either way, it should simply be spelled as
>
> is_empty_commit() {
> 	tree=$(git rev-parse "$1"^{tree})
> 	ptree=$(git rev-parse "$1"^^{tree})
> 	test "$tree" = "$ptree"
> }

Thanks; will squash in something like this:

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 82042b1..8fe304f 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -168,9 +168,10 @@ has_action () {
 }
 
 is_empty_commit() {
-	tree=$(git rev-parse "$1"^{tree})
-	ptree=$(git rev-parse "$1"^^{tree})
-	return $(test "$tree" = "$ptree")
+	tree=$(git rev-parse "$1"^{tree} 2>/dev/null) &&
+	ptree=$(git rev-parse "$1"^^{tree} 2>/dev/null) ||
+		die "$1: not a commit that can be picked"
+	test "$tree" = "$ptree"
 }
 
 # Run command with GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
