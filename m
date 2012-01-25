From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH v2 3/3] git-p4: Add test case for complex branch import
Date: Wed, 25 Jan 2012 01:23:31 +0000
Message-ID: <CAOpHH-V2nZ8meh7x6vCVGUQCKQqJ+sPcnGRo+8SqfNavg7F87w@mail.gmail.com>
References: <1327105292-30092-1-git-send-email-vitor.hda@gmail.com>
 <1327105292-30092-4-git-send-email-vitor.hda@gmail.com> <7vehutd59p.fsf@alter.siamese.dyndns.org>
 <4F1A98A3.2090607@diamand.org> <20120121171130.GA6235@padd.com>
 <CAOpHH-W1LY3Q50otrcNJTYWN67k_pCZHEOkgbKy7kPgfUbGeQw@mail.gmail.com> <20120123224012.GA10626@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Diamand <luke@diamand.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 02:24:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RprbD-0007Fm-Fd
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 02:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755358Ab2AYBYF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jan 2012 20:24:05 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:36598 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754957Ab2AYBYE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 20:24:04 -0500
Received: by lagu2 with SMTP id u2so419377lag.19
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 17:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=REYw46tHY1+O+JAWGpU5DbXawAXyT05JbupiVjD03j8=;
        b=YU3Ga9PuF3jJTTqjto/ZSeDqDD3oSGZZpnSTzMaItNB7TU076lYN3pSaMX1l4+kO0Z
         7g5/iFPfHpSOun5Na72RULLVIyZ70CSHtn7thjP7BBiubTSRR9nChuO416eIDd6T1mHa
         AgHnHv9sTFTwdPNREnB+xWmLJGRcqI/sCDZwA=
Received: by 10.112.23.230 with SMTP id p6mr3820356lbf.103.1327454642312; Tue,
 24 Jan 2012 17:24:02 -0800 (PST)
Received: by 10.152.105.179 with HTTP; Tue, 24 Jan 2012 17:23:31 -0800 (PST)
In-Reply-To: <20120123224012.GA10626@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189088>

On Mon, Jan 23, 2012 at 10:40 PM, Pete Wyckoff <pw@padd.com> wrote:
> How about taking what's below and just squashing it in. =A0It's
> incremental on your changes and would go well with Luke's series
> that fixes a bunch of scattered quoting issues similarly.
>
> The change to "describe %s" is unnecessary, but makes all the
> invocations look similar. =A0You can leave it out.

I've squashed your patch, but kept the "describe %s" fix in a separate
commit.

>> BTW, and on an unrelated topic, are any test cases failing on your s=
ide?
>
> I do run the tests regularly, and your series is good. =A0There's
> the 'clone --use-client-spec' one that is broken until my
> 2ea09b5 (git-p4: adjust test to adhere to stricter useClientSpec,
> 2012-01-11) is merged. =A0It's on pu.

Tests in t9809-git-p4-client-view.sh were failing for me because I'm
using dash instead of bash. Please check patch below for a fix.

Test 15 of t9800-git-p4-basic.sh is still failing and I've not been abl=
e
to pinpoint the problem. I can send you the logs off-list, if you want.

Thanks,
Vitor



diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view=
=2Esh
index c9471d5..5b0ad99 100755
--- a/t/t9809-git-p4-client-view.sh
+++ b/t/t9809-git-p4-client-view.sh
@@ -31,7 +31,7 @@ client_view() {
 #
 check_files_exist() {
        ok=3D0 &&
-       num=3D${#@} &&
+       num=3D$# &&
        for arg ; do
                test_path_is_file "$arg" &&
                ok=3D$(($ok + 1))
