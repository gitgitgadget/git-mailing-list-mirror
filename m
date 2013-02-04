From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature request: Allow extracting revisions into directories
Date: Mon, 04 Feb 2013 08:55:17 -0800
Message-ID: <7v38xc3toq.fsf@alter.siamese.dyndns.org>
References: <1359901085.24730.11.camel@t520>
 <510F9907.7010107@drmicha.warpmail.net> <1359980045.24730.32.camel@t520>
 <CAH5451mp6fRU25LWE+8gk1h6Mz=y_XQHaU-iE0k4=bP0RfzLAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Clausecker <fuzxxl@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 17:55:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2PKZ-0000ri-Km
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 17:55:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756632Ab3BDQzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 11:55:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56023 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756246Ab3BDQzT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 11:55:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 819E6CDAE;
	Mon,  4 Feb 2013 11:55:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dXcqFTWYRTeHKEg91VkfY/hzW7o=; b=wjHy3g
	kwHtpcwQH74xmVfJSTBcX9lffLsst6nj2IvXR0LxAEKxl3BZSajpYE8mf4X2ovD3
	z6YGeuBJAQLyeDKwUiTxFGbUZk+K7RPLWLvMr/LacXrLxkZSxgpCWy8wXuTZuP3z
	euvMGyrcou7sQ1mbJ7gQxU2UEoJRbT6PFTidc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oOtkPbxXk7Z/XnSw3GHCOEsZu2/PbHsB
	2whkQAv+m5WxvgjDFM/1uRhYZLunKr9elbiOzGL1NOePOTvbVrFqOX07mVB1RY7l
	FBxVxmv1B7Cawr14bJKMmr1Czoddeie2xnhsgX/mxfLGjTqRLJ6lNzYDvnqDBcIk
	MY8IfYAUd20=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 743B6CDAD;
	Mon,  4 Feb 2013 11:55:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E74A6CDAA; Mon,  4 Feb 2013
 11:55:18 -0500 (EST)
In-Reply-To: <CAH5451mp6fRU25LWE+8gk1h6Mz=y_XQHaU-iE0k4=bP0RfzLAA@mail.gmail.com> (Andrew
 Ardill's message of "Mon, 4 Feb 2013 23:58:39 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A8012188-6EEB-11E2-8CD7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215395>

Andrew Ardill <andrew.ardill@gmail.com> writes:

> On 4 February 2013 23:14, Robert Clausecker <fuzxxl@gmail.com> wrote:
>> The specific workflow I am planning is this:
>>
>> I have a server that hosts a bare git repository. This git repository
>> contains a branch production. Whenever somebody pushes to production a
>> hook automatically puts a copy of the current production branch
>> into /var/www/foo. I could of course use pull for that but it just does
>> not feels right. Why should I have a repository twice on the server?
>
> Maybe I'm missing something. How does the behaviour you need differ from
>
>> GIT_WORKING_DIR=/var/www/foo git checkout -f <tree-ish>
>
> ??

In addition to the fact that your misspellt environment variable
name will not cause it to write there, you will also be overwriting
the index for your working tree, which presumably you meant is a
location different from the /var/www/foo, with the contents of
<tree-ish>.
