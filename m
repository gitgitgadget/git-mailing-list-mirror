From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Change in .gitignore handling: intended or bug?
Date: Fri, 04 Mar 2016 09:28:31 -0800
Message-ID: <xmqq4mcm17b4.fsf@gitster.mtv.corp.google.com>
References: <1457057516.1962831.539160698.3C8B30BC@webmail.messagingengine.com>
	<20160304055117.GB26609@ikke.info>
	<1457071957.2027843.539286050.10CF8D0A@webmail.messagingengine.com>
	<20160304115634.GC26609@ikke.info>
	<CACsJy8AN7xxFuVX4c6aR_RdDiuDRPjqbXS8Y2+xD4pV8G2onfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kevin Daudt <me@ikke.info>, Charles Strahan <charles@cstrahan.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 18:28:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abtWx-0004Uf-7o
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 18:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758360AbcCDR2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 12:28:36 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58559 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757568AbcCDR2f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 12:28:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 259A148559;
	Fri,  4 Mar 2016 12:28:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L07YqaVpBF2nQFQrZIVAB2g7oJQ=; b=xtAbnW
	VWwesUR74uTTV9acOg6YK0KtsRKrbPVDiJ64OrmLEzxWdRLp6EIZ9Cw1NzO28H02
	q2d1RF7FxpFnwWI277nsiOAl2+0dQoC8thHePA6PU4l+qC3FmBbves7Xdj4hg1Ty
	mjx5iSwO/ybAKvLYxqPaFJODJtaGYgZu/SpVI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AkxPRGEnL4RoXD5rWlD//EN3oDzA8Sf8
	QcCAm+8HTe3DfYpL73uszFHIL9svBJeuuxYpu3DNSKolLVv1IRDuiXn2Xh94VUlg
	5t5fAEIacHD2/oTOcRa1/kw1z0EO/iWza6jgZ4STpoQLuIRD2znlSVJHyyc33CPV
	Q9+deTVGVw8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1D0C748558;
	Fri,  4 Mar 2016 12:28:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 94EB948557;
	Fri,  4 Mar 2016 12:28:33 -0500 (EST)
In-Reply-To: <CACsJy8AN7xxFuVX4c6aR_RdDiuDRPjqbXS8Y2+xD4pV8G2onfg@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 4 Mar 2016 19:36:46 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 853A384C-E22E-11E5-90F5-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288263>

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Mar 4, 2016 at 6:56 PM, Kevin Daudt <me@ikke.info> wrote:
>> Verified that it's different in 2.7.0, but 2.7.2 gives expected output.
>
> Thanks. 2.7.1 reverts the faulty commit from 2.7.0 that generated two
> other regression reports before this one. I guess it's all good then
> (except for the people still on 2.7.0)

Are we good at 2.8.0-rc0, too?  Somehow I had an impression that we
queued "another attempt to do it differently" or something.

 ... goes and looks ...

    $ rungit maint status -suall
    ?? baz/quux/corge/wibble.txt
    ?? baz/quux/grault.txt
    ?? foo/bar.txt
    $ rungit master status -suall
    ?? baz/quux/corge/wibble.txt
    ?? baz/quux/grault.txt
    ?? baz/waldo.txt
    ?? foo/bar.txt
    ?? foo/garply.txt
