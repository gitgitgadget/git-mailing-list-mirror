From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: refuse complete src:dst fetchspec arguments
Date: Tue, 20 Oct 2009 14:11:06 -0700
Message-ID: <7v1vkxn53p.fsf@alter.siamese.dyndns.org>
References: <d561e70f0aa802ceb96eba16d3bb2316134d69c8.1256062808.git.trast@student.ethz.ch> <BLU0-SMTP97AA2287062D9A104101C8AEC00@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>
To: Sean Estabrooks <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Tue Oct 20 23:11:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0LzK-0001LV-It
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 23:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbZJTVLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 17:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbZJTVLN
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 17:11:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42484 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbZJTVLM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 17:11:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 788E97FDAB;
	Tue, 20 Oct 2009 17:11:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z3proQNHH5UnKf96YYX3yBnI+wQ=; b=Awb2Mk
	b2K1EpBQsbFYrc98jHO9NNcAKYgWWycs1VQpMlaV425JZIUPJtcC3YazuO5nckjR
	0qxV+fKw5KcaMgc8pmU7wig5CE+iMLqhCTA50EYeMHJRifUjR7XPJcIYhtsPHqSc
	SMgtl1CdilhGz5+eAZnv8SispYcyeFwhIsxQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cG3LANyLkwsCGmnDKO/Un85Q/3q18Y3h
	eq+ZkTHkHbPz1qbxJPdzA0692fr8ao/nmc0PwgbBBzfG1M6sMWa0JkH7LJG+gEbq
	4ugwksB0dkOoKZWfjUgGhqrCd6mTdCdIuhNsghvW+RNAnKgJ8ZR0zooumHbVPqUw
	ceWVcOBQNaQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 49F3E7FDA6;
	Tue, 20 Oct 2009 17:11:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B7D187FDA3; Tue, 20 Oct 2009
 17:11:07 -0400 (EDT)
In-Reply-To: <BLU0-SMTP97AA2287062D9A104101C8AEC00@phx.gbl> (Sean
 Estabrooks's message of "Tue\, 20 Oct 2009 13\:30\:53 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 185783D4-BDBD-11DE-8065-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130849>

Sean Estabrooks <seanlkml@sympatico.ca> writes:

>> -test_expect_success 'pulling into void using master:master' '
>> -	mkdir cloned-uho &&
>> -	(
>> -		cd cloned-uho &&
>> -		git init &&
>> -		git pull .. master:master
>> -	) &&
>> -	test -f file &&
>> -	test -f cloned-uho/file &&
>> -	test_cmp file cloned-uho/file
>> -
>> -
>>  test_expect_success 'test . as a remote' '
>>  
>>  	git branch copy master &&
>> -- 
>> 
>
> Instead of removing this test it should be modified or replaced
> with a test that ensures the new functionality operates correctly.
> In this case that would mean checking that using a full refspec
> errors out.

Shouldn't "git pull .. master" still work in this case, too?  So this test
will probably become two tests, one for "git pull .. master:master" that
correctly fails, and the other for "git pull .. master" to still work as
expected.
