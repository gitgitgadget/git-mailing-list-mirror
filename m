From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Introduce git submodule attached update
Date: Tue, 07 Jan 2014 10:56:38 -0800
Message-ID: <xmqq38kzei3d.fsf@gitster.dls.corp.google.com>
References: <1388890249-3577-1-git-send-email-ceztko@gmail.com>
	<1388890249-3577-2-git-send-email-ceztko@gmail.com>
	<20140105203349.GB3737@book.hvoigt.net>
	<CALas-ijjzyRVuc0NaAS5QS98pX2198mv4HoHDacgYFYNLXbXFw@mail.gmail.com>
	<20140106140627.GA27265@t2784.greatnet.de>
	<CALas-ihHD_eJOXLUrhCVZjidQDmrCN=QpdfMKoN1i9A7FAo3RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	"W. Trevor King" <wking@tremily.us>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 19:56:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0bpY-0006Po-9F
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 19:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbaAGS4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 13:56:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62752 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857AbaAGS4n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 13:56:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D68BE614D2;
	Tue,  7 Jan 2014 13:56:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BGoL6W0sBR0H8vcp7JHefWXXzQQ=; b=pyWNTC
	1uD9uwMXGN5t7DffCo6fM6I/nJkDbLetIMKG4MSYHfdReZ16LVHdZs++UH8OAmRf
	znTwD5A5JfesdXaoR7SVvE3pf+z5qf4VCx0+hOrUzQMJ1Af598FwsPaEx+IPNOlR
	i1lQlmPIHHKbePAm89C0R8ZmKJjifpE1+SKqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DwAn569UUWBPNfNXGWHGtAruuLublHcu
	TTnhO5z455eayD+P8WgB9BHZbxNpIp9xyK5ckdhCXOvn4zq/ZqT1jYjfLnBTvo/m
	MqCOKW1Qesq7ONLkjhJTXobd6MXrjwe1OnifJMsgwBACx2gbNp0bNDbMUmMkEC37
	dsnApS3rvlk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4B4E614D1;
	Tue,  7 Jan 2014 13:56:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED857614CE;
	Tue,  7 Jan 2014 13:56:41 -0500 (EST)
In-Reply-To: <CALas-ihHD_eJOXLUrhCVZjidQDmrCN=QpdfMKoN1i9A7FAo3RQ@mail.gmail.com>
	(Francesco Pretto's message of "Mon, 6 Jan 2014 18:47:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 723CD43E-77CD-11E3-978E-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240128>

Francesco Pretto <ceztko@gmail.com> writes:

>>> >  - In which situations does the developer or maintainer switch between
>>> >    your attached/detached mode?
>>>
>>> The developer/maintainer does so optionally and voluntarily and it
>>> effects only its private working tree.
>>
>> This does not answer my question. I would like to find out the reason
>> why one would do the switch.
>
> The developer does it voluntarily, at his responsibility, because he
> may decide to partecipate more actively to the development of the
> submodule and still want to use a simple "git submodule update" to
> updates his submodules, overriding its configuration as it can be done
> for other properties like, for example, "branch".

It is still unclear to me why we need attached/detached mode for
that.  The developer may want to do an exploratory development,
whose result is unknown to deserve to be committed on the specified
branch at the beginning, and choose to build on a detached HEAD,
which is a perfectly normal thing to do.  But the standard way to do
so, whether the developer is working in the top-level superproject
or in a submodule, would be to just do:

	cd $there && git checkout HEAD^0

or use whatever commit the state to be detached is at instead of
"HEAD" in the above example, no?
