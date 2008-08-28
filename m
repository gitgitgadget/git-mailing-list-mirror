From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] be paranoid about closed stdin/stdout/stderr
Date: Thu, 28 Aug 2008 15:17:46 +0200
Message-ID: <48B6A57A.6050109@gnu.org>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu> <48B28CF8.2060306@viscovery.net> <48B29C52.8040901@gnu.org> <E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net> <7vbpzgb94q.fsf@gitster.siamese.dyndns.org> <E1KXsL9-0004ef-Co@fencepost.gnu.org> <48B3A948.3080800@viscovery.net> <20080826074044.GA22694@cuci.nl> <32541b130808262201v4d7c1aa5r781720a80b79fcd0@mail.gmail.com> <20080827091800.GB484@cuci.nl> <48B54A3D.3080708@gnu.org> <7vej4aqsge.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Karl Chen <quarl@cs.berkeley.edu>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 15:19:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYhOq-0007br-IR
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 15:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbYH1NRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 09:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752516AbYH1NRw
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 09:17:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:47746 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304AbYH1NRv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 09:17:51 -0400
Received: by nf-out-0910.google.com with SMTP id d3so54521nfc.21
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 06:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:sender;
        bh=9U1/1EIraFgyOkzn/leZ3r8szxEJUUNQjIJDeQRInCo=;
        b=MiEGm3H1lsjgE75MTyG1sc+S62yariGHbVT0ICeDACoxEVPwQ9GKxWjTQD2CxLx4Wn
         RRIpuZ6j95x0sXp6CwYS83aHjoq7Fa7tFEBjcWDoYzxY1l/D5rYqSO7sBP0Mw/b6/R2e
         qDP1NGYitBjO1GdgwJFUs8RAKQH+HpbwxR7SI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:sender;
        b=laNBzkJBs4JZhe0IMiDeWLjSkOwKdJfODPk0XdOdDuaiE/Ose/DeE6xyyFcb4S5mjB
         antn+McSspNkl+3o49mq5bbl6kfbfEGnUqpt8P/0WMc5pKDOZQEwnSXNM5zunObUpcnH
         arB9BpZEeNqh3FEP4G5i9QlQnSUm3/h10bizE=
Received: by 10.103.242.7 with SMTP id u7mr854330mur.100.1219929469407;
        Thu, 28 Aug 2008 06:17:49 -0700 (PDT)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id y6sm4643884mug.7.2008.08.28.06.17.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Aug 2008 06:17:48 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vej4aqsge.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94051>


> It is either run by ssh (via command="" option in authorized_keys file),
> by init/login (if in /etc/passwd), or by gitosis (and its equivalent).

It is possible to run it with file descriptors closed via ssh, using
command="git-shell 0<&- 1<&- 2<&-" in the authorized_keys file.

It's true that in this case the user is also shooting himself, but given
that git-shell is used to restrict operation to "safe" commands, this
special case might be worth being worked around.

Paolo
