From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Is there a reason to keep walker.c ?
Date: Sun, 27 Jan 2008 13:23:13 -0800 (PST)
Message-ID: <m37ihv9d52.fsf@localhost.localdomain>
References: <20080127204535.GA4702@glandium.org>
	<alpine.LSU.1.00.0801272045490.23907@racer.site>
	<20080127205155.GA5476@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Jan 27 22:23:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJEyi-0000nk-PX
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 22:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754538AbYA0VXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 16:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753159AbYA0VXS
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 16:23:18 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:11487 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729AbYA0VXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 16:23:16 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1461338fga.17
        for <git@vger.kernel.org>; Sun, 27 Jan 2008 13:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=U9g5QFnf+fQL+tNASeokk30P/UdWfAgASRAGV+YLNVE=;
        b=Q4j4ltfm+4xQm3KvsvdOVYiMlLdd868KAl2k1c7cYom4Ws8pBmaWjYjzp1QNaeJQ88f8MMVzn4tnjVCffjSDA7+7Uv0T6xMfUo8IoOt2V9SH1YKsNDvYubjZXzVqDExmczi/kqlczauAxNyrMxA/yrx9u2x2Jz265qsC9TktboY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=CltUMx2XT2SI7s0vixbuBD6qtDCRjfnUy4SOwhrP9K5fC7H9vPNZSKzByUAF0BTxvQrYNCihYywZPqLsuiwXhC0S3y7sBNhhzCncP/bn3RlsesFU+IDkqOG/uOZujMo+UedvrVtKQNSHAu+r8S9ZPeuBbUcSMe0XxYFm2pVVZ10=
Received: by 10.78.185.15 with SMTP id i15mr6338365huf.15.1201468994685;
        Sun, 27 Jan 2008 13:23:14 -0800 (PST)
Received: from localhost.localdomain ( [83.8.201.236])
        by mx.google.com with ESMTPS id 7sm611774nfv.35.2008.01.27.13.23.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Jan 2008 13:23:13 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m0RLN7rt012463;
	Sun, 27 Jan 2008 22:23:07 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m0RLN5ZV012460;
	Sun, 27 Jan 2008 22:23:05 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <20080127205155.GA5476@glandium.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71833>

Mike Hommey <mh@glandium.org> writes:

> On Sun, Jan 27, 2008 at 08:46:59PM +0000, Johannes Schindelin wrote:
>> On Sun, 27 Jan 2008, Mike Hommey wrote:
>> 
>>> While working on the http code refactoring, I got to wonder if the 
>>> walker.c "wrapper", that is only used for the http transport, is still 
>>> worth keeping. If there are plans for others transport to use this code, 
>>> obviously, it would be worth keeping, but on the contrary, I think it 
>>> would simplify the http transport code even more. What do you think ?
>> 
>> Really, I was waiting for somebody needing ftp and/or sftp support badly 
>> enough, so let's keep it.
>> 
>> I mean, one of those guys asking for ftp push support _got_ to just start 
>> scratching that itch, right?
> 
> Though, technically, ftp push could work with the curl code.

IIRC git fetch works with FTP transport.  Somebody would have to write
replacement for WebDAV authentication for ftp / sftp / ftps to have
proper ftp push support.  There were request, but AFAIR no code.

Are you thinking about POP / IMAP transport, or XMPP one ;-PPP ?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
