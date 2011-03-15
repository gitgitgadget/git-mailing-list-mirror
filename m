From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] make_absolute_path: Don't try to copy a string to
 itself
Date: Tue, 15 Mar 2011 10:02:12 -0700
Message-ID: <7vd3lsb9m3.fsf@alter.siamese.dyndns.org>
References: <1300130318-11279-1-git-send-email-cmn@elego.de>
 <1300130318-11279-2-git-send-email-cmn@elego.de>
 <7v39mpcuv9.fsf@alter.siamese.dyndns.org>
 <1300140128.4320.39.camel@bee.lab.cmartin.tk>
 <7vpqptb976.fsf@alter.siamese.dyndns.org>
 <1300190396.19100.31.camel@bee.lab.cmartin.tk>
 <1300192832.19100.35.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 18:02:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzXdf-0002Ao-Pi
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 18:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453Ab1CORC0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Mar 2011 13:02:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65485 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932357Ab1CORCZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Mar 2011 13:02:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4295549A8;
	Tue, 15 Mar 2011 13:03:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Q5+uJPTDNbWZ
	vw7wGgVLW89OuJ4=; b=HRsOdZfDx2gqN3GdSwCWvb2slzRlnGP98Q3x71vAdXFi
	2IFseAENU7PPxEBZqFEiVrQ/5P5brEeyh+T6P4WPCbVzu697aWcN+eGFPZ8Lm49P
	NQTFhSiusvaoWFB/17OATwdP4yYbbwA9JrDCNKDtuLNEVDBOgX5L712oqKEkbrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mJUBlw
	CdII3G8DwBqHv6CElyNXLNMczFZ3zncyykzMdZ/87Q94UmNdTF0fMLDSkr0PXnwm
	AELLgtvCVmPuSv3AeIxsl8go7QL2oBj7dQME+uyRzXdSiDccMGbKyAFWDU1MRsIW
	TYpBA23QDRjZlhSY/3m0rfFd90S3H2gQE+TfI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1101849A6;
	Tue, 15 Mar 2011 13:03:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DBE0849A5; Tue, 15 Mar 2011
 13:03:46 -0400 (EDT)
In-Reply-To: <1300192832.19100.35.camel@bee.lab.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Tue, 15 Mar 2011 13:40:31
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 33588420-4F26-11E0-B1A7-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169076>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> On mar, 2011-03-15 at 12:59 +0100, Carlos Mart=C3=ADn Nieto wrote:
>> On lun, 2011-03-14 at 15:58 -0700, Junio C Hamano wrote:
>> > Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
> [...]
>> >=20
>> > >  There is however the extra functionality the function offers, n=
amely
>> > > resolving links. It might be good to split it into two functions=
 so each
>> > > caller can specify what it wants.
>> >=20
>> > Probably.
>>=20
>>  With the changes mentioned earlier, if you want an absolute pathnam=
e,
>> you'd call absolute_path/make_nonrelative_path and if you want to ma=
ke
>> sure you have the real path of the target file, you'd use real_path =
just
>> as you'd use realpath on a sane system, with
>
>  ... a comment on the functions and maybe some documentation in
> Documentation/techncal, as it doesn't seem to exist yet.

We probably should involve Nguy=E1=BB=85n in this thread as his fingers=
 are
everywhere on the codepaths related to setup.
