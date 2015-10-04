From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2 4/4] git-p4: Disable t9819 git-p4-case-folding test on OS X
Date: Sun, 4 Oct 2015 11:38:31 -0700
Message-ID: <E363C89B-7039-49F6-B723-8609DBAF2C64@gmail.com>
References: <1443981977-64604-1-git-send-email-larsxschneider@gmail.com> <1443981977-64604-5-git-send-email-larsxschneider@gmail.com> <xmqqa8ry1ods.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, luke@diamand.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 04 20:38:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZioBF-0001rg-FD
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 20:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbbJDSih convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Oct 2015 14:38:37 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35158 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbbJDSig convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Oct 2015 14:38:36 -0400
Received: by wicge5 with SMTP id ge5so92616821wic.0
        for <git@vger.kernel.org>; Sun, 04 Oct 2015 11:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/P6CznrillVJUCS+ZgTtoOQE21d32yzUY8hgn2LUpn8=;
        b=G+w32C+vJMiGQyQ/+S1aews3RiHeLwErsLpi1Jf6V86CPLR1rKb3ElFE/7gGIvcEdO
         33ulrNy9Pg20AO3osRdqblOYfxwepKlK1jQ6L1BJ5A6y0XIffvFCBKCDQ7JzSkWxJt+o
         kfWzXDF59xJsenk9WWMUvp4ueai7xvm6/wgki9P8SsE+LMk1sAtpNN4WJb7Fs9qNaZm4
         mrA7u/dRgmkE2BX02D9hgqXvg+K8/kBPPgmhHriLcM2qbdHDC1Bs5CjtgShCQG9MQ9O9
         jnAsMr34oaxpfecFSpG602Nw4Zc/FJZ8SYABb5Mxoy6iyxK/jNbniaMLlj9HGCNWZXEt
         my3A==
X-Received: by 10.180.91.194 with SMTP id cg2mr8253886wib.72.1443983915292;
        Sun, 04 Oct 2015 11:38:35 -0700 (PDT)
Received: from remdbq1n32.ads.autodesk.com (adsk-nat-ip3.autodesk.com. [132.188.71.3])
        by smtp.gmail.com with ESMTPSA id xt1sm22774763wjb.32.2015.10.04.11.38.33
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 04 Oct 2015 11:38:34 -0700 (PDT)
In-Reply-To: <xmqqa8ry1ods.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279019>


On 04 Oct 2015, at 11:26, Junio C Hamano <gitster@pobox.com> wrote:

> larsxschneider@gmail.com writes:
>=20
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> The OS X file system is case insensitive by default. Consequently th=
is
>> test does not apply.
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> t/t9819-git-p4-case-folding.sh | 5 +++++
>> 1 file changed, 5 insertions(+)
>>=20
>> diff --git a/t/t9819-git-p4-case-folding.sh b/t/t9819-git-p4-case-fo=
lding.sh
>> index 78f1d0f..c69ae47 100755
>> --- a/t/t9819-git-p4-case-folding.sh
>> +++ b/t/t9819-git-p4-case-folding.sh
>> @@ -4,6 +4,11 @@ test_description=3D'interaction with P4 case-foldin=
g'
>>=20
>> . ./lib-git-p4.sh
>>=20
>> +if test_have_prereq DARWIN; then
>> +	skip_all=3D'skipping P4 case-folding tests; OS X file system is ca=
se insensitive by default'
>> +	test_done
>> +fi
>=20
> Makes one wonder what should happen on Windows, or vfat mounted on
> Linux for that matter.  IOW, shouldn't the prerequisite be more like
> "do not run any of these tests if the filesystem does not allow us
> to have two files in different cases at the same time"?
>=20
> Perhaps
>=20
>        if ! test_have_prereq CASE_INSENSITIVE_FS
>        then
>                skip_all=3D...
>                test_done
>        fi
>=20
> instead, or something?
Agreed! Although I think the =93!=94 in the if clause is not correct.
By the way... what formatting should I use?

if foo
then
  bar

or

if foo; then
  bar

I think the latter is more used in the code base.

- Lars