From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 20/24] update-index: test the system before enabling untracked cache
Date: Wed, 21 Jan 2015 10:51:02 -0800
Message-ID: <xmqqvbk0vug9.fsf@gitster.dls.corp.google.com>
References: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
	<1421759013-8494-21-git-send-email-pclouds@gmail.com>
	<xmqqwq4gy1nq.fsf@gitster.dls.corp.google.com>
	<CACsJy8CDgUWEE=QKAgw4G8pgA-cOmLMs4sH67C47Ohd5XJQDNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 19:51:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE0Mz-0007de-Qb
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 19:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbbAUSvK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2015 13:51:10 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57717 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752144AbbAUSvH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2015 13:51:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C35F72FC0F;
	Wed, 21 Jan 2015 13:51:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=UVnDDKRKquIc
	NpFF7SScXq11DWI=; b=yW9rG+M9UcjLmmNb2/wTsK6mf99kHVbwno4H5McuOdhB
	s+VRfI/zdkpSmMoXIFO/wLq3ERqpzEA86WovLCjYJjyoQfhjZUnqzWuUZj4imBPt
	HFkqbbskZ2EXkvqQCSrlQWpkfyy/SqaxGGLtlwtNSy+tgJ++fP7p0p1M4/jIFgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=eQFjIS
	qLc9YUVWdG3Lj6y6EUwhwi29Ck7CABDSBcho8wNeHwj4+CFhnmU5iZm6ocwbbG+X
	nGNJinPBeClgK0G1zwQm5LyKtvd8orQhn1EbU8E+CXdcUsA7olqY8HtYgK8bnHQg
	vrmQqy4AsuFdZV/1AS3OpVi5kcHj4tIIFfff0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B72282FC0E;
	Wed, 21 Jan 2015 13:51:05 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 070732FC0D;
	Wed, 21 Jan 2015 13:51:03 -0500 (EST)
In-Reply-To: <CACsJy8CDgUWEE=QKAgw4G8pgA-cOmLMs4sH67C47Ohd5XJQDNQ@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 21 Jan 2015 16:46:30 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 735DDEDE-A19E-11E4-9751-D3749F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262740>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Jan 21, 2015 at 3:32 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>
>>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>> ---
>>
>> It appears that this hijacks a fixed name dir-mtime-test at the root
>> level of every project managed by Git.  Is that intended?
>
> I did think about filename clash, but I chose a fixed name anyway for
> simplicity, otherwise we would need to reconstruct paths
> "dir-mtime-test/..." in many places.

If you stuff the name of test directory (default "dir-mtime-test")
in a strbuf and formulate test paths by chomping to the original and
then appending "/..." at the end, like your remove_test_directory()
already does, wouldn't that be sufficient?

>> Shouldn't --use-untracked-cache option require the working tree
>> (i.e. die in a bare repository)?
>
> setup_work_tree() takes care of that

OK, thanks.
