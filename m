From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] mergetool: Skip autoresolved paths
Date: Fri, 20 Aug 2010 05:09:57 -0500
Message-ID: <20100820100957.GB32127@burratino>
References: <7veie0gy3r.fsf@alter.siamese.dyndns.org>
 <1282036966-26799-1-git-send-email-davvid@gmail.com>
 <201008191202.36508.trast@student.ethz.ch>
 <20100820035236.GA18267@gmail.com>
 <4C6E519E.1080700@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Magnus =?utf-8?B?QsOkY2s=?= <magnus.back@sonyericsson.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Aug 20 12:11:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmOZj-0002ha-Av
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 12:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300Ab0HTKLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 06:11:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33985 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867Ab0HTKLo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 06:11:44 -0400
Received: by iwn5 with SMTP id 5so665647iwn.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 03:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=n8Y488X1fwdN5XB9MKB9VMTs5rZzvP+dZRNaZnfTw1A=;
        b=oU7k0GxO61nKjw+nBfQSKqc/2kT/kmlLzAvYRjn2Dptw3gDWQnIBMHR9j9n7ajfXF0
         DjQeVfyGBbqbgzR1SLHMcj2eVskr+BNlVobk6LlHW5naGRqfbpTCK6DwXXWtrEQrloaX
         4sUH1jOOdEkQ0wsdg+FrRE1Lmtr5F1+63CM+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tpfYnvWUaTLSaO8UzSUUqMkBX80RKI/TCjNxBRkv5BuBuvL2k3KgW3T6slnrjPbObh
         Y1V219ZmG2f6AJVlnlxom85Znu4ZN7wBrlofEQA4kW+uBztFaCsKAjRXs1NFYAs/YO3e
         M4OUn3GAz1L0l7zW5zqcSXSIY/ToJeh12Kj0I=
Received: by 10.231.19.198 with SMTP id c6mr1305719ibb.140.1282299103546;
        Fri, 20 Aug 2010 03:11:43 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r3sm2476993ibk.19.2010.08.20.03.11.42
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 03:11:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C6E519E.1080700@hashpling.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153994>

Charles Bailey wrote:

> We're in the middle of a shell pipe which has replaced stdin and
> merge_file needs access to the human on it's stdin; hence the
> </dev/tty. Strictly.
[...]
> Is there some way of juggling file descriptors in shell?

You can duplicate important fds, like so:

 exec 3<&0

 foo |
 (
	bar
	baz
	quuz <&3
 )

> I had a
> quick play with this but suspect it's a bashism

It's standard, luckily.  See http://unix.org/2008edition/

Hope that helps.
