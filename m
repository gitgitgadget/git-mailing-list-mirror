From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] diff: funcname and word patterns for perl
Date: Sun, 26 Dec 2010 04:54:41 -0600
Message-ID: <20101226105441.GA27039@burratino>
References: <20101222234843.7998.87068.stgit@localhost.localdomain>
 <201012252314.22541.jnareb@gmail.com>
 <20101226090731.GA21588@burratino>
 <201012261143.33190.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	"J.H." <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Dec 26 11:55:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWoFo-0000PL-N2
	for gcvg-git-2@lo.gmane.org; Sun, 26 Dec 2010 11:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841Ab0LZKzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Dec 2010 05:55:01 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46743 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784Ab0LZKzA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Dec 2010 05:55:00 -0500
Received: by iwn9 with SMTP id 9so7963142iwn.19
        for <git@vger.kernel.org>; Sun, 26 Dec 2010 02:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=YXi6AMwNVtsIt7v1BJSIX2EjNx+/A0af+58dpZ5DpjU=;
        b=dq7ZP7wwwL9L7pNX4nOe4OKY3yCXraI92LyFQg99ngwuHxYQobJMH1vYD+5BuQIohK
         QqR0BbJz7EVL/jiAYjGLAZzmvbAtznwD+MW0Xk7rAR3eeHxewcIjvhJitqZPDXjtgZcA
         Y5qOa5+sC9dq62KxbpMVMV4MlCC81+zCtwK8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=o+hbK6ptXyscOYcTZhO+UGCaTpC+1wqoO89LMTawUwCQNKbXOd+V0mfDe++EJkUsJC
         ZgYIztJIYTEoXvB7dxjwvmwRJhgbyTvX9HZ1HyZ/tKf14oqyjURjKuIn4wTriD0o3M9p
         p5g1EIIYo8AqEK+Un3wEtTV1W3j5dmDUXFgJE=
Received: by 10.42.173.69 with SMTP id q5mr11518830icz.86.1293360899781;
        Sun, 26 Dec 2010 02:54:59 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id jv9sm9643434icb.13.2010.12.26.02.54.57
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 26 Dec 2010 02:54:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201012261143.33190.trast@student.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164188>

Thomas Rast wrote:
> Jonathan Nieder wrote:

>> +	 "|[^[:space:]]"),
>
> I think it should get the |[\x80-\xff]+ arm, too.  That one was
> designed to avoid splitting UTF-8 characters.  At the risk of gluing
> together too many of them, of course, but I think confusing the
> terminal would be worse.

Hmm.  Should it be

	|([\x80-\xff]+[\x00-\x7f])

then, to match exactly one multibyte UTF-8 character?
