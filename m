From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Minor bug in bash completion
Date: Wed, 30 Dec 2009 10:00:05 -0800
Message-ID: <7v1vic2vh6.fsf@alter.siamese.dyndns.org>
References: <4B3A140A.60302@steek.com> <20091230112222.GA493@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sylvain RABOT <srabot@steek.com>, spearce@spearce.org,
	git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Dec 30 19:00:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQ2qO-0002VF-2B
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 19:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbZL3SAS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Dec 2009 13:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbZL3SAR
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 13:00:17 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46317 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbZL3SAQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Dec 2009 13:00:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 454D2AB68D;
	Wed, 30 Dec 2009 13:00:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=rh4QbLmWXjEIRmXFUABW+UC3c
	Fc=; b=V8PrBSyxsUR+55Fg4/76+G/+nt09w1obCstoPwM9aCkkzaDijxumnnrNm
	Ud5nmIakSeVgxuLym7lWi5K+hnB5e+58/zi5XxodvZcT+HypWQYriDoy+S7Xaoew
	8yJne6MbfPbzBrxr6HRh0GyEyhx0EAsB5hdlPt0/AZSLO2EdWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=njJxWQrY/SN6n006qNH
	0JiczHHHfcJU3yseW2WvHuS5jIRut5kOllwDNbS5OsvZwKJFqRBed3mPZ/cJYckv
	I3mQXr8b7L7Y+kqlEy1yECWS3FfV+vMZlBoGKTf9X9+5pfNb3kJ0owdxRgiJ6iy/
	JxaiJUy/vd8EzddXeNG22LXM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0615BAB68B;
	Wed, 30 Dec 2009 13:00:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B2095AB68A; Wed, 30 Dec 2009
 13:00:06 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2CD148EE-F56D-11DE-BDBD-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135911>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> On Tue, Dec 29, 2009 at 03:36:58PM +0100, Sylvain RABOT wrote:
>> I found a bug in the git bash completion.
>> It occurs when I press tab to complete branch name when I want to pu=
ll =20
>> from the origin.
>> Instead of completing the branch name it prompts me directly for my =
=20
>> password on the origin remote.
>
> I don't think it's a bug.  The completion script should offer the
> currently available refs in the remote repository after a 'git pull
> <remote> <TAB>'.  In order to do that it contacts the remote
> repository for the list of refs available there.

It is definitely a non-bug since the user _asked_ to complete and the
information necessary to do the job the user _asked_ to do is only
accessible over the network connection.

I however do think this is an annoyance when it happens to you by
accident.  I wonder if it is worth to have a way for users to tell
completion to skip the ls-remote invocation (hence not getting branches
completed) depending on the type of remote.
