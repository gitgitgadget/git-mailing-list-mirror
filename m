From: Lucian Poston <lucian.poston@gmail.com>
Subject: Re: [PATCH v3 4/7] t4052: Adjust --graph --stat output for prefixes
Date: Tue, 17 Apr 2012 19:23:49 -0700
Message-ID: <CACz_eyfvC9OWwBscCTHVvs+udRW5_QUReZnxpPVWSrL1MAC6rA@mail.gmail.com>
References: <1334573095-32286-1-git-send-email-lucian.poston@gmail.com>
	<1334573095-32286-5-git-send-email-lucian.poston@gmail.com>
	<7vzkabtsw9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 04:23:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKKYl-0003fj-Ov
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 04:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570Ab2DRCXv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 22:23:51 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58342 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512Ab2DRCXu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 22:23:50 -0400
Received: by pbcun15 with SMTP id un15so8347631pbc.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 19:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=SOLLPfjAbsTTe9fhTM7ofKXzFS0YMkl7r1BygBhl87E=;
        b=xC5hh1Y4N9uERVhx7DbBMT2rfYBCQjgRccu+6iezgkBSkuSuLi1PDolQMwLs1JM6Du
         8nejaOHJZgKxUN9h1E7iyROjQjQzJuKkYKUfHoaREukyGkl1gO0wZY8faVzVFyctEDlY
         X7n36WrUHik5EVZOp64N+HJtrqgwBgyJLThQ2w5cfGzTI1z/Vwcpk3lErKYiUnkp9htH
         +o10zEuiUMIri14Ux6X6NHj3mM/i97m2HwtKqbzrZjRnWmNhgHLJTFCw7+iTBQ9aO/xc
         jR7/YXWHZnbMwyZiU4EtO2VUhL+BLx9sTRBsPfhGnOn5Ho/T2pjX/+HDKRwnD2k23VPF
         9iXQ==
Received: by 10.68.222.38 with SMTP id qj6mr2228767pbc.69.1334715829769; Tue,
 17 Apr 2012 19:23:49 -0700 (PDT)
Received: by 10.68.58.129 with HTTP; Tue, 17 Apr 2012 19:23:49 -0700 (PDT)
In-Reply-To: <7vzkabtsw9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195828>

On Mon, Apr 16, 2012 at 11:48, Junio C Hamano <gitster@pobox.com> wrote=
:
>> @@ -117,7 +117,7 @@ cat >expect40 <<'EOF'
>> =C2=A0 abcd | 1000 ++++++++++++++++++++++++++
>> =C2=A0EOF
>> =C2=A0cat >expect40-graph <<'EOF'
>> -| =C2=A0abcd | 1000 ++++++++++++++++++++++++++
>> +| =C2=A0abcd | 1000 ++++++++++++++++++++++++
>> =C2=A0EOF
>> =C2=A0while read verb expect cmd args
>> =C2=A0do
>> @@ -127,12 +127,6 @@ do
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_cmp "$expect" =
actual
>> =C2=A0 =C2=A0 =C2=A0 '
>>
>> - =C2=A0 =C2=A0 test_expect_success "$cmd $verb statGraphWidth confi=
g" '
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git -c diff.statGraphWid=
th=3D26 $cmd $args >output
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 grep " | " output >actua=
l &&
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_cmp "$expect" actua=
l
>> - =C2=A0 =C2=A0 '
>> -
>
> This is unclear. =C2=A0Why does this need to be removed?

This test was actually only moved. There were 4 test_expect_success in
a while loop -- 2 tested COLUMNS=3D40, and 2 tested
diff.statGraphWidth=3D26. I moved the two tests for diff.statGraphWidth
to a new while loop. expect40-graph varies between these two sets of
tests, so I thought it cleaner to separate them so that the
expectation could be defined separately.
