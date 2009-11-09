From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] unpack-objects abnormal exit when pushing
Date: Mon, 09 Nov 2009 08:56:42 -0800
Message-ID: <7vd43ry6ut.fsf@alter.siamese.dyndns.org>
References: <vpqeio8eou4.fsf@bauges.imag.fr> <vpqhbt3ap3w.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Nov 09 17:56:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7XY1-0003om-D0
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 17:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbZKIQ4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 11:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752639AbZKIQ4q
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 11:56:46 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49568 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbZKIQ4q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 11:56:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1398E986C3;
	Mon,  9 Nov 2009 11:56:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5UrixNOxQx6YV1L58npfLzr9I24=; b=j1rn2N
	uacdiDDE1Iofmjaba7wgR3CqPZyCp+6CbYmO8aPAoLZnZgqtCNNCDquNcwblHUtl
	injSToAKqjHnt147Tb83VxfhkNSemzZpOCHeunQQYuK9DH9sYcdtjHJMiVeuNTFu
	XNBWe2dM9KPED7X8wuFjILh22DSX8f0ADZGzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xoSGCzgWyUcbbXwC7NPhDP8M5ffQ3Rzj
	q5sVOXxXbJUKxvWed2jEYYtwcMfRqd3lYCRbItcdSASSWagICKeALY4HviMtwKiS
	i4eqsX0GQOkoIicJFCz50Pt7mQcuraCDT5vbN/Son58nS5F2+JvbaHGT9WzwtKzY
	ilBggakw22s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E9526986C1;
	Mon,  9 Nov 2009 11:56:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EA4B7986C0; Mon,  9 Nov 2009
 11:56:43 -0500 (EST)
In-Reply-To: <vpqhbt3ap3w.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon\, 09 Nov 2009 12\:56\:19 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DDBFD7FA-CD50-11DE-B59C-BD45BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132494>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I just found a way to reproduce the problem using plain SSH, and not
> Git:
>
> $ ssh localhost cat < random.bin | wc
>     249    1460   65536
> $ cat < random.bin | wc
>     796    4545  204800
>
> So, sshd is broken on this machine, and I don't think Git is the one
> to blame.

Yuck; that sounds scary.
