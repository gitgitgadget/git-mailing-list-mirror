From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.6.4.rc1
Date: Wed, 15 Jul 2009 23:55:41 -0700
Message-ID: <7vocrl9kwi.fsf@alter.siamese.dyndns.org>
References: <7vmy75bg2f.fsf@alter.siamese.dyndns.org>
 <4A5EA598.5050801@garzik.org> <7v3a8xb0lz.fsf@alter.siamese.dyndns.org>
 <4A5ECC09.3010405@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751223AbZGPGzu@vger.kernel.org Thu Jul 16 08:56:39 2009
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751223AbZGPGzu@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRKtQ-0002Up-W2
	for glk-linux-kernel-3@gmane.org; Thu, 16 Jul 2009 08:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbZGPGzu (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 16 Jul 2009 02:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbZGPGzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jul 2009 02:55:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52068 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbZGPGzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jul 2009 02:55:49 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 916198597;
	Thu, 16 Jul 2009 02:55:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2A1688596; Thu, 16 Jul 2009
 02:55:42 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B1617410-71D5-11DE-8894-9AE02FB70C38-77302942!a-pb-sasl-sd.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123371>

Jeff Garzik <jeff@garzik.org> writes:

> I want to publish this tree to the world via a *.kernel.org-like
> system, so my task is to
>
> 	scp -r /spare/repo/cld/.git remote.example.com:/pub/scm/cld.git
>
> but if I do this with scp, then future pushes to
> remote.example.com:/pub/scm/cld.git emit the warning about updating
> the currently checked-out branch

I think "scp -r" is a wrong way to "clone", as it will copy .git/config
that is specific to your local work tree that does not apply to the
situation at remote.example.com anyway.  You do not want to push into your
local repository with a work tree you are "scp -r"ing out of, but you do
want to push into the one at remote.example.com.

Interestingly enough, we had a two separate thread about making a bare
repository out of a repository with a work tree today ;-)

	remote.example.com$ cd /pub/scm/
        remote.example.com$ git clone --bare over.there:/spare/repo/cld/.git cld.git
