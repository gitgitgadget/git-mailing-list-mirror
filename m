From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Silence stderr in parse_commit*() subroutines
Date: Mon, 13 Feb 2012 10:44:59 -0800
Message-ID: <7vmx8mfu8k.fsf@alter.siamese.dyndns.org>
References: <5fa08a8b-f0a2-4796-bf0d-06a8f13bf703@b23g2000yqn.googlegroups.com>
 <CA+EqV8xiLYo8XE--c1QfuXdhentUFpHqfPYXHt72eCpEA_hCNQ@mail.gmail.com>
 <201202092114.40832.jnareb@gmail.com> <201202111402.31684.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rajesh boyapati <boyapatisrajesh@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 19:45:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx0tl-00007I-Ig
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 19:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757553Ab2BMSpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 13:45:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52992 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757425Ab2BMSpF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 13:45:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47BB46F7B;
	Mon, 13 Feb 2012 13:45:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/g3siOWRXJWLcUztRTnDi4F6jn8=; b=Q7dpYO
	GmR9ax5HYC4DYh/MLSoEfYbGD4tcOEqeKfsKDFQZp+jX4XUwbkmpTlWA/vlHw8dF
	om70AHyH8v6//z108vvNZDJTTmhaGyKdABcOe6vPD8WO9GiYyyFQeekL1iid8e9x
	raK1ATCzDZTPoQXMoolhWM2aKa53AirUtki8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fCrHrPudSI5X1yUY+VLhYIWihzbZ2pU7
	mPznwBbJEPqN6+aB4B2WZRg923vPO5G6eaoscoHWp7NOt45x4Nq1ia+88QOEybXx
	zLiy5DYEwOWAqhJEGO8etY7wWcimUkz6pITN5EaACPW05u2LU+zXHy1n2o0QnC2V
	6TKcNrL+qw0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3ECFE6F71;
	Mon, 13 Feb 2012 13:45:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B3006F70; Mon, 13 Feb 2012
 13:45:00 -0500 (EST)
In-Reply-To: <201202111402.31684.jnareb@gmail.com> (Jakub Narebski's message
 of "Sat, 11 Feb 2012 14:02:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D5C55AF4-5672-11E1-9D25-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190645>

Jakub Narebski <jnareb@gmail.com> writes:

> Anyway, here is the patch that should fix those "CGI: fatal: Not a valid
> object name HEAD" errors for you.

I have to wonder if it is simpler and less error prone to check HEAD
before doing anything else immediately after which repository is being
consulted, and give the same "no history at all yet in this project" page
for most if not all operations, instead of patching things up at this deep
in the callchain.
