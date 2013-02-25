From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] mingw: rename WIN32 cpp macro to NATIVE_WINDOWS
Date: Sun, 24 Feb 2013 22:44:03 -0800
Message-ID: <7vliac3nbg.fsf@alter.siamese.dyndns.org>
References: <50EB8EB5.6080204@gmail.com>
 <CALxABCYHRp17rcoOca1xWG9S19fq2rotz8FEKo09jNdrgMLiyQ@mail.gmail.com>
 <CALxABCavvW77djKQnbQsjCBcahmMfrP24SDz609NG-94_ifZ9Q@mail.gmail.com>
 <50F303D8.20709@gmail.com> <50F5A435.5090408@ramsay1.demon.co.uk>
 <20130120101007.GD16339@elie.Belkin> <50FEDB08.6030901@ramsay1.demon.co.uk>
 <51031C43.5030307@gmail.com> <7v38xo3irh.fsf@alter.siamese.dyndns.org>
 <51032481.4030707@redhat.com> <20130126010359.GH3341@elie.Belkin>
 <5106C382.20009@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Eric Blake <eblake@redhat.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Jason Pyeron <jpyeron@pdinc.us>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Stephen & Linda Smith <ischis2@cox.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 07:44:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9rnc-0004Ea-Uz
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 07:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754895Ab3BYGoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 01:44:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53330 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751551Ab3BYGoF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 01:44:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CE34A5A6;
	Mon, 25 Feb 2013 01:44:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=XN3idPdfo8XfpzOgubWLLsSJaAE=; b=l39tlmOdZlcJ8+cyCyxA
	Jx5YyziUjtck3Qcil9LOs/oW943AWRbz+N8OmPQdia2dcfr25RhyHKaYy/wzvLeQ
	RyC/ZGbwJJDVe8uBDlqL5pGvdLMHyyEZSUzlK3NIKz9/IWlFAQ+rvu68v4CMFy37
	Y2KLMjgFwjK8rFFnGUQRQNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=FbHJP3iujaUJ5zem4W/36qnlO4XVxoH72IaxhQS7LSDz1x
	jD2rKZ+RE5BLEUzZyy3H+8xMuwCfIjRTrccStGpE6hrCCV+U0rkXf4WsmRQPWRnD
	mSQHHFA+6GH88IepZXc5mDLzgcX7UezcXK2m19aG7SKinP9nGkaylC4Ajj2AQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60AFAA5A4;
	Mon, 25 Feb 2013 01:44:05 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5983A5A3; Mon, 25 Feb 2013
 01:44:04 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF330458-7F16-11E2-9378-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217036>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Jonathan Nieder wrote:
> 
>> Throughout git, it is assumed that the WIN32 preprocessor symbol is
>> defined on native Windows setups (mingw and msvc) and not on Cygwin.
>> On Cygwin, most of the time git can pretend this is just another Unix
>> machine, and Windows-specific magic is generally counterproductive.
>> 
>> Unfortunately Cygwin *does* define the WIN32 symbol in some headers.
>> Best to rely on a new git-specific symbol NATIVE_WINDOWS instead,
>> defined as follows:
>> 
>> 	#if defined(WIN32) && !defined(__CYGWIN__)
>> 	# define NATIVE_WINDOWS
>> 	#endif
>> 
>> After this change, it should be possible to drop the
>> CYGWIN_V15_WIN32API setting without any negative effect.
>> 
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>
> If we go with this approach, could we prefix the symbol name with GIT_
> in order to reduce the global namespace pollution?
>
> eg GIT_NATIVE_WINDOWS, or GIT_NATIVE_WIN32 or just GIT_WIN32.
> (Yeah, I'm not good at choosing names!)

I was in "find leftover bits" mode today and found this thread hanging.

Has anything come out of this thread, or there is nothing to improve
in this area?
