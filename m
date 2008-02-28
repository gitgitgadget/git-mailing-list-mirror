From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 20/40] Windows: A rudimentary poll() emulation.
Date: Thu, 28 Feb 2008 10:36:36 +0100
Message-ID: <47C680A4.6050309@gnu.org>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-21-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Feb 28 10:37:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUfCb-0007K3-Mj
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 10:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755119AbYB1Jgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 04:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755176AbYB1Jgp
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 04:36:45 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:18407 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755069AbYB1Jgo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 04:36:44 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2636317fga.17
        for <git@vger.kernel.org>; Thu, 28 Feb 2008 01:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=usLr+F5rXAkuXfC10uULalsW1wTyhO0WpJ4IB8fjOxg=;
        b=IS+szxGucse9ZqIYScsqusNRyRFy7osRspZNVK2Np5XD4I21dtmpaB/vCQs1/v1tg6J4KeAihpj1fnpDsHv/+WQ0Ye67pho9MP58/tOZV9SIRa3aaO0gs3+mcfgIV349TSGyHABVENyaovZayO6d8m9HcFYtnrXg/2tkcd1uaDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=Gk9CV7FMXfho8epDhGsZ8Wb91ISWWYTrwSUMk4lzU02QaXFb07shZyowBdS/p57wLfPqnQDBvN+FkYMgRnY50va2ftVZHO1ySAdSDQQajU21UZgfXl2jsvdy6DOpNpivi/yOXIybdQIuL9g2KoFMaKQsimqjUuCqjSRJ1lQMX2Y=
Received: by 10.86.73.17 with SMTP id v17mr7807122fga.40.1204191402525;
        Thu, 28 Feb 2008 01:36:42 -0800 (PST)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id u9sm16904512muf.4.2008.02.28.01.36.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Feb 2008 01:36:41 -0800 (PST)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <1204138503-6126-21-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75372>

Johannes Sixt wrote:
> This emulation of poll() is by far not general. It assumes that the
> fds that are to be waited for are connected to pipes. The pipes are
> polled in a loop until data becomes available in at least one of them.
> If only a single fd is waited for, the implementation actually does
> not wait at all, but assumes that a subsequent read() will block.

For the future, would it be better to first use WaitForMultipleObjects, 
and then use PeekNamedPipe to find which handles have data on it? 
That's how the mingw port of GNU Smalltalk does it.

Paolo
