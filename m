From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Teach rm to remove submodules unless they contain a
 git directory
Date: Thu, 27 Sep 2012 09:53:33 -0700
Message-ID: <7v8vbvs8z6.fsf@alter.siamese.dyndns.org>
References: <50634799.7090807@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?TWljaGHFgiBHw7Ny?= =?utf-8?B?bnk=?= <mgorny@gentoo.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Sep 27 18:53:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THHLP-0000yi-Cc
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 18:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442Ab2I0Qxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 12:53:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63174 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751140Ab2I0Qxh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 12:53:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7FDC904C;
	Thu, 27 Sep 2012 12:53:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mkj/SHuNnx6b3KU9e1idNgSEgwo=; b=KHeYjL
	//1DfPAdL6rtL4EUJQoi1o8XDe+noiD6OVB06jui6i6rMR69MaMu2pK2XDtX+B3n
	M6Vn2RFYdYy3hgvY+ZVJ1RaC0efUOHB6egVRB838EGmLg8DOflEhcFHx9J7X8IeV
	BGgLod6v+jdpur195KSiFUWh0OJDQtG7Hs9nE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C8YCcGX1ksALE0zR3UzjX1F+jp3MILXS
	lolw5l9jTMMxFIbJshk0Z/35d3LeoJuCVu3yVGARRcicGUGkjaLyXFjopNuSz4J3
	9b9T49Bf0OvfBXjbDZeC3RaPLbQfjvSz4YdXo+wp7gIjmfdroxY06a8S/dXj3iwn
	xCMJ43CMjLM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95B1A904B;
	Thu, 27 Sep 2012 12:53:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 13E01904A; Thu, 27 Sep 2012
 12:53:35 -0400 (EDT)
In-Reply-To: <50634799.7090807@web.de> (Jens Lehmann's message of "Wed, 26
 Sep 2012 20:21:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E0FDA418-08C3-11E2-8A62-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206486>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Changes since v3:
> - Added get_ours_cache_pos() helper to only check stage 2 of a conflict
> - Added tests for modified submodules in the conflict case

Thanks.

> +			/*
> +			 * Skip unmerged entries except for populated submodules
> +			 * that could loose history when removed.
> +			 */

s/loose/lose/, I think.
