From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2] t4018: introduce test cases for the internal hunk header patterns
Date: Tue, 20 Dec 2011 10:13:51 +0100
Message-ID: <87ty4vli5s.fsf@thomas.inf.ethz.ch>
References: <7vmxaokv6k.fsf@alter.siamese.dyndns.org>
	<1324348939-27115-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <gitster@pobox.com>, <git@vger.kernel.org>, <peff@peff.net>,
	<j6t@kdbg.org>, <jrnieder@gmail.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 20 10:14:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rcvlw-00024Y-Eu
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 10:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983Ab1LTJN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Dec 2011 04:13:57 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:15614 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752939Ab1LTJNz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 04:13:55 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 20 Dec
 2011 10:13:51 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 20 Dec
 2011 10:13:52 +0100
In-Reply-To: <1324348939-27115-1-git-send-email-drafnel@gmail.com> (Brandon
	Casey's message of "Mon, 19 Dec 2011 20:42:19 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187504>

Brandon Casey <drafnel@gmail.com> writes:

> Let's introduce some infrastructure to make it easy to create test cases
> for the hunk header patterns and provide a few cases for the cpp pattern.
[...]
>    int WRONG_function_hunk_header (void)
[...]
>    int RIGHT_function_hunk_header (void)
>    {
>            const char *msg = "ChangeMe";

Excellent idea!

> +template <class T> int RIGHT_function_hunk_header (T unused)
> +{
> +	const char *msg = "ChangeMe";
> +	printf("Hello, world, %s\n", msg);
> +	return 0;
> +}

I'd still like to have an extremely contrived overuse of templated
classes, like so:

---- 8< ----
int WRONG_function_hunk_header_preceding_the_right_one (void)
{
	return 0;
}

foo::RIGHT<int*&,1>::operator<<(int bar)
{
	const char *msg = "ChangeMe";
	printf("Hello, world, %s\n", msg);
	return 0;
}

int WRONG_function_hunk_header_following_the_right_one (void)
{
	return 0;
}
---- >8 ----

That will guard us against updating the C++ pattern to something better
but still slightly too simple.

Other than that and Jakub's comments,

Acked-by: Thomas Rast <trast@student.ethz.ch>

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
