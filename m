From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problems using perl's Git.pm module
Date: Thu, 02 Dec 2010 09:51:50 -0800
Message-ID: <7vipzcrrk9.fsf@alter.siamese.dyndns.org>
References: <20101202114003.GA26070@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josef Wolf <jw@raven.inka.de>
X-From: git-owner@vger.kernel.org Thu Dec 02 18:52:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PODKA-0007v1-1e
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 18:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757798Ab0LBRv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 12:51:59 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37679 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757466Ab0LBRv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 12:51:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 029653B95;
	Thu,  2 Dec 2010 12:52:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d2Ht+ww1YNLSrNMpGU8S/yPywJ8=; b=c3GL7Y
	LsXhF1PLxKLdoBMJcpVhivAX1msZ0s9J4Xao6QQRqXH3QJqvflDJF0NZ9iTyxSSs
	ULwZTg55oqofVpKlaVRPUFMJ0TGbiX7KBrilvaQYeiX19dTOoJsUmf3QxRNV5+NL
	ZWA8DpTpxRS9LSUKIN46EGc4EcWnrO3j+Tlv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fwsbxz3+wirXPB7gGbF5Frelkxgk97Az
	IXNjL+H6Zt96iRlkEBuShYUP0uY1pS6RboCjmYa1MST53wP8us9aGFfYsCxp0hLM
	oOOnbJNaP8BdixMQ3DsIkz2IanPRtC86765AglBpCF5MvvMzJTlo+lwZWDzuLZ4p
	He1Ead1flyY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D53E13B94;
	Thu,  2 Dec 2010 12:52:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EAD433B93; Thu,  2 Dec 2010
 12:52:12 -0500 (EST)
In-Reply-To: <20101202114003.GA26070@raven.wolf.lan> (Josef Wolf's message of
 "Thu\, 2 Dec 2010 12\:40\:03 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E63810F0-FE3C-11DF-A71E-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162720>

Josef Wolf <jw@raven.inka.de> writes:

>   jw@raven:~/testrepos> git st
>   # On branch master
>   nothing to commit (working directory clean)

I take it that you have "alias.st.cmd = status".

Observe what this gives you:

    $ git st; echo $?

If you are running pre-1.7.0 version of git, I think "git status" was a
synonym to "git commit --dry-run" and exited with non-zero status to
signal the caller that there is nothing to commit, which is...

>   jw@raven:~/testrepos> ./test.pl
>   # On branch master
>   nothing to commit (working directory clean)
>   status failed w/ code 1 at ./test.pl line 9

...consistent with what we see here.
