From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why there is no pre-checkout hook?
Date: Fri, 15 Oct 2010 15:46:44 -0700
Message-ID: <7vr5fraxbf.fsf@alter.siamese.dyndns.org>
References: <87hbgn27f0.fsf@telefonica.net> <20101015083022.GA8763@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?=C3=93scar?= Fuentes <ofv@wanadoo.es>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 16 00:47:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6t3E-0002ww-U7
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 00:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352Ab0JOWqz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Oct 2010 18:46:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62241 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab0JOWqy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Oct 2010 18:46:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EC27DDE626;
	Fri, 15 Oct 2010 18:46:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=j7fEPl2B1iU4
	DFQQ7UTfpE5dMtU=; b=b8RHxERiZBXjVwThFMkGhOiLH1oG8ryaAAubd0MOzQKA
	LTKKkifn86uE+tF0ZBoKU+c2LRuOhw9FASXIsnDjvLR6lxY3SAXVXU1datDmzn69
	0gFNKiqLvMCVmQx13yVfdP6NEl4d6gjzz3R8+ZHyAir7ShJxa/vi6OFbbQwQ6fk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=km715X
	jUAoAAWH1Fjr/7qYPCytkUW5FpdJMcppwdOttgqzTo/5LfF/6nHebq+OnUlQM68U
	uYuiFAkBixxbpHVMQiGbF9sWYajHSfQkdoxZCczQp20a0c8tMlrFW1beWbE+OFg4
	cNH8bGVxRSDcKY07/V7EKYfnt5soDMaM+tJhU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BA532DE625;
	Fri, 15 Oct 2010 18:46:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4EBEDE623; Fri, 15 Oct
 2010 18:46:45 -0400 (EDT)
In-Reply-To: <20101015083022.GA8763@burratino> (Jonathan Nieder's message of
 "Fri\, 15 Oct 2010 03\:30\:22 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 18DB6E76-D8AE-11DF-876D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159140>

Jonathan Nieder <jrnieder@gmail.com> writes:

> =C3=93scar Fuentes wrote:
>
>> [Subject: Why there is no pre-checkout hook?]
>
> Because you can use your script in place of "git checkout".
>
> Or: because no one's come up with a compelling use case for
> one.
>
> Or: because no one implemented it and demonstrated how to
> use it yet.
>
> Take your pick. :)

The first one is the most correct answer from historical standpoint for
almost any command, as git was designed to be scripted, and if you need
pre-frotz to always run before running frotz you should be doing that
before running frotz yoruself.  The same for post-frotz that would
unconditionally run after you run frotz.

Google/Bing/Gmane Search for "five valid reasons for git hook" ;-)

Having said that, I think it may be a good time to start thinking about
loosening the criteria, especially unconditional pre- and post- ones,
around Porcelain commands.  The "five valid reasons" criteria apply to
plumbing where you have more control and freedom and we do not want to
spend extra cycles even to check for non-existence of hooks.
