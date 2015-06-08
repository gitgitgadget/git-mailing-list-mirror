From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] fsck: report errors if reflog entries point at invalid
 objects
Date: Mon, 08 Jun 2015 17:09:48 +0200
Message-ID: <5575B03C.6040008@alum.mit.edu>
References: <cover.1433769878.git.mhagger@alum.mit.edu> <2ba9ee48a062b049c8b64fed4caba32c42f03031.1433769878.git.mhagger@alum.mit.edu> <e9d2f8cc371aa41e5d9095abd3cb7edb@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 08 17:10:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1ygd-0006H7-GR
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 17:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbbFHPJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 11:09:58 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:47877 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752220AbbFHPJ5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 11:09:57 -0400
X-AuditID: 12074411-f796c6d000000bc9-67-5575b03ec98e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id FE.46.03017.E30B5755; Mon,  8 Jun 2015 11:09:50 -0400 (EDT)
Received: from [192.168.69.130] (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t58F9mtk026463
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 11:09:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <e9d2f8cc371aa41e5d9095abd3cb7edb@www.dscho.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqGu3oTTUYMkGM4uuK91MFg29V5gt
	+pd3sVn8aOlhdmDx+PAxzuNZ7x5Gj4uXlD0+b5ILYInitklKLCkLzkzP07dL4M6Y3HiPueAG
	e0XPjV/sDYyNbF2MnBwSAiYSp791sUPYYhIX7q0HinNxCAlcZpRY1LUSyjnPJPH17jtGkCpe
	AW2JMysfAXVwcLAIqErMuZIDEmYT0JVY1NPMBBIWFQiSeP0yF6JaUOLkzCcsILYI0K55L9aA
	2cwC8RKbJk9gBikXFoiUOLUuDmLTdkaJ3y8egN3GKWArsXLeNXaIej2JHdd/sULY8hLNW2cz
	T2AUmIVkxSwkZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuql5tZopeaUrqJERLK
	gjsYZ5yUO8QowMGoxMN7YFFJqBBrYllxZe4hRkkOJiVR3nnrS0OF+JLyUyozEosz4otKc1KL
	DzFKcDArifAmTwfK8aYkVlalFuXDpKQ5WJTEefmWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeA+B
	DBUsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHxWl8MTBSQVI8QHu7QNp5iwsSc4Gi
	EK2nGHU57kz5v4hJiCUvPy9VSpw3EKRIAKQoozQPbgUscb1iFAf6WJj37DqgKh5g0oOb9Apo
	CRPQku9fi0GWlCQipKQaGLfeMNO9Jd+rdp05Qkt29QRGn8uz7lxdG/B7vbnAWZZF04sfhZ25
	rCHC5PvTP9c7sKvXPluMf1nZ76yZjxml1OdE/FL4IGDqu7OKsWPf+ryb/H7TC/9w 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271044>

On 06/08/2015 04:27 PM, Johannes Schindelin wrote:
> On 2015-06-08 08:40, Michael Haggerty wrote:
>> Previously, if a reflog entry's old or new SHA-1 was not resolvable
>> to an object, that SHA-1 was silently ignored. Instead, report such
>> cases as errors.
> 
> I like the idea, but I am a bit uncertain whether it would constitute
> "too backwards-incompatible" a change to make this an error. I think
> it could be argued both ways: it *is* an improvement, but it could
> also possibly disrupt scripts that work pretty nicely at the moment.

What kind of script are you worried about? One that mucks around inside
the object database / reflog files? If people do that, all bets are off,
no? Plus,

* This change only causes fsck to output an extra line (and exit with
  a a non-zero retcode).

* Repair is only a

      git reflog expire --expire-unreachable=now --all

  away, I think.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
