From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Makefile: Remove usage of deprecated Python "has_key"
	method
Date: Sun, 28 Mar 2010 14:54:43 -0700
Message-ID: <20100328215442.GA31195@gmail.com>
References: <1269737112-21631-1-git-send-email-davvid@gmail.com> <7vy6hc4d0h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 28 23:55:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nw0Re-0001tM-IZ
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 23:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755277Ab0C1Vyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 17:54:53 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:37340 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844Ab0C1Vyw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 17:54:52 -0400
Received: by gwaa18 with SMTP id a18so3671430gwa.19
        for <git@vger.kernel.org>; Sun, 28 Mar 2010 14:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=sE2CWf8aISrfK/vd5wTrhUqMNHyb4i1EEa9wzEWAXxU=;
        b=Hgr5S8vaur35DWh9ubBAwqOVRavqOEb89bO2wNMUmJhrLfZoAuKvX1MznzpmlI/gB9
         V3EFQDW2M4fEOEuoyevXKRD/WPfvfiAyZ9GYGJ/RqVKoUAltmJRSeCLlumYZlQO/IHT3
         vO1KL3ISwfmAsgZR53oteiC4iHoyeTRDph3Qo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YO8mTR7pkUeaY+Uf6IB/WbQh6MMWYZ/AlLouSjYA0/RXOofTFP8eMuOBKv52fy+NVk
         YHV8DOYK9Iu2J6CGdtS+RYD2YaODuQZHiI75FHTj6vPHvrjgpX5Ngr1/vC2ptowzLaF3
         M3ACa+ISvIgRQ7FL6Uzrg6I0mvbGeVe+6dU2I=
Received: by 10.150.56.10 with SMTP id e10mr2137365yba.57.1269813291509;
        Sun, 28 Mar 2010 14:54:51 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 4sm827378ywi.21.2010.03.28.14.54.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Mar 2010 14:54:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vy6hc4d0h.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143420>

On Sun, Mar 28, 2010 at 09:38:54AM -0700, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > "has_key" is a deprecated dictionary method in Python 2.6+.
> > Simplify the sys.path manipulation for installed scripts by
> > passing a default value to os.getenv().
> 
> It looks like the old code was replacing sys.path[0] but you are
> prepending this.  Doesn't that change also make a difference?

The original code replaced sys.path[0] which is ''
(aka the current directory).  It's a little odd to
rely on the 0th element being something that is safe
to remove.

By prepending the path we have the same intended effect without
having to know that the 0th element is something that is
safe to remove.

Does removing '' break relative imports? (It might...)

Due to the portability concerns with relative imports the
recommendation is to always use absolute imports.  Thus, this
shouldn't hurt us in practice if we stick to absolute imports,
but I figured I'd mention it as another reason why prepending
might be preferred over replacing.

-- 
		David
