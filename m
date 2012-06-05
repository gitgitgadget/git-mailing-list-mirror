From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase [-i --exec | -ix] <CMD>...
Date: Tue, 05 Jun 2012 11:13:48 -0700
Message-ID: <7vtxypocdf.fsf@alter.siamese.dyndns.org>
References: <1338817674-22877-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <7vhaurt1m6.fsf@alter.siamese.dyndns.org>
 <20120605195959.Horde.h42jfHwdC4BPzkkfVQizm9A@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Tue Jun 05 20:13:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbyGS-0005Xg-5K
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 20:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755744Ab2FESNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 14:13:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42975 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753019Ab2FESNv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 14:13:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7ED6C8A60;
	Tue,  5 Jun 2012 14:13:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nOlLQ22S6NO3yk6TpdI4+8cIYOE=; b=xB82mK
	tSoUTLEesZ4lVwMABgrpRdKkroDa9WwD3idGGb4q3fCYJFdGFwBcM0ovwIEhM/BJ
	dbmSCgH1+RRlV+0BocJA32yosTd/zO9VlxLzhCNz3+Pq1+kb0MJo3HfJVyBXN6jf
	XsM2b4YLFPyahgZp5xo+ouFKL+YP/mjmGg4Ms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p4/TLPaurLqG+ld/W1mvJcUZNEZYtoQU
	AwI18/Udtd0COFtjGVtyF/ylkfldwlwmr2B2o84E8PRM2Id01xDyhU7JaarVL0oG
	qANX8JBPz0P4wahu1dmgWTUWG89zqElo02udI1Yq6io7dLWWfFDhfIVW/YkQFYWP
	+6MJnOF8MvU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74A118A5C;
	Tue,  5 Jun 2012 14:13:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DBDAF8A5B; Tue,  5 Jun 2012
 14:13:49 -0400 (EDT)
In-Reply-To: <20120605195959.Horde.h42jfHwdC4BPzkkfVQizm9A@webmail.minatec.grenoble-inp.fr> (konglu@minatec.inpg.fr's message of "Tue, 05 Jun 2012 19:59:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 333925A6-AF3A-11E1-91B4-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199274>

konglu@minatec.inpg.fr writes:

> But shouldn't we keep the "test `expr substr "$2" 1 1` = -" part so that
> options can't be right after the "--exec" ?

No.  We have no reason to forbid users from giving their commands
names that begin with "-", and if it is a typo, "exec" machinery
will catch it and tell the user "no such command".  I do not see any
good reason to be clever in the part of the command parsing loop
that handles "--exec <cmd>" option.
