From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t7006: guard cleanup with test_expect_success
Date: Wed, 14 Apr 2010 20:27:52 -0500
Message-ID: <20100415012752.GA17132@progeny.tock>
References: <20100413021153.GA3978@progeny.tock>
 <20100413021355.GA4118@progeny.tock>
 <7v4ojdpxls.fsf@alter.siamese.dyndns.org>
 <20100415003803.GB14151@progeny.tock>
 <7v7ho9mt3a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 03:28:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Dsa-0003ER-82
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 03:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756171Ab0DOB2S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Apr 2010 21:28:18 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:43689 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756155Ab0DOB2H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 21:28:07 -0400
Received: by ywh32 with SMTP id 32so407599ywh.33
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 18:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=IVHBM07EC+E55rqF1IHCU6NpZDhF643dDRP9v4QIwMk=;
        b=WOZLbkbrXi4EZP/WHWYzwNWSc0fOv7qGtNrEuDRu9x+/w4Fvpzgz22lqU6PGME4GcD
         T70ZqfaifnWjryD+9yfX56SyBf6isDIlmqCjoHjbIldxBzU1VjBbxxc4v3yiGumnnvhR
         dOvvrzW87w2NWnVc8AYOvhraaXl67OupqWlEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=QY3P0vQSAbe4MwwnxEC/fbGgcB7njHDuPKjMi4sCgfkBOBP2yYcYgpCBNZAHYTfpc4
         iIYA7q5mBPuX3edd+LcU4EADyEoaE61khA07ExK9VheagdOm261Doq7YSSlWMzL1dE4E
         VMh5rKvB7kMFFykjgXz56ptNkJxN1sjadhY9A=
Received: by 10.150.194.13 with SMTP id r13mr5963136ybf.284.1271294886282;
        Wed, 14 Apr 2010 18:28:06 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id a1sm540473ibs.18.2010.04.14.18.28.03
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 14 Apr 2010 18:28:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v7ho9mt3a.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144939>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

[...]
>> +cleanup_fail() {
>> +	echo >&2 cleanup failed
>> +	exit 1
>> +}
>
> I think you meant to say "false" or "(exit 1)" here.  To see why...
[...]
> ... try your patch with "rm -f stdout_is_tty" replaced with "(exit 1)=
" to
> see how your cleanup_fail behaves.

Good catch; thanks.  Here=E2=80=99s a patch for squashing in case you w=
ould
like one.

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 62595ab..a3d0210 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -6,7 +6,7 @@ test_description=3D'Test automatic use of a pager.'
=20
 cleanup_fail() {
 	echo >&2 cleanup failed
-	exit 1
+	return 1
 }
=20
 test_expect_success 'set up terminal for tests' '
