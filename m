From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] "git shell" won't work, need "git-shell"
Date: Mon, 25 Aug 2008 13:44:42 +0200
Message-ID: <48B29B2A.6000802@gnu.org>
References: <20080824202325.GA14930@eagain.net> <7vfxoukv56.fsf@gitster.siamese.dyndns.org> <20080824203825.GB14930@eagain.net> <7vbpzikt4b.fsf@gitster.siamese.dyndns.org> <20080824222534.GC14930@eagain.net> <alpine.DEB.1.00.0808251235430.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Tommi Virtanen <tv@eagain.net>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 25 13:46:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXaW9-00027n-6l
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 13:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870AbYHYLos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 07:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753833AbYHYLos
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 07:44:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:59339 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825AbYHYLor (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 07:44:47 -0400
Received: by fg-out-1718.google.com with SMTP id 19so952788fgg.17
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 04:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=6OwM1ss0Q2G46H6uELKTch5gx5eAeW1yt6Bzm8zTLxk=;
        b=b0luvU+KyKbCfWARfOgh9wxXRJb1n74chKFMLcRU4IjY1S+TzxZc+ZXb1i5UTGjVy9
         supMCCnPbko05oEaCGPLBet909XCJ5sN/Ql9sPtK+h8zNpCqAdIy/I97/HjScc58XuLt
         tXaBoIxltNV+SYftTImhyvL6pfSsS/hv0W7ic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=W+JLmYfePBakEU/Zq+3NqlavoCmCpX83K4Uj0JfkoqyKdMlC8nL7cSUl8KiTp6bVyW
         6WJVzhTY7boaXLZ6q8l6ijZ7xGkB4ISB1rgsRCCS32YalXJn6B9zTQ14iu88lZ1MfAvF
         QDzZlpN2kMm2+HNnok6OYLAJsSF/kCGJAzvtc=
Received: by 10.86.98.10 with SMTP id v10mr3265696fgb.46.1219664685477;
        Mon, 25 Aug 2008 04:44:45 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.179.202])
        by mx.google.com with ESMTPS id 4sm689283fge.8.2008.08.25.04.44.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Aug 2008 04:44:44 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <alpine.DEB.1.00.0808251235430.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93611>


>> At the minimum, git-shell(1) should explain that one needs to use the
>> libexec path.
> 
> Or maybe the real issue can be fixed?  Namely that your configuration does 
> not work?  That would involve you actually finding out what's happening, 
> though.

He said so:

> The shell field in /etc/passwd is *exec*ed, not interpreted via sh -c
> or some such. For example, source of Debian's shadow, containing
> /bin/login:
> 
> libmisc/shell.c:80:	execle (file, arg, (char *) 0, envp);
> 
> I also tested this for real, and having a
> 
> test:x:1001:1001:,,,:/home/test:/usr/bin/git-shell
> 
> line works, and
> 
> test:x:1001:1001:,,,:/home/test:/usr/bin/git shell
> 
> just makes ssh loop asking for a password, logging
> 
> "User test not allowed because shell /usr/bin/git shell does not exist"
> 
> So, as far as I understand, as it currently is, "git shell" is utterly
> useless for what it was meant to do. Restoring "git-shell" will fix
> it.

Rephrasing your question, do you (Dscho) actually know *anyone* who has
a working setup with "/usr/bin/git shell" in /etc/passwd?

Paolo
