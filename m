From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add Git::config_path()
Date: Fri, 07 Oct 2011 14:35:30 -0700
Message-ID: <7vk48gtrh9.fsf@alter.siamese.dyndns.org>
References: <vpqty7wk9km.fsf@bauges.imag.fr>
 <1317379945-9355-1-git-send-email-cowose@gmail.com>
 <1317379945-9355-2-git-send-email-cowose@gmail.com>
 <m3vcs01r32.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Cord Seele <cowose@googlemail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Cord Seele <cowose@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 23:35:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCI4w-0004j9-Tf
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 23:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595Ab1JGVfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 17:35:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50154 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753357Ab1JGVfd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 17:35:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C176368C5;
	Fri,  7 Oct 2011 17:35:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=22qkq0AP9H08OYQQJdawVYZrW+4=; b=K8IGh2
	dFjpTBtZZfCyb++G5wqQtOo8Zd7TIT4N2psZVPETDRHKBxCpE69nenlCF4nbhkCT
	HRhmn5ZxgzIDRvmI+4S7djzcw9hJgfsb5Hy5Hao32hekto4jgqplF0iY2TWvc19T
	iLxuENtKKVKcoahZMXj+NB8UocTiVELggrFys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MsOYzsmp+QulNl73ykYyn4JIKTHvkv23
	IvJPp28C8sSA3VHrZ8QHQhz6j/ZQWcvvJBlEwELIdxKADRLmqPTL+eSEyE68oowW
	EluQN1xxV6Datm+V+G3LB2JDR/969K3ix+Qo+Eak1BgxpaHbRQznlEkiDgKa1yhK
	TRXWUKQcaeI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8F1668C3;
	Fri,  7 Oct 2011 17:35:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4BD7D68C2; Fri,  7 Oct 2011
 17:35:32 -0400 (EDT)
In-Reply-To: <m3vcs01r32.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Fri, 07 Oct 2011 13:32:39 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48CAE0F2-F12C-11E0-AF96-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183112>

Jakub Narebski <jnareb@gmail.com> writes:

> diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
> index 3787186..7558f0c 100755
> --- a/t/t9700-perl-git.sh
> +++ b/t/t9700-perl-git.sh
> @@ -43,7 +43,9 @@ test_expect_success \
>       git config --add test.booltrue true &&
>       git config --add test.boolfalse no &&
>       git config --add test.boolother other &&
> -     git config --add test.int 2k
> +     git config --add test.int 2k &&
> +     git config --add test.path "~/foo" &&
> +     git config --add test.pathexpanded "$HOME/foo"

Given that test-lib.sh sets up the $HOME away from unknown place to ensure
repeatability of tests, I am not sure if this test would ever pass.
