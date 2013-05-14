From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 09/10] remote-hg: test: be a little more quiet
Date: Tue, 14 May 2013 14:40:53 -0700
Message-ID: <7vbo8dgryy.fsf@alter.siamese.dyndns.org>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
	<1368486720-2716-10-git-send-email-felipe.contreras@gmail.com>
	<51929e298955c_13a8f89e18228b@nysa.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 23:41:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcMxx-0006ml-9P
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 23:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758419Ab3ENVk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 17:40:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52762 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758539Ab3ENVk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 17:40:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6C361E892;
	Tue, 14 May 2013 21:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wxwkWOBYykqFBLqex01d1+FjdDc=; b=EDH77m
	Yqv1reN+dlJlS5igev4nSFRzjLLRf+Lxs5ABXKjJ4PqU6/19ihdVVZv0Gk3qeI+n
	5xttPWZEnLVKzaYfQeffi//XCGgbOMLZFyI3eWp9uR4QM+GohAxcsMu8iAjJMSix
	QiG6fNs6B7K+OwV0NQxvbKbakju820JutM+wE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GDsdl0MXM98vomtGjkHXesyEAqt64gFH
	iVl6IM7PmchtylEB2Jwah/i78bRpcEZK4nnSVZYuPUc6Vh9YhufUHzE2lBR7hPZL
	yCnUVoOaI9dvY2NmD5EVamQs2oTjzSemSrW3KQfiV73h0Rx16X9JGc+iad0OLIhc
	c2SAMXJY1Gk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8AC21E891;
	Tue, 14 May 2013 21:40:55 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E6511E88D;
	Tue, 14 May 2013 21:40:55 +0000 (UTC)
In-Reply-To: <51929e298955c_13a8f89e18228b@nysa.mail> (Felipe Contreras's
	message of "Tue, 14 May 2013 15:27:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F4EFF870-BCDE-11E2-87BE-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224351>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> No-brainer; improve one test.

In general, unless we are taking the output from commands to a file
and grepping in it, we prefer not to have --quiet (unless you are
testing the --quiet feature of the command, of course).  Running the
tests without "-v" option will not show them and when running with
"-v" to debug the tests, the extra output will help to figure out
which step failed.

> Felipe Contreras wrote:
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  contrib/remote-helpers/test-hg.sh | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
>> index 8de2aa7..f8d1f9e 100755
>> --- a/contrib/remote-helpers/test-hg.sh
>> +++ b/contrib/remote-helpers/test-hg.sh
>> @@ -109,10 +109,10 @@ test_expect_success 'update bookmark' '
>>    (
>>    git clone "hg::$PWD/hgrepo" gitrepo &&
>>    cd gitrepo &&
>> -  git checkout devel &&
>> +  git checkout --quiet devel &&
>>    echo devel > content &&
>>    git commit -a -m devel &&
>> -  git push
>> +  git push --quiet
>>    ) &&
>>  
>>    hg -R hgrepo bookmarks | egrep "devel[	 ]+3:"
>> -- 
>> 1.8.3.rc1.579.g184e698
