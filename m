From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] refs: use strings directly in find_containing_dir()
Date: Tue, 22 May 2012 15:18:06 -0700
Message-ID: <7vhav73lnl.fsf@alter.siamese.dyndns.org>
References: <1337692566-3718-1-git-send-email-mhagger@alum.mit.edu>
 <4FBBE012.6090702@lsrfire.ath.cx> <7vlikj3nzc.fsf@alter.siamese.dyndns.org>
 <4FBC0F12.2000001@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed May 23 00:18:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWxPD-0003IJ-Lz
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 00:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758092Ab2EVWSK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 May 2012 18:18:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48949 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754212Ab2EVWSJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2012 18:18:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E78D82AB;
	Tue, 22 May 2012 18:18:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qtUMNx9PBLXQ
	u5Xa2VujPVeRN5U=; b=ot/3RYKE7WpF3SQU9aoaftJqEOG/+Zs1BlmOseFbDtlN
	n8gmqmT4MK5kITKos2JfZciZuJFc96TmzOyfwg4kVDXhom/VLrWVlOg+VpjR+5si
	q4ZHLiRGn0oSRBuEC5FeTAbcgYsqQFJP78vgGwD2mXRHGEbuvNOF003ZXrBPxmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QCJZfb
	11v63ZGZ90E10mYkyJJ9RmhlplVKmsfFCMc7RrNaF2/jFxk7mYxEumGwn+hrbAE4
	dHjeTe52QWRZ/pjmcsbPUpzTSNCPIkn+QhtM47+ZNQ9XJODU9qWHFb6p9aE5twA1
	LsJQ9JGf96oHm4UD+vQPra5PzIIIiWDuZxaZY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42CEA82AA;
	Tue, 22 May 2012 18:18:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA72982A8; Tue, 22 May 2012
 18:18:07 -0400 (EDT)
In-Reply-To: <4FBC0F12.2000001@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Wed, 23 May 2012 00:11:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 022F0D06-A45C-11E1-B521-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198259>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> What has git grep to do with refs?  It checks if the path in the comm=
and
> above is a ref, which makes it iterate over all of them..

Do you mean:

	/* Is it a rev? */
        get_sha1()
        -> ...
          -> get_sha1_basic()
            -> dwim_ref()

callpath?
