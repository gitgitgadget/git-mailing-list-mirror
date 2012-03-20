From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9 v2] difftool: teach command to perform directory
 diffs
Date: Mon, 19 Mar 2012 22:52:44 -0700
Message-ID: <7v4ntj95ub.fsf@alter.siamese.dyndns.org>
References: <1331949442-15039-1-git-send-email-tim.henigan@gmail.com>
 <1332035734-5443-1-git-send-email-tim.henigan@gmail.com>
 <7vhaxk9ui6.fsf@alter.siamese.dyndns.org>
 <CAJDDKr74cLSfj9JCeQQcm8U_26Re0u0nueoQ3nvj0O4FWBsqxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 06:52:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9s05-00034x-JR
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 06:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975Ab2CTFwt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Mar 2012 01:52:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37992 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751729Ab2CTFws convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Mar 2012 01:52:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBBBE50EE;
	Tue, 20 Mar 2012 01:52:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wEA9XDm7bvYY
	zx8VqcTRzMP2Kng=; b=ujjYaKtvoAglEHSwqbiCwyGaTHL18Vw8S3/XNIgU1c3C
	gVdzLeeKUJg0NgrSugbpHVbQf0ayKVlwWVMSCdV/DjDelfjA55nxyv2PFMvZ0ilT
	HXBtF4guAWVJFwP+geWlhoEa723tsQJaT+As3PrDlUN9tUDb0AuI8/cKSlT0KbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=COUiVE
	yzgjyAJ51pdMRf2iSV/dy0yzndnxvsUDuBe1pY7m9WjxMjpPxh/d3cWxg7TXvFbv
	cJUv9N0DJviJ0l6oAtOShdQ+iaVtlGRu5n2QgaShzAhWe5xmIBH+LePbDwq+vXU+
	9WiL/sFiWQP4Lj+hJnQA1TISta/k23VmOJ4IE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E209050ED;
	Tue, 20 Mar 2012 01:52:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64AB050EB; Tue, 20 Mar 2012
 01:52:46 -0400 (EDT)
In-Reply-To: <CAJDDKr74cLSfj9JCeQQcm8U_26Re0u0nueoQ3nvj0O4FWBsqxg@mail.gmail.com> (David
 Aguilar's message of "Mon, 19 Mar 2012 19:52:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB0C5850-7250-11E1-A74E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193485>

David Aguilar <davvid@gmail.com> writes:

> On Mon, Mar 19, 2012 at 2:00 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Thanks.
>>
>> I do not know a difftool user, and I wasn't paying close attention t=
o the
>> discussion but I recall these points raised and I do not recall the
>> resolutions:
>>
>> =C2=A0* In [1/9], use of pass_through would mean 'git difftool' must=
 be fed the
>> =C2=A0 options for difftool and then options meant for underlying di=
ff
>> =C2=A0 machinery. =C2=A0Is this limitation still there? =C2=A0If so,=
 isn't this a
>> =C2=A0 regression? =C2=A0Shouldn't it at least be advertised to the =
users a lot
>> =C2=A0 stronger in documentation?
>
> Tim asserted that this is not the case.  The options should pass
> through.  Hopefully there aren't any behavior changes between perl
> versions and this option.
>
> I sent a patch adding a test case to cover this scenario.  I would
> prefer that we avoid a regression.  If there's a regression then we
> can do without Getopt::Long, IMO.

Yeah.  Does tonight's 'pu' pass for you?

> I do not have Windows to test with, but this supposedly works since
> Git.pm does not use git.exe either.

Yeah, that matches my guess.

>> =C2=A0* In [7/9], difftool--helper declares SUBDIRECTORY_OK, but the=
re doesn't
>> =C2=A0 seem to be any inclusion of git-sh-setup in this script, and =
the patch
>> =C2=A0 does not have any effort to prepend $prefix to paths relative=
 to $cwd.
>> =C2=A0 What good does the variable do here?
>
> I'll defer to Tim on this one.  This seems like an oversight.  It
> seems like something should be done to handle it.

Well, it does not seem to dot-source git-sh-setup so it probably stays
where it was launched, so in that case there is nothing that needs to b=
e
done, including SUBDIRECTORY_OK which nobody would look at IIRC.

> Also.. I think we need some tests to cover the new behavior.  A test
> to cover the subdirectory behavior would be especially helpful given
> the note about [7/9].

Yeah, that makes sense.
