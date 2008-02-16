From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/2] mailinfo: support rfc3676 (format=flowed) text/plain messages
Date: Sat, 16 Feb 2008 02:43:41 -0500
Message-ID: <76718490802152343g6a987c8ay80493187d0a3ccba@mail.gmail.com>
References: <1203042077-11385-1-git-send-email-jaysoffian@gmail.com>
	 <7vr6fei1s4.fsf@gitster.siamese.dyndns.org>
	 <76718490802151037m87995c2gacf29667259eae41@mail.gmail.com>
	 <7vodahcrrl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 08:44:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQHic-0006CK-7n
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 08:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbYBPHno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 02:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbYBPHno
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 02:43:44 -0500
Received: from qb-out-0506.google.com ([72.14.204.233]:43794 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbYBPHnn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 02:43:43 -0500
Received: by qb-out-0506.google.com with SMTP id e11so385940qbe.15
        for <git@vger.kernel.org>; Fri, 15 Feb 2008 23:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=eP+4tWT3FvSLJPVpXltuKq4IwBr5isI9DPcHWx4HAq8=;
        b=FAR2yOugs+BdlZG5zCzWwo5CL+cNR3mVCUQzA2wYesOt+X91i27jBRA5NDaDZRv398MGnaGLcPccCoSU6WiPqCKlM27npPFJOr6umq5Xemyn8LgBrOPMifzG0VcXCDYDeSB112HkvJ7Ds3jKnY2r8NQQjDVOXpJdjgEboX2defo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dl8ejP4ue1nOE2PV3KT8m8N25DPloeptaubi7xh46JvxJm/cAPToPzEYmdo29u/Btq4KyWYLPUkCIzz4/g7UB96453S+BcI9joHBP7UxCc0Zy3ITxB59z7ffRB6qw+9jDlIPyFznweCWCP/C/4Y/LqkImtOW9FOLHuZ3AipM2JU=
Received: by 10.114.192.1 with SMTP id p1mr3978457waf.47.1203147821839;
        Fri, 15 Feb 2008 23:43:41 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Fri, 15 Feb 2008 23:43:41 -0800 (PST)
In-Reply-To: <7vodahcrrl.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74025>

On Feb 16, 2008 1:57 AM, Junio C Hamano <gitster@pobox.com> wrote:

> But format=flowed is different.  It loses information.  Not just
> one space at the end of the original line, but if you have very
> long line that has more than one spaces at an unfortunate place,
> the sending MUA can cut the line there and leave a single
> trailing space for the receiving end to reflow.

Well, according to the RFC, that shouldn't be the case. The only
lost information should be trailing whitespace. Embedded
whitespace should not be altered.

> RFC3676 may be a good text communication medium.  It is just not
> suitable for patch transfer.  Just don't use it.

Would you consider making this configurable. Something like:

applymail.allowed_flowed = true/false/warn

If you're completely opposed though, we should modify git-am
(and/or mailinfo) to reject format=flowed messages entirely, no?

j.
