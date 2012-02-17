From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Add a setting to require a filter to be successful
Date: Fri, 17 Feb 2012 07:35:06 -0800
Message-ID: <7vd39dv5g5.fsf@alter.siamese.dyndns.org>
References: <7vobsywck1.fsf@alter.siamese.dyndns.org>
 <4f3daaf7.e302440a.02ba.fffff463@mx.google.com>
 <4F3DFCD0.6070002@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jehan@orb.com, gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Feb 17 16:35:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyPqK-0004By-MZ
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 16:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191Ab2BQPfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 10:35:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61562 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940Ab2BQPfK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 10:35:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BDC261A6;
	Fri, 17 Feb 2012 10:35:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Tpzu2E0Mw/g+OxKrGYPyanRZEZM=; b=huOTPP
	q/UC60fpYaZ3tL1e2vORW1Ass6+AM2mKLpg90PKI/yGgg8m3U1zKrHSMHU8iFT6z
	SPAY2xwBWlPfDj3bcp1Og1wuAvtdlWZ+O0JYUNJDvPzPhQx6Ls4+6ebzJIkfpHFQ
	KSbE7ASyjMSNASV50+F99JXg7QxI23jvW6xTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L95j39z0hjuvOxtUts112npNEYwfeATI
	BPgiWid+ffdHBcMlab5vftcBuFIAnOEQ12zoSAJn/z39JcZaMcXgsRemEXBtXPPD
	5AaIq5qF9uWoIxbzSZqnBsCJURieV6OLR6AK42OpH9i1gfCyoRW01M97x1C0Vtnn
	qgTEEu9CvPI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E6D861A4;
	Fri, 17 Feb 2012 10:35:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29DEA61A2; Fri, 17 Feb 2012
 10:35:08 -0500 (EST)
In-Reply-To: <4F3DFCD0.6070002@viscovery.net> (Johannes Sixt's message of
 "Fri, 17 Feb 2012 08:08:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F8BDB74C-597C-11E1-BEC1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190961>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 2/17/2012 2:19, schrieb jehan@orb.com:
>> @@ -747,13 +753,19 @@ int convert_to_git(const char *path, const char *src, size_t len,
> ...
>>  	ret |= apply_filter(path, src, len, dst, filter);
>> +	if (!ret && required)
>> +		die("required filter '%s' failed", ca.drv->name);
>
> Wouldn't it be much more helpful if this were:
>
> 	die("%s: clean filter '%s' failed", path, ca.drv->name);
>
> Likewise (with s/clean/smudge/) in convert_to_working_tree_internal().
>
>> +	! git checkout -- test.fs
>
> 	test_must_fail git checkout -- test.fs
>
>> +	! git add test.fc
>
> 	test_must_fail git add test.fc
>
> -- Hannes

Thanks; I'll just squash these in in-place.
