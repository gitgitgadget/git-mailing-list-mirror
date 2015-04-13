From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Installing git binaries on a non-default directory (Ubuntu)
Date: Sun, 12 Apr 2015 23:05:36 -0700
Message-ID: <xmqq7ftg4l73.fsf@gitster.dls.corp.google.com>
References: <loom.20150410T183218-536@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Gianpaolo Macario <gianpaolo_macario@mentor.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 08:05:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhXVA-00006Y-Rt
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 08:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbbDMGFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 02:05:40 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58869 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751227AbbDMGFj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 02:05:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6357C3AA47;
	Mon, 13 Apr 2015 02:05:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AM5ZW1AtcN/RuSlp68oFf9PXhl8=; b=SRmMd0
	7twlNpE7CDxN0BBxFUR7nV1BhLqhJHpamCO35kfqyMLok5pbBj703wATqJqqdt1y
	og+lUQaXRv1fYqaojI8jfOGXB/6HwFCQXZO4eV/SQF+zSt25ow7SMqNa7UpPhd1q
	AvrKCV5PQ9ChWJObwBUhX71BtJNLdo3gNJfnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fsiZrIlvQMbQalO2NNqFM+gRO7C4ZCyB
	IHo6nwfmykiljZ8H+IkQb/Ps1yh7iav1P1IW0t70LIN/TPnDFmTg27nicNxRLHMc
	ktVmS6hxrv/lVEUWMRFV3RFYWeAdAlZeFYpst4o+yzOER1sOCPivwqRkjUzUy2pb
	CcFCQsmWdaM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CFA13AA46;
	Mon, 13 Apr 2015 02:05:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA9323AA45;
	Mon, 13 Apr 2015 02:05:37 -0400 (EDT)
In-Reply-To: <loom.20150410T183218-536@post.gmane.org> (Gianpaolo Macario's
	message of "Fri, 10 Apr 2015 16:34:26 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1B1811C8-E1A3-11E4-8F4B-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267067>

Gianpaolo Macario <gianpaolo_macario@mentor.com> writes:

> By some googling and after reading the git sources and the commit logs I 
> assumed that the `RUNTIME_PREFIX` option
> (see <https://github.com/git/git/blob/master/exec_cmd.c>) was designed for 
> that purpose,

I do not think so.

The standard procedure to stage into a temporary with "make install"
and then make a tarball is done by using DESTDIR, e.g. something
like

  $ make DESTDIR=/var/tmp/gittt ...other args... install
  $ tar zCf /var/tmp/gittt git-version.tar.gz
