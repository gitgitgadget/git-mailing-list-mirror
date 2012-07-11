From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] read-cache.c: Handle long filenames correctly
Date: Wed, 11 Jul 2012 09:33:51 -0700
Message-ID: <7vobnmfea8.fsf@alter.siamese.dyndns.org>
References: <7vy5mtlebz.fsf@alter.siamese.dyndns.org>
 <1341998558-8502-1-git-send-email-t.gummerer@gmail.com>
 <1341998558-8502-2-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 18:34:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SozrU-0002qp-0H
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 18:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932738Ab2GKQdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 12:33:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62202 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752743Ab2GKQdy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 12:33:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6FCA3F53;
	Wed, 11 Jul 2012 12:33:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2DIeg5oU+zjKtSRYmqWZV251o4k=; b=N8PVvA
	UmpzJrt2MWkfasA3eD2v92Ek0eM6e77iytcSPoUYEkzzV68iPrdPOZZBGM56ft55
	dwoi9tTsrc7Shf5uPnV58UW65UcOTKPAzTvet2Y5/CgCKLOf9PksctKcpUfmvtOw
	l3WMdVmF9F1zfJerend9UNQiWvtGJMBxy0bK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uK4WG/QpPNHrvDC1WZraf3BDnQoOSXcm
	UUbjA4BmCE0kM90hVs7nis2iiZAMJL/2UJLOKQID7M9UV9tUGyTrt/SSZe7bzASw
	VVmhnpLgtSdDq0q9uwprTx4n/p3xwpeqypcHe6a8xyH/CM8eXdAeo8XFQvkuPwHh
	AcggJ9J5ajQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE2EA3F52;
	Wed, 11 Jul 2012 12:33:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 579E73F51; Wed, 11 Jul 2012
 12:33:53 -0400 (EDT)
In-Reply-To: <1341998558-8502-2-git-send-email-t.gummerer@gmail.com> (Thomas
 Gummerer's message of "Wed, 11 Jul 2012 11:22:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 33D08CC2-CB76-11E1-BF3E-C3672E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201314>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Make git handle long file/path names (> 4096 characters) correctly.
>
> There is a bug in the current version, which causes very long
> file/pathnames to be handled incorrectly, or not even added to
> the index, if they share the first 4096 characters.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>

Ahh, I guess I should have opened my mailbox before starting to look
into this myself ;-)
