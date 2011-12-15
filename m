From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: [bug?] checkout -m doesn't work without a base version
Date: Thu, 15 Dec 2011 11:11:37 +0100
Message-ID: <4EE9C7D9.8020407@elegosoft.com>
References: <4EDBF4D5.6030908@pcharlan.com> <7vbormn8vk.fsf@alter.siamese.dyndns.org> <4EE8782A.9040507@elegosoft.com> <7vhb13qbs6.fsf@alter.siamese.dyndns.org> <buoipli8nzy.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Pete Harlan <pgit@pcharlan.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Dec 15 11:13:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rb8JA-00017C-Au
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 11:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469Ab1LOKMy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Dec 2011 05:12:54 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:51226 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758754Ab1LOKMw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 05:12:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 09352DE8C8;
	Thu, 15 Dec 2011 11:12:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LKGXvDb1Q2QZ; Thu, 15 Dec 2011 11:12:46 +0100 (CET)
Received: from [192.168.1.101] (e178178079.adsl.alicedsl.de [85.178.178.79])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 3F775DE8C7;
	Thu, 15 Dec 2011 11:12:46 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111108 Thunderbird/8.0
In-Reply-To: <buoipli8nzy.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187202>

On 12/15/2011 05:20 AM, Miles Bader wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>>> builtin/checkout.c: In function =E2=80=98cmd_checkout=E2=80=99:
>>> builtin/checkout.c:210:5: warning: =E2=80=98mode=E2=80=99 may be us=
ed uninitialized
>>> in this function [-Wuninitialized]
>>> builtin/checkout.c:160:11: note: =E2=80=98mode=E2=80=99 was declare=
d here
>>
>> Isn't this just your gcc being overly cautious (aka "silly")?
>>
>> The variable "mode" is assigned to when we see an stage #2 entry in =
the
>> loop, and we should have updated threeway[1] immediately before doin=
g so.
>> If threeway[1] is not updated, we would have already returned before=
 using
>> the variable in make_cache_entry().
>=20
> Maybe that is actually guaranteed (I dunno), but it's certainly not
> obvious from the code here, even to a human... any guarantee would
> have to come from external invariants that the compiler doesn't know
> about.
>=20
> Given that, I think it's a fair warning, certainly not "silly."  This
> aspect of the code doesn't seem easy to understand...

Silly or not: That's what gcc 4.6.x is warning about with -Wuninitializ=
ed
(-Wall) set - I didn't set any additional options, just plain `make all=
`.
