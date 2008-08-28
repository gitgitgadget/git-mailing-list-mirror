From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] dir.c: avoid c99 array initialization
Date: Thu, 28 Aug 2008 11:50:32 -0700
Message-ID: <7vhc95dldz.fsf@gitster.siamese.dyndns.org>
References: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil> <G-ipWASixyGW7nvO1KquifehvBB7FNKwjPtIB0ukyEJ1Si1CJWM34w@cipher.nrlssc.navy.mil> <871w09kvew.fsf@lysator.liu.se> <GwKOGVPR0AVw4_Phmw1TSNzzMDtafrawMMahm2DQwh44k6uTOHkjTQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Aug 28 20:54:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYmav-00027P-W0
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 20:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbYH1Sul convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Aug 2008 14:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752675AbYH1Sul
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 14:50:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54513 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbYH1Suk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Aug 2008 14:50:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A13A65500B;
	Thu, 28 Aug 2008 14:50:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E03D155008; Thu, 28 Aug 2008 14:50:35 -0400 (EDT)
In-Reply-To: <GwKOGVPR0AVw4_Phmw1TSNzzMDtafrawMMahm2DQwh44k6uTOHkjTQ@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Thu, 28 Aug 2008 11:45:52 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3571CCB0-7532-11DD-97E4-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94113>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> David K=C3=A5gedal wrote:
>> Brandon Casey <casey@nrlssc.navy.mil> writes:
>>=20
>>> The following syntax:
>>>
>>>         char foo[] =3D {
>>>                 [0] =3D 1,
>>>                 [7] =3D 2,
>>>                 [15] =3D 3
>>>         };
>>>
>>> is a c99 construct which some compilers do not support even though =
they
>>> support other c99 constructs. Use an alternative.
>>=20
>> But the alternative is much worse.
>
> _Much_ worse? In what way?
>
> From an execution standpoint, I don't think any more work is performe=
d.
> Probably exactly the same amount of work.
>
> From a readability standpoint, I think it is very nearly the same in
> this case. The whole function is only 17 lines.

I do not think your patch deserves "much worse" comment.

>> So how important is it to support non-C99 compilers?
>
> I think it is relative to the amount of effort it takes. If there is
> a demonstrated need and a trivial work around, I think it is worth
> it to support non-c99 compilers.

I do not mind taking this patch.  While it would not hurt (because the
code is readable with or without the change) to convert the trivial one=
s
like this patch addresses, it would not help portability if there are m=
ore
nontrivial dependance to c99 constructs in other places in the code.  A=
re
there known ones?
