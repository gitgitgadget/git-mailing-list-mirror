From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a svnrdump-simulator replaying a dump file for
 testing.
Date: Mon, 23 Jul 2012 08:06:39 -0700
Message-ID: <7v4noyo6tc.fsf@alter.siamese.dyndns.org>
References: <4514544.Xip1OCQ7Uj@flomedio> <20120722214333.GB680@burratino>
 <2948040.5ceLh0WG3L@flomedio> <1448476.VR1Gla8Cvg@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, davidbarr@google.com,
	git@vger.kernel.org
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 17:06:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StKDn-00038m-N0
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 17:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134Ab2GWPGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 11:06:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50008 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753641Ab2GWPGn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 11:06:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 297407E4F;
	Mon, 23 Jul 2012 11:06:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UBuZdbWsr9FCALuxMu1ld+M4zI4=; b=ONo24h
	1IIamLQjEYrxufEYEtcvYkxPMhKPG36ONJB/mtnjy3W7c6M+q2S7DPQniOzfWpsK
	sh4jsAl9vyGw4Mox8eBm7PfLUOc46334IwwDyWSxEmM/Mr39dBwrM+bb0N/KukcJ
	1+nA7eaJM2NVXaO0aOZYaH4VZ+X4EltuchHKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C0b4d6F4giWfbVqRMXlHh7bm/KYyuSXs
	I5Mjacn3mulq5aSzqqOHaMJA0u7O4aTIElStlNEPGbQg0BBUyv+mFkIIe/AjhNat
	fbJuTbrrrZhzeuNLO3vIPErmkxcTHXq09th9rHiq9OaZHlfIKbN08rnTVdFYUyU4
	/BIxvscTfvc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1521D7E4E;
	Mon, 23 Jul 2012 11:06:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68E2A7E4D; Mon, 23 Jul 2012
 11:06:41 -0400 (EDT)
In-Reply-To: <1448476.VR1Gla8Cvg@flomedio> (Florian Achleitner's message of
 "Mon, 23 Jul 2012 14:44:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 024BF3A6-D4D8-11E1-B309-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201935>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> It requires the remote url to start with sim://.
> Start and end revisions are evaluated.

It is a bit unclear where "start" and "end" comes from, and if
"evaluated" is the most important aspect of the handling of these
two values.  Do you mean the tool takes start and end revisions as
arguments?  If so, describe "how".  E.g. as two arguments (-rSTART
-rEND)? As an argument that shows a range (-rSTART-END? -rSTART,END)?

Do not answer with "It is in the code" (I cheated and peeked to find
out it is -rSTART:END, but the reader should not have to peek).

> If the requested revision doesn't exist, as it is the case with
> incremental imports, if no new commit was added, it returns 1
> (like svnrdump).

This sentence does not parse for me.  What is it trying to say?
Requested revision does not exist _where_?  It is unclear how
"incremental import" and "revision doesn't exist" are related.  "no
new commit was added" to _what_ by _whom_?  I presume that nobody is
adding new commit _to_ an existing dump file, and the only thing
this script does is to read and selectively write part of a dump file,
so that would not add any new commit either.

Puzzled.
