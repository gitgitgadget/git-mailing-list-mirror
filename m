From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] init - Honour the global core.filemode setting
Date: Thu, 02 Oct 2014 10:02:02 -0700
Message-ID: <xmqqzjdeo16d.fsf@gitster.dls.corp.google.com>
References: <CAE1pOi0zhnUNNdHsrq+4H_6LiFnr-qoY-owrcJquy6dyG+Mk4g@mail.gmail.com>
	<5427F68E.5030003@web.de>
	<CAE1pOi1dAO7XFZtrgZyNm-eLVKQx=KpeejbGmF8khCofAppDLg@mail.gmail.com>
	<xmqqy4szpvfv.fsf@gitster.dls.corp.google.com>
	<542D33E1.6080709@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Oct 02 19:02:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZjld-00047C-MI
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 19:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753995AbaJBRCI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Oct 2014 13:02:08 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62173 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753129AbaJBRCG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Oct 2014 13:02:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A016B3EEDB;
	Thu,  2 Oct 2014 13:02:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1pyWcgj+XA6+
	9bB/rI9mARD+Bb8=; b=ooF/bmRqN2RsvTgTf7JfYpnCmyUvPvUScTeNLUPoL9iv
	BkJm7YI+QQQUuV8ltrDCQoBdiu9EPFeY5lZSNSiZo8TpCi7QuRNXnDlcQTnLR+A9
	4P9O5YIOBbVY691bKaH2GfvWPX86vPcc6nEtOTPMoLEWGnbIVnSjfwzLkCSV3Us=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hfMP29
	UWh5qjCQQ83ZD0XlcOlh6+HGqp2V+PF7vTsco4w9anJ/IsFtsd+HW3L4UUrLrgUF
	5CKATMgco3wtS2JXd1Yq6V/I1+iADBK4LX+KwlIAMF+QOAm+L7NUWgcn4EjpEFrk
	JmjTSHOdDsd/mQ82hCPKEZ6TXuayi+ZGPr1zY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9594E3EEDA;
	Thu,  2 Oct 2014 13:02:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D37DA3EED8;
	Thu,  2 Oct 2014 13:02:04 -0400 (EDT)
In-Reply-To: <542D33E1.6080709@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Thu, 02 Oct 2014 13:15:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D5DEB826-4A55-11E4-AEBC-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257812>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 2014-10-01 19.10, Junio C Hamano wrote:
>> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>>=20
>>> Perhaps I completely misunderstand the meaning of core.filemode but=
 I
>>> thought it determined whether Git cared about changes in file
>>> properties?
>>=20
>> By setting it to "false", you tell Git that the filesystem you
>> placed the repository does not correctly represent the filemode
>> (especially the executable bit).
>>=20
>> "core.fileMode" in "git config --help" reads:
>>=20
>>        core.fileMode
>>            If false, the executable bit differences between the
>>            index and the working tree are ignored; useful on broken
>>            filesystems like FAT. See git-update- index(1).
>
> Out of my head: Could the following be a starting point:
>
>         core.fileMode
>             If false, the executable bit differences between the
>             index and the working tree are ignored.
>             This may be usefull when visiting a cygwin repo with a no=
n-cygwin
>             Git client. (should we mention msysgit ? should we mentio=
n JGit/EGit ?)

Between these two sentences, there may still be the same cognitive
gap that may have lead to the original confusion.

The first sentence says what happens, as it should.

But it is not directly clear what makes the executable bit differ
and when it is a useful thing to ignore the differences, so the
second sentence that says "This may be useful" does not give the
reader very much.

Here is my attempt.

	Tells Git if the executable bit of files in the working tree
	is to be honored.

	Some filesystems lose the executable bit when a file that is
	marked as executable is checked out, or checks out an
	non-executable file with executable bit on.  "git init" and
	"git clone" probe the filesystem to see if it records
	executable bit correctly when they create a new repository
	and this variable is automatically set as necessary.

        A repository, however, may be on a filesystem that records
        the filemode correctly, and this variable is set to 'true'
        when created, but later may be made accessible from another
        environment that loses the filemode (e.g. exporting ext4 via
        CIFS mount, visiting a Cygwin managed repository with
        MsysGit).  In such a case, it may be necessary to set this
        to 'false'.
