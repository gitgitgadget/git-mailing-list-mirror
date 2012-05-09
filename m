From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/19] bash prompt: use bash builtins to find out current
 branch
Date: Wed, 09 May 2012 13:02:41 -0700
Message-ID: <7vzk9hqg0u.fsf@alter.siamese.dyndns.org>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
 <1336524290-30023-12-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 09 22:02:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSD61-0005ZA-TY
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 22:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757681Ab2EIUCp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 16:02:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33856 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756490Ab2EIUCo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 16:02:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAFC18E1E;
	Wed,  9 May 2012 16:02:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+EQibk08rmkl
	K/WPijejLvjNJ84=; b=AH4mILstjouja+1QGVk34PbYhPS0NunQHR3mIOfx30uB
	ZpJeP7a3hnJMzT5HyBnppqXJGxbofH/FmwUoX59uPxyNknvGjmYx3Bq0HBkPUPtx
	Xq93RtEGSbreib460GfJXGWJEJsGL8SpxxefXmQoMpiUyC01LPoSfmakn6pYvgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=u49c5v
	qNuQQKWS+n39YExKNIhT/geyEzFG1jj/CEuQj8XhoiAV5eJ7hRKAL46Qs7ReBnwZ
	OVDOEEh5U0IAzxPFInnCd2FPcpV+JCYVwjG4HYpt4hWKSfR6ee2U5AwQ92/SMjj1
	W2rWi0iaOI/n/SuqUUdLjny/Hvxkax8amYUWI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D261C8E1D;
	Wed,  9 May 2012 16:02:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A1DE8E1C; Wed,  9 May 2012
 16:02:43 -0400 (EDT)
In-Reply-To: <1336524290-30023-12-git-send-email-szeder@ira.uka.de> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?= message of "Wed, 9 May 2012 02:44:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F04BDD20-9A11-11E1-8E97-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197500>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> Since HEAD is a single-line file and the symbolic ref format is quite
> simple to recognize and parse,...

Strictly speaking, that is true only if you somehow know that HEAD is n=
ot
a symlinked symref.  You may end up reading [0-9a-f]{40} out of HEAD
without learning where the symbolic link pointed at.

I personally do not _know_ of anybody who is still using a symlinked
symref, but the reasoning behind 9f0bb90 (core.prefersymlinkrefs: use
symlinks for .git/HEAD, 2006-05-02) cannot go away by definition until
every project that benefited from the configuration the commit introduc=
ed
goes extinct, so I wouldn't be surprised if you get complaints from the
users if we adopt this patch.
