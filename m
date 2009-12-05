From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add commit.infodisplay option to give message editor
 empty file
Date: Fri, 04 Dec 2009 23:30:56 -0800
Message-ID: <7vpr6t6fnz.fsf@alter.siamese.dyndns.org>
References: <1259967879-65517-1-git-send-email-jh@jameshoward.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "James P. Howard\, II" <jh@jameshoward.us>
X-From: git-owner@vger.kernel.org Sat Dec 05 08:31:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGp6l-0000yo-C9
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 08:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbZLEHbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 02:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752521AbZLEHa7
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 02:30:59 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51634 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806AbZLEHa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 02:30:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 62387A4F0C;
	Sat,  5 Dec 2009 02:31:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=E1disX586S3btManTW5FqDbjLZ4=; b=i9lsSB0fR14SVB8M5Tb5S2P
	mpNkDgY5u2rWAsSWZMFpTECSveDOsIlN78wT8Lwh7/NHsjeeZtyXG6cqcodMzt0E
	XnXOjaYiahyFL3UjM8d2ZrR9dFGoNM4zGqPbldUNN5gVPn5Vj2+py3NduL5RbY7d
	eXbLA/dkow18rv3t8DQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=BPY9kJozaJeX5veK4PxwgZmSXcrvicTIzkS5USNBt4vsjXnZU
	1oWYwtWzWvf24zX6XQQvPXnBZxl33ucqu3Wo5xJ/OENM44rw4R6GvoTKmC+PCLdf
	8oNcW7ecm9BlbeEKV6Hn/SFIyBXqABG8VA9agIKiyDIhtI9IZjQEBVDAGM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 42D39A4F0B;
	Sat,  5 Dec 2009 02:31:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4D4AEA4F0A; Sat,  5 Dec 2009
 02:30:57 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2348E892-E170-11DE-82EC-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134592>

"James P. Howard, II" <jh@jameshoward.us> writes:

> This patch creates commit.infodisplay which causes git commit to
> display the status information on the standard output rather
> than in the temporary file for the commit message.  By doing
> this, it becomes feasible to set core.editor for commit messages
> to be a line editor, e.g. ex or ed.

Two points and a half:

 - Why does info_display need to be visible to everybody else by being in
   cache.h and environment.c?  Shouldn't its scope be similar to that of
   template_file, that is static to builtin-commit.c?

 - A configuration variable that does not allow the users to override from
   the command line is a no-no.  We usually do command line option first
   and then (or at the same time) configuration variable as a typesaver.

 - While the amount of change necessary for this change doesn't look too
   bad, is it really worth it?  What is wrong with "1,$p" while using ed
   as your editor?
