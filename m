From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v4 01/16] GSOC remote-svn
Date: Mon, 20 Aug 2012 09:23:16 -0700
Message-ID: <7vk3wtleh7.fsf@alter.siamese.dyndns.org>
References: <1345235157-702-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <8572000.QUVXl8yetS@flobuntu> <7vzk5srm9w.fsf@alter.siamese.dyndns.org>
 <6231669.WggyDX4Xa3@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 18:23:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3UlB-0005Ru-G2
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 18:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119Ab2HTQXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 12:23:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56653 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392Ab2HTQXT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 12:23:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 015B3743F;
	Mon, 20 Aug 2012 12:23:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/RsUDffG0EzymxdNbO8EPkM1W0Y=; b=Fkj5Q+
	RKXodPJNZ6w5AemmdI4oJMePHthayGWP1MQCPsSFW+De32D6gVp2vqiaL2bLU87G
	N9fgyMaOYNmkCSd8jwfKkUI4ZILMXChZB8r/4IBnXWJo1PX4KlHvXXN8jnrdCpmf
	SECfSawSbwiWACVAbAyYRwKQY4oqhTiLDayrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J2Zxe7cxycvbSINo2t2nTGkLkaZjevZJ
	s7JEaggKPNe2F6iqmLbJZSbGtgIJuBkLGB2wP6vVaJLN2PFmqyycqRRvBH31A79S
	veTWozS5vsgzYnLKMt4c3uibZvtcWVZlLkqo96XS3L4fCVIkeABCY20mv99OFdig
	hKST2h3qbt4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E30A8743E;
	Mon, 20 Aug 2012 12:23:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4CA6E743D; Mon, 20 Aug 2012
 12:23:18 -0400 (EDT)
In-Reply-To: <6231669.WggyDX4Xa3@flomedio> (Florian Achleitner's message of
 "Mon, 20 Aug 2012 15:52:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59D1B6B2-EAE3-11E1-9B9C-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203850>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> On Saturday 18 August 2012 13:13:47 Junio C Hamano wrote:
>> That indicates that one necessary patch to add logic to Makefile to
>> go and build that subdirectory, at least before running the test,
>> but possibly as part of the "all" target, is missing, isn't it?
>> 
>> Or you can add, at the beginning of your tests files that require
>> the contrib bit, to have something like
>> 
>>         if test -e "$GIT_BUILD_DIR/remote-svn"
>>         then
>>                 test_set_prereq REMOTE_SVN
>>         fi
>> 
>> and protect your tests with the prerequisite, e.g.
>> 
>>         test_expect_success REMOTE_SVN 'test svn:// URL' '
>>                 ...
>>         '
>> 
>> without changing the top-level Makefile.
>
> What version would you prefer? Currently nothing in contrib/ is built by the 
> toplevel Makefile..

The latter approach of running tests only for people who went to
contrib/vcs-svn and built things there may be more conservative.  I
could be persuaded either way.
