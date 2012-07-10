From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] branch: introduce --set-upstream-to
Date: Tue, 10 Jul 2012 15:11:05 -0500
Message-ID: <20120710201105.GH8439@burratino>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
 <1341939181-8962-2-git-send-email-cmn@elego.de>
 <20120710191354.GE8439@burratino>
 <7v1ukjiehe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 22:11:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SogmC-0001kS-3A
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 22:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806Ab2GJULL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 16:11:11 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:34444 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757Ab2GJULK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 16:11:10 -0400
Received: by gglu4 with SMTP id u4so461575ggl.19
        for <git@vger.kernel.org>; Tue, 10 Jul 2012 13:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=VDZPOu52hKCubApTCSVLFivP84cRzQhPcwAwtz71qBY=;
        b=Ptwy4+NP90FHMO2s04+ZVJfrouFdEYeqbxBrXLkmW7N5FHX2CPf0zXCGljXoYo9wy2
         zrbCGZ2t6wNRxhj9Dm9kCE8VFFj4pN1M6K+uaKysnbJwQrqeZmbajn5ozkasCwJaL0u8
         pbn49zU5tCQEl8w0+cvZfpyqoocXf/y1gWMKVUuDpd5FJf3QVZ82CZ+2PL1tQE3q3xSd
         WkkMuAuoU1PECrsO2JzdpiQ59GkDngkY6p+NjpcVt1XuDEQ+WWv9m9Fm+JyFNq3n26Gd
         s+YNWDJIhAHGWPHGLz+9QWkP6nlw47ROjbLb7CK1XfFjIyzSuzE61a1fxZy+Uyfy2CUM
         H6cg==
Received: by 10.50.17.230 with SMTP id r6mr12675310igd.63.1341951069487;
        Tue, 10 Jul 2012 13:11:09 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id bp8sm26978544igb.12.2012.07.10.13.11.08
        (version=SSLv3 cipher=OTHER);
        Tue, 10 Jul 2012 13:11:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v1ukjiehe.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201273>

Junio C Hamano wrote:

> I am not super excited about it either, but at least it is a vast
> improvement compared to the older one, with which it was entirely
> unclear if we are setting the value of upstream *to* what is given
> as an option, or setting the upstream *for* what is given on the
> command line.

Ah, do you mean that --set-upstream is meant to have usage like
"git remote set-url" and co?

	git remote set-url <remote> <url>
	git branch --set-upstream <branch> <upstream>

That's a reasonable stance, and it seems possible to get used to it.
In that case, we should just teach --set-upstream not to create
new branches, and people will get used to it.

The immediate problem that seems to trip people up is that it is very
tempting to run

	git branch --set-upstream junio/master

in an attempt to change what is upstream to the current branch, and
the result is some other completely counterintuitive thing.  I suspect
the order of arguments to --set-upstream is a red herring, as long as
it errors out when the arguments are switched to help people catch
mistakes.
