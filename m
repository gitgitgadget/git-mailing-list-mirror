From: Michael G Schwern <schwern@pobox.com>
Subject: Re: [PATCH 4/4] Move initialization of Git::SVN variables into
 Git::SVN.
Date: Fri, 27 Jul 2012 13:56:02 -0700
Message-ID: <50130062.7090901@pobox.com>
References: <1343344945-3717-1-git-send-email-schwern@pobox.com>
 <1343344945-3717-5-git-send-email-schwern@pobox.com>
 <7vhast3hpb.fsf@alter.siamese.dyndns.org> <20120727053800.GC4685@burratino>
 <7v394d3ffc.fsf@alter.siamese.dyndns.org>
 <7vpq7h1z1q.fsf@alter.siamese.dyndns.org>
 <7vlii51xz4.fsf@alter.siamese.dyndns.org>
 <20120727200703.GA2034@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jul 27 22:56:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SurZz-0005kU-RQ
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 22:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859Ab2G0U4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 16:56:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47474 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751579Ab2G0U4E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 16:56:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1427C9160;
	Fri, 27 Jul 2012 16:56:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=9Io3yxpqP8cs
	2YOzQr69Q4PxfAo=; b=BLh8R5/O8BOp0ij4ad0iW5B9hLaUiJECE1WbUYJ604hy
	qdqdcNCmJWb3x9UuqHVa3irVeK4D2SiQgVnaqQpufrSrXAgpYZYTZAV1K+KpPfnF
	RnGoPN773ba9ynTordXN74FfY3XR1IAdinMm/tbLK7yLIbLiiuGuftTQu2OueCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ai+kmP
	kA07mkAU2dPz56Xsy2FPfbIsgObvvqThIMpmrDGOcBZU8xk8UfLG6sEvAIQA8Xc/
	lpU0n07wEqeSxV9OgjH3ZMcYj040DBPDUdyjExPuxddZLgyPfE48TDWNF0immeJP
	OYjjY0Q/4ktVPm5iL++wgGHkIMHEAV7ale/Co=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3856915F;
	Fri, 27 Jul 2012 16:56:03 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F228F915D; Fri, 27 Jul
 2012 16:56:02 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120727200703.GA2034@dcvr.yhbt.net>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: 7A5715F8-D82D-11E1-8F49-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202375>

On 2012.7.27 1:07 PM, Eric Wong wrote:
> While Makefile.PL now finds .pm files on its own, it does not
> detect new files after it generates perl/perl.mak.

Are you saying this doesn't work?

perl Makefile.PL
make -f perl.mak
touch Git/Foo.pm
perl Makefile.PL
make -f perl.mak

or this?

perl Makefile.PL
make -f perl.mak
touch Git/Foo.pm
make -f perl.mak

The former should work.  The latter is a MakeMaker limitation.  Makefile.PL
hard codes the list of .pm files into the Makefile.


-- 
Who invented the eponym?
