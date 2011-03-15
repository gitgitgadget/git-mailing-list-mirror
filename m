From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/README: Add a note about running commands under
 valgrind
Date: Tue, 15 Mar 2011 10:06:08 -0700
Message-ID: <7v8vwgb9fj.fsf@alter.siamese.dyndns.org>
References: <1300130318-11279-1-git-send-email-cmn@elego.de>
 <1300130318-11279-3-git-send-email-cmn@elego.de>
 <7v7hc1cvdt.fsf@alter.siamese.dyndns.org>
 <1300140119.4320.38.camel@bee.lab.cmartin.tk>
 <20110315011230.GA31865@sigill.intra.peff.net>
 <1300181536.19100.7.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Mar 15 18:06:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzXhS-00041Y-9s
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 18:06:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463Ab1CORGV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Mar 2011 13:06:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36961 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932435Ab1CORGU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Mar 2011 13:06:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D1F774A0F;
	Tue, 15 Mar 2011 13:07:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Dlqzp48p0B8+
	Htf/UXwr/Xl5heo=; b=TE2Amh3TOBwTHUhaXQs4CGdX//gybrCe7ORWhdspBdIJ
	jESVVTKXEGNlOXsHYRUqDiyTIL1Tuk2uQOwZ4zn6lNr6TrZ/8p3yVQ/p3d+t9RI0
	9zg16Q/EZ0WxvjNglACrTvBqDKz79OZKgdOU0nR8HR6z1NyXnNIkm3Plcrld3SI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=tVR+Ly
	7g6jAfVXg1ARBgQ+To9V0mNJ6o3/ie2A/5mKp7Z8vMWSkIwUEoqh9Cwl4B4eO4Jv
	K/4LfugfvE1aTkZrxzRqWhfGrx1gJjHYIlEfbwVa4KZTzLml1exQ/WWuKeE7yjH/
	opZIFSUeJ/D3RE+8aKhxGftE5imouE3CrmPzo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9FB094A0E;
	Tue, 15 Mar 2011 13:07:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3D3814A0D; Tue, 15 Mar 2011
 13:07:41 -0400 (EDT)
In-Reply-To: <1300181536.19100.7.camel@bee.lab.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Tue, 15 Mar 2011 10:32:11
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C05BD160-4F26-11E0-9966-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169077>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

>  As Jeff pointed out, the test suite does use --leak-check=3Dno. I wa=
s
> using valgrind manually as I was chasing a different error that does
> show up. How about adding this to the README?

> diff --git a/t/README b/t/README
> index 78c9e65..2a73fc3 100644
> --- a/t/README
> +++ b/t/README
> @@ -98,6 +98,13 @@ appropriately before running "make".
>  	not see any output, this option implies --verbose.  For
>  	convenience, it also implies --tee.
> =20
> +	*NOTE*: As the git process is short-lived and some errors are
> +	not interesting, valgrind is run with (among others) the
> +	option --leak-check=3Dno. In order to run a single command under
> +	the same conditions manually, you should set GIT_VALGRIND to
> +	point to the 't/valgrind/' directory and use the commands
> +	under 't/valgrind/bin/'.

I think what the text says is a good addition.  If I were writing this
myself, I would rephrase "*NOTE*:" to say "Note that ...", though, as t=
hat
seems to be more in line with the other parts of the document.
