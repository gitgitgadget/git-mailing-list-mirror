From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] valgrind: ignore SSE-based strlen invalid reads
Date: Wed, 16 Mar 2011 04:56:32 -0500
Message-ID: <20110316095632.GA8277@elie>
References: <1300267874-15365-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Mar 16 10:56:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PznTA-0002ZO-Ue
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 10:56:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552Ab1CPJ4k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 05:56:40 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45516 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370Ab1CPJ4j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2011 05:56:39 -0400
Received: by gwaa18 with SMTP id a18so582458gwa.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 02:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ZzaGmks+vJS4oAD9TWy8RxdKp44rxoVFWwJuXkHrNIE=;
        b=Tug3+nuSIUm0uwIPmoLcIzKmzm8RJ+NP9a1iPVi4h2kApljJAx5QD0IiSEag6e16yR
         ytjeKpnyN9RnovhNPtJhW/eEZoKPO09Un0YYzXq7R7i1IY/LGh81/bkzO8vjy3xAwZWs
         Vk1DmmfN3wqdSw42v5CHK/r2f9NhWfjhlyRCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Z0j59g2s99Z9spUkXCq/HSXzvMwlxIdMuszD6Cb/BjKQEp217VsPOA3rkvD9bRzLTw
         hrGtvXzWRPCBjjG8wOLiFwipweq/UJ4ca7l6FMI3qlNNLGnn7Fh/wJ7++ZFdIubr/O6Y
         zLuQxGwytb1d6Bt3vYjf8tbu+jNK8tJrMUNbs=
Received: by 10.151.77.4 with SMTP id e4mr1122766ybl.147.1300269398456;
        Wed, 16 Mar 2011 02:56:38 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id q18sm3468110ybk.23.2011.03.16.02.56.37
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 02:56:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1300267874-15365-1-git-send-email-cmn@elego.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169131>

Hi Carlos,

Carlos Mart=C3=ADn Nieto wrote:

> The C library uses SSE instructions to make strlen (among others)
> faster, loading 4 bytes at a time and reading past the end of the
> allocated memory. This read is safe and when the strlen function is
> inlined, it is (obviously) not replaced by valgrind, which reports a
> false-possitive.

It would be GCC rather than the C library if the strlen is inlined, I
think.  Is this a distinct bug from
<http://bugs.kde.org/show_bug.cgi?id=3D266961>?  Has it been filed
with the valgrind maintainers?

Thanks,
Jonathan
