From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: Add commit_list prefix to reduce_heads function.
Date: Sun, 05 Dec 2010 20:01:30 -0800
Message-ID: <7v7hfntuqt.fsf@alter.siamese.dyndns.org>
References: <a3f4bdc2d5f5d13c772a82de9afe2691b8a12863.1291514223.git.tfransosi@gmail.com>
 <20101205021837.GA24614@burratino>
 <AANLkTinAT3kotKQTS6eS1SLigNzSp6grAU7WNRbHf3N=@mail.gmail.com>
 <20101205170919.GA7913@burratino>
 <AANLkTikL4BWtzNgx1+MBYxRRdfL=Gu71KPjaiKXprvnb@mail.gmail.com>
 <AANLkTinjJpGW2OiXM3edWYaNhS+w4qNLrvg-0aBwsL=x@mail.gmail.com>
 <7vk4joszcj.fsf@alter.siamese.dyndns.org>
 <AANLkTi=QK=N+_iGR9-47JKFs_SDKujJ8c4mtnnM0yo94@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 06 05:01:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPSGn-0000JP-Qt
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 05:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347Ab0LFEBl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Dec 2010 23:01:41 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46789 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185Ab0LFEBk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Dec 2010 23:01:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 90EFC265F;
	Sun,  5 Dec 2010 23:02:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vndiqQ0HnufC
	4Tpwhs1fY7Ujrkw=; b=nnKmBnv/nPN8qW8jedwl2dsptHV7qMl1zxU/8b1XHlT6
	FqjI3/Q6LsnCAURuWOXWi6hLtFzFLpg1XX0N4uQTenHDzk5AlSqv9wAUwu0pbeQG
	5iO8m9hwcpEKH9ztIYe0+Anf8IpqYhpz8NQVICh2QKklncDJf3KHf9+qAk0TkuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CuNsUh
	GtIIB5QBnAUgZ9f3hI2wmlYlQdwaM13Bww779xKC2qfsF62Hvxyr+Fsb5imCDXUq
	l4ZssuXIt+jVmU85Mo7XlCcSRhTtkn9wPXbkshwR7lFE5NQINzCmDUdLrNN7rjJN
	CKFP4PrQcvqK3yWfk8aB1X697nBJGMUoFp28o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 607B0265E;
	Sun,  5 Dec 2010 23:01:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0114A2647; Sun,  5 Dec 2010
 23:01:53 -0500 (EST)
In-Reply-To: <AANLkTi=QK=N+_iGR9-47JKFs_SDKujJ8c4mtnnM0yo94@mail.gmail.com>
 (Thiago Farina's message of "Sun\, 5 Dec 2010 19\:29\:12 -0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 92EFFF80-00ED-11E0-93E9-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162972>

Thiago Farina <tfransosi@gmail.com> writes:

>> "insert-by-date" does not say _why_ you want things to be inserted b=
y date
>> (neither "sort-by-date"). =C2=A0They are pretty generic looking name=
s for any
>> function that deal with a list of elements that record date. =C2=A0I=
t makes
>> sense to anticipate there will be many other such functions that dea=
l with
>> different kinds of lists that hold date-recording things, and naming=
 one
>> of them "this deals with list of COMMITS" by saying "commit_list_foo=
"
>> makes quite a lot of sense, as "insert-by-date" does not give suffic=
ient
>> information to the reader.
>>
> That makes sense to me. And clarified why the complain at all. And yo=
u
> are right.

Actually I think s/insert_by_date/commit_list_insert_by_date/ is a
mistake.  Something like insert-commit-by-date would be more appropriat=
e.
Similarly for s/sort_by_date/commit_list_sort_by_date/
