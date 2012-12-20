From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: RFC: "git config -l" should not expose sensitive information
Date: Thu, 20 Dec 2012 16:51:37 +0100
Message-ID: <50D33409.1050309@alum.mit.edu>
References: <50CF039A.7010800@gmx.de> <20121220150408.GD27211@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 20 16:52:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TliPl-0005ls-PU
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 16:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741Ab2LTPvs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Dec 2012 10:51:48 -0500
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:53186 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751610Ab2LTPvq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Dec 2012 10:51:46 -0500
X-AuditID: 1207440c-b7f196d0000008bc-56-50d33410ae38
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 1F.09.02236.01433D05; Thu, 20 Dec 2012 10:51:44 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qBKFpdKw019289
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 20 Dec 2012 10:51:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20121220150408.GD27211@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsUixO6iqCtgcjnAYNESSYuuK91MFj9aepgt
	rk9dw+jA7PHhY5zHs949jB6fN8kFMEdx2yQllpQFZ6bn6dslcGfs3XuDtWAWd8XGnv2MDYz/
	OLoYOTkkBEwk1i2/wgRhi0lcuLeerYuRi0NI4DKjxOmv76Cc40wSbY/+soBU8QpoS/zc1w3W
	wSKgKtH2aR6YzSagK7GopxnMFhUIkFi85Bw7RL2gxMmZT8B6RQRkJb4f3sgIYjMLREu0XnrK
	BmILC3hKbJ/TCWYLCYRIfPu9m7mLkYODU8Ba4vgXQxCTWUBdYv08IYhOeYnmrbOZJzAKzEKy
	YBZC1SwkVQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrq5WaW6KWmlG5ihIQtzw7Gb+tk
	DjEKcDAq8fAunHYpQIg1say4MvcQoyQHk5Io7wejywFCfEn5KZUZicUZ8UWlOanFhxglOJiV
	RHhztYByvCmJlVWpRfkwKWkOFiVxXtUl6n5CAumJJanZqakFqUUwWRkODiUJ3mMgQwWLUtNT
	K9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBURpfDIxTkBQP0N4fIO28xQWJuUBRiNZTjMYc
	DS9vPGXkuNVw8ymjEEtefl6qlDjvTJBSAZDSjNI8uEWwhPWKURzob2HeXyBVPMBkBzfvFdAq
	JqBVQXoXQFaVJCKkpBoYnXc3fVIQfSx5b9uqZYszX/Hs8c2a2ZtVJ3tLaEu7wQL5pXs8HrDP
	ZYi5VPd+xu1ZtzR1n5jd7rnB+0G4kFuq1uzMRp7cyFD72ANTP3yZrbV3/pOLRrf+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211900>

On 12/20/2012 04:04 PM, Jeff King wrote:
> On Mon, Dec 17, 2012 at 12:35:54PM +0100, Toralf F=C3=B6rster wrote:
>> often the output is requested in help forums - and a
>> "git config -l | wgetpaste" exposes parameters like sendmail.smtppas=
s -
>> so hide those variables in the output (if not explicitly wanted) wou=
ld
>> makes sense, or ?
>=20
> But if we change "git config -l", won't that break all of the
> non-exposing uses that rely on seeing all of the variables (e.g., it =
is
> perfectly fine for a porcelain to parse "git config -l" rather than
> making several calls to "git config"; IIRC, git-cola does this).
>=20
> The problem seems to be that people are giving bad advice to tell peo=
ple
> to post "git config -l" output without looking at. Maybe we could hel=
p
> them with a "git config --share-config" option that dumps all config,
> but sanitizes the output. It would need to have a list of sensitive k=
eys
> (which does not exist yet), and would need to not just mark up things
> like smtppass, but would also need to pull credential information out=
 of
> remote.*.url strings. And maybe more (I haven't thought too long on i=
t).

I think the problem is yet another step earlier: why do we build tools
that encourage people to store passwords in plaintext in a configuratio=
n
file that is by default world-readable?

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
