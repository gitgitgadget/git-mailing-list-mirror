From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] parse-remote: replace unnecessary sed invocation
Date: Wed, 30 Mar 2011 18:02:08 -0700
Message-ID: <AANLkTin3R8ApTZ97Cw67dN7_s_ycX8sQThypMq2N6eJi@mail.gmail.com>
References: <1301474920-6718-1-git-send-email-bebarino@gmail.com> <AANLkTikBD4T3hdyT2h=2dzw-QO1BnBp3eT=WGj5s5dC3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Schubert <mschub@elegosoft.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 03:02:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q56HO-0000iJ-Cx
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 03:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933256Ab1CaBCY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Mar 2011 21:02:24 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51481 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932212Ab1CaBCY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Mar 2011 21:02:24 -0400
Received: by gwaa18 with SMTP id a18so776737gwa.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 18:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=VmE2l24mNj6R/e6eJRVrobHd5NiYpmKtpL1RTDADy/0=;
        b=TvFvAMPPieiwOXx188SFIanxk5NhK/IxV9He2ebJgDA5JflyP8TRllUlV4S8ZWinUE
         58xUU753tjZGsvn5/2DpqTG5IWIRcenc+CAi1ERRJNp4vjf5D3Xe82m7hgVEndWEdlVx
         PhzllB1+Oxan4sQymrjWwrz3Op6z+JAmy5iRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=K1UiX0u1QMMstyipSHzEwB1nTH3WU5UdKJkxqHkYVot+zGkI2lC43IKhBwzwrMRj6J
         VMWGWImizNlzzmAFgzAxnleRgeoyPUrmTxAh2+oVG3t3Eka+nKBHQK1Wex+99G5u2iar
         ln08/eGnzqJjvQcsWRp/VNDw4Ee7bpz0FesNE=
Received: by 10.236.192.138 with SMTP id i10mr2856841yhn.255.1301533343094;
 Wed, 30 Mar 2011 18:02:23 -0700 (PDT)
Received: by 10.236.105.143 with HTTP; Wed, 30 Mar 2011 18:02:08 -0700 (PDT)
In-Reply-To: <AANLkTikBD4T3hdyT2h=2dzw-QO1BnBp3eT=WGj5s5dC3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170435>

On Wed, Mar 30, 2011 at 11:31 AM, Michael Schubert <mschub@elegosoft.co=
m> wrote:
>> + =C2=A0 =C2=A0 =C2=A0 curr_branch=3D$(git symbolic-ref -q HEAD)
>> + =C2=A0 =C2=A0 =C2=A0 curr_branch=3D"${cur_branch#refs/heads/}"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ^^^

Ah! How did this pass the test suite... Anyway, looks like Junio
applied this patch to maint already :-( Sorry.

Junio, please apply this (probably word wrapped since this is gmail
interface) and drop your trust level of me by a few points.

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 9168879..ea093d2 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -6,7 +6,7 @@ GIT_DIR=3D$(git rev-parse -q --git-dir) || :;

 get_default_remote () {
        curr_branch=3D$(git symbolic-ref -q HEAD)
-       curr_branch=3D"${cur_branch#refs/heads/}"
+       curr_branch=3D"${curr_branch#refs/heads/}"
        origin=3D$(git config --get "branch.$curr_branch.remote")
        echo ${origin:-origin}
 }
