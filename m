From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add Git::config_path()
Date: Fri, 07 Oct 2011 15:26:18 -0700
Message-ID: <7vbotstp4l.fsf@alter.siamese.dyndns.org>
References: <vpqty7wk9km.fsf@bauges.imag.fr>
 <m3vcs01r32.fsf@localhost.localdomain>
 <7vk48gtrh9.fsf@alter.siamese.dyndns.org>
 <201110072344.46556.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Cord Seele <cowose@googlemail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Cord Seele <cowose@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 08 00:27:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCIt0-0004dV-8b
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 00:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758750Ab1JGW0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 18:26:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35954 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754731Ab1JGW0U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 18:26:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05AD5565B;
	Fri,  7 Oct 2011 18:26:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Uc4klYOuOrk0Rkul/daltzpx7wY=; b=kSNW/0
	0eDS1qs3d5wuNLb9bLWSwQ/AZGhMPYklsYbbYuKRTDfHkmtxaGE1GErvDgJ+211z
	bSqRvizrbw79pBdwCX7SC/r3mdJiOMqriZsS0ydzrQgG9CJqmgaGg/ch35G1kKk6
	OU3dmss5z/PvsGVIMPjqBDa+PikOLpeqDNmKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d90Pcf1Qj0Aejj7g21+DhxV2RJ2Y5KZY
	gOYAEPBDMfFvu8kZNm06g9SSBD/sDXQjcMgpjWw+fFpzVBv/pOSzV1aDUvjLGS7Z
	9Gym4zZ6erXfeVC++WhpwQhR56ifVxvPJg5sCS+n4pYZjKmwflFlcJvmQQzj45M6
	jx7NJNQPBjc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F06565659;
	Fri,  7 Oct 2011 18:26:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 805235658; Fri,  7 Oct 2011
 18:26:19 -0400 (EDT)
In-Reply-To: <201110072344.46556.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 7 Oct 2011 23:44:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 61168196-F133-11E0-9D7F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183118>

Jakub Narebski <jnareb@gmail.com> writes:

>   char *expand_user_path(const char *path)
>   [...]
>                 if (username_len == 0) {
>                         const char *home = getenv("HOME");
>                         if (!home)
>                                 goto return_null;
>                         strbuf_add(&user_path, home, strlen(home));
>                 } else {
>   [...]

Ahh, Ok. I was afraid getpwnam() codepath might interfere with it.
