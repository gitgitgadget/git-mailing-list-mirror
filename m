From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3 2/2] rebase -i: save only original commit sha1 to save author information
Date: Mon, 22 Jun 2009 09:35:08 +0200
Message-ID: <200906220935.11581.jnareb@gmail.com>
References: <20090622042831.3858.67926.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Jun 22 09:30:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIdyi-0005ea-87
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 09:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbZFVH35 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jun 2009 03:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbZFVH34
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 03:29:56 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:50706 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbZFVH34 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 03:29:56 -0400
Received: by bwz9 with SMTP id 9so2915590bwz.37
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 00:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=pZZCo9OeA+K/r4Qd/RoppEwQ0X/0ZfffYnm5Md/DA6g=;
        b=kW4HnYmNuOcq7wlpnvChN5vP8e7qBHr1b1PCLML7f7kUbyrIw3c9kT49HpZcMACe4Y
         dPQKFYUqhItbaKrGsE/28sp2CPARpOsgay/+2lPU1fNOCnk1n0HruuTckahasLoKZfsD
         j6JsW7pn36HU3zoKGKKKnlWdwC0jEiYnUSG9E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=usLnKDOXpAoKojI8NFBjxr6gO+9d7mkYZK9U6H8xLuwqYSKHWzFrAWccyIIP3LdNBB
         3yILCs2kiIHN20Mq4Yv3MBcNc31S4Zjbc8u3/s7QswLXEGKDKXkD9odfb+fdHbYsELqC
         809sazvN/2uPIlgXvCTR5sEajmKt52MJseAh4=
Received: by 10.223.114.135 with SMTP id e7mr5480155faq.89.1245655797030;
        Mon, 22 Jun 2009 00:29:57 -0700 (PDT)
Received: from ?192.168.1.13? (abrz167.neoplus.adsl.tpnet.pl [83.8.119.167])
        by mx.google.com with ESMTPS id 21sm11851796fks.39.2009.06.22.00.29.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Jun 2009 00:29:55 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090622042831.3858.67926.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122013>

Christian Couder wrote:

> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
GIT_AUTHOR_NAME=3D"$author_ident_name" \
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
GIT_AUTHOR_EMAIL=3D"$author_ident_email" \
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
GIT_AUTHOR_DATE=3D"$author_ident_date" \
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0$USE_OUTPUT git commit --no-verify \
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0$MSG_OPT "$EDIT_OR_FILE" || failed=3Dt

Why not use 'git commit -C $(cat "$SAVED_COMMIT") ...' ?

--=20
Jakub Narebski
Poland
