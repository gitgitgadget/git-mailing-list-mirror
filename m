From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] zlib: wrap deflate side of the API
Date: Fri, 10 Jun 2011 16:00:24 -0700
Message-ID: <7vvcwduwaf.fsf@alter.siamese.dyndns.org>
References: <1307736948-16956-1-git-send-email-gitster@pobox.com>
 <1307736948-16956-5-git-send-email-gitster@pobox.com>
 <BANLkTinz9VAL_j9hZeF=kuAPwU1+0yEyRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 11 01:00:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVAgw-000306-9j
	for gcvg-git-2@lo.gmane.org; Sat, 11 Jun 2011 01:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758169Ab1FJXAd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2011 19:00:33 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48877 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758237Ab1FJXAc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2011 19:00:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 38AAA56B1;
	Fri, 10 Jun 2011 19:02:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5VnZp4iDv2Rw
	fJv9ahxhrfH9pdE=; b=Iz++xAWDs4XaWofzWM36b+m/qoZs8Q27NdJJDp+XdD9P
	Lx78g1GbJjrohg6SqVjqc3xnRVwlTV/UqNUOz3TZrFCoa1HBgXdlrmjq5P5c6N8i
	7JIjm6wRnJWMlQIoP/jejTIPdZbqTZ4zhnv+3J+SPaQey9kTEGEyzVNNyMOUT4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=SGJ2P4
	8z8z9lj7AeSHKw5I4xZvmC0ruZaaUIWDbpTDJYSErbxrWng9702W4qGFlZHxQ3ii
	AqIrJ31O7ki6MRsj4nKg0jfoAj4Rh5syzBbu33rzrT5yeN9YcbTGIWISsuZ0ZqR/
	8jH7mrbOKjpbSFDkKYk5i3gqTZm0Svs4hlOOA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1459056A2;
	Fri, 10 Jun 2011 19:02:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D691456A1; Fri, 10 Jun 2011
 19:02:34 -0400 (EDT)
In-Reply-To: <BANLkTinz9VAL_j9hZeF=kuAPwU1+0yEyRw@mail.gmail.com> (Thiago
 Farina's message of "Fri, 10 Jun 2011 19:23:47 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BC609F72-93B5-11E0-AC46-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175633>

Thiago Farina <tfransosi@gmail.com> writes:

> On Fri, Jun 10, 2011 at 5:15 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> +void git_deflate_init_gzip(z_streamp strm, int level)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Use default 15 bits, +16 is to genera=
te gzip header/trailer
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* instead of the zlib wrapper.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 const int windowBits =3D 15 + 16;
> Was this style intentional?

Sorry, but what style specifically do you find questionable?
