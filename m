From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2014, #07; Fri, 28)
Date: Mon, 31 Mar 2014 15:04:55 -0700
Message-ID: <xmqqmwg62feg.fsf@gitster.dls.corp.google.com>
References: <xmqqtxai7ym6.fsf@gitster.dls.corp.google.com>
	<CACsJy8CucWgHWjwpq+=wD1KQuTNpx2sokhQtFY02Puy-FFJi4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 00:05:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUkKE-0007A8-HI
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 00:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbaCaWE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 18:04:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58818 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987AbaCaWE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 18:04:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAD1E79C62;
	Mon, 31 Mar 2014 18:04:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=tVR9C70Dert115qkqsznXyClfV0=; b=yQtog7wI4iZ5GzZdneWy
	chAXMk7rHrlVePXKhtJovYNoV68ZIrP1NXbmXAmvsnwgOSCckty0Gp1tnZzm1RZB
	SaNp5ZQHeCqY7/LJw/dB6BQQLCYQl3Xi+FrESJPYc0InRpfntveYvA9MdrNkCBSo
	W7VrnEXMGLexFoBdfcx8MzE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=IUnXIbCiUkWoF+WWydUQuBDwWaJMSPRFXdJSPdvKG5x0jw
	XIea/5FtkoLh/ox1JrcBGkYLRuVRNgFP63pBVnufhsmVa3Ufomtn8MjtnCztgUUP
	W1PxDFap8X8qiipmUm0xNHu8RipUkBOtnn9lD3uMGhWgR2+eUx+EDPIDrNdfM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BACD479C61;
	Mon, 31 Mar 2014 18:04:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0003D79C5E;
	Mon, 31 Mar 2014 18:04:56 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7EE2BA84-B920-11E3-9398-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245549>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Mar 29, 2014 at 5:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * nd/gc-aggressive (2014-03-17) 4 commits
>>  - gc --aggressive: three phase repacking
>>  - gc --aggressive: make --depth configurable
>>  - pack-objects: support --keep
>>  - environment.c: fix constness for odb_pack_keep()
>
> Using --before=1.year.ago my way does not keep all recent chains short
> because commit time is unreliable. But even with better recent object
> selection, the performance gain is still within noise level. I suggest
> we keep " gc --aggressive: make --depth configurable" and drop the
> rest.

I think the three-phase thing may not be so well conceived or
cooked, but the other three looked like reasonable changes, although
it would have been easier to say so if "pack-objects --keep" were
done without a new buffer of size PATH_MAX ;-)

Let's do the const and --depth and discard the other two.
