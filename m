From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v4 01/16] GSOC remote-svn
Date: Sat, 18 Aug 2012 13:13:47 -0700
Message-ID: <7vzk5srm9w.fsf@alter.siamese.dyndns.org>
References: <1345235157-702-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <7v4no0u950.fsf@alter.siamese.dyndns.org> <8572000.QUVXl8yetS@flobuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 18 22:13:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2pPB-0004Cz-3V
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 22:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410Ab2HRUNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 16:13:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64702 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750984Ab2HRUNu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 16:13:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 728C19341;
	Sat, 18 Aug 2012 16:13:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tpGbgsphoX1/L7wONAww9R2nSB0=; b=IAPwsR
	CSi57xzYaQhCJM7XwUrdOkNsoE2epEtH0hT076XUgjDpANuS2U/JJryGhkCGNEmi
	dhetVFQZw/BAbYtUf9pKoD/he12x4pjhXyKaypd/nvL9WzWzelQ43WnXcMju0rOh
	jj44+vAZ4Qz9SHmf7s4Qm+K7+IRYE9Eoz24Uk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cu+qdxsmcTtpozi7R+PqH8JpkVvAffhK
	ekayC8oMIkEL23OHONSxVehgEoalCIsN+kq/GAXJlWL2ltDRsnlpQeQPDw88D0py
	YoudH3nIc72+11KDz2t+dD3Jh5SfCYxDBdNcWJ+2BQOL0EHP6xHjn7K71OXxtrRA
	CD9aVaoJyfw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F5F69340;
	Sat, 18 Aug 2012 16:13:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BADE6933F; Sat, 18 Aug 2012
 16:13:48 -0400 (EDT)
In-Reply-To: <8572000.QUVXl8yetS@flobuntu> (Florian Achleitner's message of
 "Sat, 18 Aug 2012 20:06:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3895B3D6-E971-11E1-8484-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203692>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> On Friday 17 August 2012 21:16:59 Junio C Hamano wrote:
>> Comments from mentors and people interested in remote helpers?
>> 
>> I did minimum line wrapping, typofix and small compilation fixes
>> and queued these on 'pu'; I think I saw one commit whose message
>> I didn't quite get what it was trying to say, and another that was
>> missing S-o-b (I left them untouched).
>
> Should I provide a better version? I found the commit that I forgot to sign-
> off, but I'm not sure which message you mean.

There was a one with "E.g:" followed by an incomplete sentence that
did not parse for me.  Can you fetch 'pu', run format-patch on your
topic and compare the output with what you sent to the list?

>> The result merged to 'pu' seems to fail 9020, by the way.
>
> That's because contrib/svn-fe isn't built automatically if you call make in 
> the toplevel dir. 
> It dies with "fatal: Unable to find remote helper for 'svn'", because the 
> helper is not built. We currently need to run make in contrib/svn-fe 
> seperately.
> That's a bit awkward.

That indicates that one necessary patch to add logic to Makefile to
go and build that subdirectory, at least before running the test,
but possibly as part of the "all" target, is missing, isn't it?

Or you can add, at the beginning of your tests files that require
the contrib bit, to have something like

	if test -e "$GIT_BUILD_DIR/remote-svn"
        then
		test_set_prereq REMOTE_SVN
	fi

and protect your tests with the prerequisite, e.g.

	test_expect_success REMOTE_SVN 'test svn:// URL' '
        	...
	'

without changing the top-level Makefile.
