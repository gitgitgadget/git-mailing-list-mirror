From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4018: introduce test cases for the internal hunk header
 patterns
Date: Tue, 20 Dec 2011 12:08:03 -0800
Message-ID: <7vmxanj9b0.fsf@alter.siamese.dyndns.org>
References: <20111217012118.GB20225@sigill.intra.peff.net>
 <31E9klcRboMV0wSJY5WO-N7nIBOUOa_wr6MVfWY9AInImxJIqC0flahvpDrVGMIuZ9e7Ouha1HDuesbwTGaNQA4dgN-FShNJKkfMG_cHLUJAT2rE539shnQxzM0dQyZIb5661As6Tvs@cipher.nrlssc.navy.mil> <7vty4wkx19.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net, git@vger.kernel.org, j6t@kdbg.org,
	jrnieder@gmail.com, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Dec 20 21:08:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rd5z1-00084t-Ti
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 21:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121Ab1LTUIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Dec 2011 15:08:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43982 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703Ab1LTUIH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 15:08:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8F99578D;
	Tue, 20 Dec 2011 15:08:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gMGkNJ/NeufPvpSIvwVS2A7nUdE=; b=VFap8g
	K+vRQb4McH2N1MK8rH8YeraZ6ixJ8U7UV0xLmHbaLUdkzpazjz+Rq+oO3rKx0amE
	sox54kSiHh52mZWYkz3fLQJ98CG2+0tBukTJsqeMN75ZTzr94xWJJ0lgz1t5JZVi
	sW0LmpWT8Z0YOLuf/0tTG/GP8ezbKkgprUJwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ANW2vU4zjrNTbO60Vf4JpUDkujhDugUF
	uwF+8yo2gLk07LwGphhCjloT2+Zyx5hFcodgi56SAtfGrQnlAKWqt9a9XtyEGMx8
	aqWXSKlFwhTzLoIqFdABGbJjbLGt7x4oq+/b2FRsZGKWD0PNswpiAJNfJ01le9Ng
	wMlQgnAxZnk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E03D5578C;
	Tue, 20 Dec 2011 15:08:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC3CC578B; Tue, 20 Dec 2011
 15:08:05 -0500 (EST)
In-Reply-To: <7vty4wkx19.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 19 Dec 2011 14:37:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 542DF1EC-2B46-11E1-9780-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187523>

Junio C Hamano <gitster@pobox.com> writes:

> Brandon Casey <casey@nrlssc.navy.mil> writes:
>
>>    * new test cases can be dropped into the t4018 directory
>>    * filenames end with the pattern name e.g. .cpp .objc .matlab etc.
>>    * filenames should be descriptive since it will be used in the test
>>      suite output
>>    * broken test cases should be given a filename prefixed with "broken_"
>
> Cute. I like the general idea.

Actually, I do not like this "broken_" filename prefix part. Even though I
can imagine "git show -M" would do a reasonable job, marking that a fix to
a pattern makes a test that used not to pass succeed by renaming a file
goes against the convention of changing one line to turn the "failure" to
"success" in test_expect_failure used in normal tests.

Can we use stable filename that says what is being tested instead?
