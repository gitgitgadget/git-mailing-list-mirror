From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] revert.c: defer writing CHERRY_PICK_HEAD till it is
 safe to do so
Date: Thu, 06 Oct 2011 14:55:25 -0700
Message-ID: <7vzkhdyecy.fsf@alter.siamese.dyndns.org>
References: <1317923315-54940-1-git-send-email-jaysoffian@gmail.com>
 <CAG+J_Dw8w9UGBzq4xK+i+QtA4ZuwJ5w1+mPg15mPNcGLuRaXyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, nicolas.dichtel@6wind.com,
	Jeff King <peff@peff.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 23:55:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBvue-00059Q-Cj
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 23:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759320Ab1JFVz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 17:55:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49028 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757353Ab1JFVz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 17:55:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D97FD6EDB;
	Thu,  6 Oct 2011 17:55:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DXsW4PltcnUmo3yy6pk/XNN+HdY=; b=ksC4W6
	U6Gr7PgCIMAB2PPr7SVatluxeMks5518C24BoMUDB7mO3AECG4GZAavXXpjDfUUm
	dDgmjBsJdp7zr0/2JZXrdkydnKkc6AYgugKSTg52PEKZEkA19MOXZ2LdCemuZ1WG
	gr6l06+eLmGFbZArXUARQToJ2YABrPgxDIcNY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HWChzHq+MD6NQAe7HiI5JcvH13Gl4CfU
	gsdy+L8f/F3E2ZPl8qVPGw5x402BHjt06ktWRx8VQ6+4gwQUzw0HXNVF77Bn3W54
	rIU/LZAR2SCS/M38JrC25zB17vYkwZX6lhCu5EZnzlQfjwsLjR6bSs7NQ7saJQom
	s6w9DnIUWAk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0AB86EDA;
	Thu,  6 Oct 2011 17:55:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 657FB6ED9; Thu,  6 Oct 2011
 17:55:26 -0400 (EDT)
In-Reply-To: <CAG+J_Dw8w9UGBzq4xK+i+QtA4ZuwJ5w1+mPg15mPNcGLuRaXyg@mail.gmail.com> (Jay
 Soffian's message of "Thu, 6 Oct 2011 13:58:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E61F0D46-F065-11E0-832B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183041>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Thu, Oct 6, 2011 at 1:48 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
>> Note that do_recursive_merge() aborts if the merge cannot start, while
>> try_merge_command() returns a non-zero value other than 1.
>
> Maybe you want this on-top:

Good thinking.

commit 4ed15ff067b548011b1eda8b12d46d887c4f056c
Author: Jay Soffian <jaysoffian@gmail.com>
Date:   Thu Oct 6 13:58:01 2011 -0400

    cherry-pick: do not give irrelevant advice when cherry-pick punted
    
    If a cherry-pick did not even start because the working tree had local
    changes that would overlap with the operation, we shouldn't be advising
    the users to resolve conflicts nor to conclude it with "git commit".
    
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks. Care to sign-off?
