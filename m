From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Questions about the new
Date: Mon, 12 Oct 2009 14:06:29 -0700
Message-ID: <7v8wfge2zu.fsf@alter.siamese.dyndns.org>
References: <loom.20091012T115746-719@post.gmane.org>
 <4AD31EBF.6090307@viscovery.net> <4AD3619C.6010808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 23:14:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxSDf-0002of-KT
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 23:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbZJLVHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 17:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbZJLVHV
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 17:07:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41552 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144AbZJLVHT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 17:07:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 313B775D11;
	Mon, 12 Oct 2009 17:06:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=NHcMLB6sYmxckjtIpeiNE2SfhYI=; b=Ig0NPNsGVuvrIBNYlNP8S+L
	v9y9hlZcaHlqbJy+G9+LPpf3XH/iRc6UKz4U4wjgDr37A3nPuaHKLvSB2FbpKqdG
	ChMp79paaxyzoD3GagctATgFvHVQIufJWJmfyN18mtmMlbcTpoDH9QVPAY8kD5e2
	EZE/eTtt1pvB3xZVlBJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=xGDXZ8Op8TJM95cCxb/7zdAs5/SYuMQpWon0A8Dbjf5sR69zT
	TZVSUWttZPRCvI04Ew0wQneb2DtoC9DjnByrJn578Ah9ZX0x/S3NmAeiDg7ZR+HS
	Ey3KKZHSSx0R7KJ3P8JvJuOsJgs0hC3PvRDa4RgAOJCZq4ckZYGeinvJM4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 04AFA75D10;
	Mon, 12 Oct 2009 17:06:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BD22A75D0E; Mon, 12 Oct 2009
 17:06:30 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1FC40098-B773-11DE-9ACB-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130069>

Sergio Callegari <sergio.callegari@gmail.com> writes:

> If I want to replace some commit X by some commit X' I merely need to
> modify the
> parent information of all the commits that are child of X so that they
> pretend
> to be child of X', or am I missing something?

You need to find all the commits that are child of X in the first place.
What should happen if your colleague has such a commit in his repository
(which you haven't fetched from yet), you enumerated all children of X
known to you in your graft file and then you fetch from him?  You need to
enumerate all children of X again to keep the graft file up to date.

> Thanks for the explanation. Can this be made possible for grafts too?
> Wouldn't it be a matter of having history walkers never obey grafts but
> keep track of them (i.e. of the history of the parenthood they
> reference)?

In the past we discussed the possibility of that for quite a while but
never saw a successful implementation.  The replace mechanism seemed a
cleaner way to do this, and it turned out to be the case.

You are welcome to try doing that for the grafts, of course.
