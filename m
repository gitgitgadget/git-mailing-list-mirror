From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-hg: fix path when cloning with tilde expansion
Date: Fri, 09 Aug 2013 13:53:33 -0700
Message-ID: <7vy58a4mcy.fsf@alter.siamese.dyndns.org>
References: <CAMP44s1Jqao0YvBSh18t1C2LwAF4_u2GaTNx1RwdW+pmCFcxvQ@mail.gmail.com>
	<1376068387-28510-1-git-send-email-apelisse@gmail.com>
	<7veha266nq.fsf@alter.siamese.dyndns.org>
	<CALWbr2w2JjEr_hYX9ighu_-=iTV6etG=78g4AbKko64EsecxFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 22:53:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7tgr-0003te-2j
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 22:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031110Ab3HIUxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 16:53:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34267 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031087Ab3HIUxg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 16:53:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BE3C3806B;
	Fri,  9 Aug 2013 20:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ioL5yf5DiVPQYJvVIjrWKLHPGrg=; b=cfWj6h
	JNztoXUFKQQxo29KpDKh396W57aXHKyfM++uZN2k4TR0dPW9RfbD7iCnKPuL5uYI
	icx1IQBJwy1+FFTPVY/iActA/fcYoar84xzpi3b/WPklHQMvjSCsfbBfcg1Y8Vu+
	kHYAWiQoYT7e8aMbU21jiny9IHodaGLvXj0aE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B5IJ/me5OkdJkyjw+BAlgtjXitUrwSML
	Ide9YZP+sD2aMttpwShD73zuCLK3lLmXJPs36bPA/yhUqrC1iLwOemNp0LxLVqhH
	YS/sDTf/Wsvt/IQ19tSP5VUj28E7HJ6fpEUg97R/3Q7XPFqzdoGaQYfnOiUGK+M+
	/001g9448mc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FD943806A;
	Fri,  9 Aug 2013 20:53:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A98D338069;
	Fri,  9 Aug 2013 20:53:34 +0000 (UTC)
In-Reply-To: <CALWbr2w2JjEr_hYX9ighu_-=iTV6etG=78g4AbKko64EsecxFA@mail.gmail.com>
	(Antoine Pelisse's message of "Fri, 9 Aug 2013 22:09:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C1C501E8-0135-11E3-B499-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232029>

Antoine Pelisse <apelisse@gmail.com> writes:

> So when we run:
>
> git clone hg::~/my/repo
>
> Git will remove the "hg::" part, and Mercurial will expand tilde and
> clone $HOME/my/repo.

Now you confused me.  If the implementation were for us to remove
the hg:: prefix and let Mercurial do whatever it wants to do with
the rest, you are right that we will not have to do any expansion
like your patch.  But you sent a patch to do so, so apparently it
is not what happens.  So where does it go wrong?

Puzzled...

>> By the way, you earlier sent an updated 1/2; is this supposed to be
>> 2/2 to conclude the two-patch series?
>
> Those two patches don't interact with each other, but you can of
> course join them if it makes it easier for you (and I don't think one
> is going to have to go "faster" than the other anyway).

Hmph, so there is a different 2/2 that we haven't seen recently on
the list (meaning you have three patches)?

Thanks.
