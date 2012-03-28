From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9 v8] difftool: print list of valid tools with
 '--tool-help'
Date: Wed, 28 Mar 2012 13:02:06 -0700
Message-ID: <7v4nt8v6ip.fsf@alter.siamese.dyndns.org>
References: <1332959684-2231-1-git-send-email-tim.henigan@gmail.com>
 <7vvclov9hi.fsf@alter.siamese.dyndns.org>
 <CAFouetjbq+A04HECXN39KeLBgkTd+HJyxeM0wSDhS2Xo=_gQVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	davvid@gmail.com
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 22:02:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCz4S-0001Jy-Hs
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 22:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758188Ab2C1UCL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Mar 2012 16:02:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50779 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753499Ab2C1UCK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Mar 2012 16:02:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9079E7D8D;
	Wed, 28 Mar 2012 16:02:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=N//e0+lzIDaa
	FcJcyWeAm08tHNs=; b=Jfcn5cx7TJd7tTb6gViQgTBcM01u/HzB+KfB1ejART4w
	+51xF9kl5AvgFQeyhvm3Pfr5E/JWx/K142I2MEaO0aU6WHDe0Alu7GqWc9/Ox+p8
	lCZSt+iZyLkAuVY5T36lb7J8JUsv6kXUtYThnplYWMD13135OWs/Hdpsa6wyTfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FYhvzC
	PGoPYoiOG5anyOij0gObcf4RF2IzfMd02FHlp5fapwYkxLqp7xGyUzyqLBojvFzK
	ZpQt5QOqZT/9w19etB28GtS6B/ACjaYxbATdZ9ZtJnmHzZ2bc4lkCgVtAT3pR6iH
	PGVrCVOhNtyUKHYZim3K6gHTWixuecR1Jeo8E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86F307D8C;
	Wed, 28 Mar 2012 16:02:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1059C7D89; Wed, 28 Mar 2012
 16:02:07 -0400 (EDT)
In-Reply-To: <CAFouetjbq+A04HECXN39KeLBgkTd+HJyxeM0wSDhS2Xo=_gQVQ@mail.gmail.com> (Tim
 Henigan's message of "Wed, 28 Mar 2012 15:48:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E5DDD2C0-7910-11E1-9366-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194181>

Tim Henigan <tim.henigan@gmail.com> writes:

> On Wed, Mar 28, 2012 at 2:58 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Tim Henigan <tim.henigan@gmail.com> writes:
>>
>> OK, but doesn't File::Find recurse into its subdirectories? =C2=A0If=
 you create
>> a 'foo' directory there and drop a 'bar' script in it, is the rest o=
f the
>> code prepared to give you "git difftool -t foo/bar"?
>
> It does recurse, but in this context '$_' only contains the current
> file name within the directory...not the directory itself [1].  So if
> we call 'find' on a directory that contains:
>
>   foo
>   bar/
>       baz
>
> then @tools =3D ('foo', 'baz')

That is even worse, no?  Is the rest of the code prepared to give you "=
git
difftool -t baz" in such a layout?  What if you have another baz next t=
o
foo and bar?

What I was hinting at was that you may want to $File::Find::prune=3D1 w=
hen
you find a subdirectory.  While at it, you may also want to replace
the "unless -d $_" with "if -f $_ && -x _" or something.
