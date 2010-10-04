From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/7] commit-tree: free commit message before exiting
Date: Mon, 4 Oct 2010 02:56:13 -0500
Message-ID: <20101004075613.GL24884@burratino>
References: <wes62zknmki.fsf@kanis.fr>
 <7v1va760ip.fsf@alter.siamese.dyndns.org>
 <20100810032647.GA2386@burratino>
 <20101002082752.GA29638@burratino>
 <20101002084100.GH29638@burratino>
 <7vlj6edcic.fsf@alter.siamese.dyndns.org>
 <20101004041834.GD24884@burratino>
 <7vtyl28k8k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 09:59:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2fxO-0002hY-7z
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 09:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091Ab0JDH73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 03:59:29 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61245 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936Ab0JDH72 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 03:59:28 -0400
Received: by iwn5 with SMTP id 5so6599276iwn.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 00:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=c3DEvjRSy9qjMPCOJUDPQL3Szuu6cM5W7Zo9NL5WslU=;
        b=Gm0XC7IPR6Vrqgm+Ro4WbfAyOo8zqd9no0N3v9qFgwi2OsZvii0Zc+SrjqHjAAIAth
         QXhErNHTFmWvSbAfTTrqb3fd8TeXZCPl0OpEA/S6JLS7d07cXwJuG36zaT+4x8EQp0j6
         3BvpWcFHnfP7RM/vhr6nR8LzE9VaiY+N/S8Q0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DdX9ej1W2rTfMQObiWC3s+p4+mWFCSbArgeuFsUCobA1pXSC9LmHP5e3IN0aQkeCRk
         NZ2IaQux4bXQHUKLgdxcXdUGfwLgn0u1O6ukflJ3l5kcQvfe1VPF5nCpAvSL0yczKCBO
         VLX1mAa/xLtMjKxVCP6QIs3AaZ6uRU5+EP2YQ=
Received: by 10.231.39.205 with SMTP id h13mr9721140ibe.148.1286179167708;
        Mon, 04 Oct 2010 00:59:27 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id u6sm3009193ibd.6.2010.10.04.00.59.26
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 00:59:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vtyl28k8k.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158007>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Even better would be to exit() instead of returning from cmd_
>> functions.  Valgrind will not consider any memory that still has a
>> pointer to it at exit time as a leak.
>
> Hmm, is there a way to tell valgrind that in these functions pretend as if
> they left the scope by calling exit() when they return?

You mean a way to tell it to trap the return from these functions?
No, I don't think so.
