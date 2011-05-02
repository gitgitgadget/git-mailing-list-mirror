From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add --info-path and --man-path options to git.
Date: Sun, 01 May 2011 17:02:26 -0700
Message-ID: <7v62puq8a5.fsf@alter.siamese.dyndns.org>
References: <1304237785-56101-1-git-send-email-jon.seymour@gmail.com>
 <7vbozmthhy.fsf@alter.siamese.dyndns.org> <20110501234833.GC11550@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 02 02:02:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGgb3-0003nD-KH
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 02:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737Ab1EBACh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2011 20:02:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43957 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453Ab1EBACh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2011 20:02:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DCC6B5746;
	Sun,  1 May 2011 20:04:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8NDqayWbfgNd5Y69of2hhv7ZdCk=; b=l/eryD
	Y13R3ms0tFYQ2bG3tA+9QYjA94RFBcgExwtOsuun2kRON1UQ5jsajg2nRjIbr5ZG
	rVzZttTa1DL45e6HqLr46ggzdGvXMYxQyENTwT5NpHbsliifeQeEBKW0SfsrPQD9
	M9CSJ+C8Ds8BYNRz2RCEa1mkD5YDdO0NVTr0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sXAcv1S4qrmHE8Y0oNpdhPMFWUJ5N6HP
	Ho06CgEGuMuSWBtbI9dKlegmMpST6LVD+XA3XnP4j8VMifNhU8r5kPeIXO9bQwEm
	BuYJ2QwMhVxS1/rJ9FuzVv1FHBBFno5nD4Ab6K2siULMsjIL6caB1z6lWZ+3Rukz
	mniT08aNsPw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A7D415742;
	Sun,  1 May 2011 20:04:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6FA62573E; Sun,  1 May 2011
 20:04:31 -0400 (EDT)
In-Reply-To: <20110501234833.GC11550@elie> (Jonathan Nieder's message of
 "Sun, 1 May 2011 18:48:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C3B8AAEC-744F-11E0-A064-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172556>

Jonathan Nieder <jrnieder@gmail.com> writes:

> By contrast, man and info typically use standard search mechanisms:
> man using $MANPATH and info using the dir.info file.  The usual
> interface to git's documentation through a man browser is not
>
> 	man /usr/share/man/man1/git-add.1.gz
>
> but
>
> 	man git-add;	# or "man git add" if your man viewer supports it

I think you are forgetting the case where the git-man-path the user uses
to install git may be outside /usr/share/man (e.g. $HOME/share/man).  In
such an installation, by setting $PATH to include your installed git
binary (e.g. $HOME/bin), you should be able to say "git help -m git" to
tell help.c to internally prepend $HOME/share/man to the $MANPATH before
it kicks "man".  Does "man git-add" work without you knowing where that
directory is (iow, without having $HOME/share/man on $MANPATH)?  And if it
does not, how would you learn what directory to add to your $MANPATH?

Isn't that what this patch is solving?  I am not sure where the similarity
with the html documentation breaks donw.  The same thing for info.
