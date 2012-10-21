From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2012, #06; Fri, 19)
Date: Sat, 20 Oct 2012 22:57:10 -0700
Message-ID: <7vfw58gyfd.fsf@alter.siamese.dyndns.org>
References: <7vmwzii37w.fsf@alter.siamese.dyndns.org>
 <CACsJy8A2PdG69hB1=YgHMAdibO=7_Uu5qvmyAqcrhdBVWy761g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 07:58:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPoYV-0006Vm-CO
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 07:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462Ab2JUF5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 01:57:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46027 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217Ab2JUF5T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 01:57:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DBF95B51;
	Sun, 21 Oct 2012 01:57:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=raoefWtHyNa6KvuPRDqKNccPTG8=; b=TYhtWz
	Osvb18TcczS87sn4as4r2aKeQRp7kGHZ8PWRasaFixH+YZR6plieDXIKzLi9lD2W
	JQhpxfHDmKlshUXZKVgJRzJQmCLnmoC+1C732yos503ULkl/Xf7EETLXQVVSu+aC
	xqA3ygrbrRCuFgCs1OfMXF8bs7tp78f1vBOmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dhTj/zc+X1PESpqF96M/h8bkPHdhICfu
	RB+VR9fB9Ua03te6pdHdcMoaTudOmeVDEeEa3L8Gw0NjA5Dkia5EFSeDn1iccyei
	yGIyiszFIuZD0YAwiUuCVbvKkgKoQ3h6OELBcUcIfrTdEvY5hWddQPp5ntGY4xPG
	HU7k8VXzmuQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B6BC5B50;
	Sun, 21 Oct 2012 01:57:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96C425B4E; Sun, 21 Oct 2012
 01:57:12 -0400 (EDT)
In-Reply-To: <CACsJy8A2PdG69hB1=YgHMAdibO=7_Uu5qvmyAqcrhdBVWy761g@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sun, 21 Oct 2012 11:24:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2887C33A-1B44-11E2-8FEE-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208105>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>>  I suspect that this needs to be plugged to pathspec matching code;
>>  otherwise "git log -- 'Docum*/**/*.txt'" would not show the log for
>>  commits that touch Documentation/git.txt, which would be confusing
>>  to the users.
>
> I do want non-recursive "*" in pathspec and "**" can help retain the
> recursive "*" semantics. But can we just flip the coin at some point
> and change "*" semantics in pathspec from recursive to non-recursive?

Fair enough; that indeed is a valid concern.  Something like
":(glob)" magic may be necessary as an early step.  Longer term
(like Git 3.0 where we might say "screw the existing users" and
redesign "if we were doing Git from scratch"), it would be nice to
have excludes, attributes and pathspecs all share the same syntax,
though.
